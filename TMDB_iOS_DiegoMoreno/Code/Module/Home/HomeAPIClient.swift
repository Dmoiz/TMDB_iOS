//
//  HomeAPIClient.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

class HomeAPIClient: BaseAPIClient {
    
    private func buildQueryParams(page: Int, query: String? = nil) -> [URLQueryItem] {
        var items = [URLQueryItem(name: "page", value: "\(page)")]
        
        if let query = query, !query.isEmpty {
            items.append(URLQueryItem(name: "query", value: query))
        }
        
        return items
    }
    
    func getPopularMovies(page: Int) async throws -> Data {
        return try await request(AppEnvironment.popularEndpoint, extraQueryItems: buildQueryParams(page: page)).0
    }

    func searchFilms(page: Int, query: String) async throws -> Data {
        return try await request(AppEnvironment.searchFilmEndpoint, extraQueryItems: buildQueryParams(page: page, query: query)).0
    }
}
