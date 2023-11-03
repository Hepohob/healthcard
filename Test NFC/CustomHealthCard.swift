//
//  CustomHealthCard.swift
//  NFCTagReader
//
//  Created by Aleksei Neronov on 16.10.23.
//  Copyright © 2023 Apple. All rights reserved.
//

import Foundation
import CoreNFC
import UIKit

class CustomHealthCard: NSObject {
    private var tsession: NFCTagReaderSession?
    
    override init() {
        super.init()
        self.tsession = NFCTagReaderSession(pollingOption: .iso14443, delegate: self, queue: nil)
        tsession?.alertMessage = "Hold your iPhone near the item to learn more about it."
        tsession?.begin()
    }
}

extension CustomHealthCard: NFCTagReaderSessionDelegate {
    func tagReaderSessionDidBecomeActive(_ session: NFCTagReaderSession) {
        // TODO: Implements something
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didInvalidateWithError error: Error) {
        if let readerError = error as? NFCReaderError {
            print("ERROR RECEIVED:\(readerError.localizedDescription)")
        }
    }
    
    func tagReaderSession(_ session: NFCTagReaderSession, didDetect tags: [NFCTag]) {
        
        if case let .iso7816(iso7816) = tags.first {
            let card = NFCCard(isoTag: iso7816)
            let cardType = card as CardType
                        let writeTimeout = TimeInterval(0)
                        let readTimeout = TimeInterval(0)
            
            //            let command = HealthCardCommand.Select.selectFile(with: CardAid.egk.rawValue)
            //            let commandApdu = try! command.toLogicalChannel(channelNo: UInt8(0))
            //            let apdu = NFCISO7816APDU(command: commandApdu)
            
            guard let parsedCan = try? CAN.from(Data("670004".utf8)),
                  let channel = try? card.openBasicChannel()
            else { return }
            
            Task {
                print("---->>>>> openSecureSession")
                _ = card.openSecureSession(can: parsedCan, writeTimeout: writeTimeout, readTimeout: readTimeout)
                    .sink(receiveCompletion: { err in
                        print(err)
                    }, receiveValue: { healthCardType in
                        print(healthCardType.status)
                    })

//                guard let keyAlgorithm = await getKeyAlgorithm(channel: channel),
//                      let type = await readCardType(channel: channel),
//                      let healthCard = await readHealthCard(cardType: cardType, channel: channel, type: type, algorithm: keyAlgorithm, can: parsedCan)
//                else { return }
//                print("healthCard - \(healthCard.status)")
            }
        }
    }
    
    private func getCardAid(channel: CardChannelType) -> CardAid? {
        print("---->>>>> getCardAid")

        var cardAID: CardAid?
        _ = channel.determineCardAid()
            .sink { _ in } receiveValue: { cardAid in
                cardAID = cardAid
                _ = HealthCardCommand.Select.selectFile(with: cardAid.rawValue)
            }
        return cardAID
    }
    
    private func getKeyAlgorithm(
        channel: CardChannelType,
        writeTimeout: TimeInterval = 30.0,
        readTimeout: TimeInterval = 30.0
    ) async -> KeyAgreement.Algorithm? {
        print("getKeyAlgorithm")
        guard let cardAid = getCardAid(channel: channel),
              let readCommand = try? HealthCardCommand.Read.readFileCommand(with: cardAid.efCardAccess, ne: APDU.expectedLengthWildcardShort),
              let response = await execute(for: readCommand, channel: channel, writeTimeout: writeTimeout, readTimeout: readTimeout),
              let data = response.data,
              let protocolOid = try? ObjectIdentifier.protocolOid(from: data),
              let keyAgreementAlgorithm = protocolOid.keyAgreementAlgorithm
        else { return nil }
        return keyAgreementAlgorithm
    }
    
    private func readCardType(
        channel: CardChannelType,
        writeTimeout: TimeInterval = 30.0,
        readTimeout: TimeInterval = 30.0
    ) async -> HealthCardPropertyType? {
        print("readCardType")
        guard let cardAid = getCardAid(channel: channel),
              let readCommand = try? HealthCardCommand.Read.readFileCommand(with: cardAid.efVersion2Sfi, ne: channel.expectedLengthWildcard),
              let response = await execute(for: readCommand, channel: channel, writeTimeout: writeTimeout, readTimeout: readTimeout),
              let cardVersion2 = try? CardVersion2(data: response.data ?? Data.empty)
        else { return nil }
        return try? HealthCardPropertyType.from(cardAid: cardAid, cardVersion2: cardVersion2)
    }
    
