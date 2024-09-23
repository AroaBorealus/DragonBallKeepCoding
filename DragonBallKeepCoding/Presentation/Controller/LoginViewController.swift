//
//  LoginViewController.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 11/9/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    let loginUsername = "Aroa"
    let loginPassword = "1234"

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        
        
        let username = usernameTextField.text
        let password = passwordTextField.text

        guard let getUsername = username, let getPassword = password else {
            print("username or password is missing")
            return
        }
        
        
        
        
        print("username: \(getUsername)")
        print("password: \(getPassword)")
        
        if(getUsername == loginUsername && getPassword == loginPassword){
            let charactersTableViewController = CharactersTableViewController()
            navigationController?.setViewControllers([charactersTableViewController], animated: true)
        }
        
    }
}
