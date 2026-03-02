//
//  StadiumResponse.swift
//  HockeyApp
//
//  Created by Yoji on 13.02.2026.
//

struct StadiumResponse: Codable {
    let id: Int
    let name: String
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case name = "NAME"
        case address = "ADDRESS"
    }
}
