import SwiftUI

struct CountdownView: View {
    @Binding var showCountdown: Bool
    @Binding var countdown: Int
    @Binding var showBreathingSession: Bool
    @Binding var showDurationSelection: Bool

    var body: some View {
        VStack {
            Text("Starting in...")
                .font(.largeTitle)
                .padding(.bottom, 20)
            Text("\(countdown)")
                .font(.system(size: 60))
                .fontWeight(.bold)
                .padding(.bottom, 20)
            Button("Cancel") {
                showCountdown = false
                showDurationSelection = true
                countdown = 3 // Reset countdown
            }
            .buttonStyle(CustomButtonStyle())
        }
        .onAppear {
            startCountdown()
        }
    }

    private func startCountdown() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if self.countdown > 0 {
                self.countdown -= 1
            } else {
                timer.invalidate()
                showCountdown = false
                showBreathingSession = true
            }
        }
    }
}
