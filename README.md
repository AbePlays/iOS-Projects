# Cheat Sheet

## How To Play An Audio  🎶

import AVFoundation

var player : AVAudioPlayer!

let url = Bundle.main.url(forResource: filename, withExtension: "extension_of_filename")

player = try! AVAudioPlayer(contentsOf: url!)

player.play()

## How To Use A Timer  ⏳

var timer = Timer()

timer.invalidate()

timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(function_name), userInfo:nil, repeats: true)

timer.invalidate()
