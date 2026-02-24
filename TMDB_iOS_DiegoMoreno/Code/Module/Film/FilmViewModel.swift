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
    private let dataManager = FilmDataManager()
    private let state: CurrentValueSubject<FilmDetailState, Never> = .init(.loading)
    
    var cancellables = Set<AnyCancellable>()
    
    func getFilmDetail(filmID: Int) async {
        do {
            let response = try await dataManager.getFilmDetail(filmID: filmID)
            filmDetail = response
        } catch {
            print("Cagadón histórico")
        }
    }
    
    func getSimilarFilm(filmID: Int) async {
        do {
            let response = try await dataManager.getSimilarFilms(filmID: filmID)
            similarFilms = response.results ?? []
        } catch {
            print("Hasta luego lucas")
        }
    }
}
