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

    func request(_ relativePath: String, page: Int) async throws -> (Data, HTTPURLResponse) {
        
        let urlString = baseURL.appendingPathComponent(relativePath)
        var components = URLComponents(url: urlString, resolvingAgainstBaseURL: true)!
        
        let queryItems: [URLQueryItem] = [
            URLQueryItem(name: "page", value: "\(page)")
        ]
        
        components.queryItems = queryItems
        
        guard let finalURL = components.url else { throw URLError(.badURL) }
        print(finalURL)
        
        var request = URLRequest(url: finalURL)
        
        if let token = apiKey {
            print("Api Key = \(token)")
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("No hay")
        }
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.badResponse
        }
        
        if response.statusCode == 200 {
            return (data, response)
        }
        
        switch response.statusCode {
        case 401:
            throw NetworkError.needsAuth
        case 522:
            throw NetworkError.serviceDown
        case 404:
            throw NetworkError.notFound
        default:
            throw NetworkError.unkown
        }
    }
}
