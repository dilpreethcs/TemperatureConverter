//
//  ConversionViewController.swift
//  TemperatureConverter
//
//  Created by Dilpreet Singh on 20/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    private var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    private var celsiusValue: Double? {
        guard let fahrenheitTemp = fahrenheitValue else { return nil }
        return (fahrenheitTemp - 32) * (5 / 9)
    }
    
    private let numberFormatter: NSNumberFormatter = {
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = .DecimalStyle
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBAction func dismissKeyboard(sender: AnyObject) {
        fahrenheitTextField.resignFirstResponder()
    }
    @IBAction func fahrenheitFieldEditingChanged(sender: UITextField) {
        if let temperatureString = sender.text, temperature = numberFormatter.numberFromString(temperatureString) {
            fahrenheitValue = temperature.doubleValue
        } else {
            fahrenheitValue = nil
        }
    }
    
    private func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.stringFromNumber(value)
            celsiusLabel.text = celsiusLabel.text! + "°"
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        let numberSet = NSCharacterSet(charactersInString: "123456789.0")
        let currentLocale = NSLocale.currentLocale()
        let decimalSeparator = currentLocale.objectForKey(NSLocaleDecimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.rangeOfString(decimalSeparator)
        let replacementTextHasDecimalSeparator = string.rangeOfString(decimalSeparator)
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || !numberSet.isSupersetOfSet(NSCharacterSet(charactersInString: string)) {
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        var timeOfDay: TimeOfDay
        let presentHour = NSCalendar.currentCalendar().component(.Hour, fromDate: NSDate())
        
        switch presentHour {
        case 7...18:
            timeOfDay = .Day
        default:
            timeOfDay = .Night
        }
        
        switch timeOfDay {
        case .Day:
            view.backgroundColor = UIColor(red: 210/255.0, green: 240/255.0, blue: 255/255.0, alpha: 1.0)
        case .Night:
            view.backgroundColor = UIColor(red: 84/255.0, green: 96/255.0, blue: 102/255.0, alpha: 1.0)
            fahrenheitTextField.textColor = UIColor.whiteColor()
        }
    }
    
    enum TimeOfDay: String {
        case Day
        case Night
    }
}
