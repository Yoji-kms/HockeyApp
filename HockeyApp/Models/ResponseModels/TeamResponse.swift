//
//  TeamResponse.swift
//  HockeyApp
//
//  Created by Yoji on 13.12.2025.
//

struct TeamResponse: Codable {
    let teamId: Int
    let adult: String
    let name: String
    let birthday: String
    let teamAdmin: Int
    let site: String
    let email: String
    let insta: String
    let fbook: String
    let telegram: String
    let needForPlayers: Bool
    let teamLevel: String
    let crc32: Int
    let pictureClass: String
}
