//
//  DBHandler.swift
//  Simple Notes
//
//  Created by Anton on 20.09.2021.
//

import UIKit
import CoreData


/// Data base handler
class DBHandler {
    
    // MARK: - Non private variables
    
    var notes: [NSManagedObject] = []
    
    // MARK: - Instance Methods
    
    func save(title: String, noteText: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: managedContext) else {
            return
        }
        
        let note = NSManagedObject(entity: entity, insertInto: managedContext)
        
        note.setValue(title, forKeyPath: "title")
        note.setValue(noteText, forKeyPath: "notetext")
        
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
