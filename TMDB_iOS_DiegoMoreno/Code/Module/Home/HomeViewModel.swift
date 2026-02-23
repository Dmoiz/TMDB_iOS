//
//  HomeViewModel.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var popularFilms: [Result] = []
    
    private let homeDataManager = HomeDataManager()
    private let state: CurrentValueSubject<FilmDetailState, Never> = .init(.loading)
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        getPopularFilms()
    }
    
    func getPopularFilms() {
        Task {
            do {
                let response = try await homeDataManager.getPopularFilms()
                updateHomeView(with: response.results)
            } catch let error as NetworkError {
                state.send(.failure(error))
            }
        }
    }
    
    private func updateHomeView(with model: [Result]) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            popularFilms.append(contentsOf: model)
        }
    }
    
}

enum FilmDetailState {
 case loading
 case success(String)
 case failure(NetworkError)
}
