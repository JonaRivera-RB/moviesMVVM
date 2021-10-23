//
//  API.swift
//  CoppelMovies
//
//  Created by Jonathan Rivera on 21/10/21.
//

import Foundation

struct ResponseStatus{
    static let OK = true
    static let Error = false
}

func nsdataToJSON(_ data: Data) -> [String:AnyObject]? {
    do {
        return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
    } catch  _{
        print("dataString = \(NSString(data: data, encoding:String.Encoding.utf8.rawValue)!)")
        return nil
    }
}

class GetDataHttp {
    var url = URL(string: " ")
    let json:AnyObject? = nil
    var paramString = " "
    var header = false
    
    func forData(_ completion: @escaping(_ data:Data?,_ error: NSError?, _ success:Bool) ->()) {
        guard let url = url else {
            completion(nil,nil, ResponseStatus.Error)
            return }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        print(url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async (execute: {
                if error != nil{
                    completion(nil,error as NSError?, ResponseStatus.Error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode >= 400 {
                        print(httpResponse.statusCode)
                        completion(data,nil, ResponseStatus.Error)
                        return
                    }
                }
                
                if let data = data, let json = nsdataToJSON(data){
                    print(json)
                }
                
                completion(data, error as NSError?, true)
                return
            })
        })
        task.resume()
        
    }
    
}

class PostDataHttp {
    var url = URL(string: " ")
    let json:AnyObject? = nil
    var paramString: [String: Any] = [:]
    var header = false
    
    func forData(_ completion: @escaping(_ data:Data?,_ error: NSError?, _ success:Bool) ->()) {
        let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        
        print(url!)
        print(paramString)
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: paramString, options: JSONSerialization.WritingOptions()) // pass dictionary to nsdata object and set it as request body
        } catch let error {
            print(error.localizedDescription)
        }
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {(data, response, error) in
            DispatchQueue.main.async (execute: {
                if error != nil{
                    completion(nil,error as NSError?, ResponseStatus.Error)
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode >= 400 {
                        print(httpResponse.statusCode)
                        completion(data,nil, ResponseStatus.Error)
                        return
                    }
                    if let data = data {
                        if let json = nsdataToJSON(data){
                            print(json)
                        }
                        
                        completion(data, error as NSError?, true)
                        return
                    }
                    
                    completion(nil, error as NSError?, true)
                    return
                }
            })
        })
        task.resume()
        
    }
    
}
