//
//  NewTokenResponseModel.swift
//  HockeyApp
//
//  Created by Yoji on 03.09.2025.
//

struct NewTokenResponse: Codable {
    let result: Bool?
    let error: String?
    let newToken: String?
}
