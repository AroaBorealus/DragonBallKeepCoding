//
//  CharactersTableViewController.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 15/9/24.
//

import UIKit

final class CharactersTableViewController: UITableViewController {
    
    // MARK: - TableView DataSource
    typealias DataSource = UITableViewDiffableDataSource<Int, DBCharacter>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Int, DBCharacter>

    // MARK: - Model
    private let charactersModel: CharactersModel
    private var dataSource: DataSource?
    private var transformations: [DBCharacter]?
    
    // MARK: - Components
    private var activityIndicator: UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        return spinner
    }
    
    // MARK: - Initializers
    init(_ transformations: [DBCharacter]?, charactersModel: CharactersModel = .shared) {
        self.charactersModel = charactersModel
        self.transformations = transformations
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = activityIndicator
        
        tableView.register(
            // Instanciamos el archivo .xib a traves de su numbre
            UINib(nibName: CharactersTableViewCell.identifier, bundle: nil),
            // Cada vez que TableView se encuentre este identificador
            // tiene que instanciar el .xib que le especificamos
            forCellReuseIdentifier: CharactersTableViewCell.identifier
        )
        
        
        dataSource = DataSource(tableView: tableView) { tableView, indexPath, character in
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CharactersTableViewCell.identifier,
                for: indexPath
            ) as? CharactersTableViewCell else {
                // Si no podemos desempaquetarla
                // retornamos una celda en blanco
                return UITableViewCell()
            }
            
            
            cell.configure(with: character, false)
            return cell
        }
        
        tableView.dataSource = dataSource
        
        
        guard let unpackedTransformations = self.transformations else {
            NetworkModel.shared.getCharacters("",
                completion: {
                    result in
                    switch result {
                        case let .success(characters):
                            self.onCharacterRequestSuccess(characters)
                        case let .failure(error):
                            self.onCharacterRequestError(error)
                    }
                }
            )
            return
        }
        
        var snapshot = Snapshot()
        snapshot.appendSections([0])
        snapshot.appendItems(unpackedTransformations.sorted{
            let name0Arr = $0.name.components(separatedBy: ".")
            let name1Arr = $1.name.components(separatedBy: ".")
            
            guard let num0Str = name0Arr.first else
            {
                return $0.name < $1.name
            }
            
            guard let num1Str = name1Arr.first else
            {
                return $0.name < $1.name
            }
            
            guard let int0 = Int(num0Str) else
            {
                return $0.name < $1.name
            }
            
            guard let int1 = Int(num1Str) else
            {
                return $0.name < $1.name
            }
            
            return int0 < int1
        } )
        self.dataSource?.apply(snapshot)
    }
    
    func onCharacterRequestError(_ error: DBError) {
        print("An error has occurred: \(error)")
    }
    
    func onCharacterRequestSuccess (_ characters: [DBCharacter]){
        CharactersModel.shared.setCharacterList(characters)
    
        DispatchQueue.main.async{
            var snapshot = Snapshot()
            snapshot.appendSections([0])
            snapshot.appendItems(self.charactersModel.getCharacters())
            self.dataSource?.apply(snapshot)
        }
    }
}

// MARK: - Table View Delegate
extension CharactersTableViewController {
    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        100
    }
    
    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        
        var elementFound: DBCharacter
        
        guard let foundCell = tableView.cellForRow(at: indexPath) as? CharactersTableViewCell else{
            return
        }
        
        if let unpackedTransformations = transformations {
            guard let transformationFound = unpackedTransformations.first(where: { $0.id == foundCell.getCharacterID() }) else {
                return
            }
            elementFound = transformationFound
            
        } else {
            guard let characterFound = CharactersModel.shared.getCharacterByID(foundCell.getCharacterID()) else {
                return
            }
            elementFound = characterFound
        }
        
        let detailViewController = CharactersDetailViewController(elementFound)
        navigationController?.show(detailViewController, sender: self)
    }
}

