import SwiftUI

struct BreathingSessionView: View {
    @State private var phase = 0
    @State private var barHeight: CGFloat = 15
    @State private var totalHeight: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var remainingTime: Double
    @State private var backgroundColor: Color = Color.blue.opacity(0.1)
    @State private var showSummary = false

    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()

    init(remainingTime: Double) {
        self._remainingTime = State(initialValue: remainingTime)
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 4))

                VStack {
                    Spacer()
                    
                    // Countdown Timer
                    Text("\(Int(remainingTime))")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)
                    
                    Spacer()

                    // Breathing Guide Circle
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: barHeight, height: barHeight)
                        .animation(.easeInOut(duration: 4))

                    Spacer()

                    // Instruction Text
                    Text(getCurrentPhaseText())
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding()
                        .transition(.scale)
                        .animation(.easeInOut(duration: 0.5))

                    // Progress Bar
                    ProgressView(value: progress, total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: Color.white))
                        .frame(width: geometry.size.width * 0.8)
                        .padding(.bottom, 20)
                }
                .onAppear {
                    totalHeight = geometry.size.height
                    startSession()
                }
                .onReceive(timer) { _ in
                    withAnimation(.easeInOut(duration: 4)) {
                        nextPhase(totalHeight: geometry.size.height)
                    }
                    updateRemainingTime()
                }
            }
            .sheet(isPresented: $showSummary) {
                SessionSummaryView(showSummary: $showSummary)
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
            return ""
        }
    }

    private func getCurrentColor() -> Color {
        switch phase {
        case 0:
            return Color.green.opacity(0.3)
        case 1:
            return Color.yellow.opacity(0.3)
        case 2:
            return Color.red.opacity(0.3)
        case 3:
            return Color.purple.opacity(0.3)
        default:
            return Color.blue.opacity(0.1)
        }
    }

    private func nextPhase(totalHeight: CGFloat) {
        phase = (phase + 1) % 4
        backgroundColor = getCurrentColor()
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
        updateProgress()
    }

    private func updateProgress() {
        progress = 0
        withAnimation(.linear(duration: 4)) {
            progress = 1
        }
    }

    private func updateRemainingTime() {
        if remainingTime > 0 {
            remainingTime -= 4
        }
    }
}

struct SessionSummaryView: View {
    @Binding var showSummary: Bool

    var body: some View {
        VStack {
            Text("Session Complete")
                .font(.largeTitle)
                .padding()

            Text("Great job! You've completed your breathing session.")
                .font(.title2)
                .padding()

            Button(action: {
                showSummary = false
            }) {
                Text("Restart")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            Button(action: {
                showSummary = false
            }) {
                Text("Return to Main Menu")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
    }
}

struct BreathingSessionView_Previews: PreviewProvider {
    static var previews: some View {
        BreathingSessionView(remainingTime: 60)
    }
}
