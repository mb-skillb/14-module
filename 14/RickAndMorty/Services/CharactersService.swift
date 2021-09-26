//
//  CharactersService.swift
//  12
//
//  Created by Максим Болдырев on 27.06.2021.
//

import Foundation
import Alamofire
import AlamofireImage
import UIKit

class CharactersService: BaseService {
    static let imageCache = AutoPurgingImageCache()
    
    override init() {
        super.init()
        
        self.urlSegment = "character"
        
        self.model = Character.self
    }
    
    func getImage(url: String, completion: @escaping (UIImage) -> Void) {
        let cachedAvatar = CharactersService.imageCache.image(withIdentifier: "\(url)")
        
        if cachedAvatar != nil {
            completion(cachedAvatar!)
        } else {
            Alamofire.request("\(url)", method: .get).responseImage{ response in
                if response.result.value != nil {
                    let avatarImage = UIImage(data: response.data!, scale: 1.0)!
                    CharactersService.imageCache.add(avatarImage, withIdentifier: "\(url)")
                    completion(avatarImage)
                }
            }
        }
    }
    
    func getWithPaginator(page: Int, fromCache: Bool = false, completion: @escaping (ResponseModel) -> Void) {
        if (fromCache) {
            let response = ResponseModel(data: fetch())
            completion(response!)
        }
        
        Alamofire.request("\(self.baseUrl)/\(urlSegment)?page=\(page)").responseJSON { response in
            if let objects = response.value,
                let jsonDict = objects as? NSDictionary {
                DispatchQueue.main.async { [self] in
                    let response = ResponseModel(data: jsonDict, type: Character.self)
                        for character in response!.data {
                            self.save(character: character as! Character)
                        }
                        completion(response!)
                    }
                }
        }
    }
}
