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
    
    static let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .medium // Use a format like "1:54 PM"
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
                }
                .padding()
                .frame(width: geometry.size.width, height: geometry.size.height)
                .background(Color.white)
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
    
    func runTimer() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            remainingTime -= 1
        }
    }
    
    func resetTimer() {
        remainingTime = 1500
    }
}

#Preview {
    ContentView()
}
