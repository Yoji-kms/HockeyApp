//
//  AuthorizationView.swift
//  HockeyApp
//
//  Created by Yoji on 19.08.2025.
//

import Foundation
import SwiftUI

struct AuthorizationView: View, PasswordFieldParentProtocol {
    var hideKeyboard: (() -> Void)?
    @ObservedObject private var viewModel: AuthorizationViewModel
    @EnvironmentObject private var appCoordinator: AppCoordinator
    @State private var isRestorePasswordPopupPresented: Bool = false
    @State private var isEmailSentPopupPresented: Bool = false

    init(viewModel: AuthorizationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    HStack {
                        Spacer()
                        ZStack {
                            Image(.subtract)
                                .resizable()
                                .frame(width: 77, height: 77)
                                .foregroundStyle(.mainText)
                                .padding(16)
                            
                            Image(.subtract)
                                .resizable()
                                .frame(width: 19, height: 19)
                                .foregroundStyle(.mainText)
                                .padding([.leading], 67)
                                .padding([.top], 58)
                        }
                    }
                    
                    Text("Добро пожаловать \nна лёд!")
                        .font(.system(size: 32, weight: .semibold))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.mainText)
                        .padding([.vertical], 16)
                    
                    //            Логин
                    HStack {
                        Text("Введите логин")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    TextField(
                        "", text: $viewModel.login,
                        prompt: Text("login".localized).foregroundStyle(.secondaryText)
                    )
                    .textFieldStyle(.plain)
                    .padding(16)
                    .foregroundStyle(.mainText)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .foregroundStyle(.textField)
                    )
                    .padding([.horizontal, .bottom], 16)
                    
                    //            Пароль
                    HStack {
                        Text("Пароль")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    PasswordField(viewModel: viewModel.passwordFieldViewModel, parent: self)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.mainText)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.textField)
                        )
                        .padding([.horizontal, .bottom], 16)
                    
                    Button {
                        withAnimation {
                            isRestorePasswordPopupPresented.toggle()
                        }
                    } label: {
                        Text("Забыли пароль?")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.accent)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Войти")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.buttonText)
                            .padding(8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.accent)
                    .padding([.top], 120)
                    .padding([.horizontal], 16)
                    
                    Button {
                        let registrationViewModel = RegistrationViewModel()
                        appCoordinator.push(.registration(viewModel: registrationViewModel))
                    } label: {
                        Text("Регистрация")
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.mainText)
                            .padding(8)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.textField)
                    .padding([.horizontal, .bottom], 16)
                }
            }
            
            if isRestorePasswordPopupPresented {
                RestorePasswordPopupView(
                    isPresented: $isRestorePasswordPopupPresented,
                    isSentPopupPresented: $isEmailSentPopupPresented)
            }
            if isEmailSentPopupPresented {
                EmailSentPopupView(isPresented: $isEmailSentPopupPresented)
            }
        }
    }
}
