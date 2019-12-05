//
//  AppDelegate.swift
//  Brightness
//
//  Created by Ray on 11/28/19.
//  Copyright © 2019 Ray. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    let menu = NSMenu()

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = NSImage(named: "menubar_icon")
        statusItem.button?.toolTip = "Option-Click to show menu"
        statusItem.button?.target = self
        statusItem.button?.action = #selector(handleStatusItemClick)

        let sb = NSStoryboard(name: "Main", bundle: nil)
        popover.contentViewController = sb.instantiateController(withIdentifier: "PopoverContent") as? ViewController
        popover.behavior = .transient

        menu.addItem(NSMenuItem(title: "Start on Login", action: #selector(startOnBoot), keyEquivalent: ""))
        menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
    }

    @objc func handleStatusItemClick() {
        if NSEvent.modifierFlags.contains(NSEvent.ModifierFlags.option) {
            statusItem.menu = menu
            statusItem.button?.performClick(nil)
            statusItem.menu = nil
        } else {
            popover.show(relativeTo: statusItem.button!.bounds, of: statusItem.button!, preferredEdge: .maxY)
            NSApp.activate(ignoringOtherApps: true)
        }
    }

    @objc func startOnBoot() {
        let alert = NSAlert()
        alert.alertStyle = .informational
        alert.messageText = "System Preferences ▸ Users & Groups ▸ Login Items ▸ [+]"
        alert.addButton(withTitle: "Open Preferences")
        alert.addButton(withTitle: "Cancel")

        if (alert.runModal() == .alertFirstButtonReturn) {
            NSWorkspace.shared.open(URL(fileURLWithPath: "/System/Library/PreferencePanes/Accounts.prefPane"))
        }
    }

    func applicationWillResignActive(_ notification: Notification) {
        popover.close()
    }
}

