//
//  Error.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

extension PaymentSDK {
    public enum Error: Swift.Error {
        case encodingError(error: EncodingError)
        case decodingError(error: DecodingError)
        case statusCodeError(statusCode: Int)
        case requestError(error: URLError)
        case unknownError(error: Swift.Error)
        case internalError
    }
}
