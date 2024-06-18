import SwiftUI

struct BreathingSessionView: View {
    @State private var phase = -1 // Start with -1 to handle the first phase properly
    @State private var barHeight: CGFloat = 15
    @State private var totalHeight: CGFloat = 0
    @State private var remainingTime: Double
    @State private var backgroundColor: Color = Color.blue.opacity(0.1)
    @State private var showSummary = false
    @State private var phaseText: String = "Get Ready"
    @State private var showCancel = false
    @Binding var showDurationSelection: Bool

    let phaseDuration: Double = 4.0
    @State private var countdownText: String = "00:00"

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(remainingTime: Double, showDurationSelection: Binding<Bool>) {
        self._remainingTime = State(initialValue: remainingTime)
        self._showDurationSelection = showDurationSelection
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: phaseDuration))

                VStack {
                    Text(countdownText)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Spacer()

                    // Breathing Guide Circle
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: barHeight, height: barHeight)
                        .animation(.easeInOut(duration: phaseDuration))

                    Spacer()

                    // Instruction Text
                    Text(phaseText)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.5))
                }
                .onAppear {
                    totalHeight = geometry.size.height
                    startSession()
                    updateCountdownText()
                }
                .onReceive(timer) { _ in
                    if remainingTime > 0 {
                        remainingTime -= 1
                        updateCountdownText()
                        if Int(remainingTime) % Int(phaseDuration) == 0 {
                            withAnimation(.easeInOut(duration: phaseDuration)) {
                                nextPhase(totalHeight: geometry.size.height)
                            }
                        }
                    } else {
                        showSummary = true
                    }
                }

                // Exit Button
                if showCancel {
                    ExitButtonView(showDurationSelection: $showDurationSelection)
                        .position(x: 40, y: 40)
                }
            }
            .onHover { hovering in
                showCancel = hovering
            }
            .sheet(isPresented: $showSummary) {
                SessionSummaryView(showSummary: $showSummary, showDurationSelection: $showDurationSelection)
            }
        }
    }

    private func startSession() {
        Timer.scheduledTimer(withTimeInterval: remainingTime, repeats: false) { _ in
            showSummary = true
        }
    }

    private func getCurrentPhaseText() -> String {
        switch phase {
        case 0:
            return "Inhale"
        case 1:
            return "Hold"
        case 2:
            return "Exhale"
        case 3:
            return "Hold"
        default:
            return "Get Ready"
        }
    }

    private func getCurrentColor() -> Color {
        switch phase {
        case 0:
            return Color.green.opacity(0.3) // Inhale: Green for calmness and tranquility
        case 1:
            return Color.yellow.opacity(0.3) // Hold: Yellow for energy and focus
        case 2:
            return Color.blue.opacity(0.3) // Exhale: Blue for relaxation
        case 3:
            return Color.purple.opacity(0.3) // Hold: Purple for balance and mindfulness
        default:
            return Color.blue.opacity(0.1)
        }
    }

    private func nextPhase(totalHeight: CGFloat) {
        phase = (phase + 1) % 4
        backgroundColor = getCurrentColor()
        phaseText = getCurrentPhaseText()
        switch phase {
        case 0:
            barHeight = totalHeight * 0.7 // Inhale
        case 1:
            barHeight = totalHeight * 0.7 // Hold
        case 2:
            barHeight = 15 // Exhale
        case 3:
            barHeight = 15 // Hold
        default:
            break
        }
    }

    private func updateCountdownText() {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        countdownText = String(format: "%02d:%02d", minutes, seconds)
    }
}
