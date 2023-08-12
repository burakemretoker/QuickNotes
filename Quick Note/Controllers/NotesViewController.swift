//
//  NotesViewController.swift
//  Quick Note
//
//  Created by Burak Emre Toker on 12.08.2023.
//

import UIKit
import CoreData


class NotesViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    var noteArray = [Notes]()

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table View Data Source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return noteArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reusableNotes", for: indexPath)
        cell.textLabel?.text = noteArray[indexPath.row].name!

        return cell
    }

    // MARK: - Table View Delegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK: - CRUD


    //MARK: - Add Button Pressed

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add a Note", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add", style: .default) { action in
            let newNote = Notes(context: self.context)
            newNote.name = textField.text!
//            self.noteArray.append(newNote)


        }

        alert.addAction(action)

        alert.addTextField { alertTextField in
            textField = alertTextField
            textField.placeholder = "Type Note"
        }

        present(alert, animated: true)

    }
}
