//
//  TaskRealmModel.swift
//  14
//
//  Created by Максим Болдырев on 07.07.2021.
//

import Foundation
import RealmSwift

class TaskRealmModel: Object {
    @objc dynamic var uuid: String = UUID().uuidString
    @objc dynamic var title: String = ""
    
    override static func primaryKey() -> String? {
        return "uuid"
    }
}
