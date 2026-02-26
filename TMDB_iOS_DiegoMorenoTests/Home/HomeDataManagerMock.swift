//
//  HomeDataManagerMock.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 26/2/26.
//

import Foundation
import Testing
@testable import TMDB_iOS_DiegoMoreno

class HomeDataManagerMock: HomeDataManagerProtocol {
    func getPopularFilms(page: Int) async throws -> TMDB_iOS_DiegoMoreno.PopularFilmModel {
        .init(page: 1, results: [.init(id: 1)], totalPages: 0, totalResults: 0)
    }
    
    func searchFilms(page: Int, search: String) async throws -> TMDB_iOS_DiegoMoreno.PopularFilmModel {
        .init(page: 1, results: [.init(title: "Toy Story")], totalPages: 1, totalResults: 1)
    }
    
    
}
