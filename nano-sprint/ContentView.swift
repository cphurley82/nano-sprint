//
//  ContentView.swift
//  nano-sprint
//
//  Created by Chris on 1/31/24.
//

import SwiftUI

struct ContentView: View {
    @State private var timerIsActive = false
    @State private var remainingTime: TimeInterval = 0
    @State private var finishTime: Date = Date()
    @State private var color: Color = Color.white
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm" // Use a format like "13:54"
        return formatter
    }()

    
    static let remainingTimeFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        return formatter
    }()
    
    var body: some View {
        TimelineView(.periodic(from: Date.now, by: 0.1)) { timeline in
            GeometryReader { geometry in
                VStack {
                    Text(getTime())
                    Text(getRemainingTime())
                    Text(getFinishTime())
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(color)
                .onAppear() {
                    runTimer()
                }
                .onTapGesture {
                    resetTimer()
                }
            }
        }
    }
    
    func getTime() -> String {
        let now = Date()
        return ContentView.timeFormatter.string(from: now)
    }
    
    func getRemainingTime() -> String {
        return ContentView.remainingTimeFormatter.string(from: remainingTime) ?? "nil"
    }
    
    func getFinishTime() -> String {
        return ContentView.timeFormatter.string(from: finishTime)
    }
    
    func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            remainingTime -= 1
            if remainingTime < 0 {
                color = Color.red
            }
        }

    }
    
    func resetTimer() {
        remainingTime = 1500
        finishTime = Date() + remainingTime
        color = Color.mint
    }
    
}

#Preview {
    ContentView()
}
