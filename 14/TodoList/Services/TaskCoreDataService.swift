//
//  TaskCoreDataService.swift
//  14
//
//  Created by Максим Болдырев on 07.07.2021.
//

import UIKit
import Foundation
import CoreData

class TaskCoreDataService {
    let entityName: String = "Task"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate //Singlton instance
    var context: NSManagedObjectContext!
    var tasks: [TaskModel] = []
    
    init() {
        context = appDelegate.persistentContainer.viewContext
    }
    
    func save(title: String) -> Void {
        let uuid = UUID().uuidString
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context)
        let task = NSManagedObject(entity: entity!, insertInto: context)
        task.setValue(title, forKey: "title")
        task.setValue(uuid, forKey: "uuid")

        do {
            try context.save()
        } catch {
            print("Storing data failed")
        }
    }
    
    func fetch() -> [TaskModel] {
        self.tasks = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let title = data.value(forKey: "title") as! String
                let uuid = data.value(forKey: "uuid") as! String
                let task = TaskModel(uuid: uuid, title: title)
                self.tasks.append(task)
            }
        } catch {
            print("Fetching data failed")
        }
        
        return self.tasks
    }
    
    func deleteByUuid(uuid: String) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        let predicate = NSPredicate(format: "uuid=\"\(uuid)\"")
        request.predicate = predicate
        do {
            let result = try context.fetch(request)
            context.delete(result.first as! NSManagedObject)
            try! context.save()
        } catch {
            print("Deleted data failed")
        }
    }
}
