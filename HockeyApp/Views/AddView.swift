//
//  AddView.swift
//  HockeyApp
//
//  Created by Yoji on 15.10.2025.
//

import SwiftUI

struct AddView: View {
    @Binding var isAddActive: Bool
    
    init(isAddActive: Binding<Bool>) {
        _isAddActive = isAddActive
    }
    
    var body: some View {
        VStack(spacing: 4) {
            HStack {
                Spacer()
                Text("add")
                    .bold()
                    .foregroundStyle(.accent)
                Spacer()
                Button {
                    withAnimation {
                        isAddActive.toggle()
                    }
                } label: {
                    Text("✕")
                        .bold()
                        .foregroundStyle(.mainText)
                }
            }
            Button {
                
            } label: {
                Image(systemName: "globe")
                Text("Join team")
                    .bold()
                Spacer()
            }
            .foregroundStyle(.mainText)
            Button {
                
            } label: {
                Image(systemName: "globe")
                Text("Find team")
                    .bold()
                Spacer()
            }
            .foregroundStyle(.mainText)
        }
        .padding(8)
        .background(
            RoundedRectangle(
                cornerRadius: 20,
                style: .continuous
            )
            .stroke(.accent, lineWidth: 1)
        )
    }
}
