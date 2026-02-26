//
//  FilmView.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 24/2/26.
//

import SwiftUI

struct FilmView: View {
    
    @StateObject var vm: FilmViewModel
    @State var selectedFilm: Result?
    
    let film: Result
    
    enum Constants {
        static let aspectRatio: CGFloat = 16/9
        static let cornerRadius: CGFloat = 10
        static let widthFrame: CGFloat = 110
        static let heightFrame: CGFloat = 160
        static let textHeight: CGFloat = 15
        static let linelimit: CGFloat = 2
        static let leadingPadding: CGFloat = 10
    }
    
    var body: some View {
        VStack {
            if let detail = vm.filmDetail {
                filmDetails(detail: detail)
                
                similarFilms()
            } else {
                ProgressView()
            }
            
        }
        .navigationTitle("\(vm.filmDetail?.title ?? "")")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await vm.getFilmDetail(filmID: film.id)
            await vm.getSimilarFilm(filmID: film.id)
        }
        .navigationDestination(item: $selectedFilm) { nextFilm in
            FilmView(vm: ViewModelFactory.filmViewModel(), film: nextFilm)
        }
    }
}

private extension FilmView {
    func filmDetails(detail: FilmDetailModel) -> some View {
        VStack {
            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w500\(film.backdropPath ?? "")")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder:  {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .aspectRatio(Constants.aspectRatio, contentMode: .fill)
            .clipped()
            Text("\(film.overview)")
                .padding(.horizontal)
            List {
                ForEach(detail.genres ?? []) { genre in
                    Text(genre.name ?? "")
                }
            }
            .listStyle(.plain)
        }
    }
    
    func similarFilms() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(vm.similarFilms) { similar in
                    VStack(alignment: .leading) {
                        if let posterPath = similar.posterPath {
                            AsyncImage(url: URL(string: "https://image.tmdb.org/t/p/w200\(posterPath)")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            } placeholder: {
                                Color.gray
                            }
                            .frame(width: Constants.widthFrame, height: Constants.heightFrame)
                            .cornerRadius(Constants.cornerRadius)
                            
                            Text(similar.title ?? "")
                                .font(.caption)
                                .lineLimit(2)
                                .frame(width: Constants.widthFrame, height: Constants.textHeight, alignment: .leading)
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
                    }
                    .onTapGesture {
                        let resultCompatible = Result(
                            backdropPath: similar.backdropPath, id: similar.id ?? 0,
                            overview: similar.overview ?? "", posterPath: similar.posterPath, title: similar.title
                        )
                        selectedFilm = resultCompatible
                    }
                }
                .padding(.leading, Constants.leadingPadding)
            }
        }
    }
}

#Preview {
    FilmView(vm: ViewModelFactory.filmViewModel(), film: Result())
}
