//
//  ResultPensionViewController.swift
//  LuckyTeam_HW2.8
//
//  Created by mac on 14.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

import UIKit

class ResultPensionViewController: UIViewController {
    

    @IBOutlet var results: [UILabel]!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var proffesionLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var okButton: UIButton!
    
    private var age = AgeToPension.getAge()
    var dictionary: [String : String]!
    var birthday: Date!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        let days = calculatePensionAgeWithProffesionAndExperiens()
        if days > 0 {
            ageLabel.text = "\(days) дней"
        } else {
            ageLabel.text = "Уже на пенсии!"
        }
        genderLabel.text = dictionary[Keys.gender.rawValue]
        proffesionLabel.text = dictionary[Keys.proffesion.rawValue]
        experienceLabel.text = dictionary[Keys.experiense.rawValue]
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        birthdayLabel.text =  dateFormatter.string(from: birthday)
        okButton.layer.cornerRadius = 7
        
    }
    

    @IBAction func DoneButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func okButtonPress(_ sender: Any) {
        dismiss(animated: true)
    }
    
    private func calculateYearsToPension() -> Int {
        var result = 0
        if let res = dictionary[Keys.days.rawValue] {
            if dictionary[Keys.gender.rawValue] == Gender.female.rawValue {
                result = (Int(res) ?? 0) - ((age.maleAge - age.femaleAge) * 365)
            } else {
                result = (Int(res) ?? 0)
            }
        }
        return result
    }
    
    private func calculatePensionAgeWithProffesionAndExperiens() -> Int {
        let age = calculateYearsToPension()
        var result = 0
        
        if dictionary[Keys.proffesion.rawValue] == Proffesion.doctor.rawValue
            && Int(dictionary[Keys.experiense.rawValue] ?? "0") ?? 0 >= 25 {
            result = age - 10 * Int(365.25)
        } else if dictionary[Keys.proffesion.rawValue] == Proffesion.pilot.rawValue
            && Int(dictionary[Keys.experiense.rawValue] ?? "0") ?? 0 >= 25 {
            result = age - 15 * Int(365.25)
        } else if dictionary[Keys.proffesion.rawValue] == Proffesion.teacher.rawValue
            && Int(dictionary[Keys.experiense.rawValue] ?? "0") ?? 0 >= 25 {
            result = age - 10 * Int(365.25)
        }   else if dictionary[Keys.proffesion.rawValue] == Proffesion.artist.rawValue
            && Int(dictionary[Keys.experiense.rawValue] ?? "0") ?? 0 >= 20 {
            result = age - 5 * Int(365.25)
        }  else if dictionary[Keys.proffesion.rawValue] == Proffesion.civilServant.rawValue
            && Int(dictionary[Keys.experiense.rawValue] ?? "0") ?? 0 >= 25 {
            result = age - 10 * Int(365.25)
        }   else if dictionary[Keys.proffesion.rawValue] == Proffesion.police.rawValue
            && Int(dictionary[Keys.experiense.rawValue] ?? "0") ?? 0 >= 25 {
            result = age - 15 * Int(365.25)
        } else {
            result = age
        }
        
        return result
    }
    
}


