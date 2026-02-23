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
    
    static let shared = AppEnvironment()
    
    
    // MARK: Properties
    
    private var plistEnvironment: [String: Any]?
    
    var baseURL: String {
        guard let baseUrl = plistEnvironment?[baseURLKey] as? String else { fatalError("Invalid baseURL at plist") }
        return baseUrl
    }
    
    var apiKey: String {
        guard let apikey = plistEnvironment?[baseURLKey] as? String else {
            fatalError("Invalid apiKey at plist") }
        return apikey
        }
    }
