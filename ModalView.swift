import SwiftUI

struct ModalView: View {
    var exercise: BreathingExercise
    @Binding var isPresented: Bool
    @Binding var showHomeView: Bool
    @Binding var selectedExercise: BreathingExercise?
    @Binding var selectedDuration: Double
    @State private var showDurationSelection: Bool = false
    @State private var showCountdown: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 10)

                VStack {
                    Spacer()

                    ZStack(alignment: .topTrailing) {
                        modalContent(geometry: geometry)

                        ExitButtonView()
                            .padding([.top, .trailing], 10)
                            .onTapGesture {
                                isPresented = false
                            }
                    }
                    .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                }
            }
            .transition(.move(edge: .bottom))
            .animation(.easeInOut(duration: 0.3), value: isPresented)
        }
    }

    @ViewBuilder
    private func modalContent(geometry: GeometryProxy) -> some View {
        ScrollView {
            VStack(alignment: .leading) {
                Image("breathing-exercise-bg")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.4)
                    .clipped()

                modalTextContent()
                    .padding()
                    .background(Color.black.opacity(0.7))
                    .cornerRadius(10)
                    .padding([.leading, .trailing, .bottom])
            }
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

    @ViewBuilder
    private func modalTextContent() -> some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(exercise.name)
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)
                .padding(.top)

            HStack {
                Button(action: {
                    selectedExercise = exercise
                    showHomeView = false
                    isPresented = false
                }) {
                    HStack {
                        Text("Play")
                    }
                }
                .buttonStyle(PlayButtonStyle())
                .padding(.bottom)

                Button(action: {
                    showDurationSelection.toggle()
                }) {
                    HStack {
                        Image(systemName: "clock")
                        Text("\(Int(selectedDuration / 60)) minute\(selectedDuration > 60 ? "s" : "")")
                    }
                }
                .padding(.horizontal)
                .buttonStyle(HomeDurationButtonStyle())
                .padding(.bottom)
                .sheet(isPresented: $showDurationSelection) {
                    DurationSelectionView(showDurationSelection: $showDurationSelection, selectedDuration: $selectedDuration, showCountdown: $showCountdown, exercise: exercise)
                }
            }

            Text("How it works:")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 2)

            Text(exercise.howItWorks)
                .font(.body)
                .foregroundColor(.white)
                .lineSpacing(5)
                .padding(.bottom, 10)

            Text("Purpose:")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 2)

            Text(exercise.purpose)
                .font(.body)
                .foregroundColor(.white)
                .lineSpacing(5)
                .padding(.bottom, 10)

            Text("Instructions:")
                .font(.headline)
                .foregroundColor(.white)
                .padding(.bottom, 2)

            VStack(alignment: .leading, spacing: 5) {
                ForEach(exercise.instructions, id: \.self) { instruction in
                    Text("• \(instruction)")
                        .font(.body)
                        .foregroundColor(.white)
                        .lineSpacing(5)
                }
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 10)
    }
}
