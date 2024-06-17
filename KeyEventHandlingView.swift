import SwiftUI

struct KeyEventHandlingView: NSViewRepresentable {
    var onKeyEvent: (NSEvent) -> Void

    func makeNSView(context: Context) -> NSView {
        let nsView = NSView()
        let eventMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown, .keyUp]) { event in
            self.onKeyEvent(event)
            return event
        }
        context.coordinator.eventMonitor = eventMonitor
        return nsView
    }

    func updateNSView(_ nsView: NSView, context: Context) {}

    static func dismantleNSView(_ nsView: NSView, coordinator: Coordinator) {
        if let eventMonitor = coordinator.eventMonitor {
            NSEvent.removeMonitor(eventMonitor)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator {
        var eventMonitor: Any?
    }
}
