//
//  AddCardVC.swift
//  PaymentDemo
//
//  Created by Nikunj on 23/11/17.
//  Copyright © 2017 Nikunj. All rights reserved.
//

import UIKit


class AddCardVC: UIViewController {

    enum TabIndex : Int {
        case firstChildTab = 0
        case secondChildTab = 1
        case thirdChildTab = 2
    }
    
    @IBOutlet weak var segmentedControl: HMSegmentedControl!
    
    
    @IBOutlet weak var contentView: UIView!
    let segmentedC = HMSegmentedControl(items: ["Credit card", "Reward card", "Gift card"])
    
    
    var currentViewController: UIViewController?
    lazy var firstChildTabVC: UIViewController? = {
        let firstChildTabVC = objCreditCardSB.instantiateViewController(withIdentifier: "CreditCardVC")
        
        return firstChildTabVC
    }()
    lazy var secondChildTabVC : UIViewController? = {
        let secondChildTabVC = objRewardCardSB.instantiateViewController(withIdentifier: "RewardCard")
        
        return secondChildTabVC
    }()
    
    lazy var thirdChildTabVC : GiftCardVC? = {
        let thirdChildTabVC = objGiftCardSB.instantiateViewController(withIdentifier: "GiftCardVC")
        
        return thirdChildTabVC as? GiftCardVC
    }()

    override func viewDidLoad() {
        view.addSubview(segmentedC)
        segmentedC.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentedC.translatesAutoresizingMaskIntoConstraints = false
        segmentedC.selectionIndicatorPosition = .bottom
        segmentedC.selectionIndicatorColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
         displayCurrentTab(TabIndex.firstChildTab.rawValue)
        segmentedC.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
            NSAttributedStringKey.font.rawValue : UIFont.systemFont(ofSize: 17)
        ]
        
        segmentedC.selectedTitleTextAttributes = [
            NSAttributedStringKey.foregroundColor.rawValue : #colorLiteral(red: 0.05439098924, green: 0.1344551742, blue: 0.1884709597, alpha: 1),
            NSAttributedStringKey.font.rawValue : UIFont.boldSystemFont(ofSize: 17)
        ]
        
        segmentedC.indexChangedHandler = { index in
            print(index)
            self.currentViewController!.view.removeFromSuperview()
            self.currentViewController!.removeFromParentViewController()
            
            self.displayCurrentTab(index)
            //            print(self.segmentedControl.selectedSegmentIndex)
            //            self.segmentedControl.selectedSegmentIndex = 1
        }
        
        NSLayoutConstraint.activate(
            [segmentedC.leftAnchor.constraint(equalTo: view.leftAnchor),
             segmentedC.heightAnchor.constraint(equalToConstant: 50),
             segmentedC.rightAnchor.constraint(equalTo: view.rightAnchor),
             segmentedC.topAnchor.constraint(equalTo: view.topAnchor, constant: 84)]
        )
    }
    
    @IBAction func onClickBtn_Back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func onClickBtn_AddCard(_ sender: UIButton) {
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let currentViewController = currentViewController {
            currentViewController.viewWillDisappear(animated)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Switching Tabs Functions
    @IBAction func switchTabs(_ sender: UISegmentedControl) {
        self.currentViewController!.view.removeFromSuperview()
        self.currentViewController!.removeFromParentViewController()
        
        displayCurrentTab(sender.selectedSegmentIndex)
    }
    
    func displayCurrentTab(_ tabIndex: Int){
        if let vc = viewControllerForSelectedSegmentIndex(tabIndex) {
            
            self.addChildViewController(vc)
            vc.didMove(toParentViewController: self)
            
            vc.view.frame = self.contentView.bounds
            self.contentView.addSubview(vc.view)
            self.currentViewController = vc
        }
    }
    
    func viewControllerForSelectedSegmentIndex(_ index: Int) -> UIViewController? {
        var vc: UIViewController?
        switch index {
        case TabIndex.firstChildTab.rawValue :
            vc = firstChildTabVC
        case TabIndex.secondChildTab.rawValue :
            vc = secondChildTabVC
        case TabIndex.thirdChildTab.rawValue :
            vc = thirdChildTabVC
        default:
            return nil
        }
        
        return vc
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
