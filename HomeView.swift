import SwiftUI

struct HomeView: View {
    @Binding var showHomeView: Bool
    @Binding var selectedExercise: BreathingExercise?
    @State private var showDetail = false
    @State private var selectedDetailExercise: BreathingExercise?
    @State private var selectedDuration: Double = 60
    @State private var showDurationSelection: Bool = false
    @State private var showCountdown: Bool = false
    @State private var hoveredExercise: BreathingExercise?

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color.black, Color.blue]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)

                VStack(alignment: .leading, spacing: 20) {
                    Spacer()
                    
                    // Featured Breathing Exercise
                    VStack(alignment: .leading) {
                        Text(exercises[2].name)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(exercises[2].description)
                            .font(.title3)
                            .foregroundColor(.white)
                            .lineLimit(3)
                            .truncationMode(.tail)
                            .padding(.top, 5)
                            .frame(maxWidth: geometry.size.width * 0.45, alignment: .leading)
                        HStack {
                            Button(action: {
                                selectedExercise = exercises[2]
                                showHomeView = false
                            }) {
                                HStack {
                                    Text("Play")
                                }
                            }
                            .buttonStyle(PlayButtonStyle())
                            .padding(.top, 10)

                            Button(action: {
                                selectedDetailExercise = exercises[2]
                                showDetail = true
                            }) {
                                HStack {
                                    Text("More Info")
                                }
                            }
                            .buttonStyle(MoreInfoButtonStyle())
                            .padding(.top, 10)
                            
                            // Duration Button
                            Button(action: {
                                showDurationSelection.toggle()
                            }) {
                                HStack {
                                    Image(systemName: "clock")
                                    Text("\(Int(selectedDuration / 60)) minute\(selectedDuration > 60 ? "s" : "")")
                                }
                            }
                            .padding(.horizontal)
                            .padding(.top, 10)
                            .buttonStyle(HomeDurationButtonStyle())
                            .sheet(isPresented: $showDurationSelection) {
                                DurationSelectionView(showDurationSelection: $showDurationSelection, selectedDuration: $selectedDuration, showCountdown: $showCountdown)
                            }
                        }
                    }
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding(.horizontal)

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
                                        .frame(maxWidth: geometry.size.width * 0.45, alignment: .leading)
                                    if hoveredExercise == exercise {
                                        HStack {
                                            Button(action: {
                                                selectedExercise = exercise
                                                showHomeView = false
                                            }) {
                                                HStack {
                                                    Text("Play")
                                                }
                                            }
                                            .buttonStyle(PlayButtonStyle())

                                            Button(action: {
                                                selectedDetailExercise = exercise
                                                showDetail = true
                                            }) {
                                                HStack {
                                                    Text("More Info")
                                                }
                                            }
                                            .buttonStyle(MoreInfoButtonStyle())
                                        }
                                        .padding(.top, 10)
                                    }
                                }
                                .padding()
                                .background(Color.black.opacity(0.7))
                                .cornerRadius(10)
                                .frame(width: 300, height: hoveredExercise == exercise ? 540 : 270) // Adjust height based on hover
                                .scaleEffect(selectedDetailExercise == exercise ? 1.1 : 1.0)
                                .onTapGesture {
                                    selectedDetailExercise = exercise
                                    showDetail = true
                                }
                                .onHover { hovering in
                                    hoveredExercise = hovering ? exercise : nil
                                }
                                .animation(.spring())
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 270) // Ensure the height here is appropriate for your content
                    .padding(.bottom, 10)
                }
                .frame(maxHeight: .infinity, alignment: .topLeading)

                if showDetail, let detailExercise = selectedDetailExercise {
                    ModalView(exercise: detailExercise, isPresented: $showDetail, selectedDuration: $selectedDuration)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
        }
    }
}
