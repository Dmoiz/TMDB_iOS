//
//  HomeViewModel.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation
import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var popularFilms: [Result] = []
    @Published var searchedFilms: [Result] = []
    @Published var searchText: String = ""
    var isLoading: Bool = false
    private var numberPage: Int = 1
    private var totalPage: Int = 50
    
    private let homeDataManager = HomeDataManager()
    private let state: CurrentValueSubject<FilmDetailState, Never> = .init(.loading)
    
    var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                Task {
                    await self?.searchFilm(search: query)
                }
                
            }
            .store(in: &cancellables)
    }
    
    func getPopularFilms() async {
        guard !isLoading else { return }
        isLoading = true
        
        defer { isLoading = false }

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
            print("Error loading films: \(error)")
        }
    }
    
    func searchFilm(search: String) async {
        guard !searchText.isEmpty else {
            self.searchedFilms = []
            return
        }
                
        do {
            let response = try await homeDataManager.searchFilms(page: numberPage, search: search)
            self.searchedFilms = response.results
        } catch {
            print("Error searching films \(error)")
        }
    }
}

enum FilmDetailState {
 case loading
 case success(String)
 case failure(NetworkError)
}
