//
//  CharactersTableViewCell.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 23/9/24.
//

import UIKit

class CharactersTableViewCell: UITableViewCell {
    static let identifier = String(describing: CharactersTableViewCell.self)
    // MARK: - Outlets
    @IBOutlet weak var characterPhotoImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var favouriteImageView: UIImageView!
    
    // MARK: - Configuration
    func configure(with character: DBCharacter,_ isFavourite: Bool) {
        characterNameLabel.text = character.name
        favouriteImageView.isHidden = !isFavourite
        
        guard let imageURL = URL(string: character.photo) else {
            return
        }
        characterPhotoImageView.setImage(url: imageURL)
    }
    
    func getCharacterName() -> String{
        guard let name = characterNameLabel.text else{
            return ""
        }
        return name
    }
}
