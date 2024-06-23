import SwiftUI

struct BreathingSessionView: View {
    @State private var phase = 0
    @State private var barHeight: CGFloat = 15
    @State private var totalHeight: CGFloat = 0
    @State private var progress: CGFloat = 0
    @State private var remainingTime: Double
    @State private var backgroundColor: Color = Color.blue.opacity(0.7)
    @State private var showSummary = false
    @State private var phaseText: String = "Inhale"
    @State private var showCancel = false
    @Binding var showHomeView: Bool

    let timer = Timer.publish(every: 4, on: .main, in: .common).autoconnect()
    let sessionTimer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    init(exercise: BreathingExercise, showHomeView: Binding<Bool>, selectedDuration: Double) {
        self._remainingTime = State(initialValue: selectedDuration)
        self._showHomeView = showHomeView
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)
                    .animation(.easeInOut(duration: 4))

                VStack {
                    CountdownTimerView(remainingTime: $remainingTime)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Spacer()

                    // Breathing Guide Circle
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: barHeight, height: barHeight)
                        .animation(.easeInOut(duration: 4))

                    Spacer()

                    // Instruction Text at the Bottom
                    Text(phaseText)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black.opacity(0.7))
                        .cornerRadius(10)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.bottom, 50)
                        .animation(.none)
                }
                .onAppear {
                    totalHeight = geometry.size.height
                    startSession()
                }
                .onReceive(timer) { _ in
                    withAnimation(.easeInOut(duration: 4)) {
                        nextPhase(totalHeight: geometry.size.height)
                    }
                }

                // Cancel Button
                if showCancel {
                    VStack {
                        HStack {
                            ExitButtonView()
                                .padding()
                                .onTapGesture {
                                    showSummary = false
                                    remainingTime = 0
                                    showHomeView = true
                                }
                            Spacer()
                        }
                        Spacer()
                    }
                }
            }
            .onHover { hovering in
                showCancel = hovering
            }
            .sheet(isPresented: $showSummary) {
                SessionSummaryView(showHomeView: $showHomeView)
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
            return Color.green.opacity(0.7)
        case 1:
            return Color.yellow.opacity(0.7)
        case 2:
            return Color.blue.opacity(0.7)
        case 3:
            return Color.purple.opacity(0.7)
        default:
            return Color.blue.opacity(0.7)
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
        updateProgress()
    }

    private func updateProgress() {
        progress = 0
        withAnimation(.linear(duration: 4)) {
            progress = 1
        }
    }
}
