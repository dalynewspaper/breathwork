import SwiftUI

struct PlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: "play.fill")
            configuration.label
        }
        .padding()
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct MoreInfoButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Image(systemName: "info.circle")
            configuration.label
        }
        .padding()
        .background(Color.white)
        .foregroundColor(Color.black)
        .cornerRadius(10)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct DurationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.white)
            .foregroundColor(Color.black)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}

struct HomeDurationButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.clear)
            .foregroundColor(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
