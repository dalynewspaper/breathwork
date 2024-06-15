import SwiftUI

@main
struct BreathWorkApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(width: 400, height: 400)
        }
    }
}
