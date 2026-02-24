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
    var isLoading: Bool = false
    private var numberPage: Int = 1
    private var totalPage: Int = 1
    
    private let homeDataManager = HomeDataManager()
    private let state: CurrentValueSubject<FilmDetailState, Never> = .init(.loading)
    
    var cancellables = Set<AnyCancellable>()
    
    func getPopularFilms() async {
        guard !isLoading else { return }
        
        isLoading = true
        do {
            let response = try await homeDataManager.getPopularFilms(page: numberPage)
            DispatchQueue.main.async {
                self.popularFilms.append(contentsOf: response.results)
                self.totalPage = response.totalPages
                self.numberPage += 1
            }
            isLoading = false
        } catch {
            isLoading = false
            print("Error cargando pelis: \(error)")
        }
    }
}

enum FilmDetailState {
 case loading
 case success(String)
 case failure(NetworkError)
}
