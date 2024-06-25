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
                VStack(alignment: .leading, spacing: 10) {
                    Text("How it works:")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(exercise.howItWorks)
                        .font(.body)
                    
                    Text("Purpose:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    Text(exercise.purpose)
                        .font(.body)
                    
                    Text("Instructions:")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 10)
                    VStack(alignment: .leading, spacing: 5) {
                        ForEach(exercise.instructions.indices, id: \.self) { index in
                            Text("\(index + 1). \(exercise.instructions[index])")
                                .font(.body)
                        }
                    }
                }
                .padding(.horizontal)
                .multilineTextAlignment(.leading)
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
