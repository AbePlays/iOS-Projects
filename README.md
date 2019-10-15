# Cheat Sheet

## To Play An Audio

import AVFoundation

var player : AVAudioPlayer!

let url = Bundle.main.url(forResource: filename, withExtension: "extension_of_filename")
player = try! AVAudioPlayer(contentsOf: url!)
player.play()
