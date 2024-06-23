import SwiftUI

struct BreathingExerciseDetailView: View {
    var exercise: BreathingExercise
    @Binding var showDetail: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(exercise.name)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 10)

            ScrollView {
                Text(exercise.detailedDescription)
                    .font(.body)
                    .padding(.bottom, 20)
            }

            Button(action: {
                showDetail = false
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
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 20)
        .padding()
    }
}
