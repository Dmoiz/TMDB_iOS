//
//  FilmApiClient.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 24/2/26.
//

import Foundation

class FilmAPIClient: BaseAPIClient {
    private let filmIDEndpoint = "movie/"
    private let similarFilmEndpoint = "/similar"
    
    func getFilmDetail(filmID: Int) async throws -> Data {
        return try await request("\(filmIDEndpoint)\(filmID)").0
    }
    
    func getSimilarFilms(filmID: Int) async throws -> Data {
        return try await request("\(filmIDEndpoint)\(filmID)\(similarFilmEndpoint)").0
    }
}
