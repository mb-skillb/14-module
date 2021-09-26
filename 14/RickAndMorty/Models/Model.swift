//
//  Model.swift
//  12
//
//  Created by Максим Болдырев on 25.06.2021.
//

import Foundation
import RealmSwift

class Model: Object {
    @objc dynamic public var id: Int = 0
    
    static func == (lhs: Model, rhs: Model) -> Bool {
        return lhs.id == rhs.id
    }
    
    func initialize(data: NSDictionary) {}
}
