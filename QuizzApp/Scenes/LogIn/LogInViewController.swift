//
//  ViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class LogInViewController: UIViewController {

    //MARK: Components
    private let logInImage: LogInImageView = {
        let logInImage = LogInImageView()
        logInImage.translatesAutoresizingMaskIntoConstraints = false
        return logInImage
    }()
    
    private let logInTextField: UITextField = {
        let textFIeld = UITextField()
        textFIeld.translatesAutoresizingMaskIntoConstraints = false
        textFIeld.textAlignment = .center
        textFIeld.placeholder = "შეიყვანე სახელი"
        textFIeld.layer.cornerRadius = LogInViewControllerConstants.logInTextFieldCornerRadius
        textFIeld.layer.borderWidth = LogInViewControllerConstants.logInTextFieldBorderWidth
        textFIeld.layer.borderColor = QuizzAppColors.buttonColor.cgColor
        
        return textFIeld
    }()
    
    private let logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("ქვიზის დაწყება", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: LogInViewControllerConstants.logInButtonTitleLableFont)
        button.layer.cornerRadius = LogInViewControllerConstants.logInTextFieldCornerRadius
        button.backgroundColor = QuizzAppColors.buttonColor
        
        return button
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        configUI()
    }
    
    //MARK: Config UI
    private func configUI() {
        view.backgroundColor = .systemBackground
        logInButton.addTarget(self, action: #selector(clickLogIn), for: .touchUpInside)
    }

    //MARK: Add SubViews
    private func addSubViews() {
        view.addSubview(logInImage)
        view.addSubview(logInTextField)
        view.addSubview(logInButton)
    }
    
    //MARK: Add Constrants
    private func addConstraints() {
        logInImageConstraints()
        logInTextFieldConstraints()
        logInButtonConstraints()
    }
    
    //MARK: Log In Image Constraints
    private func logInImageConstraints() {
        NSLayoutConstraint.activate([
            logInImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logInImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logInImage.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            logInImage.heightAnchor.constraint(equalToConstant: LogInViewControllerConstants.logInImageHeight)
        ])
    }
    
    //MARK: Log In Text Field Constrants
    private func logInTextFieldConstraints() {
        NSLayoutConstraint.activate([
            logInTextField.topAnchor.constraint(equalTo: logInImage.bottomAnchor, constant: LogInViewControllerConstants.logInTextFieldTopPadding),
            logInTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LogInViewControllerConstants.logInTextFieldLeadingPadding),
            logInTextField.heightAnchor.constraint(equalToConstant: LogInViewControllerConstants.logInTextFieldHeight)
        ])
    }
    
    //MARK: Log in Button Constraints
    private func logInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: logInTextField.bottomAnchor, constant: LogInViewControllerConstants.logInButtonTopPadding),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: LogInViewControllerConstants.logInButtonLeadingPadding),
            logInButton.heightAnchor.constraint(equalToConstant: LogInViewControllerConstants.logInButtonHeight)
        ])
    }
    
    @objc private func clickLogIn() {
        print("jeff")
    }
}

private extension LogInViewController {
    enum LogInViewControllerConstants {
        static let logInImageHeight: CGFloat = 433
        static let logInTextFieldCornerRadius: CGFloat = 12
        static let logInTextFieldBorderWidth: CGFloat = 1
        static let logInTextFieldTopPadding: CGFloat = 92
        static let logInTextFieldLeadingPadding: CGFloat = 55
        static let logInTextFieldHeight: CGFloat = 44
        static let logInButtonTopPadding: CGFloat = 26
        static let logInButtonBottomPadding: CGFloat = 149
        static let logInButtonLeadingPadding: CGFloat = 117
        static let logInButtonHeight: CGFloat = 44
        static let logInButtonTitleLableFont: CGFloat = 12
    }
}
