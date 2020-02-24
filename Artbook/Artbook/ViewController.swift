//
//  ViewController.swift
//  Artbook
//
//  Created by Abhishek Rawat on 22/02/20.
//  Copyright © 2020 Abhishek Rawat. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var names = [String]()
    var ids = [UUID]()
    var selectedPainting = ""
    var selectedPaintingId : UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(goToDetails))
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(getData), name: NSNotification.Name(rawValue: "New Data"), object: nil)
    }
    
    @objc func getData() {
        
        names.removeAll(keepingCapacity: false)
        ids.removeAll(keepingCapacity: false)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let name = result.value(forKey: "name") as? String {
                        names.append(name)
                    }
                    
                    if let id = result.value(forKey: "id") as? UUID {
                        ids.append(id)
                    }
                    tableView.reloadData()
                    print("Data retreived successfully")
                }
            }
        } catch {
            print("Error retreiving data")
        }
        
    }
    
    @objc func goToDetails() {
        selectedPainting = ""
        performSegue(withIdentifier: "toDetailsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destinationVC = segue.destination as! DetailsViewController
            destinationVC.chosenPainting = selectedPainting
            destinationVC.chosenPaintingId = selectedPaintingId
        }
    }
    
    // MARK: - Table View Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPainting = names[indexPath.row]
        selectedPaintingId = ids[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            let idString = ids[indexPath.row].uuidString
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString)
            fetchRequest.returnsObjectsAsFaults = false
            
            do {
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0 {
                    for result in results as! [NSManagedObject] {
                        if let id = result.value(forKey: "id") as? UUID {
                            if id == ids[indexPath.row] {
                                context.delete(result)
                                names.remove(at: indexPath.row)
                                ids.remove(at: indexPath.row)
                                tableView.reloadData()
                                
                                do {
                                    try context.save()
                                    print("Deletion successfull")
                                } catch {
                                    print("Error deleting data")
                                }
                                break
                            }
                        }
                    }
                }
            } catch {
                print("Error fetching result")
            }
            
        }
    }
    
}

