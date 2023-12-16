//
//  ViewController.swift
//  Login
//
//  Created by Vitaly on 02.11.2023.
//

import UIKit

class ViewController: UIViewController {
    //MARK: - IBOutlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var emailLineView: UIView!
    @IBOutlet private weak var envelopImageView: UIImageView!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var passwordLineView: UIView!
    @IBOutlet private weak var lockImageView: UIImageView!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var dontHaveAccountLabel: UILabel!
    @IBOutlet private weak var signupButton: UIButton!
    
    //MARK: Properties
    private var email: String = ""
    private var password: String = ""
    
    private let mockEmail = "abc@gmail.com"
    private let mockPassword = "1234567"
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        buttonViewLogin()
        emailTextField.delegate = self
        passwordTextField.delegate = self
        emailTextField.becomeFirstResponder()
    }
    //MARK: - IBActions
    @IBAction func loginButtonAction(_ sender: Any) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
        if email.isEmpty {
            makeErrorField(textField: emailTextField)
        }
        
        if password.isEmpty {
            makeErrorField(textField: passwordTextField)
        }
        
        if email == mockEmail,
           password == mockPassword {
            performSegue(withIdentifier: "goToHomePage", sender: sender)
        } else {
            let alert = UIAlertController(title: "Error".localized,
                                          message: "Wrong password or e-mail".localized,
                                          preferredStyle: .alert)
            let action = UIAlertAction(title:"OK".localized,
                                       style: .cancel)
            alert.addAction(action)
            
            present(alert, animated: true)
        }
    }
    @IBAction func signupButtonAction(_ sender: Any) {
        print("Signup")
    }
    //MARK: - Methods
    private func buttonViewLogin(){
        loginButton.layer.shadowColor = (UIColor(named: "ColorButtonView") ?? UIColor.darkGray).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0, height: 7)
        loginButton.layer.shadowOpacity = 0.4
        loginButton.layer.shadowRadius = 7
        
    }
}

extension  ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else { return }
        
        switch textField{
        case emailTextField:
            let isValidEmail = check(email: text)
            if isValidEmail {
                email = text
                envelopImageView.tintColor = .systemGray5
                emailLineView.backgroundColor = .systemGray5
            } else {
                makeErrorField(textField: textField)
            }
        case passwordTextField:
            let isValidPassword = check(password: text)
            if isValidPassword {
                password = text
                lockImageView.tintColor = .systemGray5
                passwordLineView.backgroundColor = .systemGray5
            } else {
                makeErrorField(textField: textField)
            }
        default:
            print("unknown textField")
        }
    }
    
    private func check(email: String) -> Bool {
        return email.contains("@") && email.contains(".")
    }
    
    private func check(password: String) -> Bool {
        return password.count >= 4
    }
    
    private func makeErrorField(textField: UITextField) {
        switch textField {
        case emailTextField:
            envelopImageView.tintColor = UIColor.systemRed
            emailLineView.backgroundColor = UIColor.systemRed
        case passwordTextField:
            lockImageView.tintColor = UIColor.systemRed
            passwordLineView.backgroundColor = UIColor.systemRed
        default:
            print("unknown textField")
        }
    }
}
