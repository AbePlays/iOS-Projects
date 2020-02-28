# Cheat Sheet

## How To Play An Audio  🎶

  Import AVFoundation

    var player : AVAudioPlayer!

    let url = Bundle.main.url(forResource: file_name, withExtension: "extension_of_file_name")

    player = try! AVAudioPlayer(contentsOf: url!)

    player.play()

## Detecting Shaking Gesture 👋🏻

    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
      //Write_Code
    }

## How To Use A Timer  ⏳

    var timer = Timer()

    timer.invalidate()

    timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(function_name), userInfo:nil, repeats: true)

    timer.invalidate()

## How To Use Segue 🔗

    self.performSegue(withIdentifier: "Identifier_Name", sender: self) //Inside the function that will trigger next screen

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "Identifier_Name" {
      let destinationVC = segue.destination as! Class_Name_Of_Second_Screen
        //Pass arguments
      }
    }

  Inside the function through which one wants to go back<br/>
    dismiss(animated: true, completion: nil)

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

### Creating Users

    if emailView.text != "" && passwordView.text != "" {
        Auth.auth().createUser(withEmail: emailView.text!, password: passwordView.text!) { (data, error) in
            if error != nil {
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error from firebase")
            } else {
                //Do Stuff
            }
        }
    } else {
      //Do Stuff
    }
    
### Signing In User

    if emailView.text != "" && passwordView.text != "" {
        Auth.auth().signIn(withEmail: emailView.text!, password: passwordView.text!) { (data, error) in
            if error != nil {
                self.showAlert(title: "Error", message: error?.localizedDescription ?? "Error from firebase")
            } else {
                //Do Stuff
            }
        }
    } else {
      //Do Stuff
    }
    
### Signing Out User

    Auth.auth().signOut()
    
### Uploading Media to Firestore

    let storage = Storage.storage()
    let storageReference = storage.reference()

    let mediaFolder = storageReference.child("media") //Selecting a Folder inside the database(Here "media")

    if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
        let id = UUID().uuidString
        let imageReference = mediaFolder.child("\(id).jpg") //Saving media using a UUID
        imageReference.putData(data, metadata: nil) { (storageData, error) in
            if error != nil {
              //Error
            } else {
                imageReference.downloadURL { (url, error) in
                    if error != nil {
                        //Error
                    } else {
                        let imageURL = url?.absoluteString

                        // DATABASE
                        let firebaseDatabase = Firestore.firestore()
                        var firestoreReference : DocumentReference? = nil

                        let post = ["imageURL" : imageURL!, "postedBy" : Auth.auth().currentUser!.email!, "postComment" : self.commentView.text!, "date" : FieldValue.serverTimestamp(), "likes" : 0] as [String:Any]

                        firestoreReference = firebaseDatabase.collection("Posts").addDocument(data: post, completion: { (error) in
                            if error != nil {
                                //Error
                            } else {
                                //Perform Something
                            }
                        })

                    }
                }
            }
        }
    }
    
### Remembering User

  Inside SceneDelegate :<br/>
  
    let user = Auth.auth().currentUser
    if user != nil {
        let board = UIStoryboard(name: "Main", bundle: nil)
        let tabBar = board.instantiateViewController(identifier: "tabBar") as! UITabBarController
        window?.rootViewController = tabBar
    }

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
  
## Implementing Biometrics(FaceID and TouchID) 🙂

    let authContext = LAContext()
    var error : NSError?

    if authContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
      
      authContext.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Authentication Required") {       (success, error) in
        if success == true {
          DispatchQueue.main.async {
            //Correct Biometric
          }
        } else {
          DispatchQueue.main.async {
            //Wrong Biometric
          }
        }
      }
    }
  
## Working With Database 📚
  
### Insering data inside the database

  Import CoreData.<br/>
  Create an AppDelegate instance.<br/>
  Create a new dataObject using NSEntityDescription.insertNewObject(forEntityName: <Name of Entity>, into: <Something>).<br/>
  Initialize all fields of the entity using setValue function.<br/>
  Save data using context.save() function.<br/>
  
### Retreiving data from the database

  Import CoreData.<br/>
  Create an AppDelegate instance.<br/>
  Create a fetchRequest using NSFetchRequest<NSFetchRequestResult>(entityName: "<Entity Name>")<br/>
  Fetch the data from database using context.fetch(fetchRequest) method.<br/>
  
### Deleting data from the database

  Retreive the data using aforementioned step using UUID.<br/>
  context.delete(record)<br/>
  context.save()<br/>

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
  
### Force a particular appearance :

  Inside viewDidLoad<br/>
  overrideUserInterfaceStyle = .dark OR .light
  



