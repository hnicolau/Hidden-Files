//
//  AppDelegate.swift
//  Hidden Files
//
//  Created by Hugo Nicolau on 14/02/2015.
//  Copyright (c) 2015 Hugo Nicolau. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    
    // status menu of my app
    @IBOutlet weak var statusMenu: NSMenu!
    
    // status item with variable lenght
    let statusItem = NSStatusBar.systemStatusBar().statusItemWithLength(-1)

    // menu item
    @IBOutlet weak var hiddenMenuItem: NSMenuItem!
    
    func applicationDidFinishLaunching(aNotification: NSNotification) {
        let icon = NSImage(named: "statusIcon")
        //icon.setTemplate(TRUE)
        
        statusItem.image = icon
        statusItem.menu = statusMenu
        
        //hiddenMenuItem.state = NSOnState
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    @IBAction func statusMenuClicked(sender: NSMenuItem) {
        let task = NSTask()
        task.launchPath = "/usr/bin/defaults"
        
        if(sender.state == NSOnState){
            sender.state = NSOffState;
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "NO"]
        }
        else {
            sender.state = NSOnState;
            task.arguments = ["write", "com.apple.finder", "AppleShowAllFiles", "YES"]
        }
        
        task.launch()
        task.waitUntilExit()
        
        let killFinder = NSTask()
        killFinder.launchPath = "/usr/bin/killall"
        killFinder.arguments = ["Finder"]
        killFinder.launch()
    }
}

