import SwiftUI

struct DurationSelectionView: View {
    @Binding var showDurationSelection: Bool
    @Binding var selectedDuration: Double
    @Binding var showCountdown: Bool
    var exercise: BreathingExercise

    var body: some View {
        VStack(spacing: 20) {
            Text(exercise.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.white) // Ensure text is white

            Text("Select Your Breathing Duration")
                .font(.title2)
                .foregroundColor(.gray) // Ensure text is gray
                .padding(.bottom, 10)

            HStack(spacing: 20) {
                DurationButton(title: "3 Minutes", duration: 180)
                DurationButton(title: "5 Minutes", duration: 300)
                DurationButton(title: "7 Minutes", duration: 420)
            }

            Button(action: {
                showDurationSelection = false
            }) {
                Text("Close")
                    .fontWeight(.semibold)
                    .frame(maxWidth: 100)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .shadow(radius: 10)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color.black.opacity(0.9)) // Ensure background is black
                .shadow(radius: 10)
        )
        .frame(maxWidth: 800)
    }

    @ViewBuilder
    private func DurationButton(title: String, duration: Double) -> some View {
        Button(action: {
            selectedDuration = duration
            showDurationSelection = false
            showCountdown = true
        }) {
            Text(title)
                .fontWeight(.semibold)
                .frame(minWidth: 100) // Ensure the button has enough width for text
                .foregroundColor(.white)
                .cornerRadius(10)
                .shadow(radius: 10)
        }
        .buttonStyle(HomeDurationButtonStyle())
    }
}

struct DurationSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DurationSelectionView(
                showDurationSelection: .constant(true),
                selectedDuration: .constant(60),
                showCountdown: .constant(false),
                exercise: BreathingExercise(
                    name: "Box Breathing",
                    duration: 240,
                    description: "Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, hold for 4 seconds.",
                    howItWorks: "Box breathing involves inhaling, holding the breath, exhaling, and holding again for equal lengths of time. This balanced breathing pattern helps stabilize and calm the mind.",
                    purpose: "Used to calm the mind, reduce stress, and improve concentration. It’s often used by athletes and military personnel to stay focused under pressure.",
                    instructions: [
                        "Sit upright in a comfortable position.",
                        "Inhale through your nose for 4 seconds.",
                        "Hold your breath for 4 seconds.",
                        "Exhale through your nose for 4 seconds.",
                        "Hold your breath again for 4 seconds.",
                        "Repeat for 4-5 minutes."
                    ]
                )
            )
        }
    }
}
