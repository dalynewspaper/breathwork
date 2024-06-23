import SwiftUI

struct ExitButtonView: View {
    var body: some View {
        Image(systemName: "xmark.circle.fill")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
    }
}
