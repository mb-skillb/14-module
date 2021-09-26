//
//  BaseService.swift
//  12
//
//  Created by Максим Болдырев on 27.06.2021.
//

import Foundation
import Alamofire
import RealmSwift

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

protocol ServiceProtocol {
    func getById(id: Int, fromCache: Bool, completion: @escaping (Model) -> Void)
}

class BaseService {
    let baseUrl: String = "https://rickandmortyapi.com/api"
    
    var urlSegment: String = ""
    
    var model: Model.Type = Model.self
    
    func save(character: Character) -> Void {
        let realm = getRealm()
        
        let exists = realm.object(ofType: Character.self, forPrimaryKey: character.id)
        if exists == nil {
            try! realm.write {
                realm.add(character)
            }
        }
    }
    
    func fetch() -> [Character] {
        let realm = getRealm()
        let characters = realm.objects(Character.self)
        
        var result: [Character] = []
        for character in characters {
            result.append(character)
        }
        
        return result
    }
    
    func deleteByUuid(id: Int) {
        let realm = getRealm()
        let character = realm.object(ofType: Character.self, forPrimaryKey: id)
        try! realm.write {
            realm.delete(character!)
        }
    }
    
    private func getRealm() -> Realm {
        return try! Realm()
    }
}
