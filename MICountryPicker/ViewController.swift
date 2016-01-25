//
//  ViewController.swift
//  MICountryPicker
//
//  Created by Ibrahim, Mustafa on 1/24/16.
//  Copyright © 2016 Mustafa Ibrahim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    @IBAction func openPickerAction(sender: AnyObject) {
        
        let picker = MICountryPicker { (name, code) -> () in
            print(code)
        }
        
        // Optional: To pick from custom countries list
        picker.customCountriesCode = ["EG", "US", "AF", "AQ", "AX"]
        
        // delegate
        picker.delegate = self
        
        // or closure
//        picker.didSelectCountryClosure = { name, code in
//            print(code)
//        }
        navigationController?.pushViewController(picker, animated: true)
    }
}

extension ViewController: MICountryPickerDelegate {
    func countryPicker(picker: MICountryPicker, didSelectCountryWithName name: String, code: String) {
        label.text = "Selected Country: \(name)"
    }
}

