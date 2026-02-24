//
//  HomeView.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm: HomeViewModel
    @State private var selectedFilm: Result?
    
    init(vm: HomeViewModel) {
        self._vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: 140))]) {
                    ForEach(vm.searchText.isEmpty ? vm.popularFilms : vm.searchedFilms) { film in
                        homeList(film: film)
                    }
                    if !vm.popularFilms.isEmpty {
                        ProgressView()
                            .onAppear {
                                Task { await vm.getPopularFilms() }
                            }
                    }
                }
                .padding(8)
                if vm.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .navigationTitle("Popular Films")
            .navigationDestination(item: $selectedFilm) { film in
                FilmView(vm: .init(), film: film)
            }
            .task {
                if vm.popularFilms.isEmpty {
                    await vm.getPopularFilms()
                }
            }
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer, prompt: "Search")
        }
    }
}

#Preview {
    HomeView(vm: .init())
}

private extension HomeView {
    
    func homeList(film: Result) -> some View {
        VStack {
            if let posterPath = film.posterPath {
                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder:  {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity)
                .aspectRatio(2/3, contentMode: .fill)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 20)
            } else {
                Rectangle()
                    .clipShape(.rect(cornerRadius: 20))
                    .overlay {
                        HStack {
                            Text("No image available")
                                .font(.subheadline)
                                .foregroundStyle(.white)
                            Image(systemName: "multiply")
                                .foregroundStyle(.red)
                                .scaledToFit()
                        }
                    }
            }
            
            Text("\(film.title ?? "")")
                .font(.headline)
                .lineLimit(2)
                .multilineTextAlignment(.center)
                .frame(height: 15, alignment: .top)
            
            VStack {
                Text(film.releaseDate ?? "")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                Text(String(format: "%.1f ★", film.voteAverage))
                    .font(.caption2)
                    .bold()
            }
            Spacer(minLength: 0)
        }
        .padding(.bottom, 10)
        .onTapGesture {
            selectedFilm = film
        }
    }
}
