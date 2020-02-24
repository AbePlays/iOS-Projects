//
//  DetailsViewController.swift
//  Artbook
//
//  Created by Abhishek Rawat on 22/02/20.
//  Copyright © 2020 Abhishek Rawat. All rights reserved.
//

import UIKit
import CoreData

class DetailsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameView: UITextField!
    @IBOutlet weak var artistView: UITextField!
    @IBOutlet weak var yearView: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    
    var chosenPainting = ""
    var chosenPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if chosenPainting != "" {
            
            saveButton.isHidden = true
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let id = chosenPaintingId?.uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", id!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let name = result.value(forKey: "name") as? String {
                            nameView.text = name
                        }
                        
                        if let artist = result.value(forKey: "artist") as? String {
                            artistView.text = artist
                        }
                        
                        if let year = result.value(forKey: "year") as? Int {
                            yearView.text = String(year)
                        }
                        
                        if let image = result.value(forKey: "image") as? Data {
                            imageView.image = UIImage(data: image)
                        }
                    }
                    print("Search successfull")
                }
                
            } catch {
                print("Error finding the painting")
            }
            
        } else {
            saveButton.isHidden = false
            saveButton.isEnabled = false
            nameView.text = ""
            artistView.text = ""
            yearView.text = ""
        }
        
        let gestureRec = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(gestureRec)
        
        imageView.isUserInteractionEnabled = true
        let gesRec = UITapGestureRecognizer(target: self, action: #selector(imagePressed))
        imageView.addGestureRecognizer(gesRec)
    }
    
    @objc func imagePressed() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        saveButton.isEnabled = true
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func savePressed(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext

        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings", into: context)
        newPainting.setValue(nameView.text, forKey: "name")
        newPainting.setValue(artistView.text, forKey: "artist")
        
        if let year = Int(yearView.text!) {
            newPainting.setValue(year, forKey: "year")
        }
        
        newPainting.setValue(UUID(), forKey: "id")
        
        let data = imageView.image!.jpegData(compressionQuality: 0.5)
        newPainting.setValue(data, forKey: "image")
        
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("Error saving data")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("New Data"), object: nil)
        navigationController?.popViewController(animated: true)
    }
}
