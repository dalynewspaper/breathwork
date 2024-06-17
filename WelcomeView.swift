import SwiftUI

struct WelcomeView: View {
    @Binding var showWelcome: Bool

    var body: some View {
        VStack {
            Spacer()
            Text("Welcome to BreathWork")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            Text("Find your calm with our guided breathing exercises.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding(.bottom, 40)
            Spacer()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) { // Auto transition after 3 seconds
                showWelcome = false
            }
        }
    }
}
