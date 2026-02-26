//
//  HomeDataManager.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

protocol HomeDataManagerProtocol {
    func getPopularFilms(page: Int) async throws -> PopularFilmModel
    func searchFilms(page: Int, search: String) async throws -> PopularFilmModel
}

class HomeDataManager: HomeDataManagerProtocol {
    
    private let apiClient = HomeAPIClient()
    private let decoder = JSONDecoder()
    
    func getPopularFilms(page: Int) async throws -> PopularFilmModel {
        try await decoder.decode(PopularFilmModel.self, from: apiClient.getPopularMovies(page: page))
    }
    
    func searchFilms(page: Int, search: String) async throws -> PopularFilmModel {
        try await decoder.decode(PopularFilmModel.self, from: apiClient.searchFilms(page: page, query: search))
    }
    
}
