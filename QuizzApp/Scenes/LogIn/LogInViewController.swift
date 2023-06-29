//
//  ViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class LogInViewController: UIViewController {
    
    // MARK: Components
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = false
        
        return scrollView
    }()
    
    private let logInImageView: CoverView = {
        let logInImage = CoverView()
        logInImage.translatesAutoresizingMaskIntoConstraints = false
        return logInImage
    }()
    
    private let logInTextField: UITextField = {
        let textFIeld = UITextField()
        textFIeld.translatesAutoresizingMaskIntoConstraints = false
        textFIeld.textAlignment = .center
        textFIeld.placeholder = Constants.logInTextField.logInTextFieldPlaceHolder
        textFIeld.layer.cornerRadius = Constants.logInTextField.logInTextFieldCornerRadius
        textFIeld.layer.borderWidth = Constants.logInTextField.logInTextFieldBorderWidth
        textFIeld.layer.borderColor = QuizzAppColor.buttonColor.cgColor
        textFIeld.autocorrectionType = .no
        
        return textFIeld
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.logInButton.logInButtonTitle,
                        for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: Constants.logInButton.logInButtonTitleLableFont)
        button.layer.cornerRadius = Constants.logInTextField.logInTextFieldCornerRadius
        button.backgroundColor = QuizzAppColor.buttonColor
        button.addTarget(self,
                         action: #selector(didTapLogIn),
                         for: .touchUpInside)
        
        return button
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        setConstraints()
        configureUI()
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait)
    }
    
    // MARK: View Will Disappear
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AppUtility.lockOrientation(.all)
    }
}

// MARK: - Private Functions
private extension LogInViewController {
    // MARK: Config UI
    func configureUI() {
        view.backgroundColor = .systemBackground
        hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: Add SubViews
    func addSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(logInImageView)
        scrollView.addSubview(logInTextField)
        scrollView.addSubview(logInButton)
    }
    
    // MARK: Add Constrants
    func setConstraints() {
        logInImageConstraints()
        logInTextFieldConstraints()
        logInButtonConstraints()
        scrollViewConstraints()
    }
    
    // MARK: Log In Image Constraints
    func logInImageConstraints() {
        NSLayoutConstraint.activate([
            logInImageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            logInImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            logInImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    // MARK: Log In Text Field Constrants
    func logInTextFieldConstraints() {
        NSLayoutConstraint.activate([
            logInTextField.topAnchor.constraint(equalTo: logInImageView.bottomAnchor,
                                                constant: Constants.logInTextField.logInTextFieldTopPadding),
            logInTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logInTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                    constant: Constants.logInTextField.logInTextFieldLeadingPadding),
            logInTextField.heightAnchor.constraint(equalToConstant: Constants.logInTextField.logInTextFieldHeight)
        ])
    }
    
    // MARK: Log in Button Constraints
    func logInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: logInTextField.bottomAnchor,
                                             constant: Constants.logInButton.logInButtonTopPadding),
            logInButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logInButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: Constants.logInButton.logInButtonLeadingPadding),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.logInButton.logInButtonHeight),
            logInButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor,
                                                constant: Constants.logInButton.logInButtonBottomPadding)
        ])
    }
    
    // MARK: Scroll View Constraints
    func scrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    // MARK: Hide Keyboard Function
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    // MARK: Dismiss keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: Click Log In Function
    @objc func didTapLogIn() {
        let homePageViewController = HomeViewController()
        let navigactionController = UINavigationController(rootViewController: homePageViewController)
        navigactionController.modalPresentationStyle = .fullScreen
        present(navigactionController,
                animated: true)
    }
    
    // MARK: Keyboard will show
    @objc func keyboardWillShow(notification: NSNotification) {
        let frame = logInButton.frame
        let convertedOrigin = view.convert(frame.origin,
                                           to: logInButton.superview)
        let buttonYCoordinate = view.bounds.height - convertedOrigin.y
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                if keyboardSize.height > buttonYCoordinate {
                    view.frame.origin.y -= keyboardSize.height
                } else {
                    view.frame.origin.y -= keyboardSize.height + Constants.logInButton.logInButtonBottomPadding
                }
            }
        }
    }
    
    // MARK: Keyboard will hide
    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

// MARK: - Constants
private extension LogInViewController {
    enum Constants {
        enum logInTextField {
            static let logInTextFieldCornerRadius: CGFloat = 12
            static let logInTextFieldBorderWidth: CGFloat = 1
            static let logInTextFieldTopPadding: CGFloat = 92
            static let logInTextFieldLeadingPadding: CGFloat = 55
            static let logInTextFieldHeight: CGFloat = 44
            static let logInTextFieldPlaceHolder = "შეიყვანე სახელი"
        }
        enum logInButton {
            static let logInButtonTopPadding: CGFloat = 26
            static let logInButtonBottomPadding: CGFloat = -149
            static let logInButtonLeadingPadding: CGFloat = 117
            static let logInButtonHeight: CGFloat = 44
            static let logInButtonTitleLableFont: CGFloat = 12
            static let logInButtonTitle = "ქვიზის დაწყება"
        }
    }
}
