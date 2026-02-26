//
//  HomeViewModelTest.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 26/2/26.
//

import Foundation
import Testing
@testable import TMDB_iOS_DiegoMoreno

struct HomeViewModelTest {
    @Test func getPopularFilms() async {
        let vm = await HomeViewModel(dataManager: HomeDataManagerMock())
        await vm.getPopularFilms()
        await #expect(vm.popularFilms.count >= 1)
    }
    
    @Test func seatchFilm() async {
        let vm = await HomeViewModel(dataManager: HomeDataManagerMock())
        await vm.searchFilm(search: "Toy Story")
        await #expect(vm.searchedFilms.count >= 1)
    }
}

//
//@Test func testSimilarFilms() async {
//let vm = await FilmViewModel(dataManager: FilmDataManagerMock())
//await vm.getSimilarFilm(filmID: 5)
//await #expect(vm.similarFilms.first?.id == 5)
//}
