//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 06.02.2023.
//

import UIKit

final class SettingsViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var redSliderValueLabel: UILabel!
    @IBOutlet var greenSliderValueLabel: UILabel!
    @IBOutlet var blueSliderValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    @IBOutlet var redValueTF: UITextField!
    @IBOutlet var greenValueTF: UITextField!
    @IBOutlet var blueValueTF: UITextField!
    
    var color: UIColor!
    unowned var delegate: SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSlidersColor()
        setSlidersValue()
        
        setSliderValueToOutlets(
            redSliderValueLabel,
            greenSliderValueLabel,
            blueSliderValueLabel
        )
        
        setColorToView()
        colorizedView.layer.cornerRadius = 20
        
        redValueTF.delegate = self
        greenValueTF.delegate = self
        blueValueTF.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        switch sender {
        case redSlider:
            setValue(of: sender, to: redSliderValueLabel, and: redValueTF)
        case greenSlider:
            setValue(of: sender, to: greenSliderValueLabel, and: greenValueTF)
        default:
            setValue(of: sender, to: blueSliderValueLabel, and: blueValueTF)
        }
        setColorToView()
    }
    
    @IBAction func doneButtonPressed() {
        delegate.setColor(colorizedView.backgroundColor ?? .clear)
        dismiss(animated: true)
    }
    
    // MARK: - Private methods
    private func setSliderValueToOutlets(_ labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redSliderValueLabel:
                setValue(of: redSlider, to: redSliderValueLabel, and: redValueTF)
            case greenSliderValueLabel:
                setValue(of: greenSlider, to: greenSliderValueLabel, and: greenValueTF)
            default:
                setValue(of: blueSlider, to: blueSliderValueLabel, and: blueValueTF)
            }
        }
    }
    
    private func setValue(of slider: UISlider, to label: UILabel, and textField: UITextField) {
        let value = roundValue(slider.value)
        label.text = value
        textField.text = value
    }
    
    /// Normalize text field value if entered value is not in range 0...1
    private func normalizeValue(number: Float) -> Float {
        if number > 1 {
            return Float(1)
        } else if number < 0 {
            return Float(0)
        } else {
            return number
        }
    }
    
    private func roundValue(_ value: Float) -> String {
        String(format: "%.2f", value)
    }
}


// MARK: - Alert extension
extension SettingsViewController {
    func showAlert(_ title: String, _ message: String, _ textField: UITextField) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default) {_ in
            textField.text = "1.00"
            textField.becomeFirstResponder()
            self.refreshColorState(textField)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Text field delegate extension
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let toolBar = UIToolbar()
        
        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: textField,
            action: #selector(resignFirstResponder)
        )
        
        toolBar.items = [leftSpace, doneButton]
        toolBar.sizeToFit()
        
        textField.inputAccessoryView = toolBar
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        refreshColorState(textField)
    }
}

// MARK: - Extension for work with color
private extension SettingsViewController {
    func setColorToView() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    func setSlidersColor() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    func setSlidersValue() {
        let ciColor = CIColor(color: color)
        
        redSlider.value = Float(ciColor.red)
        greenSlider.value = Float(ciColor.green)
        blueSlider.value = Float(ciColor.blue)
    }
    
    /// Refreshing slider, slider value labels and colorized view after input new values to text fields
    func refreshColorState(_ textField: UITextField) {
        if let textValue = textField.text, let numericValue = Float(textValue) {
            let value = normalizeValue(number: numericValue)
            switch textField {
            case redValueTF:
                redSlider.setValue(value, animated: true)
                redSliderValueLabel.text = roundValue(value)
                textField.text = roundValue(value)
            case greenValueTF:
                greenSlider.setValue(value, animated: true)
                greenSliderValueLabel.text = roundValue(value)
                textField.text = roundValue(value)
            default:
                blueSlider.setValue(value, animated: true)
                blueSliderValueLabel.text = roundValue(value)
                textField.text = roundValue(value)
            }
            setColorToView()
        } else {
            showAlert("Error!", "Wrong number format", textField)
        }
    }
}
