import SwiftUI

struct CountdownView: View {
    @Binding var showCountdown: Bool
    @Binding var countdown: Double
    @Binding var showBreathingSession: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("Starting in \(Int(countdown))")
                .font(.largeTitle)
                .padding()
                .multilineTextAlignment(.center) // Ensure text is centered
            Spacer()
        }
        .onAppear {
            startCountdown()
        }
    }

    private func startCountdown() {
        guard countdown > 0 else {
            showCountdown = false
            showBreathingSession = true
            return
        }

        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            countdown -= 1
            if countdown <= 0 {
                timer.invalidate()
                showCountdown = false
                showBreathingSession = true
            }
        }
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(showCountdown: .constant(true), countdown: .constant(3.0), showBreathingSession: .constant(false))
    }
}
