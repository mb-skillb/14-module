//
//  TaskRealmService.swift
//  14
//
//  Created by Максим Болдырев on 07.07.2021.
//

import Foundation
import RealmSwift

class TaskRealmService {
    func save(title: String) -> Void {
        let task = TaskRealmModel()
        task.title = title
        
        let realm = getRealm()
        try! realm.write {
            realm.add(task)
        }
    }
    
    func fetch() -> [TaskRealmModel] {
        let realm = getRealm()
        let tasks = realm.objects(TaskRealmModel.self)
        
        var result: [TaskRealmModel] = []
        for task in tasks {
            result.append(task)
        }
        
        return result
    }
    
    func deleteByUuid(uuid: String) {
        let realm = getRealm()
        let task = realm.object(ofType: TaskRealmModel.self, forPrimaryKey: uuid)
        try! realm.write {
            realm.delete(task!)
        }
    }
    
    private func getRealm() -> Realm {
        return try! Realm()
    }
}
