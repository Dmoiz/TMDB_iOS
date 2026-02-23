//
//  HomeDataManager.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

class HomeDataManager {
    
    private let apiClient = HomeAPIClient()
    
    func getPopularFilms() async throws -> PopularFilmModel {
        let decoder = JSONDecoder()
        let dataIn = try await decoder.decode(PopularFilmModel.self, from: apiClient.getPopularMovies())
        return dataIn
    }
    
}
