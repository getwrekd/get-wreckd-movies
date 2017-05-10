//
//  File.swift
//  Movies
//
//  Created by Matthew on 5/10/17.
//  Copyright © 2017 Matthew. All rights reserved.
//

import Foundation

class HTTPHandler {
    static func getJson(url: String, completionHandler: @escaping (Data?) -> (Void)) {
        let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let url = URL(string: urlString!)
        
        print("Making API call to \(url!)")
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url!) { data, response, error in
            if let data = data {
                let httpResponse = response as! HTTPURLResponse
                let statusCode = httpResponse.statusCode
                
                if statusCode == 200 {
                    print("status code was 200, calling handler")
                    completionHandler(data as Data)
                }
                
            }
            else if let error = error {
                print(String(describing: error))
                completionHandler(nil)
            }
        }
        
        task.resume()
    }
}
