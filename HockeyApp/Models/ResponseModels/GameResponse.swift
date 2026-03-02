//
//  Untitled.swift
//  HockeyApp
//
//  Created by Yoji on 13.02.2026.
//

struct GameResponse: Codable {
    let id: Int
    let team: Int
//    let rivalTxt: String
//    let gameDate: String
//    let gameTime: String
    let note: String
//    let stadium: StadiumResponse
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case team = "TEAM"
//        case rivalTxt = "RIVAL_TXT"
//        case gameDate = "GAME_DATE"
//        case gameTime = "GAME_TIME"
        case note = "NOTE"
//        case stadium = "STADIUM"
    }
}
