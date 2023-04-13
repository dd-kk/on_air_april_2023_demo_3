//
//  ViewController.swift
//  localization_demo
//
//  Created by User on 11.04.2023.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = NSLocalizedString("hello world", comment: "")
    }
}
