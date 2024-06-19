import SwiftUI

struct ModalView: View {
    var exercise: BreathingExercise
    @Binding var isPresented: Bool

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)

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

                            VStack(alignment: .leading, spacing: 10) {
                                // Exercise Name
                                Text(exercise.name)
                                    .font(.largeTitle)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top)

                                // Exercise Description
                                Text(exercise.detailedDescription)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.bottom)

                                // Play Button
                                Button(action: {
                                    // Action for play button
                                }) {
                                    HStack {
                                        Text("Start")
                                    }
                                }
                                .buttonStyle(PlayButtonStyle())
                                .padding(.bottom)

                                // Close Button
                                Button(action: {
                                    isPresented = false
                                }) {
                                    HStack {
                                        Text("Close")
                                    }
                                }
                                .buttonStyle(MoreInfoButtonStyle())
                            }
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                            .padding()
                        }
                        .background(Color.black)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
    }
}
