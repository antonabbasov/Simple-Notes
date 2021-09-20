//
//  ViewController.swift
//  Simple Notes
//
//  Created by Anton on 15.09.2021.
//

import UIKit
import CoreData

class NotesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var listOfNotes: UITableView!
    @IBOutlet var label: UILabel!
    
    // MARK: - Non private variables
    
    var dbHandler = DBHandler()
    
    // MARK: - actions
    
    @IBAction func didTapNewNote() {
        guard let newNoteViewController = storyboard?.instantiateViewController(identifier: "new") as? EntryViewController else { return }
        newNoteViewController.title = "New note"
        newNoteViewController.navigationItem.largeTitleDisplayMode = .never
        newNoteViewController.completion = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.dbHandler.save(title: noteTitle, noteText: note)
            self.listOfNotes.reloadData()
        }
        navigationController?.pushViewController(newNoteViewController, animated: true)
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewWillAppear(true)
        
        if (dbHandler.notes.count == 0) {
            label.isHidden = false
            listOfNotes.isHidden = true
        } else {
            label.isHidden = true
            listOfNotes.isHidden = false
        }
        
        listOfNotes.delegate = self
        listOfNotes.dataSource = self
        title = "Notes"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dbHandler.fetch()
    }
}

// MARK: - UITableViewDataSource

extension NotesViewController: UITableViewDataSource {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let note = dbHandler.notes[indexPath.row]
        cell.textLabel?.text = note.value(forKeyPath: "title") as? String
        cell.detailTextLabel?.text = note.value(forKeyPath: "notetext") as? String
        
        return cell
    }
}

// MARK: - UITableViewDelegate

extension NotesViewController: UITableViewDelegate {
    
    // MARK: - Instance Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dbHandler.notes.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = dbHandler.notes[indexPath.row]
        guard let noteViewController = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else { return }
        noteViewController.navigationItem.largeTitleDisplayMode = .never
        noteViewController.title = "Note"
        noteViewController.noteTitle = note.value(forKeyPath: "title") as? String ?? ""
        noteViewController.note = note.value(forKeyPath: "notetext") as? String ?? ""
        navigationController?.pushViewController(noteViewController, animated: true)
    }
}



