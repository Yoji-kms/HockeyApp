//
//  HockeyAppApp.swift
//  HockeyApp
//
//  Created by Yoji on 19.08.2025.
//

import SwiftUI

@main
struct HockeyAppApp: App {
//    let registrationViewModel = RegistrationViewModel()
//    let authorizationViewModel = AuthorizationViewModel()
//    @State private var path = NavigationPath()
    
    var body: some Scene {
        WindowGroup {
//            CoordinatorView()
//            EventCardView()
            MainScreenView()
//            RegistrationView(viewModel: registrationViewModel)
//            AuthorizationView(viewModel: authorizationViewModel)
        }
    }
}

