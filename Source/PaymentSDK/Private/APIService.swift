//
//  APIService.swift
//  PaymentSDK
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import Foundation

protocol APIService {
    func performRequest<T: Decodable>(method: HTTPMethod, path: String, body: Encodable) async throws -> T
}

class APIServiceImpl: APIService {
    let baseURLComponents: URLComponents
    let apiKey: String
    let retryCount: Int
    
    init(baseURL: URL, apiKey: String, retryCount: Int) throws {
        guard let urlComponetns = URLComponents(url: baseURL, resolvingAgainstBaseURL: false) else {
            throw URLError(.badURL)
        }
        self.baseURLComponents = urlComponetns
        self.apiKey = apiKey
        self.retryCount = retryCount
    }
    
    public func performRequest<T: Decodable>(method: HTTPMethod, path: String, body: Encodable) async throws -> T {
        guard let url = composeURL(path: path) else {
            throw PaymentSDK.Error.requestError(error: URLError(.badURL))
        }
        return try await performRequest(url: url, method: .post, body: body)
    }
    
    //MARK: - Utils
    
    private func performRequest<T: Decodable>(url: URL, method: HTTPMethod, body: Encodable) async throws -> T {
        var urlRequest = URLRequest(url: url)
        let authValue: String? = "Bearer \(apiKey)"
        let httpBody = try encodeBody(body: body)
        urlRequest.setValue(authValue, forHTTPHeaderField: "Authorization")
        urlRequest.httpBody = httpBody
        urlRequest.httpMethod = method.rawValue
        let data = try await performRequest(urlRequest, maxRetries: self.retryCount)
        return try decodeResponse(data: data)
    }
    
    private func performRequest(
        _ request: URLRequest,
        maxRetries: Int,
        currentRetry: Int = 0
    ) async throws -> Data {
        do {
            return try await performRequest(request)
        } catch {
            if RetryHelper.isRetryAllowed(error: error) && currentRetry < maxRetries {
                try await Task.sleep(nanoseconds: 1_000_000_000)
                return try await performRequest(
                    request,
                    maxRetries: maxRetries,
                    currentRetry: currentRetry + 1
                )
            } else {
                throw error
            }
        }
    }
    
    private func validateStatusCode(response: URLResponse) throws {
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw PaymentSDK.Error.statusCodeError(statusCode: -1)
        }
        if !(200...299).contains(statusCode) {
            throw PaymentSDK.Error.statusCodeError(statusCode: statusCode)
        }
    }
    
    private func performRequest(_ request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            try validateStatusCode(response: response)
            return data
        } catch {
            if let error = error as? URLError {
                throw PaymentSDK.Error.requestError(error: error)
            } else {
                throw error
            }
        }
    }
    
    private func decodeResponse<T: Decodable>(data: Data) throws -> T {
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            if let error = error as? DecodingError {
                throw PaymentSDK.Error.decodingError(error: error)
            } else {
                throw error
            }
        }
    }
    
    private func encodeBody(body: Encodable) throws -> Data {
        do {
            return try JSONEncoder().encode(body)
        } catch {
            if let error = error as? EncodingError {
                throw PaymentSDK.Error.encodingError(error: error)
            } else {
                throw error
            }
        }
    }
    
    private func composeURL(path: String) -> URL? {
        var urlComponents = self.baseURLComponents
        urlComponents.path = path
        return urlComponents.url
    }
}
