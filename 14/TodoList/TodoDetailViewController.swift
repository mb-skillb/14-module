//
//  TodoDetailViewController.swift
//  14
//
//  Created by Максим Болдырев on 07.07.2021.
//

import UIKit

enum TypeDB {
    case coreData
    case realm
}

class TodoDetailViewController: UIViewController {
    @IBOutlet weak var taskTextField: UITextField!
    @IBOutlet weak var textLabel: UILabel!
    
    var currentLabelText = "Add new item"
    
    var typeDB: TypeDB = .coreData
    var coreDataService: TaskCoreDataService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switch(self.typeDB) {
            case (.coreData):
                textLabel.text = "\(currentLabelText) to CoreData"
                break
            case (.realm):
                textLabel.text = "\(currentLabelText) to Realm"
        }
    }
    
    @IBAction func saveAction(_ sender: Any) {
        if (taskTextField.text != "") {
            switch(self.typeDB) {
                case (.coreData):
                    let coreDataService = TaskCoreDataService()
                    coreDataService.save(title: taskTextField.text ?? "")
                    break
                case (.realm):
                    let realmService = TaskRealmService()
                    realmService.save(title: taskTextField.text ?? "")
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateTodoList"), object: nil)
            self.dismiss(animated: true, completion: nil)
        } else {
            taskTextField.layer.borderColor = UIColor.systemRed.cgColor
            taskTextField.layer.borderWidth = 1.0
        }
    }
    
    @IBAction func changeTextFieldAction(_ sender: UITextField) {
        taskTextField.layer.borderColor = UIColor.clear.cgColor
        taskTextField.layer.borderWidth = 1.0
    }
    
}
