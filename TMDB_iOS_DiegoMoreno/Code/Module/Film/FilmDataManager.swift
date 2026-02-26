//
//  FilmDataManager.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 24/2/26.
//

import Foundation

protocol FilmDataManagerProtocol {
    func getFilmDetail(filmID: Int) async throws -> FilmDetailModel
    func getSimilarFilms(filmID: Int) async throws -> SimilarFilmModel
}

class FilmDataManager: FilmDataManagerProtocol {
    private let apiClient = FilmAPIClient()
    let decoder = JSONDecoder()
    
    func getFilmDetail(filmID: Int) async throws -> FilmDetailModel {
        let dataIn = try await decoder.decode(FilmDetailModel.self, from: apiClient.getFilmDetail(filmID: filmID))
        return dataIn
    }
    
    func getSimilarFilms(filmID: Int) async throws -> SimilarFilmModel {
        let dataIn = try await decoder.decode(SimilarFilmModel.self, from: apiClient.getSimilarFilms(filmID: filmID))
        return dataIn
    }
}
