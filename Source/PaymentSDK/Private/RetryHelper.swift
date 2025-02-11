//
//  RetryHelper.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

class RetryHelper {
    static func isRetryAllowed(error: Error) -> Bool {
        guard let error = error as? PaymentSDK.Error else {
            return false
        }
        switch error {
        case .requestError(let urlError):
            switch urlError.code {
            case .timedOut, .cannotFindHost, .networkConnectionLost, .dnsLookupFailed, .notConnectedToInternet:
                return true
            default:
                return false
            }
        case .statusCodeError(let statusCode):
            switch statusCode {
            case 503, 504, 509:
                return true
            default:
                return false
            }
        default:
            return false
        }
    }
}
