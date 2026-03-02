//
//  MainScreenView.swift
//  HockeyApp
//
//  Created by Yoji on 15.10.2025.
//

import SwiftUI

struct MainScreenView: View {
    @State var isAddButtonActive: Bool = false
    @State private var isDateActivitiesActive: Bool = false
    @State private var isMonth: Bool = true
    @State var animationAmount = 1.0
    @State var selectedDate: Date = Date.now
    
    var body: some View {
        VStack {
            if !isAddButtonActive {
                Button {
                    withAnimation {
                        isAddButtonActive.toggle()
                    }
                } label: {
                    Text("add +")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(Color.accent)
                .foregroundStyle(.black)
                .padding([.horizontal], 16)
            } else {
                AddView(isAddActive: $isAddButtonActive)
            }
            HStack {
                Button {
                    withAnimation {
                        if !isMonth {
                            isMonth.toggle()
                        }
                    }
                } label: {
                    Text("month")
                }
                .buttonStyle(.withBorder)
                .tint(isMonth ? .mainText : .secondaryText)
                
                Button {
                    withAnimation {
                        if isMonth {
                            isMonth.toggle()
                        }
                    }
                } label: {
                    Text("week")
                }
                .buttonStyle(.withBorder)
                .tint(!isMonth ? .mainText : .secondaryText)
                
                Spacer()
            }
            
            ScheduleView(isMonth: $isMonth, selectedDate: $selectedDate)
                .padding()
            
            HStack {
                Button {
                    withAnimation {
                        isDateActivitiesActive.toggle()
                    }
                } label: {
                    (
                        isDateActivitiesActive ?
                        Text(Image(systemName: "chevron.up")) :
                            Text(Image(systemName: "chevron.down"))
                    ) + Text(" ") + Text(selectedDate, format: .dateTime.day().month(.wide).year())
                }
                .buttonStyle(.borderless)
                .tint(.mainText)
                
                Spacer()
            }
            
            if isDateActivitiesActive {
                EventCardView()
            }
        }
        .background(Color.background)
    }
}

