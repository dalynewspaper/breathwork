import SwiftUI

struct HomeView: View {
    @Binding var showHomeView: Bool
    @Binding var selectedExercise: BreathingExercise?

    let exercises = [
        BreathingExercise(name: "Diaphragmatic Breathing", duration: 300, description: "Deep breathing through the diaphragm rather than shallow breathing through the chest."),
        BreathingExercise(name: "4-7-8 Breathing", duration: 300, description: "Inhale through the nose for 4 seconds, hold the breath for 7 seconds, and exhale slowly through the mouth for 8 seconds."),
        BreathingExercise(name: "Box Breathing", duration: 240, description: "Inhale for 4 seconds, hold for 4 seconds, exhale for 4 seconds, hold for 4 seconds. Used to calm the mind, reduce stress, and improve concentration. It’s often used by athletes and military personnel to stay focused under pressure."),
        BreathingExercise(name: "Alternate Nostril Breathing", duration: 300, description: "Close the right nostril and inhale through the left nostril, then close the left nostril and exhale through the right. Inhale through the right, then close the right and exhale through the left."),
        BreathingExercise(name: "Buteyko Breathing", duration: 300, description: "Focuses on breathing through the nose and reducing the overall breathing volume to increase carbon dioxide levels in the body."),
        BreathingExercise(name: "Pursed Lip Breathing", duration: 300, description: "Inhale through the nose and exhale slowly through pursed lips, like blowing out a candle."),
        BreathingExercise(name: "Belly Breathing", duration: 300, description: "Involves deep inhalations that expand the belly. Reduces stress, lowers blood pressure, and improves core stability.")
    ]

    var body: some View {
        ZStack {
            Image("breathing-exercise-bg")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack(alignment: .leading) {
                // Featured Breathing Exercise
                VStack(alignment: .leading) {
                    Text(exercises[2].name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    Text(exercises[2].description)
                        .font(.title3)
                        .foregroundColor(.white)
                        .lineLimit(3)
                        .truncationMode(.tail)
                        .padding(.top, 5)
                        .frame(width: 600, height: 150)
                    HStack {
                        Button(action: {
                            selectedExercise = exercises[2]
                            showHomeView = false
                        }) {
                            Text("Start")
                        }
                        .buttonStyle(CustomButtonStyle())
                        .padding(.top, 10)
                        
                        Button(action: {
                            // Show more info
                        }) {
                            Text("More Info")
                        }
                        .buttonStyle(CustomButtonStyle())
                        .padding(.top, 10)
                    }
                }
                .padding()
                .background(Color.black.opacity(0.7))
                .cornerRadius(10)
                .padding()

                // Other Breathing Exercises
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(exercises) { exercise in
                            VStack(alignment: .leading) {
                                Text(exercise.name)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                Text(exercise.description)
                                    .font(.body)
                                    .foregroundColor(.white)
                                    .lineLimit(2)
                                    .truncationMode(.tail)
                                    .padding(.top, 5)
                                HStack {
                                    Button(action: {
                                        selectedExercise = exercise
                                        showHomeView = false
                                    }) {
                                        Text("Start")
                                    }
                                    .buttonStyle(CustomButtonStyle())
                                    .padding(.top, 10)
                                    
                                    Button(action: {
                                        // Show more info
                                    }) {
                                        Text("More Info")
                                    }
                                    .buttonStyle(CustomButtonStyle())
                                    .padding(.top, 10)
                                }
                            }
                            .padding()
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                            .frame(width: 300)
                        }
                    }
                    .padding()
                }
            }
            .padding(.top, 350)
        }
    }
}
