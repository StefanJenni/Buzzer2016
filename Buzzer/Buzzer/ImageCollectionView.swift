//
//  ImageCollectionView.swift
//  Buzzer
//
//  Created by Stefan J. on 11.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

class ImageCollectionView: NSView {
    
    @IBOutlet weak var image: NSImageView!
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        
        // Rahmen um das Bild zeichnen, damit es abgerundete Ecken gibt
        image.layer!.borderWidth = 4.0
        image.layer!.cornerRadius = 20.0
        image.layer!.masksToBounds = true
        image.layer!.borderColor = CGColor.black
    }
 }
