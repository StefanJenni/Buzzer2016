//
//  ViewController.swift
//  Event
//
//  Created by Stefan J. on 11.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var status: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    override func viewDidAppear() {
        view.window?.makeFirstResponder(self)
    }
    
    override func keyDown(theEvent: NSEvent) {
        status.stringValue = "Keine besondere Taste gedrückt"
        
        if theEvent.keyCode == 11 {
            status.stringValue = "Buzzer gedrückt"
        }
        
    }


}

