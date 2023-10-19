//
//  NFCLoginControllerJWTExt.swift
//  Test NFC
//
//  Created by Aleksei Neronov on 19.10.23.
//

import Foundation
import Combine
import HealthCardAccess

class EGKSigner: JWTSigner {
    private let card: HealthCardType
    
    init(card: HealthCardType) {
        self.card = card
    }
    
    func sign(message: Data) -> AnyPublisher<Data, Swift.Error> {
        // [REQ:gemSpec_IDP_Frontend:A_20700-07] perform signature with OpenHealthCardKit
        card.sign(data: message)
            .tryMap { response in
                if response.responseStatus == ResponseStatus.success, let signature = response.data {
                    return signature
                } else {
                    throw NFCSignatureProviderError.signingFailure(.responseStatus(response.responseStatus))
                }
            }
            .eraseToAnyPublisher()
    }
}

enum NFCSignatureProviderError: Error {
    case signingFailure(SigningError)
    
    // sourcery: CodedError = "005"
    enum SigningError: Error, LocalizedError {
        // sourcery: errorCode = "01"
        case unsupportedAlgorithm
        // sourcery: errorCode = "02"
        case responseStatus(ResponseStatus)
        // sourcery: errorCode = "03"
        case certificate(Swift.Error)
        // sourcery: errorCode = "04"
        case missingCertificate
        
        var errorDescription: String? {
            switch self {
            case .unsupportedAlgorithm:
                return "Unsupported Algorithm"
            case let .responseStatus(status):
                return "Signing failed with status: \(status)"
            case let .certificate(error):
                return "Unable to construct the certificate. Error \(error.localizedDescription)"
            case .missingCertificate:
                return "missing certificate"
            }
        }
    }
}

extension PSOAlgorithm {
    // [REQ:gemSpec_Krypt:A_17207] Assure only brainpoolP256r1 is used
    // [REQ:gemSpec_Krypt:GS-A_4357-01,GS-A_4357-02,GS-A_4361-02] Assure that brainpoolP256r1 is used
    var alg: JWT.Algorithm? {
        if case .signECDSA = self {
            return .bp256r1
        }
        return nil
    }
}
