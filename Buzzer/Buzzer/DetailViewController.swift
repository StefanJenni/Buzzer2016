//
//  DetailViewController.swift
//  Buzzer
//
//  Created by Stefan J. on 10.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa
import AVFoundation

//
// Delegate-Protokoll für die Rückkehr zur Buzzer-Auswahl
//
protocol DetailViewControllerDelegate {
    func backFromDetailViewController (sourceViewController: DetailViewController)
}

class DetailViewController: NSViewController {

    var myAudioPlayer = AVAudioPlayer()
    var delegate: DetailViewControllerDelegate?

    @IBOutlet weak var imageView: NSImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Buzzer-Game - Lehrer/in werden!"
        
        // Detail-Bild mit Text anzeigen - das Bild hat den Präfix "F"
        var imageName = "F"
        imageName += self.representedObject as! String
        imageView.image = NSImage(named: imageName)
 
 
        // Sound abspielen, wenn ein Logo einer PH oder "Werde Lehrer/in" selektiert wurde
        if  imageName == "FLW" ||
            imageName == "FLPHLU" ||
            imageName == "FLPHSZ" ||
            imageName == "FLPHZG"
        {
            playSound()
        }
    }
        
    override func viewDidAppear() {
        super.viewDidAppear()
   
        // Eingabe des Buzzers ermöglichen
        view.window?.makeFirstResponder(self)
        
        // Titelzeile deaktivieren
        view.window?.standardWindowButton(NSWindowButton.closeButton)!.isHidden = true
        view.window?.standardWindowButton(NSWindowButton.miniaturizeButton)!.isHidden = true
        view.window?.standardWindowButton(NSWindowButton.zoomButton)!.isHidden = true
        view.window!.titlebarAppearsTransparent = true
        view.window?.titleVisibility = NSWindowTitleVisibility.hidden
        view.window?.styleMask.insert(.fullSizeContentView)
        
    }
    
    override func viewWillDisappear() {
        super.viewWillDisappear()
        // Zurück zur Buzzer-Auswahl
        delegate?.backFromDetailViewController (sourceViewController: self)
    }
    
    // Buzzer-Eingabe verarbeiten
    override var acceptsFirstResponder: Bool {return true}
    
    override func keyDown(with theEvent: NSEvent) {
        // b-Taste = Buzzer gedrückt
        if theEvent.keyCode == 11 {
            self.dismiss(self)
        }
    }

    // Fanfare abspielen
    func playSound() {
        let myFilePathSharing = Bundle.main.path(forResource: "audio", ofType: "wav")
        
        if let myFilePathSharing = myFilePathSharing {
            let myFilePathURL = NSURL(fileURLWithPath: myFilePathSharing)
            do {
                try myAudioPlayer = AVAudioPlayer(contentsOf: myFilePathURL as URL)
            }
            catch {
                print("Fehler: Fanfare kann nicht abgespielt werden.")
            }
        }
        myAudioPlayer.play()
    }
    
}
