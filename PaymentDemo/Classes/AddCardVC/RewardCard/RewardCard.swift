//
//  RewardCard.swift
//  PaymentDemo
//
//  Created by Nikunj on 23/11/17.
//  Copyright © 2017 Nikunj. All rights reserved.
//

import UIKit

class RewardCard: UIViewController {
@IBOutlet var btnCheck : UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func onClickBtn_AddCard(_ sender: UIButton) {
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        
    }
    
    @IBAction func onClickBtn_Check(_ sender: UIButton) {
        
        if((sender.isSelected)){
            sender.setImage(UIImage(named: "uncheck.png"), for: UIControlState.normal)
            sender.isSelected = false
            print("check")
        } else {
            sender.setImage(UIImage(named: "check.png"), for: UIControlState.normal)
            print("uncheck")
            sender.isSelected = true
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
