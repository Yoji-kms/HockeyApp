//
//  GetGamesResponse.swift
//  HockeyApp
//
//  Created by Yoji on 13.02.2026.
//

struct GetGamesResponse: Codable {
    let result: Bool
    let games: [GameResponse]?
    let error: String?
    
    enum CodingKeys: String, CodingKey {
        case result
        case games = "GAMES"
        case error
    }
}
