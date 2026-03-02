//
//  PasswordView.swift
//  HockeyApp
//
//  Created by Yoji on 05.09.2025.
//
import SwiftUI

struct PasswordField: View {
    @ObservedObject var viewModel: PasswordFieldViewModel
    @FocusState private var focusedField: Field?
    @State  private var hidePasswordFieldOpacity = Opacity.show
    @State private var showPasswordFieldOpacity = Opacity.hide
    @State private var parent: PasswordFieldParentProtocol
    
    enum Field: Hashable {
        case showPasswordField
        case hidePasswordField
    }
    
    enum Opacity: Double {
        case hide = 0
        case show = 1
        
        mutating func toggle() {
            switch self {
            case .hide:
                self = .show
            case .show:
                self = .hide
            }
        }
    }
    
    init(viewModel: PasswordFieldViewModel, parent: PasswordFieldParentProtocol) {
        self.viewModel = viewModel
        self.parent = parent
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .trailing) {
                securedTextField
                
                Button(action: {
                    performToggle()
                }, label: {
                    Image(systemName: viewModel.isSecured ? "eye.slash" : "eye")
                        .foregroundStyle(.accent)
                })
            }
        }
        .onAppear {
            parent.hideKeyboard = hideKeyboard
        }
    }
    
    var securedTextField: some View {
        Group {
            SecureField(
                "", text: $viewModel.internalPassword,
                prompt: Text(viewModel.label).foregroundStyle(.secondaryText)
            )
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .focused($focusedField, equals: .hidePasswordField)
                .opacity(hidePasswordFieldOpacity.rawValue)
            TextField(
                "", text: $viewModel.internalPassword,
                prompt: Text(viewModel.label).foregroundStyle(.secondaryText)
            )
                .textInputAutocapitalization(.never)
                .keyboardType(.asciiCapable)
                .autocorrectionDisabled(true)
                .focused($focusedField, equals: .showPasswordField)
                .opacity(showPasswordFieldOpacity.rawValue)
        }
        .padding(.trailing, 32)
        .onChange(of: focusedField, initial: false) { oldValue, newValue in
            if newValue == .hidePasswordField && oldValue == .showPasswordField {
                viewModel.action.send(.onFocusFieldChange)
            }
        }
        .onChange(of: viewModel.internalPassword, initial: false) { oldValue, _ in
            viewModel.action.send(.onInternalPasswordChange(oldValue))
        }
        
    }
    
    private func hideKeyboard() {
        self.focusedField = nil
    }
    
    private func performToggle() {
        viewModel.action.send(.isSecuredToggle)
        
        if viewModel.isSecured {
            focusedField = .hidePasswordField
        } else {
            focusedField = .showPasswordField
        }
        
        hidePasswordFieldOpacity.toggle()
        showPasswordFieldOpacity.toggle()
    }
}
