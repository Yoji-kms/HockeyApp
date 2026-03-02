//
//  AuthorizationViewModel.swift
//  HockeyApp
//
//  Created by Yoji on 13.12.2025.
//

import Foundation
import Combine

final class AuthorizationViewModel: ObservableObject, Equatable, Hashable {
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var role: Roles = .player
    
    private(set) lazy var passwordFieldViewModel = PasswordFieldViewModel(
        "enter password".localized,
        data: $password
    )

    var action = PassthroughSubject<Action, Never>()
    private var bindings = Set<AnyCancellable>()
    
    enum Action {
        case registrate
        case enter
    }
    
    init() {
        binds()
    }
    
    private func binds() {
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let self else { return }
                
                switch action {
                case .registrate:
                    ()
                case .enter:
                    ()
                }
            }
            .store(in: &bindings)
    }
    
    static func == (lhs: AuthorizationViewModel, rhs: AuthorizationViewModel) -> Bool {
        lhs.login == rhs.login
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.login)
    }
}
