//
//  Window.swift
//  Buzzer
//
//  Created by Stefan J. on 21.09.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

class Window: NSWindow {

    override var canBecomeKey: Bool {
        // Wenn die Titelzeile des Windows deaktiviert wird, geht ohne diese Überschreibung der Fokus verloren und der Buzzer-Input wird nicht verarbeitet
        return true
    }
    
    override func makeKeyAndOrderFront(_ sender: Any?) {
        super.makeKeyAndOrderFront(self)
        self.center()
    }
    
    
}
