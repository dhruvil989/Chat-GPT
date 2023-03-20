//
//  ViewModel.swift
//  ChatGPT_Text
//
//  Created by Dhruvil Moradiya on 10/03/23.
//

import Foundation
import UIKit

class ViewModel: ObservableObject {
    
    private var token = "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"
    
    // fetch data
    public func send(text: String, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/chat/completions")
        let messageLog: [[String: String]] = [
            ["role": "user", "content": "\(text)"]
        ]
        let httpBody: [String: Any] = [
            "model" : "gpt-3.5-turbo",
            "messages" : messageLog
        ]
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let httpBodyJson: Data? = try? JSONSerialization.data(withJSONObject: httpBody, options: .prettyPrinted)
        request.httpBody = httpBodyJson
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil && error == nil {
                success(data!)
            } else {
                failure(error!)
            }
        }
        task.resume()
        
    }
    
    public func generateImage(text: String, num: Int, success: @escaping(Data) -> Void, failure: @escaping(Error) -> Void) {
        let url = URL(string: "https://api.openai.com/v1/images/generations")
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "content-type")
        
        let parameters: [String: Any] = [
            "prompt": text,
            "n": num,
            "size": "256x256"
        ]
                
        let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if data != nil {
                success(data!)
            } else {
                failure(error!)
            }
        }
        task.resume()
    }
}


