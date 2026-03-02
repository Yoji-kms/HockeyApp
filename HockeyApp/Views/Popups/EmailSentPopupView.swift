//
//  EmaolSentPopupView.swift
//  HockeyApp
//
//  Created by Yoji on 14.12.2025.
//

import SwiftUI

struct EmailSentPopupView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Color.background.opacity(0.6).edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        isPresented.toggle()
                    }
                }
            
            VStack {
                Text("Пожалуйста \nпроверьте Вашу почту")
                    .font(.system(size: 24, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.mainText)
                    .padding([.top], 16)
                    .padding([.bottom], 32)
                
                Image(.emailPopup)
                    .frame(maxWidth: .infinity)
                    .padding([.horizontal], 48)
                    .padding([.vertical], 16)
                    
                Button {
                    withAnimation {
                        isPresented.toggle()
                    }
                } label: {
                    Text("Назад")
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.buttonText)
                        .padding(8)
                }
                .buttonStyle(.borderedProminent)
                .tint(.accent)
                .padding([.horizontal, .bottom], 16)
            }
            .background(Color.background)
            .cornerRadius(15)
            .padding(20)
        }
    }
}
