//
//  ButtonUtils.swift
//  HockeyApp
//
//  Created by Yoji on 15.10.2025.
//

import SwiftUI

struct BorderedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding([.horizontal], 24)
            .padding([.vertical], 8)
            .foregroundStyle(.tint)
            .background(
                RoundedRectangle(
                    cornerRadius: 20,
                    style: .continuous
                )
                .stroke(.tint, lineWidth: 1)
            )
    }
}

extension ButtonStyle where Self == BorderedButtonStyle {
    static var withBorder: Self {
        return .init()
    }
}

struct MyButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .opacity(isEnabled ? 1.0 : 0.5)
    }
}

extension ButtonStyle where Self == MyButtonStyle {
    static var my: Self {
        return .init()
    }
}
