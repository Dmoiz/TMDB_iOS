//
//  TMDB_iOS_DiegoMorenoApp.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import SwiftUI

@main
struct TMDB_iOS_DiegoMorenoApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(vm: ViewModelFactory.homeViewModel())
        }
    }
}
