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
        redSliderValueLabel.text = getRoundedSliderValue(redSlider).formatted()
        setColorToView()
    }
    
    @IBAction func greenSliderAction() {
        greenSliderValueLabel.text = getRoundedSliderValue(greenSlider).formatted()
        setColorToView()
    }
    
    @IBAction func blueSliderAction() {
        blueSliderValueLabel.text = getRoundedSliderValue(blueSlider).formatted()
        setColorToView()
    }
    
    // MARK: - Utils
    private func setUpSliders() {
        redSlider.minimumTrackTintColor = .systemRed
        greenSlider.minimumTrackTintColor = .systemGreen
        blueSlider.minimumTrackTintColor = .systemBlue
    }
    
    private func setupSliderValueLabels() {
        redSliderValueLabel.text = getRoundedSliderValue(redSlider).formatted()
        greenSliderValueLabel.text = getRoundedSliderValue(greenSlider).formatted()
        blueSliderValueLabel.text = getRoundedSliderValue(blueSlider).formatted()
    }
    
    private func getRoundedSliderValue(_ slider: UISlider) -> Float {
        round(slider.value * 100) / 100
    }
    
    private func setColorToView() {
        colorizedView.backgroundColor = UIColor(red: CGFloat(redSlider.value),
                                          green: CGFloat(greenSlider.value),
                                          blue: CGFloat(blueSlider.value),
                                          alpha: 1
        )
    }
}

