//
//  ViewController.swift
//  Buzzer
//
//  Created by Stefan J. on 10.08.16.
//  Copyright © 2016 Stefan und Manuel Jenni. All rights reserved.
//

import Cocoa

// Aktuell selectiertes Item in der CollectionView bzw. images-Tabelle
var selectedItem: Int = 1

// 
// ViewController mit CollectionView
//

class ViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    
    var images = [NSImage(named: "01"), NSImage(named: "LPHLU"), NSImage(named: "02"), NSImage(named: "03"), NSImage(named: "04"), NSImage(named: "05"), NSImage(named: "06"), NSImage(named: "07"), NSImage(named: "08"), NSImage(named: "09"), NSImage(named: "10"), NSImage (named: "LPHSZ"),  NSImage(named: "11"), NSImage(named: "12"), NSImage(named: "LW"), NSImage(named: "13"), NSImage(named: "14"), NSImage(named: "15"),  NSImage(named: "16"), NSImage(named: "17"), NSImage(named: "18"), NSImage(named: "19"), NSImage(named: "LPHZG"), NSImage(named: "20")]
    
    var backgroundQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Hintergrund schwarz
        collectionView.backgroundColors = [NSColor.black]
        
        // Buzzer starten
        startNewGame()
    }
    
    override func viewWillAppear() {
        
        // Hintergrundfarbe auf Schwarz setzen
        view.layer?.backgroundColor = CGColor.black
        self.view.wantsLayer = true
    }

    override func viewDidAppear() {
        view.window?.makeFirstResponder(self)
    }
    
    
    // Buzzer-Eingabe verarbeiten
    override var acceptsFirstResponder: Bool {return true}
    
    override func keyDown(with event: NSEvent) {
        
        // b-Taste = Buzzer gedrückt
        if event.keyCode == 11 {
            backgroundQueue.cancelAllOperations()
            backgroundQueue.waitUntilAllOperationsAreFinished()
            performSegue(withIdentifier: "showDetail", sender: self)
        }
    }
    
    // Name des selektierten Bildes an das Detail-Bild übergeben
    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
        
        let detail = segue.destinationController as! DetailViewController
        detail.representedObject = images[selectedItem]?.name()
        detail.delegate = self
    }
    
    func startNewGame () {
        
        // Bilder auswählen, bis der Buzzer gedückt wird
        backgroundQueue.addOperation(imageSelect(collectionView: collectionView))
      }
}

// 
// Nach der Rückkehr von der Detail-Ansicht wird das Buzzer-Game neu gestartet
//
extension ViewController: DetailViewControllerDelegate {
    func backFromDetailViewController (sourceViewController: DetailViewController) {
        
        let indexPath = NSIndexPath(forItem: selectedItem, inSection: 0)
        let item = collectionView.item(at: indexPath as IndexPath)
         item?.imageView?.layer!.borderColor = CGColor.black
        startNewGame()
    }
}

//
// DataSource
//
extension ViewController: NSCollectionViewDataSource {
    
    // numberOfItemsInSection: Anzahl Items in der CollectionView
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    // itemForRepresentedObjectAtIndexPath
    // func collectionView(collectionView: NSCollectionView, itemForRepresentedObjectAtIndexPath indexPath: IndexPath) -> NSCollectionViewItem {
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: "ImageCollectionViewItem", for: indexPath)
        // CollectionView mit den Bildern aus der Tabelle images abfüllen
        item.imageView?.image = images[indexPath.item]
        return item
    }
}

//
// Bilder in einem separaten Thread auswählen, bis der Buzzer gedrückt wird
//
class imageSelect: Operation {
    
    var collectionView: NSCollectionView
    
    init(collectionView: NSCollectionView) {
        self.collectionView = collectionView
     }
    
      override func main() {
        
        if self.isCancelled {
            return
        }
        selectedItem = selectImage()
      }
    
    // Bilder in einer vordefinierten Reihenfolge anzeigen, das zuletzt gewälte Item wird zurückgegeben
    func selectImage () -> Int {
        
        let mainQueue = OperationQueue.main
        var indexPath = NSIndexPath()
        var indexPathItem = 0
        var indexPathItemPrev = 0
        var item = NSCollectionViewItem ()
        
        var reihe = [1,2,3,4,5,6,12,11,10,9,8,7,13,14,15,16,17,18,24,23,22,21,20,19,13,7,1,2,8,14,20,21,15,9,3,4,10,16,22,23,17,11,5,6,12,18,24,23,22,16,10,4,3,9,15,21,20,19,13,7,1,2,3,4,5,6,12,18,17,16,15,14,8,9,10,11,17,16,10,9,15,14,8,7]
        
        // Images Auswählen, bis der Buzzer gedrückt wird
        while !self.isCancelled {
            
            for i in 1...reihe.count {
                // abbrechen, sobald der Buzzer gedrückt wird
                if self.isCancelled {
                    break
                }
                
                mainQueue.addOperation() {
                    
                    // Vorheriges Element deselektieren
                    indexPath = NSIndexPath(forItem: indexPathItemPrev, inSection: 0)
                    item = self.collectionView.item(at: indexPath as IndexPath)!
                    
                    // Element aus der CollectionView auswählen
                    indexPathItem = reihe[i-1] - 1
                    indexPathItemPrev = indexPathItem
                    
                    // Image deselektieren
                    item.imageView?.layer?.borderColor = CGColor.black
                    indexPath = NSIndexPath(forItem: indexPathItem, inSection: 0)
                    item = self.collectionView.item(at: indexPath as IndexPath)!
                    
                    // Image selektieren
                    item.imageView?.layer?.borderColor = CGColor.init(red: 0.08, green: 1.00, blue: 0.00, alpha: 1.0)
                }
                // warten, bis das nächste Bild selektiert wird
                usleep(85000)
            }
        }
        return indexPathItemPrev
    }
    
    
}

