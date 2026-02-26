//
//  FilmViewModel.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 24/2/26.
//

import Foundation
import Combine

@MainActor
class FilmViewModel: ObservableObject {
    
    @Published var filmDetail: FilmDetailModel?
    @Published var similarFilms: [SimilarFilmResult] = []
    private let dataManager: FilmDataManagerProtocol
    
    init(dataManager: FilmDataManagerProtocol) {
        self.dataManager = dataManager
    }
    
    var cancellables = Set<AnyCancellable>()
    
    func getFilmDetail(filmID: Int) async {
        do {
            filmDetail = try await dataManager.getFilmDetail(filmID: filmID)
        } catch {
            print("Error: \(error)")
        }
    }
    
    func getSimilarFilm(filmID: Int) async {
        do {
            similarFilms = try await dataManager.getSimilarFilms(filmID: filmID).results ?? []
        } catch {
            print("Error: \(error)")
        }
    }
}
