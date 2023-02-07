//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 06.02.2023.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var colorizedView: UIView!
    
    // MARK: - Labels
    @IBOutlet var redSliderValueLabel: UILabel!
    @IBOutlet var greenSliderValueLabel: UILabel!
    @IBOutlet var blueSliderValueLabel: UILabel!
    
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSliders()
        
        colorizedView.layer.cornerRadius = 20
    }
    
    // MARK: - Actions
    @IBAction func redSliderAction() {
        redSliderValueLabel.text = roundSliderValue(redSlider).formatted()
    }
    
    @IBAction func greenSliderAction() {
        greenSliderValueLabel.text = roundSliderValue(greenSlider).formatted()
    }
    
    @IBAction func blueSliderAction() {
        blueSliderValueLabel.text = roundSliderValue(blueSlider).formatted()
    }
    
    // MARK: - Utils
    private func roundSliderValue(_ slider: UISlider) -> Float {
        round(slider.value * 100) / 100.0
    }
    
    private func setUpSliders() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
}

