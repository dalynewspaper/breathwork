import Cocoa
import SwiftUI

class AppDelegate: NSObject, NSApplicationDelegate {
    var window: CustomWindow!
    var statusItem: NSStatusItem!
    var popover: NSPopover!

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        let contentView = ContentView()

        // Create the status item
        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        if let button = statusItem.button {
            button.image = NSImage(systemSymbolName: "leaf", accessibilityDescription: "BreathWork")
            button.action = #selector(togglePopover(_:))
        }

        // Create the popover
        popover = NSPopover()
        popover.contentSize = NSSize(width: 400, height: 300)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(rootView: contentView)

        // Setup transparent window
        if let screen = NSScreen.main {
            let screenRect = screen.frame
            window = CustomWindow(
                contentRect: screenRect,
                styleMask: [.borderless],
                backing: .buffered, defer: false)
            window.isOpaque = false
            window.backgroundColor = NSColor.clear // Explicitly use NSColor.clear
            window.level = .mainMenu
            window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary] // Explicitly use NSWindow.CollectionBehavior
            window.contentView = NSHostingView(rootView: contentView)
            window.makeKeyAndOrderFront(nil)
        }
    }

    @objc func togglePopover(_ sender: Any?) {
        if let button = statusItem.button {
            if popover.isShown {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
                popover.contentViewController?.view.window?.makeKey()
            }
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
