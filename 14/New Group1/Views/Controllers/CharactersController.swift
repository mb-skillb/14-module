//
//  ViewController.swift
//  12
//
//  Created by Максим Болдырев on 23.06.2021.
//

import UIKit
import Alamofire
import AlamofireImage

class CharactersController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var characters: [Character] = []
    var page: Int = 1
    let imageCache = AutoPurgingImageCache()
    var pagesCount = 0
    var fromCache = true;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Characters"
        tableView.register(UINib(nibName: "CharactersCell", bundle: nil), forCellReuseIdentifier: "CharactersCell")
        self.getData(page: 1, fromCache: self.fromCache)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fromCache = false;
        self.getData(page: 1)
    }
    
    private func getData(page: Int, fromCache: Bool = false) {
        if (!fromCache && page == 1) {
            self.characters = []
        }
        
        CharactersService().getWithPaginator(page: page, fromCache: fromCache, completion: { (response) in
            self.pagesCount = response.pagination?.pages ?? 0
            for character in response.data as! [Character] {
                if self.characters.firstIndex(of: character) == nil {
                    self.characters.append(character)
                }
            }
            self.tableView.reloadData()
        })
    }
}

extension CharactersController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CharactersCell", for: indexPath) as! CharactersCell
        let character = characters[indexPath.row]
        cell.nameLabel.text = character.name
        cell.aliveLabel.text = "\(character.status) - \(character.species)"
        cell.location.text = character.location?.name
        cell.statusColorView.backgroundColor = character.statusColor
        
        var countImages = 0
        
        CharactersService().getImage(url: character.image, completion: { (response) in
            countImages += 1
            cell.pictureView.image = response
            
            if (countImages == self.characters.count) {
                tableView.beginUpdates()
                tableView.reloadRows(at: [indexPath], with: .none)
                tableView.endUpdates()
            }
        })
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == self.characters.count - 1 {
            self.page += 1

            if (self.page <= self.pagesCount && self.fromCache == false) {
                self.getData(page: page)
            }
        }
    }
}

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}

