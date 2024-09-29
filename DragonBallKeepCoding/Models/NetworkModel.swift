//
//  NetworkModel.swift
//  DragonBallKeepCoding
//
//  Created by Aroa Miguel Garcia on 23/9/24.
//

import Foundation

final class NetworkModel {
    // Estamos creando el NetworkModel como singleton
    static let shared = NetworkModel()
    
    // https://dragonball.keepcoding.education
    private var baseComponents: URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "dragonball.keepcoding.education"
        return components
    }
    
    private let client: APIClientProtocol
    
    private var token: String?
    
    func setToken(_ token: String){
        self.token = token
    }
    
    init(client: APIClientProtocol = APIClient()) {
        self.client = client
    }
    
    func loginRequest(
        _ username: String,
        _ password: String,
        completion: @escaping (Result<String, DBError>) -> Void
    ) {
        var components = baseComponents
        components.path = "/api/auth/login"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        if (username.isEmpty || password.isEmpty){
            completion(.failure(.noData))
            return
        }
        
        
        let loginString = String(format: "%@:%@", username, password)
        guard let loginData = loginString.data(using: .utf8) else {
            completion(.failure(.encryptionError))
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        
        client.requestLogin(from: urlRequest, completion: completion)
    }
    
    func getCharacters(_ character: String,
        completion: @escaping (Result<[DBCharacter], DBError>) -> Void
    ) {
        // Vamos a crear nuestra url request
        var components = baseComponents
        components.path = "/api/heros/all"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let usableToken = token else {
            completion(.failure(.missingToken))
            return
        }
        
        let json: [String: Any] = ["name" : "\(character)"]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else{
            completion(.failure(.unknown))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(usableToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData

        client.requestCharacters([DBCharacter].self, from: urlRequest, completion: completion)
    }
    
    func getTransformations(_ characterId: String,
        completion: @escaping (Result<[DBCharacter], DBError>) -> Void
    ) {
        // Vamos a crear nuestra url request
        var components = baseComponents
        components.path = "/api/heros/tranformations"
        
        guard let url = components.url else {
            completion(.failure(.malformedURL))
            return
        }
        
        guard let usableToken = token else {
            completion(.failure(.missingToken))
            return
        }
        
        let json: [String: Any] = ["id" : "\(characterId)"]
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else{
            completion(.failure(.unknown))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("Bearer \(usableToken)", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = jsonData

        client.requestCharacters([DBCharacter].self, from: urlRequest, completion: completion)
    }
}
