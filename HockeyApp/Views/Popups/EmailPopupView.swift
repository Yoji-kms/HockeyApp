//
//  EmailPopupView.swift
//  HockeyApp
//
//  Created by Yoji on 05.12.2025.
//

import SwiftUI

struct EmailPopupView: View {
    @Binding var isPresented: Bool
    @Binding var enteredCode: String
    @Binding var isCorrect: Bool
    let checkCode: (@escaping (Bool)->Void)->Void
    
    var body: some View {
        ZStack {
            Color.background.opacity(0.6).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
            
            VStack {
                Text("Подтверждение \nпочты")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.mainText)
                    .padding([.top], 16)
                    .padding([.bottom], 32)
                
                HStack {
                    Text("Введите код, отправленный на Вашу почту")
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(.mainText)
                        .padding([.leading], 16)
                    Spacer()
                }
                
                TextField(
                    "", text: $enteredCode,
                    prompt: Text("Код подтверждения").foregroundStyle(.mainText)
                )
                .textFieldStyle(.plain)
                .keyboardType(.numberPad)
                .padding(16)
                .foregroundStyle(.mainText)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .foregroundStyle(.textField)
                )
                .padding([.horizontal], 16)
                .onChange(of: enteredCode) {
                    isCorrect = true
                }
                
                if !isCorrect {
                    HStack {
                        Text("Введён неверный код")
                            .font(.system(size: 12, weight: .semibold))
                            .multilineTextAlignment(.leading)
                            .foregroundStyle(.red)
                            .padding([.horizontal], 16)
                        
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
                        checkCode() { isCodeCorrect in
                            if isCodeCorrect {
                                withAnimation {
                                    isPresented.toggle()
                                }
                            }
                        }
                    } label: {
                        Text("Подтвердить")
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
