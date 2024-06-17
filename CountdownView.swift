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
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Text("\(countdown)")
                .font(.system(size: 100))
                .foregroundColor(.white)

            Button(action: {
                showCountdown = false
                showDurationSelection = true
            }) {
                Text("Cancel")
                    .font(.title)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear(perform: startCountdown)
    }

    private func startCountdown() {
        let timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if countdown > 0 {
                countdown -= 1
            } else {
                timer.invalidate()
                showCountdown = false
                showBreathingSession = true
            }
        }
        timer.fire()
    }
}

struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        CountdownView(showCountdown: .constant(true), countdown: .constant(3), showBreathingSession: .constant(false), showDurationSelection: .constant(false))
    }
}
