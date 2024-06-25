import SwiftUI

struct BreathingSessionView: View {
    @State private var phaseIndex = 0
    @State private var barHeight: CGFloat = 15
    @State private var totalHeight: CGFloat = 0
    @State private var remainingTime: Double
    @State private var phaseRemainingTime: Double = 0
    @State private var backgroundColor: Color = Color.blue.opacity(0.7)
    @State private var showSummary = false
    @State private var phaseText: String = ""
    @State private var showCancel = false
    @Binding var showHomeView: Bool

    let exercise: BreathingExercise
    let phases: [BreathingPhase]

    @State private var phaseTimer: Timer?
    @State private var countdownTimer: Timer?
    @State private var showDurationSelection = false
    @State private var showCountdown = false

    init(exercise: BreathingExercise, showHomeView: Binding<Bool>, selectedDuration: Double) {
        self._remainingTime = State(initialValue: selectedDuration)
        self._showHomeView = showHomeView
        self.exercise = exercise

        // Initialize phases based on the exercise
        switch exercise.name {
        case "Diaphragmatic Breathing":
            self.phases = diaphragmaticPhases
        case "4-7-8 Breathing":
            self.phases = fourSevenEightPhases
        case "Box Breathing":
            self.phases = boxBreathingPhases
        case "Alternate Nostril Breathing":
            self.phases = alternateNostrilPhases
        case "Buteyko Breathing":
            self.phases = buteykoPhases
        case "Pursed Lip Breathing":
            self.phases = pursedLipPhases
        default:
            self.phases = []
        }
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                    .transition(.opacity)

                VStack {
                    Text(timeString(time: remainingTime))
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 40)

                    Spacer()

                    // Breathing Guide Circle
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: barHeight, height: barHeight)
                        .animation(.easeInOut(duration: currentPhaseDuration()), value: barHeight)

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
                }
                .onAppear {
                    totalHeight = geometry.size.height
                    startSession()
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
                                    stopTimers()
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
            .sheet(isPresented: $showDurationSelection) {
                DurationSelectionView(showDurationSelection: $showDurationSelection, selectedDuration: $remainingTime, showCountdown: $showCountdown, exercise: exercise)
            }
        }
    }

    private func startSession() {
        phaseIndex = 0 // Start with the first phase
        phaseRemainingTime = currentPhaseDuration()
        updatePhaseText()
        startPhaseTimer()
        startCountdownTimer()
    }

    private func stopTimers() {
        phaseTimer?.invalidate()
        countdownTimer?.invalidate()
    }

    private func startPhaseTimer() {
        scheduleNextPhase()
    }

    private func scheduleNextPhase() {
        phaseTimer?.invalidate()
        let duration = currentPhaseDuration()
        phaseRemainingTime = duration
        phaseTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if phaseRemainingTime > 0 {
                phaseRemainingTime -= 1
                updatePhaseText()
            } else {
                timer.invalidate()
                withAnimation(.easeInOut(duration: duration)) {
                    nextPhase(totalHeight: totalHeight)
                }
                scheduleNextPhase() // Schedule the next phase
            }
        }
    }

    private func startCountdownTimer() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if remainingTime > 0 {
                remainingTime -= 1
            } else {
                showSummary = true
                stopTimers()
            }
        }
    }

    private func nextPhase(totalHeight: CGFloat) {
        if phases.isEmpty { return }

        phaseIndex = (phaseIndex + 1) % phases.count
        let currentPhase = phases[phaseIndex]
        phaseText = "\(currentPhase.name) for \(Int(currentPhase.duration)) seconds"
        backgroundColor = currentPhase.color

        switch currentPhase.name {
        case "Inhale":
            barHeight = totalHeight * 0.7
        case "Exhale":
            barHeight = 15
        case "Hold":
            barHeight = barHeight // Maintain the current height during hold phases
        default:
            break
        }

        phaseRemainingTime = currentPhase.duration
    }

    private func updatePhaseText() {
        let currentPhase = phases[phaseIndex]
        phaseText = "\(currentPhase.name) for \(Int(phaseRemainingTime)) seconds"
    }

    private func currentPhaseDuration() -> TimeInterval {
        return phases.isEmpty ? 1 : phases[phaseIndex].duration
    }

    private func timeString(time: Double) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
