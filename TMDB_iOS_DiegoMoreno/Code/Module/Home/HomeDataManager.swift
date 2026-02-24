//
//  HomeDataManager.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

class HomeDataManager {
    
    private let apiClient = HomeAPIClient()
    private let decoder = JSONDecoder()
    
    func getPopularFilms(page: Int) async throws -> PopularFilmModel {
        let dataIn = try await decoder.decode(PopularFilmModel.self, from: apiClient.getPopularMovies(page: page))
        return dataIn
    }
    
    func searchFilms(search: String) async throws -> PopularFilmModel {
        let dataIn = try await decoder.decode(PopularFilmModel.self, from: apiClient.searchFilms(search: search))
        return dataIn
    }
    
}
