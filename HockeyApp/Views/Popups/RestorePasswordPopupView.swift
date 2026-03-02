//
//  RestorePasswordPopupView.swift
//  HockeyApp
//
//  Created by Yoji on 14.12.2025.
//

import SwiftUI

struct RestorePasswordPopupView: View {
    @Binding var isPresented: Bool
    @Binding var isSentPopupPresented: Bool
    @State private var isEmailCorrect: Bool = true
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            Color.background.opacity(0.6).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
            
            VStack {
                Text("Укажите Вашу \nэлектронную почту")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.mainText)
                    .padding([.top], 16)
                    .padding([.bottom], 32)
                
                HStack {
                    Text("Введите почту, указанную при регистрации")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.mainText)
                        .padding([.leading], 16)
                    Spacer()
                }
                
                TextField(
                    "", text: $email,
                    prompt: Text(verbatim: "example@mail.ru").foregroundStyle(.secondaryText)
                )
                .textFieldStyle(.plain)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .padding(16)
                .foregroundStyle(.mainText)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .foregroundStyle(.textField)
                )
                .padding([.horizontal], 16)
                .onChange(of: email) {
                    withAnimation {
                        isEmailCorrect = true
                    }
                }
                
                if !isEmailCorrect {
                    HStack {
                        Text("Введён некорректный адрес электронной почты")
                            .font(.system(size: 12, weight: .medium))
                            .foregroundStyle(.red)
                            .padding([.leading], 16)
                        Spacer()
                    }
                }
                
                HStack {
                    Button {
                        withAnimation {
                            isPresented.toggle()
                        }
                    } label: {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.buttonText)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(
                                UnevenRoundedRectangle(cornerRadii: .init(
                                    topLeading: 30,
                                    bottomLeading: 30,
                                    bottomTrailing: 6,
                                    topTrailing: 6
                                ), style: .continuous)
                                .tint(.mainText)
                            )
                            .padding([.leading, .vertical], 8)
                    }
                    
                    Button {
                        if email.isValidEmail {
                            Task {
                                let restorePasswordRequest = RestorePasswordRequest(email: email)
                                let urlSrting = Requests.restorePassword.rawValue
                                let _: RestorePasswordResponse? = await urlSrting.handleAsDecodable(data: restorePasswordRequest)
                            }
                            withAnimation {
                                isPresented.toggle()
                                isSentPopupPresented.toggle()
                            }
                        } else {
                            withAnimation {
                                isEmailCorrect = false
                            }
                        }
                    } label: {
                        Text("Отправить")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundStyle(.buttonText)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(
                                UnevenRoundedRectangle(cornerRadii: .init(
                                    topLeading: 6,
                                    bottomLeading: 6,
                                    bottomTrailing: 30,
                                    topTrailing: 30
                                ), style: .continuous)
                                .tint(.accent)
                            )
                            .padding([.trailing, .vertical], 8)
                    }
                }
                .padding([.bottom], 16)
            }
            .background(Color.background)
            .cornerRadius(15)
            .padding(20)
        }
    }
}
