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
        setupSliderValueLabels()
        setColorToView()
        
        colorizedView.layer.cornerRadius = 20
    }
    
    // MARK: - Actions
    @IBAction func redSliderAction() {
        redSliderValueLabel.text = roundSliderValue(redSlider).formatted()
        setColorToView()
    }
    
    @IBAction func greenSliderAction() {
        greenSliderValueLabel.text = roundSliderValue(greenSlider).formatted()
        setColorToView()
    }
    
    @IBAction func blueSliderAction() {
        blueSliderValueLabel.text = roundSliderValue(blueSlider).formatted()
        setColorToView()
    }
    
    // MARK: - Utils
    private func setUpSliders() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func setupSliderValueLabels() {
        redSliderValueLabel.text = roundSliderValue(redSlider).formatted()
        greenSliderValueLabel.text = roundSliderValue(greenSlider).formatted()
        blueSliderValueLabel.text = roundSliderValue(blueSlider).formatted()
    }
    
    private func roundSliderValue(_ slider: UISlider) -> Float {
        round(slider.value * 100) / 100.0
    }
    
    private func setColorToView() {
        colorizedView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                          green: CGFloat(greenSlider.value),
                                          blue: CGFloat(blueSlider.value),
                                          alpha: 1
        )
    }
}

