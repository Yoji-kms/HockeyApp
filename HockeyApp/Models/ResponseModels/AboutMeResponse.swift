//
//  AboutMeResponse.swift
//  HockeyApp
//
//  Created by Yoji on 13.12.2025.
//

struct AboutMeResponse: Codable {
    let result: Bool?
    let gamer: GamerResponse?
    let gamerTeams: [GamerTeamResponse]?
    let teams: [TeamResponse]?
}
