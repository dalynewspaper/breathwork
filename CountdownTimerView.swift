import SwiftUI

struct CountdownTimerView: View {
    @Binding var remainingTime: Double
    @State private var countdownText: String = "00:00"

    var body: some View {
        Text(countdownText)
            .font(.largeTitle)
            .foregroundColor(.white)
            .padding(.top, 40)
            .onAppear {
                updateCountdownText()
            }
            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                if remainingTime > 0 {
                    remainingTime -= 1
                    updateCountdownText()
                }
            }
    }

    private func updateCountdownText() {
        let minutes = Int(remainingTime) / 60
        let seconds = Int(remainingTime) % 60
        countdownText = String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CountdownTimerView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownTimerView(remainingTime: .constant(60))
            .background(Color.black)
    }
}
