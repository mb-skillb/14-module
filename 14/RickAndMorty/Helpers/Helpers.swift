//
//  Helpers.swift
//  12
//
//  Created by Максим Болдырев on 29.06.2021.
//

import Foundation

func getListOfIdFromArrayOfUrl(listOfUrl: [String]) -> [String] {
    var result: [String] = []
    
    for url in listOfUrl {
        let url = URL(string: url)?.lastPathComponent
        result.append(url!)
    }
    
    return result
}
