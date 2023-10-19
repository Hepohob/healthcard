//
//  Certificates.swift
//  Test NFC
//
//  Created by Aleksei Neronov on 19.10.23.
//

import Foundation

class Certificates {
    
    static let secureCard = "eyJ4NWMiOlsiTUlJRGJqQ0NBeFdnQXdJQkFnSUhBc0pYSlhYU01EQUtCZ2dxaGtqT1BRUURBakNCbGpFTE1Ba0dBMVVFQmhNQ1JFVXhIekFkQmdOVkJBb01GbWRsYldGMGFXc2dSMjFpU0NCT1QxUXRWa0ZNU1VReFJUQkRCZ05WQkFzTVBFVnNaV3QwY205dWFYTmphR1VnUjJWemRXNWthR1ZwZEhOcllYSjBaUzFEUVNCa1pYSWdWR1ZzWlcxaGRHbHJhVzVtY21GemRISjFhM1IxY2pFZk1CMEdBMVVFQXd3V1IwVk5Ma1ZIU3kxRFFUVXhJRlJGVTFRdFQwNU1XVEFlRncweU16QXpNVFl3TURBd01EQmFGdzB5T0RBek1UVXlNelU1TlRsYU1JSHhNUXN3Q1FZRFZRUUdFd0pFUlRFZE1Cc0dBMVVFQ2d3VVZHVnpkQ0JIUzFZdFUxWk9UMVF0VmtGTVNVUXhFakFRQmdOVkJBc01DVEV3T1RVd01EazJPVEVUTUJFR0ExVUVDd3dLV0RFeE1EVTBOVGc0TkRFVU1CSUdBMVVFQkF3TFFzT3J3NjF5YkdsdVpYSXhSREJDQmdOVkJDb01PMU4wWldabWFTQklhV3hzWVhKNUlFRnVibVZuY21WMExVaGxhV1JsYldGeWFXVWdUV0Z5YVdVdFJXeHNZU0JRWlhSeVlTQkhjc09rWm1sdU1UNHdQQVlEVlFRREREVlRkR1ZtWm1rZ1NDNGdRUzR0U0M0Z1RTNHRSUzRnVUM0Z1IzTERwR1pwYmlCQ3c2dkRyWEpzYVc1bGNsUkZVMVF0VDA1TVdUQmFNQlFHQnlxR1NNNDlBZ0VHQ1Nza0F3TUNDQUVCQndOQ0FBU0lpbFRtQ0hWTHVZUnFPYTN6cEU4WnBBbTZKclNoVmFtUE5NUTBad3R6a0hhdjVYQWdVQlwvdmd0U2lzQXhmRzJEK0tqUmZKQ0F6MkkxQ1ozXC9Cc3ZCRm80SHZNSUhzTUI4R0ExVWRJd1FZTUJhQUZIVHArUlNENFF2bUVmWXFySmZzMmErWlE4SHdNREFHQlNza0NBTURCQ2N3SlRBak1DRXdIekFkTUJBTURsWmxjbk5wWTJobGNuUmxMeTF5TUFrR0J5cUNGQUJNQkRFd0lBWURWUjBnQkJrd0Z6QUtCZ2dxZ2hRQVRBU0JJekFKQmdjcWdoUUFUQVJHTUE0R0ExVWREd0VCXC93UUVBd0lIZ0RBZEJnTlZIUTRFRmdRVUVPV2c5bldYVHlneStQbHJPMG1hNmdpcFZ6VXdEQVlEVlIwVEFRSFwvQkFJd0FEQTRCZ2dyQmdFRkJRY0JBUVFzTUNvd0tBWUlLd1lCQlFVSE1BR0dIR2gwZEhBNkx5OWxhR05oTG1kbGJXRjBhV3N1WkdVdmIyTnpjQzh3Q2dZSUtvWkl6ajBFQXdJRFJ3QXdSQUlnR3lYdGt2dUdtRjZPY1BUU2VGaXJBSG01UzduZGp6TWtEWDRBOXU3Q3VRVUNJRWYya1lZMGFRQTArXC9xaGhWQVJNamc3ckxPRVc3V1wvODVEQW15ekZQOUFmIl0sImN0eSI6Ik5KV1QiLCJ0eXAiOiJKV1QiLCJhbGciOiJCUDI1NlIxIn0.eyJuand0IjoiZTMwLmUzMCJ9.ZjIKwKB_4yyMVEEjEwImCjum9Nls4s1IeOQaFUqY5YAC6O7nLDVSCNNdrHyvtf11QaeeCwvDepR1ndGPvQ33NQ"
    
