//
//  GetGamesRequest.swift
//  HockeyApp
//
//  Created by Yoji on 13.02.2026.
//

struct GetGamesRequest: Datable {
    let token: String
    let startDate: String
    let endDate: String
    
    enum CodingKeys: String, CodingKey {
        case token
        case startDate = "DATE1"
        case endDate = "DATE2"
    }
}
