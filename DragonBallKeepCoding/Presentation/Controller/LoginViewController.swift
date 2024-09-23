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
        
        NetworkModel.shared.loginRequest(getUsername,getPassword,completion : { result in
            switch result {
                case let .success(token):
                    self.onLoginSuccess(token)
                case let .failure(error):
                    self.onLoginError(error)
            }
        })
    }
    
    func onLoginSuccess (_ token: String) {
        NetworkModel.shared.setToken(token)
        
        DispatchQueue.main.async{
            let charactersTableViewController = CharactersTableViewController()
            self.navigationController?.setViewControllers([charactersTableViewController], animated: true)
        }
    }
    
    func onLoginError (_ error: DBError) {
        print("An error has occured: \(error)")
    }

}
