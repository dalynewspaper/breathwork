import SwiftUI

struct DurationSelectionView: View {
    @Binding var showDurationSelection: Bool
    @Binding var selectedDuration: Double
    @Binding var showCountdown: Bool

    var body: some View {
        VStack {
            Text("Box Breathing")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            
            Text("Inhale for 4 seconds, hold the breath for 4 seconds, exhale for 4 seconds, and hold the breath again for 4 seconds. Used to calm the mind, reduce stress, and improve concentration. It’s often used by athletes and military personnel to stay focused under pressure.")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)

            Text("Select Your Breathing Duration")
                .font(.title2)
                .padding(.bottom, 20)

            HStack(spacing: 20) {
                Button("1 Minute") {
                    selectedDuration = 60
                    showDurationSelection = false
                    showCountdown = true
                }
                .buttonStyle(DurationButtonStyle())
                
                Button("3 Minutes") {
                    selectedDuration = 180
                    showDurationSelection = false
                    showCountdown = true
                }
                .buttonStyle(DurationButtonStyle())
                
                Button("5 Minutes") {
                    selectedDuration = 300
                    showDurationSelection = false
                    showCountdown = true
                }
                .buttonStyle(DurationButtonStyle())
            }
            .padding()
        }
        .padding()
    }
}
