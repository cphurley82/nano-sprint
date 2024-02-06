//
//  ContentView.swift
//  nano-sprint
//
//  Created by Chris on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var finishTime: Date = Date()
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a" // Use a format like "13:54"
        return formatter
    }()
    
    static let remainingTimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    var body: some View {
        TimelineView(.periodic(from: Date.now, by: 1)) { timeline in
            GeometryReader { geometry in
                VStack {
                    Text(getTime())
                    Text(getTimeRemainingFormatted())
                    Text(getFinishTimeFormatted())
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(getTimerColor())
                .onTapGesture {
                    resetTimer()
                }
            }
        }
    }
    
    func getTime() -> String {
        return ContentView.timeFormatter.string(from: Date())
    }
    
    func getTimeRemaining() -> TimeInterval {
        return finishTime.timeIntervalSinceNow
    }
    
    func isTimeRemaining() -> Bool {
        return finishTime.timeIntervalSince(Date()) >= 0
    }
    
    func getTimeRemainingFormatted() -> String {
        let remainingTime = getTimeRemaining().rounded(.up)
        let remainingTimeFormatted = ContentView.remainingTimeFormatter.string(from: remainingTime) ?? "nil"
        return remainingTimeFormatted
    }
    
    func getFinishTimeFormatted() -> String {
        return ContentView.timeFormatter.string(from: finishTime)
    }
    
    func resetTimer() {
        finishTime = Date() + 1500 // 1500 seconds = 25 minutes
    }

    func getTimerColor() -> Color {
        if !isTimeRemaining() {
            return Color.red
        }
        return Color.mint
    }
}

#Preview {
    ContentView()
}
