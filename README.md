# Cheat Sheet

## How To Play An Audio  🎶

import AVFoundation

var player : AVAudioPlayer!

let url = Bundle.main.url(forResource: file_name, withExtension: "extension_of_file_name")

player = try! AVAudioPlayer(contentsOf: url!)

player.play()

## How To Use A Timer  ⏳

var timer = Timer()

timer.invalidate()

timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(function_name), userInfo:nil, repeats: true)

timer.invalidate()

## How To Use Segue 🔗

self.performSegue(withIdentifier: "Identifier_Name", sender: self) //Inside the function that will trigger next screen

override func prepare(for segue: UIStoryboardSegue, sender: Any?) {<br />
&emsp;if segue.identifier == "firstToSecond" {<br />
&emsp;&emsp;let destinationVC = segue.destination as! ResultsViewController<br />
&emsp;&emsp;destinationVC.perHead = resultTo2DecimalPlaces
&emsp;&emsp;destinationVC.person = String(numberOfPeople)
&emsp;&emsp;destinationVC.tipPercent = String(tip * 100)
&emsp;}<br />
}
