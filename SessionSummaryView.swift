import SwiftUI

struct SessionSummaryView: View {
    @Binding var showHomeView: Bool

    var body: some View {
        VStack {
            Text("Session Complete")
                .font(.largeTitle)
                .padding()

            Text("Great job! You've completed your breathing session.")
                .font(.title2)
                .padding()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                showHomeView = true
            }
        }
    }
}
