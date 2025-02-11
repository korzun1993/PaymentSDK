//
//  Configuration.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import UIKit

extension PaymentSDK {
    /// Contains all configurations required for the PaymentSDK
    public class Configuration {
        public let apiKey: String
        public let baseURL: URL
        public let retryCount: Int
        
        /// - Parameters:
        ///     - apiKey: API Key
        ///     - baseURL: URL where all requests will be sent
        public init(apiKey: String, baseURL: URL, retryCount: Int = 5) {
            self.apiKey = apiKey
            self.baseURL = baseURL
            self.retryCount = retryCount
        }
    }
}
