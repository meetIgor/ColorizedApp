//
//  ViewController.swift
//  HomeWork #3 - 2.28 - ColorizedApp
//
//  Created by igor s on 23.06.2022.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IB Outlets
    @IBOutlet weak var resultView: UIView!
    @IBOutlet var valueLabels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        valueLabels.forEach {
            $0.text = String(format: "%.2f", sliders[$0.tag].value)
        }
        changeColor()
        resultView.layer.cornerRadius = 30
    }
    
    //MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        changeColor()
        valueLabels[sender.tag].text = String(format: "%.2f", sender.value)
    }
    
    //MARK: - Private Methods
    private func changeColor() {
        resultView.backgroundColor = UIColor(
            red: CGFloat( sliders[0].value ),
            green: CGFloat( sliders[1].value ),
            blue: CGFloat( sliders[2].value ),
            alpha: 1
        )
    }
}

