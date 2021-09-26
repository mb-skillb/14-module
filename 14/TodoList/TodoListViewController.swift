//
//  TodoListViewController.swift
//  14
//
//  Created by Максим Болдырев on 07.07.2021.
//

import UIKit

class TodoListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    var tasksCoreData: [TaskModel] = []
    var tasksRealm: [TaskRealmModel] = []
    var segmentIndex = 0 {
        didSet {
            updateData()
        }
    }
    let coreDataService = TaskCoreDataService()
    let realmService = TaskRealmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateData), name: NSNotification.Name(rawValue: "updateTodoList"), object: nil)
        tableView.tableFooterView = UIView()
        updateData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "TodoDetailSegue") {
            let vc = segue.destination as! TodoDetailViewController
            switch segmentIndex {
                case 0:
                    vc.typeDB = .coreData
                default:
                    vc.typeDB = .realm
            }
        }
    }
    
    @IBAction func changeDBAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
            case 0:
                segmentIndex = 0
            default:
                segmentIndex = 1
        }
    }
    
    @objc func updateData() {
        switch segmentIndex {
        case 0:
            self.tasksCoreData = coreDataService.fetch()
        default:
            self.tasksRealm = realmService.fetch()
        }
        self.tableView.reloadData()
    }
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (segmentIndex == 0) {
            return tasksCoreData.count
        } else {
            return tasksRealm.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if (segmentIndex == 0) {
            cell.textLabel?.text = self.tasksCoreData[indexPath.row].title
        } else {
            cell.textLabel?.text = self.tasksRealm[indexPath.row].title
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if (segmentIndex == 0) {
                coreDataService.deleteByUuid(uuid: self.tasksCoreData[indexPath.row].uuid)
                self.tasksCoreData.remove(at: indexPath.row)
            } else {
                realmService.deleteByUuid(uuid: self.tasksRealm[indexPath.row].uuid)
                self.tasksRealm.remove(at: indexPath.row)
            }
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}
