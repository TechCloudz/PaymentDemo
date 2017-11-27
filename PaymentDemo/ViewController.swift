//
//  ViewController.swift
//  PaymentDemo
//
//  Created by Nikunj on 23/11/17.
//  Copyright © 2017 Nikunj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onClickBtn_viewDemo(){
       
        let objVC = objProductSB.instantiateViewController(withIdentifier: "ProductVC") as! ProductVC
        self.navigationController?.pushViewController(objVC, animated: true)
    }

}

