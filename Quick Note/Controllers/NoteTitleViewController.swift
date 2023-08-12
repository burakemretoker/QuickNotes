//
//  ViewController.swift
//  Quick Note
//
//  Created by Burak Emre Toker on 12.08.2023.
//

import UIKit
import CoreData


class NoteTitleViewController: UITableViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var fileArray = [Files]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        let newFile1 = Files(context: context)
        newFile1.name = "asdfsaf"
        fileArray.append(newFile1)
        
        loadFiles()
        
    }
    
    
    //MARK: - Table View DataSource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fileArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableNoteFiles", for: indexPath)
        
        cell.textLabel?.text = fileArray[indexPath.row].name!
        
        return cell
    }
    
    
    //MARK: - Table View Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - CoreData - CRUD
    
    func loadFiles() {
        let request: NSFetchRequest<Files> = Files.fetchRequest()
        
        do {
            fileArray = try context.fetch(request)
        } catch {
            print("Something Happend When Fetching Files: \(error)")
        }
    }
    
    func saveFiles() {
        do {
            try context.save()
            tableView.reloadData()
        } catch {
            print("Something Happend When Saving Files: \(error)")
        }
    }
    
    
    //MARK: - addButton Pressed

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add Note File", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { action in
            print(textField.text!)
            
            let newFile = Files(context: self.context)
            newFile.name = textField.text!
            self.fileArray.append(newFile)
            
            self.tableView.reloadData()
            
            self.saveFiles()
        }
        
        alert.addAction(action)
        
        alert.addTextField { alertTextField in
            textField.placeholder = "Type a Name For File"
            textField = alertTextField
        }
        
        present(alert, animated: true)
        
    }
}

