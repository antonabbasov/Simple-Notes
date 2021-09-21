//
//  DBHandler.swift
//  Simple Notes
//
//  Created by Anton on 20.09.2021.
//

import UIKit
import CoreData

/// Note data base manager
class NotesCoreDataManager {
    
    // MARK: - Non private variables
    
    var notes: [NSManagedObject] = []
        
    // MARK: - Instance Methods
    
    func save(title: String, noteText: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let note = Note(context: managedContext)
        
        note.title = title
        note.notetext = noteText
        
        do {
            try managedContext.save()
            notes.append(note)
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetch() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Note")
        
        do {
            notes = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
}
