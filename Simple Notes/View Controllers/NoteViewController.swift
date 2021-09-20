//
//  NoteViewController.swift
//  Simple Notes
//
//  Created by Anton on 15.09.2021.
//

import UIKit

class NoteViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteText: UITextView!
    
    // MARK: - Non private variables
    
    public var noteTitle: String = ""
    public var note: String = ""
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteText.text = note
    }
}