    static let secureCard2 = "eyJhbGciOiJCUDI1NlIxIiwia2lkIjoicHVrX2Rpc2Nfc2lnIiwieDVjIjpbIk1JSUN3RENDQW1hZ0F3SUJBZ0lEQlIwWE1Bb0dDQ3FHU000OUJBTUNNRzh4Q3pBSkJnTlZCQVlUQWtSRk1SVXdFd1lEVlFRS0RBeG5aVzFoZEdscklFZHRZa2d4TWpBd0JnTlZCQXNNS1V0dmJYQnZibVZ1ZEdWdUxVTkJJR1JsY2lCVVpXeGxiV0YwYVd0cGJtWnlZWE4wY25WcmRIVnlNUlV3RXdZRFZRUUREQXhIUlUwdVMwOU5VQzFEUVRRd0hoY05NakV3TlRJMk1UUTBPVE0xV2hjTk1qWXdOVEkxTVRRME9UTTBXakJuTVFzd0NRWURWUVFHRXdKQlZERVNNQkFHQTFVRUNnd0pVa2xUUlNCSGJXSklNU2t3SndZRFZRUUZFeUEzTXpNNU5DMVdNREZKTURBd01WUXlNREl4TURVeU5qRTBOREkwT0RVNU1qRVpNQmNHQTFVRUF3d1FhV1J3TG5KcGMyVXVaR2x6WXk1d2RUQmFNQlFHQnlxR1NNNDlBZ0VHQ1Nza0F3TUNDQUVCQndOQ0FBU1c4SjZaKytad0JndkpiQlRDVjRUR3VjREZ0R3k1N1JjaTRFRFlzWDYrN0I0TllkNG92aUhHWmxFa1hOUVJEVUNMU0tlKzk2U1IyN3lyNmRMc2dXU1JvNEgzTUlIME1CMEdBMVVkRGdRV0JCVGpkdEZ4UTkzRDNjdTdJeE1JckQ2VDZGaitNVEFmQmdOVkhTTUVHREFXZ0JRQ1ZlTGJJYyswS3gydHJkZ2UvRVJoL3VPMXNEQkNCZ2dyQmdFRkJRY0JBUVEyTURRd01nWUlLd1lCQlFVSE1BR0dKbWgwZEhBNkx5OXZZM053TWk1cmIyMXdMV05oTG5SbGJHVnRZWFJwYXk5dlkzTndMMlZqTUE0R0ExVWREd0VCL3dRRUF3SUhnREFoQmdOVkhTQUVHakFZTUFvR0NDcUNGQUJNQklFak1Bb0dDQ3FDRkFCTUJJRkxNQXdHQTFVZEV3RUIvd1FDTUFBd0xRWUZLeVFJQXdNRUpEQWlNQ0F3SGpBY01Cb3dEQXdLU1VSUUxVUnBaVzV6ZERBS0JnZ3FnaFFBVEFTQ0JEQUtCZ2dxaGtqT1BRUURBZ05JQURCRkFpRUFuc3g4U2RwejhKUXViYUVENk1KMDdEN2Y0RTNSOG5QTER0RGtOM2E1c05NQ0lGelZ2S1BoTERNUXlSaitDTWROZ0lVMmEyY2hWQ1ZrU3FVeFNXbUtXRUhhIl0sInR5cCI6IkpXVCJ9.eyJpYXQiOjE2OTc2NDI3ODMsImV4cCI6MTY5NzcyOTE4MywiaXNzdWVyIjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUiLCJqd2tzX3VyaSI6Imh0dHBzOi8vaWRwLmFwcC50aS1kaWVuc3RlLmRlL2NlcnRzIiwidXJpX2Rpc2MiOiJodHRwczovL2lkcC5hcHAudGktZGllbnN0ZS5kZS8ud2VsbC1rbm93bi9vcGVuaWQtY29uZmlndXJhdGlvbiIsImF1dGhvcml6YXRpb25fZW5kcG9pbnQiOiJodHRwczovL2lkcC5hcHAudGktZGllbnN0ZS5kZS9hdXRoIiwic3NvX2VuZHBvaW50IjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUvYXV0aC9zc29fcmVzcG9uc2UiLCJ0b2tlbl9lbmRwb2ludCI6Imh0dHBzOi8vaWRwLmFwcC50aS1kaWVuc3RlLmRlL3Rva2VuIiwiYXV0aF9wYWlyX2VuZHBvaW50IjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUvYXV0aC9hbHRlcm5hdGl2ZSIsInVyaV9wYWlyIjoiaHR0cHM6Ly9pZHAtcGFpcmluZy56ZW50cmFsLmlkcC5zcGxpdGRucy50aS1kaWVuc3RlLmRlL3BhaXJpbmdzIiwia2tfYXBwX2xpc3RfdXJpIjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUvZGlyZWN0b3J5L2trX2FwcHMiLCJ0aGlyZF9wYXJ0eV9hdXRob3JpemF0aW9uX2VuZHBvaW50IjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUvZXh0YXV0aCIsImZlZF9pZHBfbGlzdF91cmkiOiJodHRwczovL2lkcC5hcHAudGktZGllbnN0ZS5kZS9kaXJlY3RvcnkvZmVkX2lkcF9saXN0IiwiZmVkZXJhdGlvbl9hdXRob3JpemF0aW9uX2VuZHBvaW50IjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUvZmVkYXV0aCIsInVyaV9wdWtfaWRwX2VuYyI6Imh0dHBzOi8vaWRwLmFwcC50aS1kaWVuc3RlLmRlL2NlcnRzL3B1a19pZHBfZW5jIiwidXJpX3B1a19pZHBfc2lnIjoiaHR0cHM6Ly9pZHAuYXBwLnRpLWRpZW5zdGUuZGUvY2VydHMvcHVrX2lkcF9zaWciLCJjb2RlX2NoYWxsZW5nZV9tZXRob2RzX3N1cHBvcnRlZCI6WyJTMjU2Il0sInJlc3BvbnNlX3R5cGVzX3N1cHBvcnRlZCI6WyJjb2RlIl0sImdyYW50X3R5cGVzX3N1cHBvcnRlZCI6WyJhdXRob3JpemF0aW9uX2NvZGUiXSwiaWRfdG9rZW5fc2lnbmluZ19hbGdfdmFsdWVzX3N1cHBvcnRlZCI6WyJCUDI1NlIxIl0sImFjcl92YWx1ZXNfc3VwcG9ydGVkIjpbImdlbWF0aWstZWhlYWx0aC1sb2EtaGlnaCJdLCJyZXNwb25zZV9tb2Rlc19zdXBwb3J0ZWQiOlsicXVlcnkiXSwidG9rZW5fZW5kcG9pbnRfYXV0aF9tZXRob2RzX3N1cHBvcnRlZCI6WyJub25lIl0sInNjb3Blc19zdXBwb3J0ZWQiOlsib3BlbmlkIiwiZS1yZXplcHQiLCJlYnRtLWJkciIsImZoaXItdnpkIiwiaXJkLWJtZyIsIm9yZ2Fuc3BlbmRlLXJlZ2lzdGVyIiwicGFpcmluZyIsInJwZG9jLWVtbWEiLCJycGRvYy1lbW1hLXBoYWIiLCJ0aS1zY29yZSIsInp2ci1ibm90ayJdLCJzdWJqZWN0X3R5cGVzX3N1cHBvcnRlZCI6WyJwYWlyd2lzZSJdfQ.FO3AlZA_PdPfrThY4WZ8ixuUZfCVaYHDItRrbzJsyUEdYdpOdmEJO_SqLLlDx-Vq2zcZCRmMLzCLNLSy530TmQ"
    
    static let njwt = "e30.e30"
}
