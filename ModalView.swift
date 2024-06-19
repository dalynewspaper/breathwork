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

                    ZStack(alignment: .topTrailing) {
                        VStack(alignment: .leading) {
                            // Image placeholder
                            Image("breathing-exercise-bg")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.5)
                                .clipped()

                            VStack(alignment: .leading, spacing: 10) {
                                // Exercise Name
                                Text(exercise.name)
                                    .font(.system(size: 40))
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .padding(.top)

                                // Play Button
                                Button(action: {
                                    // Action for play button
                                }) {
                                    HStack {
                                        Text("Play")
                                    }
                                }
                                .buttonStyle(PlayButtonStyle())
                                .padding(.bottom)

                                // Exercise Description
                                Text(exercise.detailedDescription)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .padding(.bottom)
                            }
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                            .padding([.leading, .trailing, .bottom])
                        }
                        .background(Color.black)
                        .cornerRadius(20)
                        .shadow(radius: 20)
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.white, lineWidth: 1)
                        )

                        // Exit Button
                        ExitButtonView()
                            .padding([.top, .trailing], 10)
                            .onTapGesture {
                                isPresented = false
                            }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
        }
    }
}
