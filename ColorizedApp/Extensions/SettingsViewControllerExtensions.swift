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
    
    func setSlidersColor() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    func setSlidersValue() {
        redSlider.value = Float(color.rgb.red)
        greenSlider.value = Float(color.rgb.green)
        blueSlider.value = Float(color.rgb.blue)
    }
    
    /// Refreshing slider, slider value labels and colorized view after input new values to text fields
    func refreshColorState(_ textField: UITextField) {
        if let textValue = textField.text, let numericValue = Float(textValue) {
            let value = DataHelper.normalizeValue(number: numericValue)
            switch textField {
            case redValueTF:
                redSlider.setValue(value, animated: true)
                redSliderValueLabel.text = DataHelper.roundValue(value)
                textField.text = DataHelper.roundValue(value)
            case greenValueTF:
                greenSlider.setValue(value, animated: true)
                greenSliderValueLabel.text = DataHelper.roundValue(value)
                textField.text = DataHelper.roundValue(value)
            default:
                blueSlider.setValue(value, animated: true)
                blueSliderValueLabel.text = DataHelper.roundValue(value)
                textField.text = DataHelper.roundValue(value)
            }
            setColorToView()
        } else {
            showAlert("Error!", "Wrong number format", textField)
        }
    }
}
