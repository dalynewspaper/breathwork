import SwiftUI

struct DurationSelectionView: View {
    @Binding var showDurationSelection: Bool
    @Binding var selectedDuration: Double
    @Binding var showCountdown: Bool
    var exercise: BreathingExercise

    var body: some View {
        VStack {
            Text(exercise.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

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
            
            Button(action: {
                showDurationSelection = false
            }) {
                Text("Close")
                    .padding()
                    .background(Color.gray.opacity(0.7))
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .shadow(radius: 10)
            }
            .padding(.top, 10)
        }
        .padding()
        .frame(maxWidth: 400)
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding()
    }
}
