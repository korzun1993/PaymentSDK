//
//  Response.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

extension PaymentSDK {
    public enum PostPaymentResult {
        case success(transactionId: String)
        case failure(error: Error)
    }
}
