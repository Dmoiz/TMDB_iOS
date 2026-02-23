//
//  HomeAPIClient.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

class HomeAPIClient: BaseAPIClient {
    private let popularMoviesEndpoint = "movie/popular"
    func getPopularMovies() async throws -> Data {
        return try await request(popularMoviesEndpoint).0
    }
}
