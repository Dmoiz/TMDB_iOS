//
//  Environment.swift
//  TMDB_iOS_DiegoMoreno
//
//  Created by Diego Moreno on 23/2/26.
//

import Foundation

final class AppEnvironment {
    
    let baseURLKey = "baseURL"
    let environmentApiKey = "apiKey"
    
    static let popularEndpoint = "movie/popular"
    static let searchFilmEndpoint = "search/movie"
    static let filmIDEndpoint = "movie/"
    static let similarFilmEndpoint = "/similar"
    
    static let shared = AppEnvironment()
    
    
    // MARK: Properties
    private var plistEnvironment: [String: Any]?
    
    init() {
        self.plistEnvironment = loadPlist()
    }
    
    private func loadPlist() -> [String: Any]? {
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let xml = FileManager.default.contents(atPath: path) {
            return (try? PropertyListSerialization.propertyList(from: xml, format: nil)) as? [String: Any]
        }
        return nil
    }
    
    var baseURL: String {
        guard let baseUrl = plistEnvironment?[baseURLKey] as? String else { fatalError("Invalid baseURL at plist") }
        return baseUrl
    }
    
    var apiKey: String {
        guard let apikey = plistEnvironment?[environmentApiKey] as? String else {
            fatalError("Invalid apiKey at plist") }
        return apikey
    }
}
