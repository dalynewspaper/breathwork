//
//  BreathingSessionView.swift
//  BreathWork
//
//  Created by Brian Daly on 17.06.24.
//

import SwiftUI

struct BreathingSessionView: View {
    @State private var phase = 0
    @State private var barHeight: CGFloat = 0
    @State private var totalHeight: CGFloat = 0
    @State private var selectedTheme: Theme = .defaultTheme
    @State private var progress: CGFloat = 0
    @State private var remainingTime: Double
    @State private var sessionActive = true

    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Spacer()
                    HStack(alignment: .bottom) {
                        VStack {
                            Spacer()
                            Rectangle()
                                .fill(getCurrentColor())
                                .frame(width: 25, height: barHeight)
                                .onReceive(timer) { _ in
                                    withAnimation(.easeInOut(duration: getCurrentDuration())) {
                                        nextPhase(totalHeight: geometry.size.height)
                                    }
                                }
                        }
                        Spacer()
                    }
                }
                .background(Color.clear)
                .onAppear {
                    totalHeight = geometry.size.height
                    barHeight = 15 // Initial small height
                }

                // Progress Indicator
                VStack {
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(width: geometry.size.width * 0.8)
                        .padding(.top, 20)
                    Spacer()
                }

                // Timer and Session End Handling
                VStack {
                    Text("Time Remaining: \(Int(remainingTime))s")
                        .font(.headline)
                        .padding()
                    Spacer()
                }
                .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                    } else {
                        sessionActive = false
                        phase = 0
                        barHeight = 15
                        progress = 0
                    }
                }

                // Key Event Handling View
                KeyEventHandlingView { event in
                    if event.keyCode == 11 && event.modifierFlags.contains(.command) { // 11 is the keyCode for 'B'
                        toggleSession()
                    }
                }
                .frame(width: 0, height: 0) // Invisible frame
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottomLeading)
        .onAppear {
            updateProgress()
        }
    }
    
    private func getCurrentDuration() -> Double {
        return 4.0 // Each phase (inhale, hold, exhale, hold) is 4 seconds
    }
    
    private func nextPhase(totalHeight: CGFloat) {
        phase = (phase + 1) % 4
        switch phase {
        case 0:
            barHeight = totalHeight // Inhale
        case 1:
            barHeight = totalHeight // Hold
        case 2:
            barHeight = 15 // Exhale
        case 3:
            barHeight = 15 // Hold
        default:
            break
        }
        updateProgress()
    }

    private func updateProgress() {
        progress = 0
        withAnimation(.linear(duration: getCurrentDuration())) {
            progress = 1
        }
    }

    private func getCurrentColor() -> LinearGradient {
        switch phase {
        case 1, 3:
            // Hold phase (completely purple)
            return LinearGradient(
                gradient: Gradient(colors: [Color.purple.opacity(0.7), Color.purple.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
        default:
            // Inhale or Exhale phase (blue gradient)
            return LinearGradient(
                gradient: selectedTheme.gradient,
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func toggleSession() {
        // Toggle session start/stop logic here
    }
}

enum Theme: String, CaseIterable, Identifiable {
    case defaultTheme
    case calmingTheme
    case energizingTheme

    var id: String { self.rawValue }

    var gradient: Gradient {
        switch self {
        case .defaultTheme:
            return Gradient(colors: [Color.blue, Color.purple])
        case .calmingTheme:
            return Gradient(colors: [Color.green, Color.blue])
        case .energizingTheme:
            return Gradient(colors: [Color.red, Color.orange])
        }
    }

    var inhaleColors: [Color] {
        switch self {
        case .defaultTheme:
            return [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]
        case .calmingTheme:
            return [Color.green.opacity(0.7), Color.blue.opacity(0.7)]
        case .energizingTheme:
            return [Color.red.opacity(0.7), Color.orange.opacity(0.7)]
        }
    }

    var holdColors: [Color] {
        switch self {
        case .defaultTheme:
            return [Color.green.opacity(0.7), Color.yellow.opacity(0.7)]
        case .calmingTheme:
            return [Color.blue.opacity(0.7), Color.purple.opacity(0.7)]
        case .energizingTheme:
            return [Color.orange.opacity(0.7), Color.yellow.opacity(0.7)]
        }
    }
    var exhaleColors: [Color] {
    switch self {
    case .defaultTheme:
    return [Color.red.opacity(0.7), Color.orange.opacity(0.7)]
    case .calmingTheme:
    return [Color.blue.opacity(0.7), Color.green.opacity(0.7)]
    case .energizingTheme:
    return [Color.yellow.opacity(0.7), Color.red.opacity(0.7)]
    }
    }
    }

    struct BreathingSessionView_Previews: PreviewProvider {
    static var previews: some View {
    BreathingSessionView(remainingTime: 60)
    }
    }

