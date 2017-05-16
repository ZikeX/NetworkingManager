//
//  NetworkingManager.swift
//  NetworkingManager
//
//  Created by shen on 2017/5/16.
//  Copyright © 2017年 shen. All rights reserved.
//

import UIKit

class NetworkingManager: NSObject ,URLSessionDataDelegate{
    
     static let share = NetworkingManager()
    
    // MARK:- get请求
    func getHttpsWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        var i = 0
        var address = path
        if let paras = paras {
            
            for (key,value) in paras {
                
                if i == 0 {
                    
                    address += "?\(key)=\(value)"
                }else {
                    
                    address += "&\(key)=\(value)"
                }
                
                i += 1
            }
        }
        
        let url = URL(string: address.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        print(url!)
        
        let request = URLRequest.init(url: url!)
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        
        let dataTask = session.dataTask(with: request, completionHandler: {(data,respond,error) in
            
            if let data = data {
                
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments){
                    
                    DispatchQueue.main.async(execute: {
                        
                        success(result)
                    })
                    
                }
            }else {
                
                DispatchQueue.main.async(execute: {
                    
                    failure(error!)
                })
            }
            
        })
        
        dataTask.resume()
        
    }
    
    
    // MARK:- post请求
    func postHttpsWithPath(path: String,paras: Dictionary<String,Any>?,success: @escaping ((_ result: Any) -> ()),failure: @escaping ((_ error: Error) -> ())) {
        
        var i = 0
        var address: String = ""
        
        if let paras = paras {
            
            for (key,value) in paras {
                
                if i == 0 {
                    
                    address += "\(key)=\(value)"
                }else {
                    
                    address += "&\(key)=\(value)"
                }
                
                i += 1
            }
        }
        let url = URL(string: path)
        var request = URLRequest.init(url: url!)
        request.httpMethod = "POST"
        request.httpBody = address.data(using: .utf8)
        
        let session = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let dataTask = session.dataTask(with: request) { (data, respond, error) in
            
            if let data = data {
                
                if let result = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) {
                    
                    DispatchQueue.main.async(execute: {
                        
                        success(result)
                    })
                }
                
            }else {
                
                DispatchQueue.main.async(execute: {
                    
                    failure(error!)
                })
            }
        }
        dataTask.resume()
        
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        guard challenge.protectionSpace.authenticationMethod == "NSURLAuthenticationMethodServerTrust" else {
            return
        }
        
        let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        completionHandler(.useCredential,credential)
    }


}
