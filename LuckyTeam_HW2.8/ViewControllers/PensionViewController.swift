//
//  PensionViewController.swift
//  LuckyTeam_HW2.8
//
//  Created by Михаил Кожанов on 13.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

import UIKit // Олег

class PensionViewController: UIViewController {

    // MARK: - IB Outlets
    @IBOutlet weak var chooseDateStack: UIStackView!
    @IBOutlet weak var chooseGenderStack: UIStackView!
    @IBOutlet weak var chooseProffesionStack: UIStackView!
    @IBOutlet weak var experienceStack: UIStackView!
    

    @IBOutlet weak var proffesionPicker: UIPickerView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var experienceTextField: UITextField!

    @IBOutlet var okButtons: [UIButton]!
    @IBOutlet var genderButtons: [UIButton]!


    // MARK: - Private Properties
    private var dateFromPicker: Date?
    private var questions = Question.getQuestions()
    private var questionIndex = 0
    private var dictionary: [String : String] = [:]
    private var selectedIndex = 0
    private var age = AgeToPension.getAge()


    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        questionLabel.isHidden = true
        proffesionPicker.delegate = self
        proffesionPicker.dataSource = self
        navigationController?.isNavigationBarHidden = true
        for button in okButtons {
            button.layer.cornerRadius = 7
        }
        for button in genderButtons {
            button.layer.cornerRadius = 7
        }
        experienceTextField.delegate = self
    }

    // MARK: - IBAction

    @IBAction func chooseDate(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.locale = Locale(identifier: "ru_RU")
        resultLabel.text = dateFormatter.string(from: datePicker.date)
        dateFromPicker = datePicker.date
    }
    
    @IBAction func birthdayButtonPress(_ sender: Any) {
        let my = getDaysFromBirthday(date: dateFromPicker ?? Date())
        let allDaysToPension = Double(age.maleAge) * 365.25
        dictionary[Keys.days.rawValue] = "\(Int(allDaysToPension) - my)"
        updateUI()
        chooseGenderStack.isHidden = false
        questionIndex += 1
    }
    
    @IBAction func startButton(_ sender: Any) {
        updateUI()
        questionLabel.isHidden = false
        chooseDateStack.isHidden = false
        startButton.isHidden = true
        questionIndex += 1

    }
    @IBAction func chooseMaleButton(_ sender: Any) {
        updateUI()
        chooseProffesionStack.isHidden = false
        questionIndex += 1
        dictionary[Keys.gender.rawValue] = Gender.male.rawValue

    }
    @IBAction func chooseFemaleButton(_ sender: Any) {
        updateUI()
        chooseProffesionStack.isHidden = false
        questionIndex += 1
        dictionary[Keys.gender.rawValue] = Gender.female.rawValue
    }

    @IBAction func proffesionButtonPress(_ sender: Any) {
        dictionary[Keys.proffesion.rawValue] = Proffesion.getAllValues()[selectedIndex].rawValue
        print(dictionary)
        updateUI()
        experienceStack.isHidden = false
        questionIndex += 1
    }
    @IBAction func expirienceButtonPress(_ sender: Any) {
        dictionary[Keys.experiense.rawValue] = experienceTextField.text
        questionLabel.isHidden = true
        if experienceTextField.text?.isEmpty ?? false {
            showAlert(title: "Oops", message: "Ведите свой стаж!")
        }
    }
    
    // MARK: - Private Methods
    
   private func updateUI() {
        chooseDateStack.isHidden = true
        chooseGenderStack.isHidden = true
        chooseProffesionStack.isHidden = true
        experienceStack.isHidden = true

        let currentQuestion = questions[questionIndex]
        questionLabel.text = currentQuestion.text
        let totalProgress = Float(questionIndex) / Float(questions.count)
        progressView.setProgress(totalProgress, animated: true)

    }

    private func getDaysFromBirthday(date: Date) -> Int{
          let currentDate = Date()
          let calendar = Calendar.current
          let dateComponents = DateComponents(year: calendar.component(.year, from: date),
                                              month: calendar.component(.month, from: date),
                                              day: calendar.component(.day, from: date))
          var day = 0
          if let someDateTime = calendar.date(from: dateComponents) {
              day = calendar.dateComponents([.day], from: someDateTime, to: currentDate).day ?? 0
          }
          return day
      }

}
// MARK: - DATE
extension Date {
    func removing(month: Int) -> Date? {
        let result =  Calendar.current.date(byAdding: .month, value: -(month), to: self)
        return result
    }
}

// MARK: - PICKER VIEW
extension  PensionViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        Proffesion.getAllValues().count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let gender = Proffesion.getAllValues()[row]
        return gender.rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row
    }

}

// MARK: - NAVIGATE
extension PensionViewController {
    private func nextQuestion() {
                questionIndex += 1
                if questionIndex < questions.count {
                    updateUI()
                } else {
                  performSegue(withIdentifier: "resultPension", sender: nil)
              }
            }

          override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
              guard segue.identifier == "resultPension" else { return }
              let resultsVC = segue.destination as! ResultPensionViewController
              resultsVC.dictionary = dictionary
              resultsVC.birthday = datePicker.date
          }
}
//MARK: - ALERT
extension PensionViewController {

    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
//MARK: - TEXTFIELD
extension PensionViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
           if textField == experienceTextField {
               let allowedCharacters = CharacterSet(charactersIn:"0123456789 ")
               let characterSet = CharacterSet(charactersIn: string)
               return allowedCharacters.isSuperset(of: characterSet)
           }
           return true
       }
}
