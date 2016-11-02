//
//  ConversionViewController.swift
//  TemperatureConverter
//
//  Created by Dilpreet Singh on 20/10/16.
//  Copyright © 2016 Dilpreet Singh. All rights reserved.
//

import UIKit

class ConversionViewController: UIViewController, UITextFieldDelegate {
    
    fileprivate var fahrenheitValue: Double? {
        didSet {
            updateCelsiusLabel()
        }
    }
    
    fileprivate var celsiusValue: Double? {
        guard let fahrenheitTemp = fahrenheitValue else { return nil }
        return (fahrenheitTemp - 32) * (5 / 9)
    }
    
    fileprivate let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.minimumFractionDigits = 0
        numberFormatter.maximumFractionDigits = 1
        return numberFormatter
    }()
    
    
    @IBOutlet weak var celsiusLabel: UILabel!
    @IBOutlet weak var fahrenheitTextField: UITextField!
    @IBAction func dismissKeyboard(_ sender: AnyObject) {
        fahrenheitTextField.resignFirstResponder()
    }
    @IBAction func fahrenheitFieldEditingChanged(_ sender: UITextField) {
        if let temperatureString = sender.text, let temperature = numberFormatter.number(from: temperatureString) {
            fahrenheitValue = temperature.doubleValue
        } else {
            fahrenheitValue = nil
        }
    }
    
    fileprivate func updateCelsiusLabel() {
        if let value = celsiusValue {
            celsiusLabel.text = numberFormatter.string(from: NSNumber(value: value))
            celsiusLabel.text = celsiusLabel.text! + "°"
        } else {
            celsiusLabel.text = "???"
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let numberSet = CharacterSet(charactersIn: "123456789.0")
        let currentLocale = Locale.current
        let decimalSeparator = (currentLocale as NSLocale).object(forKey: NSLocale.Key.decimalSeparator) as! String
        
        let existingTextHasDecimalSeparator = textField.text?.range(of: decimalSeparator)
        let replacementTextHasDecimalSeparator = string.range(of: decimalSeparator)
        if (existingTextHasDecimalSeparator != nil && replacementTextHasDecimalSeparator != nil) || string.rangeOfCharacter(from: numberSet.inverted) != nil {
            return false
        } else {
            return true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        var timeOfDay: TimeOfDay
        let presentHour = (Calendar.current as NSCalendar).component(.hour, from: Date())
        
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
            fahrenheitTextField.textColor = UIColor.white
        }
    }
    
    enum TimeOfDay: String {
        case Day
        case Night
    }
}
