//
//  LoginViewController.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 11/9/24.
//

import UIKit

final class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.text = ""
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        guard let getUsername = usernameTextField.text, let getPassword = passwordTextField.text else {
            return
        }
                
        errorLabel.text = ""
        NetworkModel.shared.loginRequest(getUsername,getPassword,completion : { [weak self] result in
            switch result {
                case let .success(token):
                    self?.onLoginSuccess(token)
                case let .failure(error):
                    self?.onLoginError(error)
            }
        })
    }
    
    func onLoginSuccess (_ token: String) {
        NetworkModel.shared.setToken(token)
        
        DispatchQueue.main.async{
            let charactersTableViewController = CharactersTableViewController(nil)
            self.navigationController?.title = "Characters"
            self.navigationController?.setViewControllers([charactersTableViewController], animated: true)
        }
    }
    
    func onLoginError (_ error: DBError) {
        DispatchQueue.main.async {
            self.errorLabel.textColor = UIColor.red
            self.errorLabel.text = ""
            
            switch error {
            case .noData:
                self.errorLabel.text = "Username or Password missing"
                break
            case .decodingFailed, .malformedURL, .statusCode, .unauthorized, .missingToken, .encryptionError, .unknown:
                self.errorLabel.text = "Incorrect Login"
                break
            }
        }
    }
}
