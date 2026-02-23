//
//  BaseAPIClient.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

class BaseAPIClient {
    
    private var baseURL: URL {
        URL(string: AppEnvironment.shared.baseURL) ?? URL(string: "")!
    }
    
    private var apiKey: String? {
        AppEnvironment.shared.apiKey
    }
    
    private lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 60
        config.timeoutIntervalForResource = 60 * 60
        return URLSession(configuration: config)
    }()
    
    func request<T: Decodable>(
        relativePath: String,
        method: HTTPMethodAsync = .get,
        parameters: [String: Any]? = nil,
        headers: [String: String]? = nil,
        responseType: T.Type = T.self
    ) async throws -> T {

        guard let url = URL(string: relativePath, relativeTo: baseURL) else {
            throw NetworkError.badResponse
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue.uppercased()
        
        if let apiKey = apiKey {
            urlRequest.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        }

        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }

        if method == .get, let parameters = parameters {
            let query = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
            if var components = URLComponents(url: url, resolvingAgainstBaseURL: true) {
                components.query = query
                if let newURL = components.url {
                    urlRequest.url = newURL
                }
            }
        } else if (method == .post || method == .put), let parameters = parameters {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }

        let (data, response) = try await session.data(for: urlRequest)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.unkown
        }

        if !(200...299).contains(httpResponse.statusCode) {
            throw NetworkError.badResponse
        }

        do {
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.unkown
        }
    }
}

enum HTTPMethodAsync: String {
    case get
    case post
    case put
    case delete
}
