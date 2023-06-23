//
//  LogOutAlert.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

protocol logOutAlertDelegate: AnyObject {
    func pressedYesOnLogOut()
    func pressedNoOnLogOut()
}

final class LogOutAlertViewController: UIViewController {
    
    weak var delegate: logOutAlertDelegate?
    
    // MARK: Components
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColors.buttonColor
        view.layer.cornerRadius = Constants.alertViewRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.titleLabelFont)
        label.textColor = .systemBackground
        label.textAlignment = .center
        label.numberOfLines = Constants.titleLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var yesButton = createButton(Constants.yesButtonTitle)
    
    private lazy var noButton = createButton(Constants.noButtonTitle)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(noButton)
        stackView.addArrangedSubview(yesButton)
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackViewSpacing
        
        return stackView
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addViews()
        constraints()
    }
    
    func setTitleText(_ text: String) {
        titleLabel.text = text
    }
}

// MARK: -Private Functions
private extension LogOutAlertViewController {
    // MARK: Config UI
    func configUI() {
        view.backgroundColor = Constants.backgroundViewColor
        yesButton.addTarget(self, action: #selector(yesPressed), for: .touchUpInside)
        noButton.addTarget(self, action: #selector(noPressed), for: .touchUpInside)
    }
    
    // MARK: Create Button
    func createButton(_ text: String) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.title = text
        configuration.baseBackgroundColor = QuizzAppColors.alertButonColor
        configuration.baseForegroundColor = .black
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }
    
    // MARK: Add Views
    func addViews() {
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(stackView)
    }
    
    // MARK: Add Constraints
    func constraints() {
        alertViewConstraints()
        titleLabelConstraints()
        stackViewConstraints()
    }
    
    // MARK: Alert View Constraints
    func alertViewConstraints() {
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor, constant: Constants.alertViewLeftPadding),
            alertView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: Constants.alertViewTopPadding)
        ])
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor, constant: Constants.titleTopPadding),
            titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Constants.titleLeftPadding)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Constants.stackViewTopPadding),
            stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: Constants.stackViewLeftPadding),
            stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: Constants.stackViewBottomPadding)
        ])
    }
    
    // MARK: Yes Pressed Actin
    @objc func yesPressed() {
        dismiss(animated: true)
        delegate?.pressedYesOnLogOut()
    }
    
    // MARK: No Pressed Action
    @objc func noPressed() {
        dismiss(animated: true)
        delegate?.pressedNoOnLogOut()
    }
}

// MARK: -Constants
private extension LogOutAlertViewController {
    enum Constants {
        static let alertViewRadius: CGFloat = 31
        static let titleLabelFont: CGFloat = 16
        static let backgroundViewColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        static let yesButtonTitle = "კი"
        static let noButtonTitle = "არა"
        static let stackViewSpacing: CGFloat = 10
        static let alertViewLeftPadding: CGFloat = 53
        static let alertViewTopPadding: CGFloat = 350
        static let titleTopPadding: CGFloat = 40
        static let titleLeftPadding: CGFloat = 24
        static let stackViewTopPadding: CGFloat = 20
        static let stackViewLeftPadding: CGFloat = 24
        static let stackViewBottomPadding: CGFloat = -40
        static let titleLabelNumberOfLines = 0
    }
}
