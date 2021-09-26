//
//  UserDefaultsViewController.swift
//  14
//
//  Created by Максим Болдырев on 06.07.2021.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    
    let keyLastName = "lastName"
    let keyFirstName = "firstName"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let lastName = UserDefaults.standard.string(forKey: keyLastName) ?? ""
        let firstName = UserDefaults.standard.string(forKey: keyFirstName) ?? ""
        textLabel.text = "\(lastName) \(firstName)"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButon(_ sender: UIButton) {
        let lastName: String = lastNameField.text!
        let firstName: String = firstNameField.text!
        
        UserDefaults.standard.set(lastName, forKey: keyLastName)
        UserDefaults.standard.set(firstName, forKey: keyFirstName)
        
        textLabel.text = "\(lastName) \(firstName)"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
