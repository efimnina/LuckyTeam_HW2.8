//
//  CreditViewController.swift
//  LuckyTeam_HW2.8
//
//  Created by Михаил Кожанов on 13.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

import UIKit // Юля

class CreditViewController: UIViewController {
    
    @IBOutlet var interestRateAnnualTF: UITextField!
    @IBOutlet var apartmentСostTF: UITextField!
    @IBOutlet var anInitialFeeTF: UITextField!
    @IBOutlet var mortgageTermTF: UITextField!
    
    @IBOutlet var monthlyPaymentLabel: UILabel!
    @IBOutlet var totalCostLabel: UILabel!
    @IBOutlet var overpaymentLabel: UILabel!
    
    @IBOutlet var calculateButton: UIButton!
    
    var monthlyRate = 0.0
    var totalRate = 0.0
    var creditAmount = 0
    var mortgage = 0.0
    
    var monthlyPayment = 0.0
    var overpayment = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calculateButton.layer.cornerRadius = 7
        interestRateAnnualTF.delegate = self
        apartmentСostTF.delegate = self
        anInitialFeeTF.delegate = self
        mortgageTermTF.delegate = self
    }
    
    @IBAction func showCalculateButton() {
        guard let apartmentСost = apartmentСostTF.text else { return }
        guard let anInitialFee = anInitialFeeTF.text else { return }
        
        if (Int(apartmentСost) ?? 0) >= (Int(anInitialFee) ?? 0) {
            chekTextField(senders: interestRateAnnualTF, apartmentСostTF, anInitialFeeTF, mortgageTermTF)
        } else {
            showAlert(title: "Ошибка", message: "Взнос больше стоимости квартиры")
        }
    }
    
    private func calculateMonthlyPayment() -> String {
        
        if let apartmentСost = apartmentСostTF.text, let anInitialFee = anInitialFeeTF.text {
            creditAmount = (Int(apartmentСost) ?? 0) - (Int(anInitialFee) ?? 0)
        }
        if let interestRateAnnual = interestRateAnnualTF.text {
            monthlyRate = (Double(interestRateAnnual) ?? 0) / 12 / 100
        }
        if let mortgageTerm = mortgageTermTF.text {
            totalRate = pow((1 + monthlyRate), (Double(mortgageTerm) ?? 0))
        }
        monthlyPayment = Double(creditAmount) * monthlyRate * totalRate / (totalRate - 1)
        return string(from: monthlyPayment)
    }
    
    private func calculateOverpaymant() -> String {
        if let mortgageTerm = mortgageTermTF.text {
            overpayment = monthlyPayment * (Double(mortgageTerm) ?? 0) - Double (creditAmount)
        }
        return string(from: overpayment)
    }
    
    private func calculateTotalRate() -> String {
        return string(from: overpayment + Double(creditAmount))
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    private func string (from sender: Double ) -> String {
        String(format: "%.2f", sender)
    }
   
    private func chekTextField(senders: UITextField...) {
        for sender in senders {
            guard sender.text != "" && sender.text != "0" else {
                showAlert(title: "Ошибка", message: "Введите корректное значение")
                return
            }
        }
        getValue()
    }
    
    private func getValue() {
        monthlyPaymentLabel.text = calculateMonthlyPayment()
        overpaymentLabel.text = calculateOverpaymant()
        totalCostLabel.text = calculateTotalRate()
    }
}

extension CreditViewController: UITextFieldDelegate {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}
