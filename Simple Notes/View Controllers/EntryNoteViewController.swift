//
//  EntryViewController.swift
//  Simple Notes
//
//  Created by Anton on 15.09.2021.
//

import UIKit

final class EntryNoteViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var noteTextView: UITextView!
    
    // MARK: - Non private variables
    
    public var completion: ((String, String) -> Void)?
    
    // MARK: - Instance Methods
    
    @objc private func didTapSave() {
        if let text = titleTextField.text, !text.isEmpty, !noteTextView.text.isEmpty {
            completion?(text, noteTextView.text)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
}
