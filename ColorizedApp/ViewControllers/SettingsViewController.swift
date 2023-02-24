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
    
    var color: UIColor!
    unowned var delegate: SettingViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        setSliderValues()
        setSliderValueToLabels(redSliderValueLabel, greenSliderValueLabel, blueSliderValueLabel)
        
        setColorToView()
        colorizedView.layer.cornerRadius = 20
//        delegate =
    }
    
    @IBAction func slidersAction(_ sender: UISlider) {
        setColorToView()
        switch sender {
        case redSlider:
            redSliderValueLabel.text = getRoundedSliderValue(redSlider)
        case greenSlider:
            greenSliderValueLabel.text = getRoundedSliderValue(greenSlider)
        default:
            blueSliderValueLabel.text = getRoundedSliderValue(blueSlider)
        }
    }
    
    // MARK: - Private methods
    private func setUpSliders() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func setSliderValues() {
        redSlider.value = Float(color.rgb.red)
        greenSlider.value = Float(color.rgb.green)
        blueSlider.value = Float(color.rgb.blue)
    }
    
    private func setSliderValueToLabels(_ labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redSliderValueLabel:
                redSliderValueLabel.text = getRoundedSliderValue(redSlider)
            case greenSliderValueLabel:
                greenSliderValueLabel.text = getRoundedSliderValue(greenSlider)
            default:
                blueSliderValueLabel.text = getRoundedSliderValue(blueSlider)
            }
        }
    }
    
    private func getRoundedSliderValue(_ slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func setColorToView() {
        colorizedView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                                green: CGFloat(greenSlider.value),
                                                blue: CGFloat(blueSlider.value),
                                                alpha: 1
        )
    }
    
    // MARK: - IB Actions
    @IBAction func doneButtonPressed() {
        guard let color = colorizedView.backgroundColor else { return }
        delegate.setColor(color)
        dismiss(animated: true)
    }
}
