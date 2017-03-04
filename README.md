# Buzzer2016
BuzzerGame ZEBI PH Luzern 2016

Das BuzzerGame für den Stand der PH Luzern an der ZEBI (Zentralschweizer Bildungsmesse) wurde auf einem Mac mit Xcode Version 8.1 realisiert. Für den Betrieb ist z.B. ein iMac und ein grosser Monitor erforderlich.

Der Buzzer wurde von http://www.f-pro.de/buzzer/ bezogen. Er lässt sich programmieren, so dass er beim Drücken z.B. einen Buchstaben sendet. Das BuzzerGame reagiert auf den Buchstaben b. Der Buzzer wurde auf diesen Buchstaben programmiert. Die Software fürs Programmieren des Buzzers findet man auf der Website des Herstellers.

Die App funktioniert aus User-Sicht wie folgt: Die einzelnen Bilder erhalten abwechselnd nach einem bestimmten Muster den Fokus. Drückt man den Buzzer auf dem Bild einer Lerhperson, wird das Bild mit einem Text angezeigt. Landet der Buzzer auf einem Logo, ertönt eine Fanfare und der/die Kandidat/in hat etwas gewonnen.

Die beiden Klassen ViewController und DetailViewController erledigen die Hauptarbeit des BuzzerGames.

ViewController zeigt die Bilder in einer CollectionView an. Die Reihenfolge der Bilder wird in der Tabelle images festgelegt. Die Klasse imageSelect setzt den Fokus auf die einzelnen Bilder und wartet, bis der Buzzer gedrückt wird. Das Muster der Anzeige wird in der Tabelle reihe festgelegt. Das setzen des Fokus läuft in einem separaten Thread, da gleichzeitig auf das Drücken des Buzzers gewartet werden muss. Sobald der Buzzer gedrückt wird, wird der Thread beendet und nach der Anzeige der DatailView beginnt das Spiel wieder von vorne.

DetailViewController zeigt das mit dem Buzzer selektierte Bild im Grossformat an. Falls ein Logo gedrückt wird, ertönt eine Fanfare (Methode playSound() ). Die Bilder sind unter Assets.xcassets abgelegt. Die kleinen Bildformate der Lehrpersonen sind von 01 – 20 durchnummeriert. Die grossen Bilder haben als Präfix ein „F“. Logos haben separate Namen.

Die Software wurde von Stefan und Manuel Jenni in ihrer Freizeit programmiert. Ziel war es, mal etwas in Xcode zu realisieren

Der Programmcode darf von anderen Interessierten frei verwendet werden und an die eigenen Bedürfnisse angepasst werden.

Feedbacks oder Verbesserungsvorschläge sind willkommen.
