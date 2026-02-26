//
//  FilmViewModelTest.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 26/2/26.
//

import Foundation
import Testing
@testable import TMDB_iOS_DiegoMoreno

struct FilViewModelTest {
    @Test func testSimilarFilms() async {
        let vm = await FilmViewModel(dataManager: FilmDataManagerMock())
        await vm.getSimilarFilm(filmID: 5)
        await #expect(vm.similarFilms.first?.id == 5)
    }
    
    @Test func testDetailFilm() async {
        let vm = await FilmViewModel(dataManager: FilmDataManagerMock())
        await vm.getFilmDetail(filmID: 1)
        await #expect(vm.filmDetail?.id == 1)
    }
}
