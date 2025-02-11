//
//  PaymentGateway.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

class PaymentGateway {
    let apiService: APIService
    
    init(apiService: APIService) {
        self.apiService = apiService
    }
    
    func postPayment(amount: Decimal, currency: PaymentSDK.Currency, recipient: String) async -> PaymentSDK.PostPaymentResult {
        let requestBody: PostPaymentRequestBody = .init(
            amount: amount,
            currency: currency.rawValue,
            recipient: recipient
        )
        
        do {
            let response: PostPaymentRequestResponse
            response = try await apiService.performRequest(
                method: .post,
                path: "/payment",
                body: requestBody
            )
            guard response.status == "success" else {
                throw PaymentSDK.Error.internalError
            }
            return .success(transactionId: response.transactionId)
        } catch {
            if let error = error as? PaymentSDK.Error {
                return .failure(error: error)
            } else {
                return .failure(error: .unknownError(error: error))
            }
        }
    }
}
