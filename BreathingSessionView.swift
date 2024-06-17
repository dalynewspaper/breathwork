import SwiftUI

struct BreathingSessionView: View {
    var remainingTime: Double

    @State private var phase = 0
    @State private var barHeight: CGFloat = 0
    @State private var totalHeight: CGFloat = 0
    @State private var progress: CGFloat = 0

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
                gradient: Theme.defaultTheme.gradient,
                startPoint: .top,
                endPoint: .bottom
            )
        }
    }

    private func toggleSession() {
        // Toggle session start/stop logic here
    }
}
