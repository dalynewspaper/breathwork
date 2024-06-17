import SwiftUI

struct DurationSelectionView: View {
    @Binding var showDurationSelection: Bool
    @Binding var selectedDuration: Double
    @Binding var showCountdown: Bool

    var body: some View {
        VStack {
            Text("Select Your Breathing Duration")
                .font(.title2)
                .padding(.bottom, 20)
            HStack(spacing: 20) {
                Button("1 Minute") {
                    selectedDuration = 60
                    showDurationSelection = false
                    showCountdown = true
                }
                .buttonStyle(CustomButtonStyle())
                Button("3 Minutes") {
                    selectedDuration = 180
                    showDurationSelection = false
                    showCountdown = true
                }
                .buttonStyle(CustomButtonStyle())
                Button("5 Minutes") {
                    selectedDuration = 300
                    showDurationSelection = false
                    showCountdown = true
                }
                .buttonStyle(CustomButtonStyle())
            }
            .padding()
        }
    }
}
