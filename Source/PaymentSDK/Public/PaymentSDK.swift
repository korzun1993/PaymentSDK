//
//  PaymentSDK.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

/// PaymentSDK provides easy to use access to Payment API
public class PaymentSDK {
    
    public let configuration: Configuration
    private let apiService: APIService
    private let paymentGateway: PaymentGateway
    
    public init(configuration: Configuration) throws {
        self.configuration = configuration
        self.apiService = try APIServiceImpl(
            baseURL: configuration.baseURL,
            apiKey: configuration.apiKey,
            retryCount: configuration.retryCount
        )
        self.paymentGateway = PaymentGateway(apiService: apiService)
    }
    
    /// Sends payment information to API asynchronously
    ///
    /// - Parameters:
    ///     - amount: total amount to be transfered
    ///     - currency: enum value of currency used for trasaction
    ///     - recipient: account id of recipient
    ///
    /// - Returns: Response enum.
    @discardableResult
    public func postPaymentDetails(amount: Decimal, currency: Currency, recipient: String) async -> PostPaymentResult {
        return await paymentGateway.postPayment(amount: amount, currency: currency, recipient: recipient)
    }
}


//    do {
//        let response: PostPaymentRequestResponse = try await performRequest(url: url, method: .post, body: body)
//    } catch {
//        if let error = error as? PaymentSDK.Error {
//            return .failure(error: error)
//        } else {
//            return .failure(error: .unknownError(error: error))
//        }
//    }
