//
//  SettingsViewControllerExtensions.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 24.02.2023.
//

import UIKit

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
            self.refreshColorState(textField)
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - Text field delegate extension
extension SettingsViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        refreshColorState(textField)
    }
}

// MARK: - Color extension
extension SettingsViewController {
    func setColorToView() {
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    /// Refreshing slider, slider value labels and colorized view after input new values to text fields
    func refreshColorState(_ textField: UITextField) {
        if let textValue = textField.text, let numericValue = Float(textValue) {
            switch textField {
            case redValueTF:
                redSlider.setValue(numericValue, animated: true)
                redSliderValueLabel.text = textValue
            case greenValueTF:
                greenSlider.setValue(numericValue, animated: true)
                greenSliderValueLabel.text = textValue
            default:
                blueSlider.setValue(numericValue, animated: true)
                blueSliderValueLabel.text = textValue
            }
            setColorToView()
        } else {
            showAlert("Error!", "Wrong number format", textField)
        }
    }
}