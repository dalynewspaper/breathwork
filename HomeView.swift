import SwiftUI
import Combine

struct HomeView: View {
    @Binding var showHomeView: Bool
    @Binding var selectedExercise: BreathingExercise?
    @Binding var selectedDuration: Double
    @State private var showDetail = false
    @State private var selectedDetailExercise: BreathingExercise?
    @State private var showDurationSelection: Bool = false
    @State private var showCountdown: Bool = false
    @State private var hoveredExercise: BreathingExercise?
    @State private var animationAmount: CGFloat = 1.0
    @State private var particles = [Particle]()
    @State private var timeOfDay: TimeOfDay = .day
    
    private let featuredExercise = exercises[2] // Select the featured exercise

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background Gradient
                LinearGradient(gradient: Gradient(colors: timeOfDay == .day ? [.blue, .purple] : [.black, .blue]),
                               startPoint: .top,
                               endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 2), value: timeOfDay)
                    .onAppear { setup(geometry: geometry) }

                // Interactive Particles
                ForEach(particles) { particle in
                    Circle()
                        .fill(Color.white)
                        .frame(width: particle.size, height: particle.size)
                        .position(particle.position)
                        .animation(Animation.linear(duration: 5).repeatForever(autoreverses: false))
                }

                VStack(alignment: .leading, spacing: 20) {
                    Spacer()

                    // Featured Breathing Exercise
                    VStack(alignment: .leading) {
                        Text(featuredExercise.name)
                            .font(.system(size: 48))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text(featuredExercise.description)
                            .font(.title3)
                            .foregroundColor(.white)
                            .lineLimit(3)
                            .truncationMode(.tail)
                            .padding(.top, 5)
                            .frame(maxWidth: geometry.size.width * 0.45, alignment: .leading)
                        HStack {
                            Button(action: {
                                selectedExercise = featuredExercise
                                showHomeView = false
                            }) {
                                HStack {
                                    Text("Play")
                                }
                            }
                            .buttonStyle(PlayButtonStyle())
                            .padding(.top, 10)

                            Button(action: {
                                selectedDetailExercise = featuredExercise
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
                                DurationSelectionView(showDurationSelection: $showDurationSelection, selectedDuration: $selectedDuration, showCountdown: $showCountdown, exercise: featuredExercise)
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
                            ForEach(exercises.filter { $0.id != featuredExercise.id }) { exercise in
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
                
                // Breathing Animation on the upper-right side
                VStack {
                    HStack {
                        Spacer()
                        VStack {
                            Circle()
                                .fill(Color.white.opacity(0.5))
                                .scaleEffect(animationAmount)
                                .frame(width: 200, height: 200)
                                .animation(Animation.easeInOut(duration: 4).repeatForever(autoreverses: true))
                                .onAppear {
                                    self.animationAmount = 1.0
                                    withAnimation {
                                        self.animationAmount = 1.5 // Subtle expansion
                                    }
                                }
                        }
                    }
                    Spacer()
                }
                .padding(.trailing, 80) // Adjust padding to keep it to the right
                .padding(.top, 80) // Adjust padding to keep it at the top

                if showDetail, let detailExercise = selectedDetailExercise {
                    ModalView(exercise: detailExercise, isPresented: $showDetail, showHomeView: $showHomeView, selectedExercise: $selectedExercise, selectedDuration: $selectedDuration)
                        .transition(.move(edge: .bottom))
                        .animation(.spring())
                }
            }
        }
    }
    
    private func setup(geometry: GeometryProxy) {
        // Set up particles
        let screenSize = geometry.size
        for _ in 0..<20 {
            let particle = Particle(position: CGPoint(x: CGFloat.random(in: 0...screenSize.width),
                                                      y: CGFloat.random(in: 0...screenSize.height)),
                                    size: CGFloat.random(in: 2...8))
            particles.append(particle)
        }
        
        // Set up day/night cycle
        updateTimeOfDay()
    }
    
    private func updateTimeOfDay() {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour >= 6 && hour < 18 {
            timeOfDay = .day
        } else {
            timeOfDay = .night
        }
    }
}

enum TimeOfDay {
    case day
    case night
}

struct Particle: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
}
