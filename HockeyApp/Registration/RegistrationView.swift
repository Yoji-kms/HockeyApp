//
//  RegistrationView.swift
//  HockeyApp
//
//  Created by Yoji on 20.08.2025.
//

import SwiftUI

struct RegistrationView: View, PasswordFieldParentProtocol {
    var hideKeyboard: (() -> Void)?
    
    @ObservedObject private var viewModel: RegistrationViewModel
    @State private var isRoleCollapsed: Bool = false
    @State private var isPopupPresented: Bool = false
    @State private var isCorrect: Bool = true
    @State private var isEmailConfirmed: Bool = false
    @State private var isPasswordsEqual: Bool = true
    
    init(viewModel: RegistrationViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.background.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    //            Имя
                    HStack {
                        Text("Ваше Имя")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal, .top], 16)
                        Spacer()
                    }
                    TextField(
                        "", text: $viewModel.firstName,
                        prompt: Text("Имя").foregroundStyle(.secondaryText)
                    )
                    .textFieldStyle(.plain)
                    .padding(16)
                    .foregroundStyle(.mainText)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .foregroundStyle(.textField)
                    )
                    .padding([.horizontal, .bottom], 16)
                    
                    //            Фамилия
                    HStack {
                        Text("Ваша Фамилия")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    TextField(
                        "", text: $viewModel.lastName,
                        prompt: Text("Фамилия").foregroundStyle(.secondaryText)
                    )
                    .textFieldStyle(.plain)
                    .padding(16)
                    .foregroundStyle(.mainText)
                    .background(
                        RoundedRectangle(cornerRadius: 6, style: .continuous)
                            .foregroundStyle(.textField)
                    )
                    .padding([.horizontal, .bottom], 16)
                    
                    //            Роль
                    HStack {
                        Text("Выберите роль")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    if !isRoleCollapsed {
                        Button {
                            withAnimation {
                                isRoleCollapsed.toggle()
                            }
                        } label: {
                            HStack {
                                if viewModel.role == .unselected {
                                    Text("Роль")
                                        .foregroundStyle(.secondaryText)
                                } else {
                                    Image(systemName: viewModel.role.imageString)
                                        .foregroundStyle(.accent)
                                    Text(viewModel.role.text)
                                        .foregroundStyle(.mainText)
                                }
                                Spacer()
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.accent)
                            }
                            .padding(16)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.textField)
                        )
                        .padding([.horizontal, .bottom], 16)
                    } else {
                        VStack {
                            Button {
                                withAnimation {
                                    isRoleCollapsed.toggle()
                                }
                            } label: {
                                HStack {
                                    Text("Роль")
                                        .foregroundStyle(.secondaryText)
                                    Spacer()
                                    Image(systemName: "chevron.up")
                                        .foregroundStyle(.accent)
                                }
                                .padding(16)
                            }
                            ForEach(Roles.allCases) { role in
                                if role != .unselected {
                                    Button {
                                        withAnimation {
                                            viewModel.role = role
                                            isRoleCollapsed.toggle()
                                        }
                                    } label: {
                                        HStack {
                                            Image(systemName: role.imageString)
                                                .foregroundStyle(.accent)
                                            Text(role.text)
                                                .foregroundStyle(.mainText)
                                            Spacer()
                                        }
                                        .padding([.horizontal, .bottom], 16)
                                    }
                                }
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.textField)
                        )
                        .padding([.horizontal, .bottom], 16)
                    }
                    
                    //            Логин
                    HStack {
                        Text("Придумайте Логин")
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
                        Text("Придумайте Пароль")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    PasswordField(viewModel: viewModel.enterPasswordFieldViewModel, parent: self)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.mainText)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.textField)
                        )
                        .padding([.horizontal], 16)
                    PasswordField(viewModel: viewModel.confirmPasswordFieldViewModel, parent: self)
                        .textFieldStyle(.plain)
                        .foregroundStyle(.mainText)
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.textField)
                        )
                        .padding([.horizontal, .bottom], 16)
                        .onChange(of: viewModel.confirmPassword) {
                            if(
                                viewModel.confirmPassword != "" &&
                                viewModel.confirmPassword != viewModel.password
                            ) {
                                isPasswordsEqual = false
                            } else {
                                isPasswordsEqual = true
                            }
                        }
                    if(!isPasswordsEqual) {
                        HStack {
                            Text("Введённые пароли не совпадают")
                                .font(.system(size: 12, weight: .medium))
                                .foregroundStyle(.red)
                                .padding([.leading], 16)
                            Spacer()
                        }
                    }
                    
                    //            Электронная почта
                    HStack {
                        Text("email")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.mainText)
                            .padding([.horizontal], 16)
                        Spacer()
                    }
                    HStack {
                        TextField(
                            "", text: $viewModel.email,
                            prompt: Text(verbatim: "example@mail.ru")
                                .foregroundStyle(.secondaryText)
                        )
                        .textFieldStyle(.plain)
                        .foregroundStyle(.mainText)
                        .textContentType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .padding(16)
                        .keyboardType(.emailAddress)
                        .background(
                            RoundedRectangle(cornerRadius: 6, style: .continuous)
                                .foregroundStyle(.textField)
                        )
                        .padding([.horizontal, .bottom], 16)
                        .onChange(of: viewModel.email) {
                            isEmailConfirmed = false
                        }
                        
                        Button {
                            viewModel.action.send(.confirmEmail { newCode in
                                
                            })
                            withAnimation {
                                isPopupPresented.toggle()
                            }
//                            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) {_ in
//                                withAnimation {
//                                    isPopupPresented.toggle()
//                                }
//                            }
                        } label: {
                            Image(systemName: "checkmark.square")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundStyle(isEmailConfirmed ? .accent : .secondaryText)
                        }
                        .padding([.trailing], 16)
                    }
                    
                    Button {
                        viewModel.action.send(.registrate)
                    } label: {
                        Text("registrate".localized)
                            .frame(maxWidth: .infinity)
                            .foregroundStyle(.buttonText)
                            .padding(16)
                            .background(
                                RoundedRectangle(cornerRadius: 30, style: .continuous)
                                    .foregroundStyle(.accent)
                            )
                            
                    }
                    .buttonStyle(.my)
                    .padding([.horizontal, .bottom], 16)
                    .disabled (
                        viewModel.firstName == "" ||
                        viewModel.lastName == "" ||
                        viewModel.role == .unselected ||
                        viewModel.login == "" ||
                        !isEmailConfirmed
                    )
                }
                .background(Color.background)
            }
            
            if isPopupPresented {
                EmailPopupView(
                    isPresented: $isPopupPresented,
                    enteredCode: $viewModel.enteredCode,
                    isCorrect: $isCorrect
                ) { completion in
                    viewModel.action.send(.checkCode { isCodeCorrect in
                        isCorrect = isCodeCorrect
                        isEmailConfirmed = isCodeCorrect
                        completion(isCodeCorrect)
                    })
                }
            }
        }
        .navigationTitle("Регистрация")
    }
}
