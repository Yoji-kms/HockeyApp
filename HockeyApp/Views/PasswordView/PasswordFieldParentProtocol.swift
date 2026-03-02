//
//  PasswordViewModel.swift
//  HockeyApp
//
//  Created by Yoji on 08.09.2025.
//
import Foundation

protocol PasswordFieldParentProtocol {
    var hideKeyboard: (() -> Void)? { get set }
}

extension PasswordFieldParentProtocol {
    private func performHideKeyboard() {
        guard let hideKeyboard = self.hideKeyboard else { return }
        hideKeyboard()
    }
}
