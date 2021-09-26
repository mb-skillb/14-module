//
//  Pagination.swift
//  12
//
//  Created by Максим Болдырев on 23.06.2021.
//

import Foundation

class Pagination {
    var count: Int = 0
    var pages: Int = 0
    var next: String? = ""
    var prev: String? = ""
    
    init?(data: NSDictionary){
        if data["next"] != nil {
            self.next = data["next"] as? String
        } else {
            self.next = ""
        }
        
        if data["prev"] != nil {
            self.prev = data["prev"] as? String
        } else {
            self.prev = ""
        }
            
        self.count = data["count"] as? Int ?? 0
        self.pages = data["pages"] as? Int ?? 0
    }
    
    init() {
        
    }
}
