//
//  nano_sprintApp.swift
//  nano-sprint
//
//  Created by Chris on 1/31/24.
//

import SwiftUI

@main
struct nano_sprintApp: App {
    @State private var helpOpened = false
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .commands {
            CommandGroup(replacing: .help) {
                Button(action: {
                    if !helpOpened {
                        helpOpened.toggle()
                        HelpView(isOpen: $helpOpened).openNewWindow(with: "nano-sprint Help")
                    }
                }) {
                    Text("nand-sprint Help")
                }
            }
        }
    }
}

extension View {
    func openNewWindow(with title: String = "new Window") {
        let window = NSWindow(
            contentRect: NSRect(x: 20, y: 20, width: 640, height: 420),
            styleMask: [.titled, .miniaturizable, .resizable, .closable, .fullSizeContentView],
            backing: .buffered, defer: false)
        window.center()
        window.isReleasedWhenClosed = false
        window.title = title
        window.makeKeyAndOrderFront(nil)
        window.contentView = NSHostingView(rootView: self)
    }
}

struct HelpView: View {
    @Binding var isOpen: Bool
    var body: some View {
        VStack {
            Text("Line 1: Current clock time in h:mm a.")
            Text("Line 2: Remainig time on timer in h:mm:ss. When time is up will go negative.")
            Text("Line 3: Clock time when timer will end in h:mm a. If timer is negative, this is the time it reached 0.")
            Text("Click anywhere on the window to reset and run the timer.")
                .padding()
            Text("While timer running, window will turn mint color.")
            Text("While timer has completed, window will turn red color.")
        }
        .onDisappear {
            isOpen = false
        }
        .onAppear {
            isOpen = true
        }
    }
}

    
