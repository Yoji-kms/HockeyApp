//
//  MainScreenViewModel.swift
//  HockeyApp
//
//  Created by Yoji on 15.10.2025.
//

import Foundation
import Combine

final class MainScreenViewModel: ObservableObject {
    @Published var login: String = ""

    private var code: String = ""
    var action = PassthroughSubject<Action, Never>()
    private var bindings = Set<AnyCancellable>()
    
    enum Action {
        case joinTeam
        case findTeam
//        case checkCode((Bool)->())
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
                case .joinTeam:
                    ()
                case .findTeam:
                    ()
                }
            }
            .store(in: &bindings)
    }
    
}
