//
//  ViewController.swift
//  Demo
//
//  Created by 李响 on 2019/4/20.
//  Copyright © 2019 swift. All rights reserved.
//

import UIKit
import Delegates

protocol TestDelegate {
    func test()
}

class ViewController: UIViewController {

    let delegates = Delegates<TestDelegate>()
    
    var testA = TestA()
    var testB = TestB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //delegates.add(testA)
        //delegates.add(testB)
        
        delegates += testA
        delegates += testB
        
        delegates.invoke { $0.test() }
        
        print(delegates.contains(testA))
    }
}

class TestA: TestDelegate {
   
    func test() {
        print("testA")
    }
}

class TestB: TestDelegate {
    
    func test() {
        print("testB")
    }
}


