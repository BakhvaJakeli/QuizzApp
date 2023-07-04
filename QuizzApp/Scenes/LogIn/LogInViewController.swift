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
        textFIeld.placeholder = Constants.LogInTextField.placeHolder
        textFIeld.layer.cornerRadius = Constants.LogInTextField.cornerRadius
        textFIeld.layer.borderWidth = Constants.LogInTextField.borderWidth
        textFIeld.layer.borderColor = QuizzAppColor.buttonColor.cgColor
        textFIeld.autocorrectionType = .no
        
        return textFIeld
    }()
    
    private lazy var logInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.LogInButton.title,
                        for: .normal)
        button.titleLabel?.font = Constants.LogInButton.font
        button.layer.cornerRadius = Constants.LogInTextField.cornerRadius
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
                                                constant: Constants.LogInTextField.topPadding),
            logInTextField.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logInTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                    constant: Constants.LogInTextField.leftPadding),
            logInTextField.heightAnchor.constraint(equalToConstant: Constants.LogInTextField.height)
        ])
    }
    
    // MARK: Log in Button Constraints
    func logInButtonConstraints() {
        NSLayoutConstraint.activate([
            logInButton.topAnchor.constraint(equalTo: logInTextField.bottomAnchor,
                                             constant: Constants.LogInButton.topPadding),
            logInButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            logInButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,
                                                 constant: Constants.LogInButton.leftPadding),
            logInButton.heightAnchor.constraint(equalToConstant: Constants.LogInButton.height),
            logInButton.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.bottomAnchor,
                                                constant: Constants.LogInButton.bottomPadding)
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
                    view.frame.origin.y -= keyboardSize.height + Constants.LogInButton.bottomPadding
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
        enum LogInTextField {
            static let cornerRadius: CGFloat = 12
            static let borderWidth: CGFloat = 1
            static let topPadding: CGFloat = 92
            static let leftPadding: CGFloat = 55
            static let height: CGFloat = 44
            static let placeHolder = "შეიყვანე სახელი"
        }
        enum LogInButton {
            static let topPadding: CGFloat = 26
            static let bottomPadding: CGFloat = -149
            static let leftPadding: CGFloat = 117
            static let height: CGFloat = 44
            static let font: UIFont = .boldMyriadGeo(ofSize: 12)
            static let title = "ქვიზის დაწყება"
        }
    }
}
