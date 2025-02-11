//
//  PostPaymentRequestBody.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import UIKit

struct PostPaymentRequestBody: Codable {
    let amount: Decimal
    let currency: String
    let recipient: String
}
