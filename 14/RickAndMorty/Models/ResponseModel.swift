//
//  ResponseModel.swift
//  12
//
//  Created by Максим Болдырев on 23.06.2021.
//

import Foundation

class ResponseModel {
    let pagination: Pagination?
    var data: [Any] = []
    
    init?(data: NSDictionary, type: Model.Type) {
        self.pagination = Pagination(data: data["info"] as! NSDictionary)!
        let results = data["results"] as! NSArray
        
        for (_, item) in results.enumerated() where item is NSDictionary {
            let entity = type.init()
            entity.initialize(data: item as! NSDictionary)
            self.data.append(entity)
        }
    }
    
    init?(data: [Character]) {
        pagination = Pagination()
        self.data = data
    }
}
