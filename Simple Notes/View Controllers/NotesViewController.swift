//
//  ViewController.swift
//  Simple Notes
//
//  Created by Anton on 15.09.2021.
//

import UIKit
import CoreData

final class NotesViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var listOfNotesTableView: UITableView!
    @IBOutlet private var emptyNotesLabel: UILabel!
    
    // MARK: - Non private variables
    
    var dbHandler = DBHandler()
    
    // MARK: - Constants
    
    private enum Constants {
        static let newNoteViewControllerIdentifier = "new"
        static let newNoteViewControllerTitle = "New note"
        static let notesViewControllerTitle = "Notes"
        static let notesTableViewCellIdentifier = "cell"
        static let existingNoteViewControllerIdentifier = "note"
        static let existingNoteViewControllerTitle = "Note"
        static let noteEntityAttributeNameTitle = "title"
        static let noteEntityAttributeNameNoteText = "notetext"
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapNewNote() {
        guard let newNoteViewController = storyboard?.instantiateViewController(identifier: Constants.newNoteViewControllerIdentifier) as? EntryNoteViewController else {
            return
        }
        newNoteViewController.title = Constants.newNoteViewControllerTitle
        newNoteViewController.navigationItem.largeTitleDisplayMode = .never
        newNoteViewController.completion = { noteTitle, note in
            self.navigationController?.popToRootViewController(animated: true)
            self.dbHandler.save(title: noteTitle, noteText: note)
            self.listOfNotesTableView.reloadData()
        }
        navigationController?.pushViewController(newNoteViewController, animated: true)
    }
    
    // MARK: - Instance Methods
    
    private func emptyNotesLabelHandling() {
        if (dbHandler.notes.count == 0) {
            emptyNotesLabel.isHidden = false
            listOfNotesTableView.isHidden = true
        } else {
            emptyNotesLabel.isHidden = true
            listOfNotesTableView.isHidden = false
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyNotesLabelHandling()
        listOfNotesTableView.delegate = self
        listOfNotesTableView.dataSource = self
        title = Constants.notesViewControllerTitle
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.notesTableViewCellIdentifier, for: indexPath)
        let note = dbHandler.notes[indexPath.row]
        cell.textLabel?.text = note.value(forKeyPath: Constants.noteEntityAttributeNameTitle) as? String
        cell.detailTextLabel?.text = note.value(forKeyPath: Constants.noteEntityAttributeNameNoteText) as? String
        
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
        guard let noteViewController = storyboard?.instantiateViewController(identifier: Constants.existingNoteViewControllerIdentifier) as? NoteViewController else {
            return
        }
        noteViewController.navigationItem.largeTitleDisplayMode = .never
        noteViewController.title = Constants.existingNoteViewControllerTitle
        noteViewController.noteTitle = note.value(forKeyPath: Constants.noteEntityAttributeNameTitle) as? String ?? ""
        noteViewController.note = note.value(forKeyPath: Constants.noteEntityAttributeNameNoteText) as? String ?? ""
        navigationController?.pushViewController(noteViewController, animated: true)
    }
}
