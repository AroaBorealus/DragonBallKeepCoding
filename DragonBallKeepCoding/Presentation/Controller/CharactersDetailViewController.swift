//
//  CharactersDetailViewController.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 26/9/24.
//

import UIKit

class CharactersDetailViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    private var character: DBCharacter
    
    init(_ character: DBCharacter){
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func transformationsPressed(_ sender: UIButton) {
        NetworkModel.shared.getTransformations(character.id,
            completion: {
                result in
                switch result {
                    case let .success(characters):
                    self.onTransformationsRequestSuccess(characters)
                    case let .failure(error):
                        print(error)
                }
            }
        )

    }
    
    func onTransformationsRequestSuccess(_ transformations: [DBCharacter]) {
        DispatchQueue.main.async{
            let charactersTableViewController = CharactersTableViewController(transformations)
            self.navigationController?.show(charactersTableViewController, sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension CharactersDetailViewController {
    func configureView() {
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.description
        guard let imageURL = URL(string: character.photo) else {
            return
        }
        characterImageView.setImage(url: imageURL)
        
        transformationsButton.isHidden = character.isTransformation()
    }
}
