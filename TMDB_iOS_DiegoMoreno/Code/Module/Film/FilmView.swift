//
//  FilmView.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 24/2/26.
//

import SwiftUI

struct FilmView: View {
    
    @StateObject var vm: FilmViewModel
    
    let film: Result
    
    var body: some View {
        VStack {
            if let detail = vm.filmDetail {
                filmDetails(detail: detail)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(vm.similarFilms) { similar in
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(similar.posterPath ?? "")")) { image in
                                    image.resizable()
                                         .aspectRatio(contentMode: .fill)
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 110, height: 160)
                                .cornerRadius(10)

                                Text(similar.title ?? "")
                                    .font(.caption)
                                    .lineLimit(2)
                                    .frame(width: 110, height: 15, alignment: .leading)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
            } else {
                ProgressView()
            }
            
        }
        .navigationTitle("\(film.title ?? "")")
        .onAppear {
            Task {
                await vm.getFilmDetail(filmID: film.id)
                await vm.getSimilarFilm(filmID: film.id)
            }
        }
    }
}

#Preview {
    FilmView(vm: .init(), film: Result())
}

private extension FilmView {
    func filmDetails(detail: FilmDetailModel) -> some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(film.backdropPath ?? "")")) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder:  {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            Text("\(film.overview)")
                .padding(.horizontal)
                .overlay {
                    Rectangle()
                        .foregroundStyle(.gray)
                        .opacity(0.5)
                }
            List {
                ForEach(detail.genres ?? []) { genre in
                    Text(genre.name ?? "Caca")
                }
                .padding(.top, 10)
            }
            .scrollDisabled(true)
        }
    }
}
