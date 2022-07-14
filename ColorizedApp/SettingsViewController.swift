//
//  ViewController.swift
//  HomeWork #3 - 2.28 - ColorizedApp
//
//  Created by igor s on 23.06.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    //MARK: - IB Outlets
    @IBOutlet weak var resultView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    @IBOutlet weak var redTextField: UITextField!
    @IBOutlet weak var greenTextField: UITextField!
    @IBOutlet weak var blueTextField: UITextField!
    
    //MARK: - Public Properties
    var color: UIColor!
    var delegate: SettingsViewControllerDelegate!
    
    //MARK: - Life Cycles Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        resultView.layer.cornerRadius = 30
        updateUI()
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
        setKeyboardToolBar()
    }
    
    //MARK: - IB Actions
    @IBAction func slidersAction(_ sender: UISlider) {
        changeColor()
        setValue(for: sender.tag)
    }
    
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        guard let viewColor = resultView.backgroundColor else { return }
        delegate.setColor(viewColor)
        dismiss(animated: true)
        
    }
    
    @objc func doneTBButtonPressed() {
        view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //MARK: - Private Methods
    private func updateUI() {
        let newColor = CIColor(color: color)
        
        redSlider.value = Float(newColor.red)
        greenSlider.value = Float(newColor.green)
        blueSlider.value = Float(newColor.blue)
        
        changeColor()
        setValue(for: redLabel.tag, greenLabel.tag, blueLabel.tag)
    }
    
    
    private func changeColor() {
        resultView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1
        )
    }
    
    private func setValue(for labelTag: Int...) {
        labelTag.forEach { tag in
            switch tag {
            case 0:
                redLabel.text = string(from: redSlider)
                redTextField.text = string(from: redSlider)
            case 1:
                greenLabel.text = string(from: greenSlider)
                greenTextField.text = string(from: greenSlider)
            default:
                blueLabel.text = string(from: blueSlider)
                blueTextField.text = string(from: blueSlider)
            }
        }
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
}

//Mark: - UITextFieldDelegate
extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let colorValue = Float(newValue) else { return }
        
        guard colorValue >= 0, colorValue <= 1 else { return }
        
        switch textField.tag {
        case 0:
            redSlider.setValue(colorValue, animated: true)
            slidersAction(redSlider)
        case 1:
            greenSlider.setValue(colorValue, animated: true)
            slidersAction(greenSlider)
        default:
            blueSlider.setValue(colorValue, animated: true)
            slidersAction(blueSlider)
        }
    }
}

//Mark: - setKeyboardToolBar
extension SettingsViewController {
    private func setKeyboardToolBar() {
        let doneToolBar = UIToolbar()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneTBButtonPressed)
        )
        let flexSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        doneToolBar.items = [flexSpace, doneButton]
        doneToolBar.sizeToFit()
        
        redTextField.inputAccessoryView = doneToolBar
        greenTextField.inputAccessoryView = doneToolBar
        blueTextField.inputAccessoryView = doneToolBar
    }
}
