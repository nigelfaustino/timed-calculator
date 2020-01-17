//
//  CalculatorVC.swift
//  timed_calculator
//
//  Created by NIGEL FAUSTINO on 1/16/20.
//  Copyright © 2020 NIGEL FAUSTINO. All rights reserved.
//

import UIKit

private enum Operations {
    case multiply
    case divide
    case add
    case subtract
    case equals
}

class CalculatorVC: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var zeroButton: UIButton!
    @IBOutlet weak var oneButton: UIButton!
    @IBOutlet weak var twoButton: UIButton!
    @IBOutlet weak var threeButton: UIButton!
    @IBOutlet weak var fourButton: UIButton!
    @IBOutlet weak var fiveButton: UIButton!
    @IBOutlet weak var sixButton: UIButton!
    @IBOutlet weak var sevenButton: UIButton!
    @IBOutlet weak var eightButton: UIButton!
    @IBOutlet weak var nineButton: UIButton!
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var divideButton: UIButton!
    @IBOutlet weak var multiplyButton: UIButton!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var equalButton: UIButton!
    @IBOutlet weak var textFieldHeightConstraint: NSLayoutConstraint!
    private var numberButtonArray = [UIButton]()
    private var runningTotal = 0.0
    private var currentNumber = 0.0
    private var currentOperation: Operations = .add

    override func viewDidLoad() {
        super.viewDidLoad()
        modifyTextField()
        addTargetsToButtons()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        textFieldHeightConstraint.constant = view.frame.height/3
    }

    private func modifyTextField() {
        textField.isUserInteractionEnabled = false
        textField.textAlignment = .right
        textField.text = "0"
    }

    private func addTargetsToButtons() {
        numberButtonArray = [zeroButton, oneButton,  twoButton, threeButton, fourButton, fiveButton, sixButton, sevenButton, eightButton, nineButton]
        for i in 0 ..< numberButtonArray.count {
            numberButtonArray[i].tag = i
            numberButtonArray[i].addTarget(self, action: #selector(numberButtonPressed(sender:)), for: .touchUpInside)
        }
        clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(addButtonPressed), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(minusButtonPressed), for: .touchUpInside)
        multiplyButton.addTarget(self, action: #selector(multiplyButtonPressed), for: .touchUpInside)
        divideButton.addTarget(self, action: #selector(divideButtonPressed), for: .touchUpInside)
        equalButton.addTarget(self, action: #selector(equalButtonPressed), for: .touchUpInside)
    }

    @objc private func numberButtonPressed(sender: UIButton) {
        if textField.text == "0" || textField.text == "+" || textField.text == "-" || textField.text == "/" || textField.text == "X" {
            textField.text = String(sender.tag)
        } else if currentOperation == .equals {
            clear()
            textField.text = String(sender.tag)
        } else {
            textField.text = (textField?.text ?? "") + String(sender.tag)
        }
        if let count = (textField.text as? NSString)?.doubleValue {
            currentNumber = count
        }
    }

    @objc private func addButtonPressed() {
        executeOperation()
        currentOperation = .add
        textField.text = "+"
    }

    @objc private func minusButtonPressed() {
        executeOperation()
        currentOperation = .subtract
        textField.text = "-"
    }

    @objc private func multiplyButtonPressed() {
        executeOperation()
        currentOperation = .multiply
        textField.text = "X"
    }

    @objc private func divideButtonPressed() {
        executeOperation()
        currentOperation = .divide
        textField.text = "/"
    }

    private func executeOperation() {
        switch currentOperation {
        case .add:
            runningTotal += currentNumber
        case .divide:
            runningTotal = runningTotal/currentNumber
        case .subtract:
            runningTotal = runningTotal - currentNumber
        case .multiply:
            runningTotal = runningTotal*currentNumber
        case .equals:
            break
        }
        currentNumber = 0.0
    }

    @objc private func equalButtonPressed() {
        executeOperation()
        currentOperation = .equals
        textField.text = String(runningTotal)
    }

    @objc private func clear() {
        currentOperation = .add
        textField.text = "0"
        runningTotal = 0
    }
}
