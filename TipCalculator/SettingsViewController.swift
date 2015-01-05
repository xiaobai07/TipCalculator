//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Yue Bai on 12/25/14.
//  Copyright (c) 2014 Yue Bai. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var firstSlider: UISlider!
    @IBOutlet weak var secondSlider: UISlider!
    @IBOutlet weak var thirdSlider: UISlider!
    @IBOutlet weak var firstValueLabel: UILabel!
    @IBOutlet weak var secondValueLabel: UILabel!
    @IBOutlet weak var thirdValueLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Tip Percentage"
        var backButton = UIBarButtonItem(image: UIImage(named: "Back"), style: UIBarButtonItemStyle.Bordered, target: self, action: "back")
        backButton.tintColor = UIColor.whiteColor()
        self.navigationItem.leftBarButtonItem = backButton
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        firstValueLabel.frame = CGRectMake(screenWidth/2, 80, 40, 40)
        secondValueLabel.frame = CGRectMake(screenWidth/2, 170, 40, 40)
        thirdValueLabel.frame = CGRectMake(screenWidth/2, 260, 40, 40)
        firstSlider.frame = CGRectMake(80, 115, screenWidth-100, 30)
        secondSlider.frame = CGRectMake(80, 205, screenWidth-100, 30)
        thirdSlider.frame = CGRectMake(80, 300, screenWidth-100, 30)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        firstSlider.value = NSUserDefaults.standardUserDefaults().floatForKey(FV)
        secondSlider.value = NSUserDefaults.standardUserDefaults().floatForKey(SV)
        thirdSlider.value = NSUserDefaults.standardUserDefaults().floatForKey(TV)
        var firstValue = firstSlider.value
        var fpercentageValue = Int(firstValue*100)
        firstValueLabel.text = "\(fpercentageValue)"
        var secondValue = secondSlider.value
        var spercentageValue = Int(secondValue*100)
        secondValueLabel.text = "\(spercentageValue)"
        var thirdValue = thirdSlider.value
        var tpercentageValue = Int(thirdValue*100)
        thirdValueLabel.text = "\(tpercentageValue)"
        self.view.backgroundColor = UIColor.tpDarkGray()
        self.navigationController?.navigationBar.barTintColor = UIColor.blackColor()
        let font = UIFont(name: "ProximaNova-SemiBold", size: 18)
        if let font = font {
            self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName : font, NSForegroundColorAttributeName : UIColor.whiteColor()]
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func firstSliderChanged(sender: UISlider) {
        var firstValue = sender.value
        var percentageValue = Int(firstValue*100)
        firstValueLabel.text = "\(percentageValue)"
        var defaultFirstValue = NSUserDefaults.standardUserDefaults().floatForKey(FV)
        if defaultFirstValue != firstValue {
            NSUserDefaults.standardUserDefaults().setFloat(round (firstValue * 100.0) / 100.0, forKey: FV)
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
    }

    @IBAction func secondSliderChanged(sender: UISlider) {
        var secondValue = sender.value
        var percentageValue = Int(secondValue*100)
        secondValueLabel.text = "\(percentageValue)"
        var defaultSecondValue = NSUserDefaults.standardUserDefaults().floatForKey(SV)
        if defaultSecondValue != secondValue {
            NSUserDefaults.standardUserDefaults().setFloat(round (secondValue * 100.0) / 100.0, forKey: SV)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    @IBAction func thirdSliderChanged(sender: UISlider) {
        var thirdValue = sender.value
        var percentageValue = Int(thirdValue*100)
        thirdValueLabel.text = "\(percentageValue)"
        var defaultThirdValue = NSUserDefaults.standardUserDefaults().floatForKey(TV)
        if defaultThirdValue != thirdValue {
            NSUserDefaults.standardUserDefaults().setFloat(round (thirdValue * 100.0) / 100.0, forKey: TV)
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }

    func back() {
        //need update code
        self.navigationController?.popViewControllerAnimated(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
