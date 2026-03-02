//
//  ScheduleView.swift
//  HockeyApp
//
//  Created by Yoji on 15.10.2025.
//

import SwiftUI

struct ScheduleView: View {
    @Binding var selectedSessionDate: Date
    @Binding var isMonth: Bool
    
    init(isMonth: Binding<Bool>, selectedDate: Binding<Date>) {
        _isMonth = isMonth
        _selectedSessionDate = selectedDate
    }
    
    var body: some View {
        CalendarView(isMonth: $isMonth, selectedSessionDate: $selectedSessionDate)
        .background(.viewBackground)
        .cornerRadius(16)
    }
}


struct CalendarView: View {
    @State private var currentMonth = Date.now
    @State private var selectedDate = Date.now
    @State private var days: [Date] = []
    @Binding var isMonth: Bool
    @Binding var selectedSessionDate: Date
    let token: String = "05d26e182118acd90730-863850"
    let startDate = "01.02.2026"
    let endDate = "28.02.2026"
    
    let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(isMonth: Binding<Bool>, selectedSessionDate: Binding<Date>) {
        _isMonth = isMonth
        _selectedSessionDate = selectedSessionDate
    }
    
    var body: some View {
        VStack(spacing: 20) {
            // Month navigation
            HStack {
                Text(currentMonth, format: .dateTime.month(.wide).year())
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.mainText)
                Spacer()
                Button {
                    withAnimation {
                        currentMonth = Calendar.current.date(
                            byAdding: isMonth ? .month : .weekOfMonth,
                            value: -1,
                            to: currentMonth
                        )!
                        updateDays()
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.mainText)
                }
                Button {
                    withAnimation {
                        currentMonth = Calendar.current.date(
                            byAdding: isMonth ? .month : .weekOfMonth,
                            value: 1,
                            to: currentMonth
                        )!
                        updateDays()
                    }
                    Task {
                        await getGames()
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .foregroundStyle(.mainText)
                }
            }
            
            // Days of the week row
            HStack {
                ForEach(daysOfWeek.indices, id: \.self) { index in
                    Text(daysOfWeek[index])
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(.mainText)
                        .frame(maxWidth: .infinity)
                }
            }
            
            // Grid of days
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(days, id: \.self) { day in
                    Button {
                        if day >= Date.now.startOfDay && (day.monthInt == currentMonth.monthInt) || !isMonth {
                            selectedDate = day
                            selectedSessionDate = selectedDate
                        }
                    } label: {
                        Text(day.formatted(.dateTime.day()))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(foregroundStyle(for: day))
                            .frame(maxWidth: .infinity, minHeight: 40)
                            .background(
                                Circle()
                                    .foregroundStyle(
                                        day.formattedDate == selectedDate.formattedDate
                                        ? .accent
                                        : .clear
                                    )
                            )
                    }
                    .disabled(day < Date.now.startOfDay || (day.monthInt != currentMonth.monthInt) && isMonth)
                }
            }
        }
        .padding()
        .onAppear {
            updateDays()
            selectedSessionDate = selectedDate
        }
        .onChange(of: isMonth) {
            withAnimation {
                updateDays()
            }
        }
    }
    
    private func updateDays() {
        days = isMonth
        ? currentMonth.calendarDisplayDays
        : currentMonth.monthInt == selectedDate.monthInt
        ? selectedDate.calendarDisplayWekdays
        : currentMonth.calendarDisplayWekdays
    }
    
    private func foregroundStyle(for day: Date) -> Color {
        let isDifferentMonth = (day.monthInt != currentMonth.monthInt) && isMonth
        let isSelectedDate = day.formattedDate == selectedDate.formattedDate
        let isPastDate = day < Date.now.startOfDay
        
        if isDifferentMonth {
            return isSelectedDate ? .viewBackground : .mainText.opacity(0.3)
        } else if isPastDate {
            return .mainText.opacity(0.3)
        } else {
            return isSelectedDate ? .viewBackground : .mainText
        }
    }
    
    
    private func getGames () async {
        let getGamesRequest = GetGamesRequest(
            token: self.token,
            startDate: self.startDate,
            endDate: self.endDate
        )
        let urlString = Requests.getGames.rawValue
        let getGamesResponse: GetGamesResponse? = await urlString.handleAsDecodable(data: getGamesRequest)
        print(getGamesResponse?.games)
    }
}
