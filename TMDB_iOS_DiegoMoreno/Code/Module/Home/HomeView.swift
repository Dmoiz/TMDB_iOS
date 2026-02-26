//
//  HomeView.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var vm: HomeViewModel
    @State private var selectedFilm: Result?
    
    enum Constants {
        static let columnSize: CGFloat = 140
        static let aspectRatio: CGFloat = 2/3
        static let cornerRadius: CGFloat = 20
        static let shadowRadius: CGFloat = 20
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: [.init(.adaptive(minimum: Constants.columnSize))]) {
                    ForEach(vm.searchText.isEmpty ? vm.popularFilms : vm.searchedFilms) { film in
                        homeList(film: film)
                    }
                    if !vm.popularFilms.isEmpty {
                        loadingScreen

                    }
                }

                .padding(8)
                if vm.isLoading {
                    loadingScreen
                }
            }
            .navigationTitle("Popular Films")
            .navigationDestination(item: $selectedFilm) { film in
                FilmView(vm: ViewModelFactory.filmViewModel(), film: film)
            }
            .task {
                if vm.popularFilms.isEmpty {
                    await vm.getPopularFilms()
                }
            }
            .searchable(text: $vm.searchText, placement: .navigationBarDrawer, prompt: "Search")
        }
        .onAppear {
            Task { await vm.getPopularFilms() }
        }
    }
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
                .aspectRatio(Constants.aspectRatio, contentMode: .fill)
                .clipShape(.rect(cornerRadius: Constants.cornerRadius))
                .shadow(radius: Constants.shadowRadius)
            } else {
                Rectangle()
                    .clipShape(.rect(cornerRadius: Constants.cornerRadius))
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
    
    var loadingScreen: some View {
        ProgressView()
            .padding()
    }
}

#Preview {
    HomeView(vm: ViewModelFactory.homeViewModel())
}
