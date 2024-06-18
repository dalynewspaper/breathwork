import SwiftUI

struct ExitButtonView: View {
    @Binding var showDurationSelection: Bool

    var body: some View {
        Button(action: {
            showDurationSelection = true
        }) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
        }
        .buttonStyle(CustomExitButtonStyle())
    }
}
