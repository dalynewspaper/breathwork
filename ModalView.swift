import SwiftUI

struct ModalView: View {
    var exercise: BreathingExercise
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            Spacer()

            ZStack(alignment: .topLeading) {
                VStack(alignment: .leading) {
                    // Image placeholder
                    Image("breathing-exercise-bg")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 250)
                        .clipped()

                    // Play button
                    HStack {
                        Button(action: {
                            // Action for play button
                        }) {
                            HStack {
                                Image(systemName: "play.fill")
                                Text("Start")
                            }
                        }
                        .buttonStyle(PlayButtonStyle())
                        .padding()

                        Spacer()
                    }
                    .background(Color.black.opacity(0.5))
                    .frame(maxWidth: .infinity)
                }

                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        VStack(alignment: .leading) {
                            Text(exercise.name)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                            Text(exercise.detailedDescription)
                                .font(.body)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()

                    Spacer()
                }
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .padding()
            }

            // Close button
            Button(action: {
                isPresented = false
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                    Text("Close")
                }
            }
            .buttonStyle(MoreInfoButtonStyle())
            .padding()
        }
        .background(Color.black.opacity(0.8))
        .edgesIgnoringSafeArea(.all)
    }
}
