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
    
    func postUserRegistrationData(_ username: String, _ password: String) {
        
        guard let url = URL(string: "") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // change the name of variables
        let json = [
            "username": username,
            "password": password
        ]
        
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: json)
        }
        catch let error{
            print(error.localizedDescription)
        }
        
        let task = session.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!) as? NSDictionary
                
                if let json = json {
                    // take userid and do some processs
                }
                
            }catch let error {
                print(error.localizedDescription)
            }
            
            
            
            
        }
        task.resume()
    }
}
