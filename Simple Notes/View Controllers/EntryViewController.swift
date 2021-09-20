//
//  EntryViewController.swift
//  Simple Notes
//
//  Created by Anton on 15.09.2021.
//

import UIKit

class EntryViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var titleField: UITextField!
    @IBOutlet var noteField: UITextView!
    
    // MARK: - Non private variables
    
    public var completion: ((String, String) -> Void)?
    
    // MARK: - Instance Methods
    
    @objc func didTapSave() {
        if let text = titleField.text, !text.isEmpty, !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
    }
    
    // MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(didTapSave))
    }
}
