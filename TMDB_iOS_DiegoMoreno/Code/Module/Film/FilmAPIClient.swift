//
//  FilmApiClient.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 24/2/26.
//

import Foundation

protocol FilmAPIClientProtocol {
    func getFilmDetail(filmID: Int) async throws -> Data
    func getSimilarFilms(filmID: Int) async throws -> Data
}

class FilmAPIClient: BaseAPIClient, FilmAPIClientProtocol {
    
    func getFilmDetail(filmID: Int) async throws -> Data {
        return try await request("\(AppEnvironment.filmIDEndpoint)\(filmID)").0
    }
    
    func getSimilarFilms(filmID: Int) async throws -> Data {
        return try await request("\(AppEnvironment.filmIDEndpoint)\(filmID)\(AppEnvironment.similarFilmEndpoint)").0
    }
}
