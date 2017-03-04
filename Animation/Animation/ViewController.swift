//
//  ViewController.swift
//  Animation
//
//  Created by Stefan J. on 11.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var text: NSTextField!
    
    var transformLayer: CALayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        transformLayer = CALayer()
        transformLayer.frame = view.bounds.insetBy(dx: 50, dy: 50)
        transformLayer.backgroundColor = NSColor.redColor().CGColor
        view.layer?.addSublayer(transformLayer)
        
        
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func rechts(sender: AnyObject) {
        setAngle(45)
    }
    
    @IBAction func links(sender: AnyObject) {
        setAngle(-45)
    }
 
    func setAngle(degrees: CGFloat) {
        let radians = CGFloat(M_PI) * degrees / 180.0
        var transform = CATransform3DIdentity
        transform.m34 = 1 / -300
        transform = CATransform3DRotate(transform, radians, 0, 1, 0)
        transformLayer.transform = transform
        
    }
}

