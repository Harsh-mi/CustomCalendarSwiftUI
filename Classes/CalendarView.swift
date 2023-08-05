//
//  CalendarView.swift
//  SwiftUiCustomCalendar
//
//  Created by Harsh on 04/08/23.
//
import SwiftUI

public struct DateValue: Identifiable{
    public var id = UUID().uuidString
    public var day: Int
    public var date: Date
}

public struct CalendarView: View {
    
    @Binding public var currentDate: Date
    @State public var currentMonth: Int = 0
    
    public let yearNameColor: Color
    public let monthNameColor: Color
    public let leftArrowColor: Color
    public let rightArrowColor: Color
    public let selectedDateColor: Color
    public let calendarHeight: CGFloat
    
    public let weekDays: [String] = ["S", "M", "T", "W", "T", "F", "S"]
    public let eventIconString: String = "🗓️"
    public let gridColumns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(startingDate: Binding<Date>, currentMonth: State<Int>, yearNameColor: Color, monthNameColor: Color, leftArrowColor: Color, rightArrowColor: Color, selectedDateColor: Color, calendarHeight: CGFloat) {
        _currentDate = startingDate
        _currentMonth = currentMonth
        self.yearNameColor = yearNameColor
        self.monthNameColor = monthNameColor
        self.leftArrowColor = leftArrowColor
        self.rightArrowColor = rightArrowColor
        self.selectedDateColor = selectedDateColor
        self.calendarHeight = calendarHeight
    }
    
    public var body: some View {
        
        VStack {
            HStack{
                VStack(alignment: .leading, spacing: 0) {
                    Text(Calendar.current.component(.year, from: currentDate).description)
                        .font(.system(size: 14))
                        .foregroundColor(yearNameColor)
                    
                    HStack(spacing: 10) {
                        
                        Text(getYearMonthName()[1].uppercased())
                            .font(.system(size: 22).bold())
                            .foregroundColor(monthNameColor)
                        
                        Button {
                            currentMonth -= 1
                        } label: {
                            Image(systemName: "chevron.left")
                                .tint(leftArrowColor)
                                .font(.system(size: 18))
                        }
                        
                        Button {
                            currentMonth += 1
                        } label: {
                            Image(systemName: "chevron.right")
                                .tint(rightArrowColor)
                                .font(.system(size: 18))
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 10)
            .padding(.horizontal)
            .padding(.bottom, 15)
            
            HStack (spacing: 8) {
                ForEach(weekDays, id: \.self) { day in
                    Text(day)
                        .foregroundColor(day == "S" ? .gray : .primary)
                        .font(.system(size: 15))
                        .frame(maxWidth: .infinity)
                }
            }
            
                LazyVGrid(columns: gridColumns, spacing: 0) {
                    ForEach(retriveDates()) { value in
                        CardView(value: value)
                            .frame(width: value.day != -1 ? calendarHeight * 0.1 : 0, height: calendarHeight * 0.2)
                            .background(isTodayDate(date: value.date) ? selectedDateColor : Color.clear)
                            .cornerRadius(calendarHeight / 2)
                            .onTapGesture {
                                currentDate = value.date
                            }
                    }
                }
        }
        .onChange(of: currentMonth) { newValue in
            currentDate = getCurrentMonth()
        }
    }
}

//MARK: - Current Month and Date methods -
extension CalendarView {
    
    func getCurrentMonth () -> Date {
        
        let calendar = Calendar.current
        
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        return currentMonth
    }
    
    func retriveDates() -> [DateValue] {
        
        let calendar = Calendar.current
        
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date
            -> DateValue in
            
            let day = calendar.component(.day, from: date)
            
            return DateValue(day: day, date: date)
        }
        
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        return days
    }
    
    func getYearMonthName() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMM"
        let date = formatter.string(from: currentDate)
        return date.components(separatedBy: " ")
    }
}
//MARK: - Month wise days methods -
extension CalendarView {
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {
        
        VStack(spacing: 0) {
            if value.day != -1 {
                
                Text(isTodayDate(date : value.date) ? "\(value.day)" : "\(value.day)")
                    .padding(.horizontal, isTodayDate(date : value.date) ? 5 : 0)
                    .foregroundColor(isTodayDate(date : value.date) ? .white : (value.date.get(.weekday) == 1 || value.date.get(.weekday) == 7) ? .gray : .primary)
                
                Image(systemName: isTodayDate(date : value.date) ? "calendar" : "")
                    .frame(width: calendarHeight * 0.1)
            }
        }
    }
    //For checking is date is today's date or not
    func isTodayDate(date: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDateInToday(date)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView(startingDate: .constant(Date()), currentMonth: .init(initialValue: 0), yearNameColor: Color.black, monthNameColor: Color.black, leftArrowColor: Color.blue, rightArrowColor: Color.blue, selectedDateColor: Color.blue, calendarHeight: 300)
    }
}

//Extension for date
extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        return range.compactMap { day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
        }
    }
    
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

