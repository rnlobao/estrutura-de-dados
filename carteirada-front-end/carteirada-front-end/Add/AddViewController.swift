//
//  AddViewController.swift
//  carteirada-front-end
//
//  Created by Robson Novato Lobao on 19/09/22.
//

import Foundation
import UIKit

class AddViewController: UIViewController {
    @IBOutlet weak var registerButton: UIButton!
    var theActives: [String] = []
    @IBOutlet weak var pickerView: UIPickerView!
    
    @IBOutlet weak var tickerTF: UITextField!
    @IBOutlet weak var qtdTF: UITextField!
    @IBOutlet weak var priceTF: UITextField!
    @IBOutlet weak var dateTF: UITextField!
    
    private var viewModel: AddViewModel!
    
    override func viewDidLoad() {
        viewModel = AddViewModel(delegate: self)
        setupRegisterButton()
        setupPicker()
        theActives = ["Fii's", "Ações", "Criptoativos"]
        setupDateTF()
    }
    
    func setupRegisterButton() {
        registerButton.layer.cornerRadius = 20
        registerButton.layer.shadowColor = UIColor.black.cgColor
        registerButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        registerButton.layer.shadowRadius = 4.0
        registerButton.layer.shadowOpacity = 0.5
        registerButton.layer.masksToBounds = false
    }
    
    @IBAction func addButton(_ sender: Any) {
        viewModel.postAsset(email: UserDefaults.standard.string(forKey: "email") ?? "", active: pickerView.selectedRow(inComponent: 0) , date: dateTF.text ?? "", ticker: tickerTF.text ?? "", quantity: Int(qtdTF.text!) ?? 1, price: Float(priceTF.text!) ?? 1.0)
    }
    
    func setupPicker() {
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setupQtdTf() {
        qtdTF.keyboardType = .numberPad
        priceTF.keyboardType = .decimalPad
    }
    
    private func setupDateTF() {
        dateTF.delegate = self
        dateTF.keyboardType = .numberPad
    }
    
    func setupToolBar() {
        setupToolBarTicker()
        setupToolBarQtd()
        setupToolBarPrice()
        setupToolBarDate()
    }
    
    private func setupToolBarTicker() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemEmail = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardTicker))
        let nextButtonItemEmail = UIBarButtonItem(title: "próximo", style: .done, target: self, action: #selector(nextTextFieldTicker))
        keyboardToolbar.items = [flexBarButton, closeButtonItemEmail, nextButtonItemEmail]
        tickerTF.inputAccessoryView = keyboardToolbar
    }
    
    private func setupToolBarQtd() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemUser = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardQtd))
        let nextButtonItemUser = UIBarButtonItem(title: "próximo", style: .done, target: self, action: #selector(nextTextFieldQtd))
        keyboardToolbar.items = [flexBarButton, closeButtonItemUser, nextButtonItemUser]
        qtdTF.inputAccessoryView = keyboardToolbar
    }
    
    private func setupToolBarPrice() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemPW = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardPrice))
        let nextButtonItemPW = UIBarButtonItem(title: "próximo", style: .done, target: self, action: #selector(nextTextFieldPrice))
        keyboardToolbar.items = [flexBarButton, closeButtonItemPW, nextButtonItemPW]
        priceTF.inputAccessoryView = keyboardToolbar
    }
    
    private func setupToolBarDate() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        let closeButtonItemconfirmPW = UIBarButtonItem(title: "fechar", style: .done, target: self, action: #selector(closeKeyboardDate))
        keyboardToolbar.items = [flexBarButton, closeButtonItemconfirmPW]
        dateTF.inputAccessoryView = keyboardToolbar
    }
    
    @objc func closeKeyboardTicker() {
        tickerTF.endEditing(true)
    }
    
    @objc func closeKeyboardQtd() {
        qtdTF.endEditing(true)
    }
    
    @objc func closeKeyboardPrice() {
        priceTF.endEditing(true)
    }
    
    @objc func closeKeyboardDate() {
        dateTF.endEditing(true)
    }
    
    @objc func nextTextFieldTicker() {
        tickerTF.resignFirstResponder()
        qtdTF.becomeFirstResponder()
    }
    
    @objc func nextTextFieldQtd() {
        qtdTF.resignFirstResponder()
        priceTF.becomeFirstResponder()
    }
    
    @objc func nextTextFieldPrice() {
        priceTF.resignFirstResponder()
        dateTF.becomeFirstResponder()
    }
}

extension AddViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theActives.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return theActives[row]
    }
}

extension AddViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == dateTF {
            if (dateTF?.text?.count == 2) || (dateTF?.text?.count == 5) {
                if !(string == "") {
                    dateTF?.text = (dateTF?.text)! + "/"
                }
            }
            return !(textField.text!.count > 9 && (string.count ) > range.length)
        }
        else {
            return true
        }
    }
}

extension AddViewController: ServiceDelegate {
    func dataSucess() {
        let alert = UIAlertController(title: "Sucesso", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Continuar", style: .destructive, handler: {(action:UIAlertAction!) in
        }))
        self.present(alert, animated: true)
    }
        
    func dataFail(error: Error) {
        let alert = UIAlertController(title: "Erro", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .destructive, handler: nil))
        self.present(alert, animated: true)
    }
        
    func showLoad() {
        showSpinner(onView: view)
    }
        
    func removeLoad() {
        removeSpinner()
    }
}
