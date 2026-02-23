//
//  HomeView.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel
    
    
    init(vm: HomeViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        Text("Se ve")
        LazyVStack {
            ForEach(vm.popularFilms) { film in
                Text("\(film.title)")
            }
        }
    }
}

#Preview {
    HomeView(vm: .init())
}
