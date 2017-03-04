//
//  ViewController.swift
//  Threading
//
//  Created by Stefan J. on 12.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var textField: NSTextField!
    @IBOutlet weak var image: NSImageView!
    
    var backgroundQueue = NSOperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundQueue.addOperation(op(text: textField, image: image))
    }
    
    override var representedObject: AnyObject? {
        didSet {
            
        }
    }
    override func viewDidAppear() {
        view.window?.makeFirstResponder(self)
    }
    
    // Buzzer-Eingabe verarbeiten
    override var acceptsFirstResponder: Bool {return true}
    
    override func keyDown(theEvent: NSEvent) {
        if theEvent.keyCode == 11 {
            backgroundQueue.cancelAllOperations()
            print("Buzzer gedrückt")
        }
    }
}

class op: NSOperation {

    var textField: NSTextField
    var image: NSImageView
    
    init(text: NSTextField, image: NSImageView) {
        self.textField = text
        self.image = image
    }
    
    override func main() {
        
        if self.cancelled {
            return
        }
        
        myThread()
    }
    
    func myThread () {
        
        let mainQueue = NSOperationQueue.mainQueue()
        
        for i in 1...1000 {
            if self.cancelled {return}
            mainQueue.addOperationWithBlock() {
                self.textField.stringValue = "\(i)"
                if i%2 == 0 {
                    self.image.enabled = true
                }
                else {
                    self.image.enabled = false
                }
            }
            usleep(300000)
        }
    }
}










