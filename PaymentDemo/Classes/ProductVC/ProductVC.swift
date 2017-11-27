//
//  ProductVC.swift
//  PaymentDemo
//
//  Created by Nikunj on 23/11/17.
//  Copyright © 2017 Nikunj. All rights reserved.
//

import UIKit

class ProductVC: UIViewController,UITableViewDataSource,UITableViewDelegate{

    @IBOutlet var tblviewProduct : UITableView?
    @IBOutlet var tblviewProductPay : UITableView?
    @IBOutlet var btnPay : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
          self.btnPay?.backgroundColor = UIColor.gray
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
let appDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appDelegate.isAddCard){
            self.btnPay?.backgroundColor = UIColor.green
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtn_Change(_ sender: UIButton) {
        
        let objVC = objPaymentOptionsSB.instantiateViewController(withIdentifier: "PaymentOptionsVC") as! PaymentOptionsVC
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    
    //Marke: - Tableview Delegate
    //Marke: -
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (tableView == tblviewProduct) {
        return 3
        } else {
            return 1
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if (tableView == tblviewProduct) {
            
            let cell :ProductCell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
            //        cell.lblPath?.text = strPropertyType
            
            if (indexPath.row == 0) {
                cell.lbltitle?.text = "Sample product"
                cell.lblPrice?.text = "$ 9.00"
                
            } else if (indexPath.row == 1) {
                cell.lbltitle?.text = "Shipping charge"
                cell.lblPrice?.text = "$ 1.00"
                
            } else if (indexPath.row == 2) {
                cell.lbltitle?.text = "Tax"
                cell.lblPrice?.text = "$ 0.50"
            }
            
            return cell
        } else {
            let cell :ProductPayCell = tableView.dequeueReusableCell(withIdentifier: "ProductPayCell") as! ProductPayCell
            //        cell.lblPath?.text = strPropertyType
            
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
        
    }
    
    
    
    
    // MARK: - UITableViewDelegate Methods
    // MARK: -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if (tableView == tblviewProductPay) {

             //optional, to get from any UIButton for example
            
            let cell = tableView.cellForRow(at: indexPath) as! ProductPayCell


            if((cell.btnCheck?.isSelected)!){
                cell.btnCheck?.setImage(UIImage(named: "uncheck.png"), for: UIControlState.normal)
                cell.btnCheck?.isSelected = false
                self.btnPay?.backgroundColor = UIColor.gray
                print("check")
            } else {
                cell.btnCheck?.setImage(UIImage(named: "check.png"), for: UIControlState.normal)
               print("uncheck")
                self.btnPay?.backgroundColor = UIColor.green
                cell.btnCheck?.isSelected = true
            }
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
