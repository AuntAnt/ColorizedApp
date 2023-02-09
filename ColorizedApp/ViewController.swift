//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 06.02.2023.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet var colorizedView: UIView!
    
    @IBOutlet var redSliderValueLabel: UILabel!
    @IBOutlet var greenSliderValueLabel: UILabel!
    @IBOutlet var blueSliderValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        setupSliderValueToLabels(redSliderValueLabel, greenSliderValueLabel, blueSliderValueLabel)
        setColorToView()
        
        colorizedView.layer.cornerRadius = 20
    }
    
    // MARK: - Actions
    @IBAction func redSliderAction() {
        redSliderValueLabel.text = getRoundedSliderValue(redSlider)
        setColorToView()
    }
    
    @IBAction func greenSliderAction() {
        greenSliderValueLabel.text = getRoundedSliderValue(greenSlider)
        setColorToView()
    }
    
    @IBAction func blueSliderAction() {
        blueSliderValueLabel.text = getRoundedSliderValue(blueSlider)
        setColorToView()
    }
    
    // MARK: - Private methods
    private func setUpSliders() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func setupSliderValueToLabels(_ labels: UILabel...) {
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
}

