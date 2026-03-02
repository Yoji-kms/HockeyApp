
//
//  PasswordFieldViewModel.swift
//  HockeyApp
//
//  Created by Yoji on 12.09.2025.
//
import Foundation
import Combine

final class PasswordFieldViewModel: ObservableObject {
    @Published private(set) var isSecured: Bool = true
    @Published private(set) var password: String = ""
    @Published private var keepInternalPassword = false
    @Published var internalPassword: String = ""
    private(set) var label: String
    var action = PassthroughSubject<Action, Never>()
    private var bindings = Set<AnyCancellable>()
    
    enum Action {
        case onFocusFieldChange
        case onInternalPasswordChange(String)
        case isSecuredToggle
    }
    
    init(_ label: String, data: Published<String>.Publisher) {
        self.label = label
        data.assign(to: &$password)
        
        binds()
    }
    
    private func binds() {
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let self else { return }
                
                switch action {
                case .onFocusFieldChange:
                    onFocusFieldChange()
                case .onInternalPasswordChange(let oldValue):
                    onInternalPasswordChange(oldValue: oldValue)
                case .isSecuredToggle:
                    isSecuredToggle()
                }
            }
            .store(in: &bindings)
    }
    
    private func onFocusFieldChange() {
            keepInternalPassword = true
    }
    
    private func onInternalPasswordChange(oldValue: String) {
        if keepInternalPassword {
            DispatchQueue.main.async {
                self.keepInternalPassword = false
                self.internalPassword = oldValue
            }
            return
        }
        password = internalPassword
    }
    
    private func isSecuredToggle() {
        isSecured.toggle()
    }
}
