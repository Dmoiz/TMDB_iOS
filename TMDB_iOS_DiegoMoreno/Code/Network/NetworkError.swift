//
//  NetworkError.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

enum NetworkError: Error {
    case badResponse
    case needsAuth
    case serviceDown
    case notFound
    case unkown
}
