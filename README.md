# Cheat Sheet

## How To Play An Audio  🎶

import AVFoundation

var player : AVAudioPlayer!

let url = Bundle.main.url(forResource: file_name, withExtension: "extension_of_file_name")

player = try! AVAudioPlayer(contentsOf: url!)

player.play()

## Detecting Shaking Gesture 👋🏻

override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) { <br />
&emsp;//Write_Code <br />
}

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

//Inside the function through which one wants to go back<br />
dismiss(animated: true, completion: nil)<br />

## Make Application Dark Mode Compatible 🌑

Use System Colors for text and icons(SFIcons) <br />
For images, in assets folder, allocate different images for all 3 appearances(any, light and dark) <br />

## Handling APIs ⚙️

//1. Create a URL <br />
<br />
if let url = URL(string: nameOfUrl) {<br />
<br />
//2. Create a URLSession<br />           
&emsp;let session = URLSession(configuration: .default)<br />
<br />
//3. Give Session a task<br />
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
//4. Start the task<br />
&emsp;task.resume()<br />
}<br />
While the data is being fetched from the server, the UI should not be static i.e., It should be responsive and not be frozen. <br /> <br />
DispatchQueue.main.async {<br />
&emsp; //CODE<br />
}<br />

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

## Working With ARKit 📱

//Still Working

## Adding Firebase To The Project 🔥

import Firebase

FirebaseApp.configure()

let myDatabase = Database.database().reference()
//More to come

## Working With TableViewController 🀆

Provide an Identifer to the Prototype Cell.

-----TableView Datasource Methods-----

Step 1. Check for a function which returns "number of rows in section"
Step 2. Check for a function which asks for "cell for row at" a particular position

--Implementation of Functions--

FUNCTION 1 :
  return the length of data.
  
FUNCTION 2 :
  Create a cell, configure it and return the cell.
  
## Working With Maps 🗺

Import MapKit and inherit MKMapViewDelegate.

Set current ViewController as the delegate.

Create an instance of LocationManager.<br/>
  Set accuracy measure, ask for authentication and start updating location.
  
Implement a delegate function(didUpdateLocations)<br/>
  Set the latitude and longitude using CLLocationCoordinate2D<br/>
  Set the span aka zoom.<br/>
  Set the region.<br/>
  Add span and region to the map.<br/>
  
## Working With Database 📚

## Tips & Tricks

### Dismiss Keyboard : 
  Create TapGestureRecognizer and put view.endEditing inside it.
  
### Pick an Image : 
  Implement UIImagePickerControllerDelegate, UINavigationControllerDelegate to the UIViewController<br/>
  Initialize a UIImagePickerController object.<br/>
  Set the object as the delegate.<br/>
  Pick the source type.<br/>
  Present the Object into the screen.<br/>
  Using a delegate function(didFinishPickingMedia), save the image from the source.
  



