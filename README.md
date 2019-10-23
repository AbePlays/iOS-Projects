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
&emsp;if segue.identifier == "Identifier_Name" {<br />
&emsp;&emsp;let destinationVC = segue.destination as! Class_Name_Of_Second_Screen<br />
&emsp;&emsp;//Pass arguments<br />
&emsp;}<br />
}

## Handling APIs ⚙️

if let url = URL(string: urlString) {<br />
            
&emsp;let session = URLSession(configuration: .default)<br />
            
&emsp;let task = session.dataTask(with: url) { (data, response, error) in<br />
&emsp;&emsp;if error != nil {<br />
&emsp;&emsp;&emsp;self.delegate?.didFailWithError(error: error!)<br />
&emsp;&emsp;&emsp;return<br />
&emsp;&emsp;}
                
&emsp;&emsp;if let safedata = data {<br />
&emsp;&emsp;&emsp;if let weather = self.parseJSON(safedata) {<br />
&emsp;&emsp;&emsp;&emsp;self.delegate?.didUpdateWeather(self, weather: weather)<br />
&emsp;&emsp;&emsp;}<br />
&emsp;&emsp;}<br />
&emsp;}<br />
&emsp;task.resume()<br />
}

## Working With CoreML 🤖

import CoreML<br />

&emsp;func detect(image: CIImage) {<br />
&emsp;&emsp;guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {<br />
&emsp;&emsp;&emsp;fatalError("Loading CoreML Model Failed.")<br />
&emsp;&emsp;}<br />
        
&emsp;&emsp;let request = VNCoreMLRequest(model: model) { (request, error) in<br />
&emsp;&emsp;&emsp;guard let results = request.results as? [VNClassificationObservation] else {<br />
&emsp;&emsp;&emsp;&emsp;fatalError("Model failed to process image.")<br />
&emsp;&emsp;&emsp;}<br />
            
&emsp;&emsp;&emsp;if let firstResult = results.first {<br />
&emsp;&emsp;&emsp;&emsp;if firstResult.identifier.contains("hotdog") {<br />
&emsp;&emsp;&emsp;&emsp;&emsp;self.navigationItem.title = "It's a Hotdog"<br />
&emsp;&emsp;&emsp;&emsp;} else {<br />
&emsp;&emsp;&emsp;&emsp;&emsp;self.navigationItem.title = "Not a Hotdog"<br />
&emsp;&emsp;&emsp;&emsp;}<br />
&emsp;&emsp;&emsp;}<br />
&emsp;&emsp;}<br />
        
&emsp;&emsp;let handler = VNImageRequestHandler(ciImage: image)<br />
        
&emsp;&emsp;do {<br />
&emsp;&emsp;&emsp;try handler.perform([request])<br />
&emsp;&emsp;}<br />
&emsp;&emsp;catch {<br />
&emsp;&emsp;&emsp;print(error)<br />
&emsp;&emsp;}<br />
        
&emsp;}

## Working With ARKit
