//
//  WebService.swift
//  CheckRooMate
//
//  Created by Furkan Açıkgöz on 16.05.2022.
//

import Foundation

class WebService {
    
    static let run: WebService = WebService()
    let session = URLSession.shared
    
}

// Sign In User
extension WebService {
    
    func signInUser(_ username: String, _ password: String, _ CompletionHandler: @escaping (IsLoginSuccessfulResponse?)->(Void)) {
        
        guard let url = URL(string: "https://bezkoder-server.herokuapp.com/api/login") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "username" : username,
            "password" : password
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json)
        } catch let error {
            print(error.localizedDescription)
        }
        
        let _ = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
               print("Server error!")
               return
            }
            
            if let data = data {
                let json = try? JSONDecoder().decode(IsLoginSuccessfulResponse.self, from: data)
                
                if let json = json {
                    CompletionHandler(json)
                }
            }
            
        }.resume()
        
    }
    
}

// Sign Up User
extension WebService {
    
    func signUpUser(_ user: UserRegistrationRequest, _ CompletionHandler: @escaping (UserRegistrationResponse?)->(Void)) {
        
        guard let url = URL(string: "https://bezkoder-server.herokuapp.com/api/insertUser") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let json = [
            "username": user.username,
            "password": user.password,
            "name": user.name,
            "surname": user.surname,
            "email": user.email
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json)
        }
        catch let error{
            print(error)
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
               print("Server error!")
               return
            }
            
            if let data = data {
                let json = try? JSONDecoder().decode(UserRegistrationResponse.self, from: data)
                CompletionHandler(json)
            }
   
        }
        task.resume()
    }
    
}

// Get All Posts
extension WebService {
    
    func getAllPosts(_ CompletionHandler: @escaping ([Post]?)->(Void)) {
        
        guard let url = URL(string: "https://bezkoder-server.herokuapp.com/api/getPosts") else { return }
        
        let _ = session.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
               print("Server error!")
               return
            }
            
            if let data = data {
                let json = try? JSONDecoder().decode([Post].self, from: data)
                CompletionHandler(json)
            }
            
        }.resume()
    }
    
}
