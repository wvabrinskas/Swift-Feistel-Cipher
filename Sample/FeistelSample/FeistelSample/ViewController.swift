//
//  ViewController.swift
//  FeistelSame
//
//  Created by William Vabrinskas on 2/20/20.
//  Copyright © 2020 William Vabrinskas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        

        let data = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut as;dfkja;fkjakdfjadfjajf;a.sffsdajuu ".data(using: .utf8)
        let fest = Feistel.shared
        fest.passes = 5
        
        //when setting input keys the number of passes will be set to the number of input keys
        fest.inputKeys = ["asd;fkajf;dk", "asdk;fjasfkafjasds", "asdjkfhsfjdkshfh", "asdkfjkfdjsjfsdic"]
        
        print(fest.keys())

        if let encrypt = fest.encrypt(data: data) {
            let string = String(data: encrypt, encoding: .utf8)
            print("\n---------encrypted--------- \n")
            print("Data: \(encrypt) String: \(string)")
            print("\n---------decrypting--------- \n")
            if let decrypt = fest.decrypt(data: encrypt) {
                let dString = String(data: decrypt, encoding: .utf8)
                print(dString)
            }
        }

    }


}

