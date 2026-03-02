//
//  MailUtils.swift
//  HockeyApp
//
//  Created by Yoji on 19.08.2025.
//

import Foundation
import SwiftSMTP

final class MailUtils {
    static let shared = MailUtils()
    
    private lazy var emailKey: String? = {
        return KeychainUtils.shared.getFromKeychain(label: .email)
    }()
    
    private lazy var managerEmail = "HockeyManadger5.1@ya.ru"
    private lazy var manager = Mail.User(email: managerEmail)
    
    private lazy var smtp = SMTP(
        hostname: "smtp.yandex.ru",
        email: managerEmail,
        password: MailUtils.shared.emailKey ?? "",
        port: 465,
        tlsMode: .requireTLS
    )
    
    func sendConfirmationCode(to email: String, code: String) {
        let mailTo = Mail.User(email: email)
        
        let text = "confirmation code".localized + " \(code)"
        
        let mail = Mail(
            from: manager,
            to: [mailTo],
            subject: "email confirmation".localized,
            text: text
        )
        
        smtp.send(mail) { error in
            if let error = error {
                print(error)
            }
        }
    }
}
