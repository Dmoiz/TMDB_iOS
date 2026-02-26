//
//  ViewModelFactory.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 26/2/26.
//

import Foundation

struct ViewModelFactory {
    static func filmViewModel() -> FilmViewModel {
        .init(dataManager: FilmDataManager())
    }
    
    static func homeViewModel() -> HomeViewModel {
        .init(dataManager: HomeDataManager())
    }
}
