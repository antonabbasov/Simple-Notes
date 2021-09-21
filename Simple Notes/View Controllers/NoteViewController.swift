//
//  NoteViewController.swift
//  Simple Notes
//
//  Created by Anton on 15.09.2021.
//

import UIKit

final class NoteViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var noteTextView: UITextView!
    
    // MARK: - Variables
    
    var noteTitle: String = ""
    var note: String = ""
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteTextView.text = note
    }
}
