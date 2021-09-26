//
//  Location.swift
//  12
//
//  Created by Максим Болдырев on 25.06.2021.
//

import Foundation
import RealmSwift

class CutLocation: Model {
    @objc dynamic var url: String = ""
    @objc dynamic var name: String = ""
    
    override func initialize(data: NSDictionary) {
        self.url = data["url"] as! String
        self.name = data["name"] as! String
        if (url != "") {
            id = Int(getListOfIdFromArrayOfUrl(listOfUrl: [url]).first!)!
        }
    }
}
