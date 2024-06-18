import SwiftUI

struct CustomExitButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .padding()
            .background(Color.clear) // Make the background clear
            .clipShape(Circle())
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0) // Add a slight scaling effect on press
    }
}
