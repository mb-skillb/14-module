//
//  Category.swift
//  12
//
//  Created by Максим Болдырев on 23.06.2021.
//

import Foundation
import Alamofire
import UIKit
import RealmSwift

class Character: Model {
    @objc dynamic var name: String = ""
    @objc dynamic var status: String = ""
    var statusColor: UIColor = .systemGreen
    @objc dynamic var image: String = ""
    @objc dynamic var species: String = ""
    @objc dynamic var gender: String = ""
    @objc dynamic var location: CutLocation? = CutLocation()
  
    override func initialize(data: NSDictionary) {
        self.name = data["name"] as! String
        self.status = data["status"] as! String
        self.image = data["image"] as! String
        self.species = data["species"] as! String
        self.gender = data["gender"] as! String
        self.location?.initialize(data: data["location"] as! NSDictionary)

        switch status {
            case "Alive":
                self.statusColor = .systemGreen
            case "Dead":
                self.statusColor = .systemRed
            default:
                self.statusColor = .systemGray
        }
        self.id = data["id"] as! Int
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
