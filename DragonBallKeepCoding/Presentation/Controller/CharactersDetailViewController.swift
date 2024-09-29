//
//  CharactersDetailViewController.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 26/9/24.
//

import UIKit

class CharactersDetailViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var transformationsButton: UIButton!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    // MARK: - Variables
    private var character: DBCharacter
    private var charactersTransformations: [DBCharacter] = []

    // MARK: - Initializers
    init(_ character: DBCharacter){
        self.character = character
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        requestTransformations()
    }
    
    func requestTransformations() {
        NetworkModel.shared.getTransformations(character.id,
            completion: { [weak self] result in
                switch result {
                    case let .success(characters):
                        self?.onRequestSuccess(characters)
                    case let .failure(error):
                        print(error)
                }
            }
        )
    }
    
    func onRequestSuccess(_ transformations: [DBCharacter]){
        charactersTransformations = transformations
        DispatchQueue.main.async {
            self.transformationsButton.isHidden = self.charactersTransformations.isEmpty
        }
    }
    
    @IBAction func transformationsPressed(_ sender: UIButton) {
        let charactersTableViewController = CharactersTableViewController(charactersTransformations)
        navigationController?.show(charactersTableViewController, sender: self)
    }
}

private extension CharactersDetailViewController {
    func configureView() {
        transformationsButton.isHidden = false
        characterNameLabel.text = character.name
        characterDescriptionLabel.text = character.description
        characterDescriptionLabel.sizeToFit()
        
        guard let imageURL = URL(string: character.photo) else {
            return
        }
        
        characterImageView.setImage(url: imageURL)
    }
}
