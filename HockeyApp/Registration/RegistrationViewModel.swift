//
//  RegistrationViewModel.swift
//  HockeyApp
//
//  Created by Yoji on 19.08.2025.
//

import Foundation
import Combine
import SwiftSMTP

final class RegistrationViewModel: ObservableObject, Equatable, Hashable {
    @Published var login: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var email: String = ""
//    @Published var isAlertPresented: Bool = false
    @Published var enteredCode: String = ""
    @Published var role: Roles = .unselected
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    
    private(set) lazy var enterPasswordFieldViewModel = PasswordFieldViewModel(
        "enter password".localized,
        data: $password
    )
    private(set) lazy var confirmPasswordFieldViewModel = PasswordFieldViewModel(
        "confirm password".localized,
        data: $confirmPassword
    )
    private var code: String = ""
    var action = PassthroughSubject<Action, Never>()
    private var bindings = Set<AnyCancellable>()
    private var passwords = PassthroughSubject<Password, Never>()
    
    enum Action {
        case confirmEmail((String)->())
        case registrate
        case checkCode((Bool)->())
    }
    
    enum Password {
        case enter
        case confirm
    }
    
    init() {
        binds()
    }
    
    
    private func generateRandomPassword(_ length: Int) -> String {
        let digits = "1234567890"
        return String(Array(0..<length).map { _ in digits.randomElement()! })
    }
    
    private func binds() {
        action
            .receive(on: DispatchQueue.main)
            .sink { [weak self] action in
                guard let self else { return }
                
                switch action {
                case .confirmEmail(let completion):
                    confirmEmail { code in
                        completion(code)
                    }
                case .registrate:
                    Task {
                        await self.registate()
                    }
                case .checkCode(let completion):
                    let isCorrect = checkCode()
                    completion(isCorrect)
                }
            }
            .store(in: &bindings)
        
        passwords
            .receive(on: DispatchQueue.main)
            .sink { [weak self] password in
                guard let self else { return }
                
                switch password {
                case .enter:
                    ()
//                    <#code#>
                case .confirm:
                    ()
//                    <#code#>
                }
            }
            .store(in: &bindings)
    }
    
    private func registate() async {
        let newUserRequest = NewUserRequest(
            username: login,
            password: password,
            email: email
        )
        let urlString = Requests.newUser.rawValue
        let newTokenResponse: NewTokenResponse? = await urlString.handleAsDecodable(data: newUserRequest)
        if let newToken = newTokenResponse?.newToken {
            await createGamer(token: newToken)
        } else {
            
        }
    }
    
    private func createGamer(token: String) async {
        let newGamerRequest = NewGamerRequest(
            token: token,
            family: lastName,
            name: firstName,
            midname: "",
            birthday: ""
        )
        let urlString = Requests.newGamer.rawValue
        let gamerResponse: NewGamerResponse? = await urlString.handleAsDecodable(data: newGamerRequest)
        if let result = gamerResponse?.result, result {
            
        }
        
        let savedToken = KeychainUtils.shared.addStringToKeychain(key: token, label: .token)
    }
    
    private func checkCode() -> Bool {
        return code == enteredCode
    }
    
    private func confirmEmail(completion: @escaping (String) -> ()) {
        let newCode = generateRandomPassword(4)
        code = newCode
        MailUtils.shared.sendConfirmationCode(to: email, code: newCode)
    }
    
    static func == (lhs: RegistrationViewModel, rhs: RegistrationViewModel) -> Bool {
        lhs.login == rhs.login
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.login)
    }
}

enum Roles: CaseIterable, Identifiable {
    case player
    case keeper
    case coach
    case unselected
    
    var id: String {
        UUID().uuidString
    }
    
    var text: String {
        return switch self {
        case .player:
            "Игрок"
        case .keeper:
            "Вратарь"
        case .coach:
            "Тренер"
        default:
            ""
        }
    }
    
    var imageString: String {
        return switch self {
        case .player:
            "figure.hockey"
        case .keeper:
            "figure.fall"
        case .coach:
            "person.wave.2"
        default:
            ""
        }
    }
}
