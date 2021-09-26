//
//  TaskModel.swift
//  14
//
//  Created by Максим Болдырев on 07.07.2021.
//

import Foundation

class TaskModel {
    var uuid: String = ""
    var title: String = ""
    
    init(uuid: String, title: String) {
        self.title = title
        self.uuid = uuid
    }
}
