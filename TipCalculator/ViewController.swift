//
//  ViewController.swift
//  TipCalculator
//
//  Created by Yue Bai on 12/24/14.
//  Copyright (c) 2014 Yue Bai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipSegmentedControl: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        var tapGesture = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        var swipeGesture = UISwipeGestureRecognizer(target: self, action: "changeBill")
        swipeGesture.direction = UISwipeGestureRecognizerDirection.Left
        self.view.addGestureRecognizer(swipeGesture)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "appBecomeActive:",
                                                                   name: UIApplicationDidBecomeActiveNotification,
                                                                 object: nil)
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        var billString = billTextField.text as NSString
        if (billString.length > 0) {
            billTextField.frame = CGRectMake(15, 80, screenWidth-30, 100)
        }else {
            billTextField.frame = CGRectMake(15, 180, screenWidth-30, 100)
        }
        billTextField.tintColor = UIColor.brownColor()
        tipSegmentedControl.frame = CGRectMake(15, 200, screenWidth-30, 30)
        tipLabel.frame = CGRectMake(15, 230, screenWidth-30, 100)
        totalLabel.frame = CGRectMake(15, 330, screenWidth-30, 100)
    }
    
    func appBecomeActive(notificaiton : NSNotification) {
        if NSUserDefaults.standardUserDefaults().objectForKey("bill") == nil {
            billTextField.text = ""
            changeUI("")
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor.orangeColor()
        self.view.alpha = 0.8
        self.navigationController?.navigationBar.barTintColor = UIColor.orangeColor()
        self.navigationController?.navigationBar.alpha = 0.8
        let font = UIFont(name: "ProximaNova-SemiBold", size: 18)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.blackColor()]
        }
        var firstValue = NSUserDefaults.standardUserDefaults().floatForKey(FV)
        var secondValue = NSUserDefaults.standardUserDefaults().floatForKey(SV)
        var thirdValue = NSUserDefaults.standardUserDefaults().floatForKey(TV)
        tipSegmentedControl.setTitle(String(format: "%.0f",firstValue*100)+"%", forSegmentAtIndex: 0)
        let segmentedfont = UIFont(name: "ProximaNova-Regular", size: 18)
        if let font = segmentedfont {
            tipSegmentedControl.setTitleTextAttributes([NSFontAttributeName :font], forState: UIControlState.Normal)
        }        
        tipSegmentedControl.setTitle(String(format: "%.0f",secondValue*100)+"%", forSegmentAtIndex: 1)
        tipSegmentedControl.setTitle(String(format: "%.0f",thirdValue*100)+"%", forSegmentAtIndex: 2)
        changeUI(billTextField.text)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        var billString = billTextField.text as NSString
        if billString.length > 0 {
            NSUserDefaults.standardUserDefaults().setObject(billString, forKey: "bill")
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var billString = textField.text as NSString
        var newText = billString.stringByReplacingCharactersInRange(range, withString: string) as NSString
        changeUI(newText)
        return true
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func dismissKeyboard () {
        billTextField.resignFirstResponder()
    }
    
    func changeBill () {
        var currentText = billTextField.text as NSString
        if currentText.length > 0 {
            var newText = currentText.substringToIndex(currentText.length-1) as NSString
            changeUI(newText)
            billTextField.text = newText
        }
    }
    
    @IBAction func tipSegmentedControlChanged(sender: UISegmentedControl) {
        billTextField.resignFirstResponder()
        var newText = billTextField.text as NSString
        changeLabelText(newText.doubleValue)
    }
    
    func changeUI(text : NSString) {
        if text.length > 0 {
            changeLabelText(text.doubleValue)
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.tipSegmentedControl.alpha = 1
                self.tipLabel.alpha = 1
                self.totalLabel.alpha = 1
                self.billTextField.frame = CGRectMake(15, 80, screenWidth-30, 100)
            })
        }else {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.tipSegmentedControl.alpha = 0
                self.tipLabel.alpha = 0
                self.totalLabel.alpha = 0
                self.billTextField.frame = CGRectMake(15, 180, screenWidth-30, 100)
            })
            billTextField.becomeFirstResponder()
        }
    }
    
    func changeLabelText(billValue : Double) {
        var tipValue : Double?
        if tipSegmentedControl.selectedSegmentIndex == 0 {
            var firstValue : Double = NSUserDefaults.standardUserDefaults().doubleForKey(FV)
            tipValue = billValue*firstValue
            
        }else if tipSegmentedControl.selectedSegmentIndex == 1 {
            var secondValue : Double = NSUserDefaults.standardUserDefaults().doubleForKey(SV)
            tipValue = billValue*secondValue
            
        }else if tipSegmentedControl.selectedSegmentIndex == 2 {
            var thirdValue : Double = NSUserDefaults.standardUserDefaults().doubleForKey(TV)
            tipValue = billValue*thirdValue
        }
        var formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        tipLabel.text = formatter.stringFromNumber(tipValue!)
        totalLabel.text = formatter.stringFromNumber(tipValue!+billValue)
    }
    
    @IBAction func goToSettingsView(sender: UIBarButtonItem) {
        var storyBoard = UIStoryboard(name: "Main", bundle: nil)
        var settingsVC = storyBoard.instantiateViewControllerWithIdentifier("settings") as SettingsViewController
        self.navigationController?.pushViewController(settingsVC, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

