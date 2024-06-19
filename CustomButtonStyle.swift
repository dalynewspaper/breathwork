import SwiftUI

struct PlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: "play.fill")
                .foregroundColor(.black)
            configuration.label
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 10)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct MoreInfoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: "info.circle")
                .foregroundColor(.white)
            configuration.label
                .foregroundColor(.white)
        }
        .padding()
        .background(Color.gray.opacity(0.7))
        .cornerRadius(8)
        .shadow(radius: 10)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
