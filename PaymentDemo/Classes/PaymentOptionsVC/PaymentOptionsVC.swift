//
//  PaymentOptionsVC.swift
//  PaymentDemo
//
//  Created by Nikunj on 23/11/17.
//  Copyright © 2017 Nikunj. All rights reserved.
//

import UIKit
import PassKit
import Dispatch
import PopupDialog

class PaymentOptionsVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var view1 : UIView?
    @IBOutlet var view2 : UIView?
    @IBOutlet var view3 : UIView?
    @IBOutlet var view4 : UIView?
    @IBOutlet var btnPay : UIButton?
    //  Apple Pay....................
    let SupportedPaymentNetworks = [PKPaymentNetwork.visa, PKPaymentNetwork.masterCard, PKPaymentNetwork.amex, PKPaymentNetwork.discover]
    var applePayMerchantID: String = ""
    let ShippingPrice : NSDecimalNumber = NSDecimalNumber(string: "0.0")
    
    var merchantServerAddress: String = ""
    var merchantServerPort: String = ""
    var paypageId: String = ""
    var eProtectUrl: String = ""
    var eprotectHostHeader: String = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setLayout()
        self.applepay()
        // Do any additional setup after loading the view.
    }
    
    func applepay() {
        // Read settings from plist
        let path = Bundle.main.path(forResource: "Settings", ofType: "plist")!
        let url = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: url)
        let plist = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil)
        let dict = plist as! [String:String]
        merchantServerAddress = dict["merchantServerAddress"]!
        merchantServerPort = dict["merchantServerPort"]!
        paypageId = dict["paypageId"]!
        eProtectUrl = dict["eProtectUrl"]!
        applePayMerchantID = dict["applePayMerchantID"]!
        eprotectHostHeader = dict["eprotectHostHeader"]!
    }
    func setLayout(){
        view1?.layer.borderWidth  = 1
        view1?.layer.borderColor = UIColor.gray.cgColor
        
        view2?.layer.borderWidth  = 1
        view2?.layer.borderColor = UIColor.gray.cgColor
        
        view3?.layer.borderWidth  = 1
        view3?.layer.borderColor = UIColor.gray.cgColor
        
        view4?.layer.borderWidth  = 1
        view4?.layer.borderColor = UIColor.gray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onClickBtn_Back(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClickBtn_addNewCard(_ sender: UIButton) {
        let objVC = objAddCardSB.instantiateViewController(withIdentifier: "AddCardVC") as! AddCardVC
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
        
        return 2
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell :PaymentOptionsCell = tableView.dequeueReusableCell(withIdentifier: "PaymentOptionsCell") as! PaymentOptionsCell
        //        cell.lblPath?.text = strPropertyType
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        
        if (indexPath.row == 0) {
            cell.imgCard?.image = UIImage(named:"visa")!
             cell.lblCardName?.text = "3421"
        } else {
            cell.imgCard?.image = UIImage(named:"mastercard")!
              cell.lblCardName?.text = "7432"
        }
        return cell
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 50
        
    }
    
    
    
    
    // MARK: - UITableViewDelegate Methods
    // MARK: -
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let cell = tableView.cellForRow(at: indexPath) as! PaymentOptionsCell
        
        
        if((cell.btnCheck?.isSelected)!){
            cell.btnCheck?.setImage(UIImage(named: "uncheck.png"), for: UIControlState.normal)
            cell.btnCheck?.isSelected = false
            print("check")
        } else {
            cell.btnCheck?.setImage(UIImage(named: "check.png"), for: UIControlState.normal)
            print("uncheck")
            cell.btnCheck?.isSelected = true
        }
        
    }
    
    @IBAction func onClickBtn_VisaCheckout(_ sender: AnyObject) {
        self.showCustomDialog(animated: false)
    }
    @IBAction func onClickBtn_Paypal(_ sender: AnyObject) {
        let objVC = objPayPalSB.instantiateViewController(withIdentifier: "PayPalVC") as! PayPalVC
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    @IBAction func onClickBtn_Chase(_ sender: AnyObject) {
        let urlLink = "https://secure01c.chase.com/web/auth/dashboard#/dashboard/index/index"
        UIApplication.shared.openURL(URL(string: urlLink)!)
    }
    
    
    @IBAction func onClickBtn_ApplePay(_ sender: AnyObject) {
        
        let request = PKPaymentRequest()
        request.merchantIdentifier = applePayMerchantID
        request.supportedNetworks = SupportedPaymentNetworks
        request.merchantCapabilities = PKMerchantCapability.capability3DS
        request.countryCode = "US"
        request.currencyCode = "USD"
        //request.requiredBillingAddressFields = PKAddressField.All
        request.requiredShippingAddressFields = PKAddressField.all
        
        //request.applicationData = "This is a test".dataUsingEncoding(NSUTF8StringEncoding)
        
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Sample", amount: 200),
            PKPaymentSummaryItem(label: "Shipping", amount: ShippingPrice),
            PKPaymentSummaryItem(label: "Demo Merchant", amount:120)
        ]
        
        let applePayController = PKPaymentAuthorizationViewController(paymentRequest: request)
        applePayController?.delegate = self;
        
        self.present(applePayController!, animated: true, completion: nil)
    }
    
    func showCustomDialog(animated: Bool = true) {
        // Create a custom view controller
        let ratingVC = VisaCheckOutVC(nibName: "VisaCheckOutVC", bundle: nil)
        // Create the dialog
        let popup = PopupDialog(viewController: ratingVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        // Create first button
        let buttonOne = CancelButton(title: "CANCEL", height: 60) {
            //self.label.text = "You canceled the rating dialog"
        }
        
        // Create second button
        let buttonTwo = DefaultButton(title: "Continue", height: 60) {
           // self.label.text = "You rated \(ratingVC.cosmosStarRating.rating) stars"
        }
        
        // Add buttons to dialog
        popup.addButtons([buttonOne, buttonTwo])
        
        // Present dialog
        present(popup, animated: animated, completion: nil)
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
    

extension PaymentOptionsVC: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: (@escaping (PKPaymentAuthorizationStatus) -> Void)) {
        let pkPaymentToken = payment.token
        //pkPaymentToken.paymentData //base64 encoded, applepay.data
        
        let json = try? JSONSerialization.jsonObject(with: pkPaymentToken.paymentData, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:AnyObject]
        
        let version = json!["version"] as! String
        let data = json!["data"] as! String
        let signature = json!["signature"] as! String
        let ephemeralPublicKey = (json!["header"] as! [String: String])["ephemeralPublicKey"]! as String
        var applicationData: String = ""
        if let appData = (json!["header"] as! [String: String])["applicationData"] {
            applicationData = appData
        }
        let publicKeyHash = (json!["header"] as! [String: String])["publicKeyHash"]! as String
        let transactionId = (json!["header"] as! [String: String])["transactionId"]! as String
        
        //call eprotect with paymentData
        let headers = [
            "content-type": "application/x-www-form-urlencoded",
            "host": eprotectHostHeader,
            "user-agent": "Litle/1.0 CFNetwork/459 Darwin/10.0.0.d3",
            "cache-control": "no-cache"
        ]
        
        let postData = NSMutableData(data: "paypageId=\(paypageId)".data(using: String.Encoding.utf8)!)
        postData.append("&reportGroup=testReportGroup".data(using: String.Encoding.utf8)!)
        postData.append("&orderId=testOrderId".data(using: String.Encoding.utf8)!)
        postData.append("&id=00000".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.data=\(data.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.signature=\(signature.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.version=\(version.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.header.ephemeralPublicKey=\(ephemeralPublicKey.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.header.publicKeyHash=\(publicKeyHash.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.header.transactionId=\(transactionId.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        postData.append("&applepay.header.applicationData=\(applicationData.stringByAddingPercentEncodingForRFC3986()!)".data(using: String.Encoding.utf8)!)
        
        let request = NSMutableURLRequest(url: NSURL(string: eProtectUrl)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = headers
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse!)
                print(NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)
                print(self.convertStringToDictionary(text: NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)!["paypageRegistrationId"]!)
                
                let jsonResponse = self.convertStringToDictionary(text: NSString(data: data!, encoding: String.Encoding.utf8.rawValue)!)!
                let registrationId = jsonResponse["paypageRegistrationId"]!
                
                //pass regid + order info to
                //merchant server: send txn to netepay
                //replace IP in next line with dev machine IP
                let merchantRequest = NSMutableURLRequest(url: URL(string: "http://\(self.merchantServerAddress):\(self.merchantServerPort)")!)
                merchantRequest.httpMethod = "POST"
                merchantRequest.addValue("application/json", forHTTPHeaderField: "Accept")
                
                let nf = NumberFormatter()
                nf.numberStyle = .decimal
                
                let merchantJson =
                    [
                        "registrationId":registrationId,
                        "amount": nf.string(from: 100)!,
                        "description": "sample product"
                        ] as [String : Any]
                merchantRequest.httpBody = try? JSONSerialization.data(withJSONObject: merchantJson, options: .prettyPrinted)
                
                let merchantTask = URLSession.shared.dataTask(with: merchantRequest as URLRequest, completionHandler: { data, response, error in
                    guard error == nil && data != nil else {                                                          // check for fundamental networking error
                        print("error=\(String(describing: error))")
                        return
                    }
                    
                    if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {           // check for http errors
                        print("statusCode should be 200, but is \(httpStatus.statusCode)")
                        print("response = \(String(describing: response))")
                    }
                    
                    let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                    print("responseString = \(String(describing: responseString))")
                })
                merchantTask.resume()
            }
        })
        
        dataTask.resume()
        
        
        
        //TODO: Handle error condition
        completion(PKPaymentAuthorizationStatus.success)
    }
    
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func convertStringToDictionary(text: NSString) -> [String:AnyObject]? {
        if let data = text.data(using: String.Encoding.utf8.rawValue) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject]
            } catch let error as NSError {
                print(error)
            }
        }
        return nil
    }
}

extension String {
    func stringByAddingPercentEncodingForRFC3986() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}
