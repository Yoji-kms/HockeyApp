//
//  GamerTeamResponse.swift
//  HockeyApp
//
//  Created by Yoji on 13.12.2025.
//

struct GamerTeamResponse: Codable {
    let team: Int
    let gameNum: Int
    let birthplace: String
    let amplua: String
    let gameLevel: String
    let m: Int
    let h: Int
    let telInTeam: String
    let pictureClass: String
    let cCrc32: Int
    let iconClass: String
    let iCrc32: Int
    let activeStatus: Bool
    let wantJoin: Bool
}
