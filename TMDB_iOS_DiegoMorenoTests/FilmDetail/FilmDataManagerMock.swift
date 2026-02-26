//
//  FilmDataManagerMock.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 26/2/26.
//

import Foundation
import Testing
@testable import TMDB_iOS_DiegoMoreno

class FilmDataManagerMock: FilmDataManagerProtocol {
    func getFilmDetail(filmID: Int) async throws -> TMDB_iOS_DiegoMoreno.FilmDetailModel {
        .init(adult: false, backdropPath: "", belongsToCollection: nil, budget: 10, genres: nil, homepage: "", id: 1, imdbID: "", originCountry: nil, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", productionCompanies: nil, productionCountries: nil, releaseDate: "", revenue: 0, runtime: 0, spokenLanguages: nil, status: "", tagline: "", title: "", video: false, voteAverage: 0, voteCount: 0)
    }
    
    func getSimilarFilms(filmID: Int) async throws -> TMDB_iOS_DiegoMoreno.SimilarFilmModel {
        .init(page: 0, results: [.init(adult: false, backdropPath: "", genreIDS: nil, id: 5, originalLanguage: "", originalTitle: "", overview: "", popularity: 0, posterPath: "", releaseDate: "", title: "", video: false, voteAverage: 0, voteCount: 0)], totalPages: 0, totalResults: 0)
    }
    
    
}
