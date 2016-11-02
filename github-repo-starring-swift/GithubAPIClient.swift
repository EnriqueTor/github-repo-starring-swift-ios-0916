//
//  GithubAPIClient.swift
//  github-repo-starring-swift
//
//  Created by Haaris Muneer on 6/28/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    //getRepos
    class func getRepositoriesWithCompletion(_ completion: @escaping ([Any]) -> ()) {
        
        print("getRepositoriesWithCompletion called")
        
        let urlString = URL(string: "\(Github.apiURL)/repositories?client_id=\(Github.clientID)&client_secret=\(Github.clientSecret)")
        
        print("\(Github.apiURL)/repositories?client_id=\(Github.clientID)&client_secret=\(Github.clientSecret)")
        
        guard let unwrappedURL = urlString else { fatalError("Invalid URL") }
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            guard let data = data else { fatalError("Unable to get data \(error?.localizedDescription)") }
            
            if let responseArray = try? JSONSerialization.jsonObject(with: data, options: []) as? [Any] {
                
                if let responseArray = responseArray {
                    completion(responseArray)
                }
            }
        }
        task.resume()
    }
    
    //checkStar
    class func checkIfRepositoryIsStarred(fullName: String, completion: @escaping (Bool) -> (Void)) {
        
        print("checkIfRepositoryIsStarred called")
        
        let urlString = URL(string: "\(Github.apiURL)/user/starred/\(fullName)?access_token=\(Github.personalToken)")
        
        guard let unwrappedURL = urlString else { fatalError("Invalid URL") }
        
        let session = URLSession.shared
        
        var request = URLRequest(url: unwrappedURL)
        
        request.httpMethod = "GET"

        let task = session.dataTask(with: request) { (data, response, error) in
            
            let httpresponse = response as! HTTPURLResponse
            
            switch httpresponse.statusCode {
                
            case 204:
                completion(true)
                
            case 404:
                completion(false)
            default:
                break
                
            }
        }
            task.resume()
        }
        
        //starRepo
        class func starRepository(named: String, completion: @escaping ()-> ()) {
            
            print("starRepository called")
            
            let urlString = URL(string: "\(Github.apiURL)/user/starred/\(named)?access_token=\(Github.personalToken)")
            
            print("\(Github.apiURL)/user/starred/\(named)?access_token=\(Github.personalToken)")
            
            guard let unwrappedURL = urlString else { fatalError("Invalid URL") }
            
            let session = URLSession.shared
            
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "PUT"
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                completion()
            }
            task.resume()
        }
        
        //unstarRepo
        class func unstarRepository(named: String, completion: @escaping ()-> ()) {
            
            print("unstarRepository called")
            
            let urlString = URL(string: "\(Github.apiURL)/user/starred/\(named)?access_token=\(Github.personalToken)")
            
            guard let unwrappedURL = urlString else { fatalError("Invalid URL") }
            
            let session = URLSession.shared
            
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "DELETE"
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                completion()
            }
            task.resume()
        }
        
}

// request.addValue("0", forHTTPHeaderField: "content-Length")
