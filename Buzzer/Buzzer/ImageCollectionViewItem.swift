//
//  ImageCollectionViewItem.swift
//  Buzzer
//
//  Created by Stefan J. on 10.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

class ImageCollectionViewItem: NSCollectionViewItem {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        // Hintergundfarbe der Zelle 
        view.wantsLayer = true
        view.layer?.backgroundColor = CGColor.black
    }
}