    private func readHealthCard(
        cardType: CardType,
        channel: CardChannelType,
        type: HealthCardPropertyType,
        algorithm: KeyAgreement.Algorithm,
        can: CAN,
        writeTimeout: TimeInterval = 30.0,
        readTimeout: TimeInterval = 30.0
    ) async -> SecureHealthCard? {
        print("readHealthCard")
        guard let healthCard = try? HealthCard(card: cardType, status: .valid(cardType: type))
        else { return nil }
        var sessionKey: SecureMessaging?
        switch algorithm {
        case .idPaceEcdhGmAesCbcCmac128:
            let resp1 = await step0(healthCard: healthCard)
            let resp2 = await step1(card: healthCard, can: can)

            
            
//            _ = algorithm.negotiateSessionKey(
//                card: healthCard,
//                can: can,
//                writeTimeout: writeTimeout,
//                readTimeout: readTimeout)
//            .sink { _ in
//                // skip implementation
//            } receiveValue: { secureMessaging in
//                sessionKey = secureMessaging
//            }
        }
        guard let sessionKey = sessionKey else { return nil }
        return SecureHealthCard(session: sessionKey, card: healthCard)
    }
    
    private func step0(healthCard: HealthCard,
                       writeTimeout: TimeInterval = 30.0,
                       readTimeout: TimeInterval = 30.0
    ) async -> HealthCardResponseType? {
        print("step0")
        do {
            let algorithm = KeyAgreement.Algorithm.idPaceEcdhGmAesCbcCmac128
            let key = try Key(algorithm.affectedKeyId)
            let decodedOID = try ASN1Decoder.decode(asn1: try Data(hex: algorithm.protocolIdentifierHex))
            let oid = try ObjectIdentifier(from: decodedOID)
            let command: HealthCardCommand = try HealthCardCommand.ManageSE.selectPACE(symmetricKey: key, dfSpecific: false, oid: oid)
            let response = await execute(for: command, channel: healthCard.currentCardChannel, writeTimeout: writeTimeout, readTimeout: readTimeout)
            return response
        } catch {
            return nil
        }
    }
    
    private func step1(
        card: HealthCardType,
        can: CAN,
        writeTimeout: TimeInterval = 30.0,
        readTimeout: TimeInterval = 30.0
    ) async -> Data? {
        print("step1")
        let healthCardCommand = HealthCardCommand.PACE.step1a()
        do {
            let response = await execute(for: healthCardCommand, channel: card.currentCardChannel, writeTimeout: writeTimeout, readTimeout: readTimeout)
            guard let responseData = response?.data
            else { return nil }
            let nonceZ = try KeyAgreement.extractPrimitive(constructedAsn1: responseData)
            let derivedKey = KeyDerivationFunction.deriveKey(from: can.rawValue, mode: .password)
            let result = try AES.CBC128.decrypt(data: nonceZ, key: derivedKey)
            return result
        } catch {
            return nil
        }
    }
    
    private func execute(
        for command: HealthCardCommand,
        channel: CardChannelType,
        writeTimeout: TimeInterval,
        readTimeout: TimeInterval) async -> HealthCardResponseType?
    {
        do {
            let res = try channel.transmit(
                command: command,
                writeTimeout: writeTimeout,
                readTimeout: readTimeout
            )
            let result = HealthCardResponse.from(response: res, for: command)
            return result
        } catch {
            return nil
        }
    }
}

extension ObjectIdentifier {
    // swiftlint:disable:next strict_fileprivate
    fileprivate var keyAgreementAlgorithm: KeyAgreement.Algorithm? {
        if rawValue == KeyAgreement.Algorithm.idPaceEcdhGmAesCbcCmac128.protocolIdentifier {
            return .idPaceEcdhGmAesCbcCmac128
        }
        return nil
    }
    
    // swiftlint:disable:next strict_fileprivate
    fileprivate static func protocolOid(from readEfCardAccessResponse: Data) throws -> ObjectIdentifier {
        guard let asn1 = try? ASN1Decoder.decode(asn1: readEfCardAccessResponse),
              let asn1FirstSet = asn1.data.items?.first,
              let asn1Oid = asn1FirstSet.data.items?.first else {
            throw KeyAgreement.Error.unexpectedFormedAnswerFromCard
        }
        return try ObjectIdentifier(from: asn1Oid)
    }
}
