//
//  CharactersTableViewController.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 15/9/24.
//

import UIKit

final class CharactersTableViewController: UITableViewController {
        
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkModel.shared.getTransformations("Goku",
            completion: {
                result in
                switch result {
                    case let .success(characters):
                        print(characters)
                    case let .failure(error):
                        print(error)
                }
            }
        )
    }
}
