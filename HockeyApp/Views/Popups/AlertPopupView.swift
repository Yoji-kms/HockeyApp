//
//  AlertPopupView.swift
//  HockeyApp
//
//  Created by Yoji on 13.12.2025.
//

import SwiftUI

struct AlertPopupView: View {
    @Binding var isPresented: Bool
    private var message: String
    
    init(isPresented: Binding<Bool>, message: String) {
        _isPresented = isPresented
        self.message = message
    }
    
    var body: some View {
        ZStack {
            Color.background.opacity(0.6).edgesIgnoringSafeArea(.all)
            
            Text(message)
                .font(.system(size: 24, weight: .semibold))
                .padding([.all], 16)
                .multilineTextAlignment(.center)
                .foregroundStyle(.mainText)
                .background(Color.background)
                .cornerRadius(15)
                .padding([.all], 16)
        }
    }
}
