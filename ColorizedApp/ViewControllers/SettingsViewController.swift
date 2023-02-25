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
        
        setDoneToolbarButton(redValueTF, greenValueTF, blueValueTF)
        
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
        setColorToView()
        switch sender {
        case redSlider:
            setValue(of: sender, to: redSliderValueLabel, and: redValueTF)
        case greenSlider:
            setValue(of: sender, to: greenSliderValueLabel, and: greenValueTF)
        default:
            setValue(of: sender, to: blueSliderValueLabel, and: blueValueTF)
        }
    }
    
    @IBAction func doneButtonPressed() {
        guard let color = colorizedView.backgroundColor else { return }
        delegate.setColor(color)
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
        let value = DataHelper.roundValue(slider.value)
        label.text = value
        textField.text = value
    }
    
    private func setDoneToolbarButton(_ textField: UITextField...) {
        let toolBar = UIToolbar()
        let leftSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        
        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(doneToolbarButtonPressed)
        )
        
        toolBar.items = [leftSpace, doneButton]
        toolBar.sizeToFit()
        
        textField.forEach { $0.inputAccessoryView = toolBar }
    }
    
    @objc private func doneToolbarButtonPressed() {
        view.endEditing(true)
    }
}
