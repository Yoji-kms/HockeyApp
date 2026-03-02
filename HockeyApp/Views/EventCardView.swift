//
//  EventCardView1.swift
//  HockeyApp
//
//  Created by Yoji on 03.12.2025.
//


import SwiftUI

struct EventCardView: View {
    @State private var type: EventType = .rent
    @State private var place: String = "СКА Арена"
    @State private var time: String = "18:00-21:00"
    @State private var description: String = "Описание"
    @State private var state: EventState = .unselected
    
    enum EventState {
        case willGo
        case wontGo
        case unselected
        
        var string: String {
            return switch self {
            case .unselected:
                "unselected"
            case .willGo:
                "Приду"
            case .wontGo:
                "Не приду"
            }
        }
        
        var isAccepted: Bool {
            return switch self {
            case .willGo:
                true
            case .wontGo, .unselected:
                false
            }
        }
        
        var color: Color {
            return switch self {
            case .willGo:
                    .mainText
            case .wontGo, .unselected:
                    .secondaryText
            }
        }
    }
    
    enum EventType {
        case game
        case training
        case rent
        
        var string: String {
            return switch self {
            case .game:
                "Игра"
            case .training:
                "Тренировка"
            case .rent:
                "Аренда"
            }
        }
        
        var color: Color {
            return switch self {
            case .game:
                    .accent
            case .training:
                    .training
            case .rent:
                    .rent
            }
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                
                if state != .unselected {
                    Text(state.string)
                        .foregroundStyle(state.color)
                        .background(
                            RoundedRectangle(
                                cornerRadius: 20,
                                style: .continuous
                            )
                            .stroke(state.color, lineWidth: 1)
                        )
                }
                
                Text(type.string)
                    .padding(8)
                    .foregroundStyle(type.color)
                    .background(
                        RoundedRectangle(
                            cornerRadius: 20,
                            style: .continuous
                        )
                        .stroke(type.color, lineWidth: 1)
                    )
            }
            
            HStack {
                Text(place)
                    .foregroundStyle(type.color)
                
                Spacer()
            }
            
            HStack {
                Text(time)
                    .foregroundStyle(.mainText)
                
                Spacer()
            }
            
            HStack {
                Text(description)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(.secondaryText)
                
                Button {
                    
                } label: {
                    Image(systemName: "pencil")
                }
                .buttonStyle(.borderless)
                .tint(.mainText)
            }
            
            if state == .unselected {
                HStack {
                    Button {
                        withAnimation {
                            state = .willGo
                        }
                    } label: {
                        Text("Приду")
                            .foregroundStyle(.buttonText)
                            .frame(maxWidth: .infinity)
                            .background(
                                UnevenRoundedRectangle(cornerRadii: .init(
                                    topLeading: 30,
                                    bottomLeading: 30,
                                    bottomTrailing: 6,
                                    topTrailing: 6
                                ), style: .continuous)
                                .tint(.accent)
                            )
                            .padding([.leading, .vertical], 4)
                    }
                    .frame(maxWidth: .infinity)
                    
                    Button {
                        withAnimation {
                            state = .wontGo
                        }
                    } label: {
                        Text("Не приду")
                            .foregroundStyle(.mainText)
                            .frame(maxWidth: .infinity)
                            .background(
                                UnevenRoundedRectangle(cornerRadii: .init(
                                    topLeading: 6,
                                    bottomLeading: 6,
                                    bottomTrailing: 30,
                                    topTrailing: 30
                                ), style: .continuous)
                                .stroke(.accent, lineWidth: 1)
                            )
                            .padding([.trailing, .vertical], 4)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .background(Color.viewBackground)
        .cornerRadius(16)
    }
}
