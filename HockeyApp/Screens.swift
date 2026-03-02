//
//  Screens.swift
//  HockeyApp
//
//  Created by Yoji on 18.12.2025.
//

import Combine
import SwiftUI

enum Screen: Identifiable, Hashable {
    case authorization(viewModel: AuthorizationViewModel)
    case registration(viewModel: RegistrationViewModel)
    case mainScreen
    
    var id: Self { return self }
    
    var navigationTitle: String {
        return switch self {
        case .authorization(let viewModel):
            "Авторизация"
        case .registration(let viewModel):
            "Регистрация"
        case .mainScreen:
            "Основной экран"
        }
    }
}

protocol AppCoordinatorProtocol: ObservableObject {
    var path: NavigationPath { get set }
    func push(_ screen: Screen)
    func pop()
    func popToRoot()
}

class AppCoordinator: AppCoordinatorProtocol {
    @Published var path = NavigationPath()
    
    func push(_ screen: Screen) {
        path.append(screen)
    }
    
    func pop() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
    
    @ViewBuilder
    func build(_ screen: Screen) -> some View {
        switch screen {
        case .authorization(let viewModel):
            AuthorizationView(viewModel: viewModel)
        case .registration(let viewModel):
            RegistrationView(viewModel: viewModel)
        case .mainScreen:
            MainScreenView()
        }
    }
}

struct CoordinatorView: View {
    @StateObject var appCoordinator = AppCoordinator()
    private let registrationViewModel = RegistrationViewModel()
    private let authorizationViewModel = AuthorizationViewModel()
    
    var body: some View {
        NavigationStack(path: $appCoordinator.path) {
            appCoordinator.build(.authorization(viewModel: authorizationViewModel))
                .navigationDestination(for: Screen.self) { screen in
                    appCoordinator.build(screen)
                }
        }
        .environmentObject(appCoordinator)
    }
}
