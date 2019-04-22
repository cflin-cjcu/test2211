//
//  ViewController.swift
//  test1122
//
//  Created by L20102-02 on 2019/4/22.
//  Copyright © 2019年 L20102-02. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lv_name: UILabel!
    @IBOutlet weak var bt_submit: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func submit(_ sender: UIButton) {
        lv_name.text = "AAAA"
        
    }
    

}

