//
//  ContentViewModel.swift
//  PaymentSDKExample
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import UIKit
import PaymentSDK

@Observable
class ContentViewModel {
    var result: PaymentSDK.PostPaymentResult?
    private var paymentSDK: PaymentSDK = {
        let paymentSDKAPIKey = "ABC123"
        let paymentSDKBaseURL = URL(string: "https://example.com")!
        return try! PaymentSDK(
            configuration: .init(
                apiKey: paymentSDKAPIKey,
                baseURL: paymentSDKBaseURL
            )
        )
    }()
    
    func sendRequest() {
        Task {
            self.result = await self.paymentSDK.postPaymentDetails(
                amount: 100,
                currency: .USD,
                recipient: "123"
            )
        }
    }
}
