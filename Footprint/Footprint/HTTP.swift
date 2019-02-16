//
//  HTTP.swift
//  Footprint
//
//  Created by Jing Lin on 2/16/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import Foundation

enum HttpMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

class HttpClientAPI: NSObject {
    
    var request: URLRequest?
    var session: URLSession?
    
    static func instance() -> HttpClientAPI {
        return HttpClientAPI()
    }
    
    func makeAPICall(url: String, params: Dictionary<String, Any>?, method: HttpMethod, success:@escaping (Data?, HTTPURLResponse?, NSError?) -> Void, failure:@escaping (Data?, HTTPURLResponse?, NSError?) -> Void) {
        request = URLRequest(url: URL(string: url)!)
        
        if let params = params {
            let jsonData = try! JSONSerialization.data(withJSONObject: params)
            request?.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request?.httpBody = jsonData
        }
        
        request?.httpMethod = method.rawValue
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        
        session = URLSession(configuration: configuration)
        session?.dataTask(with: request! as URLRequest) { (data, response, error) -> Void in
            
            if let data = data {
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    success(data, response, error as NSError?)
                } else {
                    failure(data, response as? HTTPURLResponse, error as NSError?)
                }
            } else {
                failure(data, response as? HTTPURLResponse, error as NSError?)
            }
        }.resume()
        
    }
}
