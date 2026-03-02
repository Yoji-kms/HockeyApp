//
//  Gamer.swift
//  HockeyApp
//
//  Created by Yoji on 19.08.2025.
//

import Foundation

struct Gamer: Identifiable, Hashable {
    let id = UUID().uuidString
    let firstName: String
    let middleName: String
    let lastName: String
    let birthday: String
    let telephone: String
    let email: String
    let login: String
}

extension Gamer {
    var fullName: String {
        if
            let firstNameFirstLetter = self.firstName.first,
            let middleNameFirstLetter = self.middleName.first {
            return "\(self.lastName) \(firstNameFirstLetter).\(middleNameFirstLetter)."
        } else if let firstNameFirstletter = self.firstName.first {
            return "\(self.lastName) \(firstNameFirstletter)."
        } else {
            return self.lastName
        }
    }
}
