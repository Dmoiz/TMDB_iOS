//
//  HomeAPIClient.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

class HomeAPIClient: BaseAPIClient {
    private let popularMoviesEndpoint = "movie/popular"
    private let searchFilmEndpoint = "search/movie"
    
    private func buildQueryParams(page: Int, query: String? = nil) -> [URLQueryItem] {
        var items = [URLQueryItem(name: "page", value: "\(page)")]
        
        // Solo añadimos la query si tiene contenido (para el buscador)
        if let query = query, !query.isEmpty {
            items.append(URLQueryItem(name: "query", value: query))
        }
        
        return items
    }
    
    func getPopularMovies(page: Int) async throws -> Data {
        return try await request(popularMoviesEndpoint, extraQueryItems: buildQueryParams(page: page)).0
    }

    func searchFilms(page: Int, query: String) async throws -> Data {
        return try await request(searchFilmEndpoint, extraQueryItems: buildQueryParams(page: page, query: query)).0
    }
}
