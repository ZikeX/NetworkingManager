//
//  ViewController.swift
//  NetworkingManager
//
//  Created by shen on 2017/5/16.
//  Copyright © 2017年 shen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let path = "https://api.52kandianying.cn/index.html?method=typeinfos"
        
        let dict = ["id":"3"]
        
        NetworkingManager.share.postHttpsWithPath(path: path, paras: dict, success: {(result) in
            print(result)
            
        }, failure: {(error) in
            
            print(error)
            
        })
        
        
//        let path = "https://api.52kandianying.cn/index.html?method=typeinfos"
//        
//        let dict = ["id":"3"]
//        
//        NetworkingManager.share.postHttpsWithPath(path: path, paras: dict, success: {(result) in
//            print(result)
//            
//        }, failure: {(error) in
//            print(error)
//            
//        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

