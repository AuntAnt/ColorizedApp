//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Anton Kuzmin on 24.02.2023.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func setColor(_ color: UIColor)
}

final class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension MainViewController: SettingViewControllerDelegate {
    func setColor(_ color: UIColor) {
        view.backgroundColor = color
    }
}
