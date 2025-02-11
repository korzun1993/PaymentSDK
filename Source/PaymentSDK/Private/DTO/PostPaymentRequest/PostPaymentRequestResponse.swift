//
//  PostPaymentRequestResponse.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

struct PostPaymentRequestResponse: Codable {
    let status: String
    let transactionId: String
}
