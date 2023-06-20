//
//  ViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class LogInViewController: UIViewController {
    
    //MARK: Components
    private let logInImageView: CoverView = {
        let logInImage = CoverView()
        logInImage.translatesAutoresizingMaskIntoConstraints = false
        return logInImage
    }()
    
    private let logInTextField: UITextField = {
        let textFIeld = UITextField()
        textFIeld.translatesAutoresizingMaskIntoConstraints = false
        textFIeld.textAlignment = .center
        textFIeld.placeholder = Constants.logInTextFieldPlaceHolder
        textFIeld.layer.cornerRadius = Constants.logInTextFieldCornerRadius
        textFIeld.layer.borderWidth = Constants.logInTextFieldBorderWidth
        textFIeld.layer.borderColor = QuizzAppColors.buttonColor.cgColor
        textFIeld.autocorrectionType = .no
        
        return textFIeld
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.logInButtonTitle, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.logInButtonTitleLableFont)
        button.layer.cornerRadius = Constants.logInTextFieldCornerRadius
        button.backgroundColor = QuizzAppColors.buttonColor
        button.addTarget(self, action: #selector(clickLogIn), for: .touchUpInside)
        
        return button
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        addConstraints()
        configUI()
    }
    
    //MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    //MARK: View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
}

//MARK: - Functions
private extension LogInViewController {
    
    //MARK: Config UI
    func configUI() {
        view.backgroundColor = .systemBackground
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: Add SubViews
    func addSubViews() {
        view.addSubview(logInImageView)
        view.addSubview(logInTextField)
        view.addSubview(logInButton)
    }
    
    //MARK: Add Constrants
    func addConstraints() {
        logInImageConstraints()
        logInTextFieldConstraints()
        logInButtonConstraints()
    }
    
    //MARK: Log In Image Constraints
    func logInImageConstraints() {
        NSLayoutConstraint.activate([
            logInImageView.topAnchor.constraint(equalTo: view.topAnchor),
            logInImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            logInImageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    //MARK: Log In Text Field Constrants
    func logInTextFieldConstraints() {
        NSLayoutConstraint.activate([
            logInTextField.topAnchor.constraint(equalTo: logInImageView.bottomAnchor,
                                                constant: Constants.logInTextFieldTopPadding),
            logInTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Constants.logInTextFieldLeadingPadding),
            logInTextField.heightAnchor.constraint(equalToConstant: Constants.logInTextFieldHeight)
        ])
    }
    
    //MARK: Log in Button Constraints
    func logInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: logInTextField.bottomAnchor,
                                             constant: Constants.logInButtonTopPadding),
            logInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                 constant: Constants.logInButtonLeadingPadding),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.logInButtonHeight)
        ])
    }
    
    //MARK: Hide Keyboard Function
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    //MARK: Click Log In Function
    @objc func clickLogIn() {
        let homePageViewController = HomePageViewController()
        let navigactionController = UINavigationController(rootViewController: homePageViewController)
        navigactionController.modalPresentationStyle = .fullScreen
        present(navigactionController, animated: true)
    }
}

//MARK: - Constants
private extension LogInViewController {
    enum Constants {
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
        static let logInTextFieldPlaceHolder = "შეიყვანე სახელი"
        static let logInButtonTitle = "ქვიზის დაწყება"
    }
}
