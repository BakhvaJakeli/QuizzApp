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
        view.backgroundColor = QuizzAppColor.buttonColor
        view.layer.cornerRadius = Constants.alertView.alertViewRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: Constants.titleLabel.titleLabelFont)
        label.textColor = .systemBackground
        label.textAlignment = .center
        label.numberOfLines = Constants.titleLabel.titleLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var yesButton = makeButton(Constants.yesButton.yesButtonTitle)
    
    private lazy var noButton = makeButton(Constants.noButton.noButtonTitle)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(noButton)
        stackView.addArrangedSubview(yesButton)
        stackView.axis = .horizontal
        stackView.spacing = Constants.stackView.stackViewSpacing
        
        return stackView
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addViews()
        setConstraints()
    }
    
    func setTitleText(_ text: String) {
        titleLabel.text = text
    }
}

// MARK: - Private Functions
private extension LogOutAlertViewController {
    // MARK: Config UI
    func configureUI() {
        view.backgroundColor = Constants.backgroundViewColor
        yesButton.addTarget(self,
                            action: #selector(yesPressed),
                            for: .touchUpInside)
        noButton.addTarget(self,
                           action: #selector(noPressed),
                           for: .touchUpInside)
    }
    
    // MARK: Create Button
    func makeButton(_ text: String) -> UIButton {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.title = text
        configuration.baseBackgroundColor = QuizzAppColor.alertButonColor
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
    func setConstraints() {
        alertViewConstraints()
        titleLabelConstraints()
        stackViewConstraints()
    }
    
    // MARK: Alert View Constraints
    func alertViewConstraints() {
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.leadingAnchor.constraint(lessThanOrEqualTo: view.leadingAnchor,
                                               constant: Constants.alertView.alertViewLeftPadding),
            alertView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor,
                                           constant: Constants.alertView.alertViewTopPadding)
        ])
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor,
                                            constant: Constants.titleLabel.titleTopPadding),
            titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                                constant: Constants.titleLabel.titleLeftPadding)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: Constants.stackView.stackViewTopPadding),
            stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                               constant: Constants.stackView.stackViewLeftPadding),
            stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor,
                                              constant: Constants.stackView.stackViewBottomPadding)
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

// MARK: - Constants
private extension LogOutAlertViewController {
    enum Constants {
        static let backgroundViewColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        enum alertView{
            static let alertViewRadius: CGFloat = 31
            static let alertViewLeftPadding: CGFloat = 53
            static let alertViewTopPadding: CGFloat = 350
        }
        enum titleLabel {
            static let titleLabelFont: CGFloat = 16
            static let titleTopPadding: CGFloat = 40
            static let titleLeftPadding: CGFloat = 24
            static let titleLabelNumberOfLines = 0
        }
        enum yesButton {
            static let yesButtonTitle = "კი"
        }
        enum noButton {
            static let noButtonTitle = "არა"
        }
        enum stackView{
            static let stackViewSpacing: CGFloat = 10
            static let stackViewTopPadding: CGFloat = 20
            static let stackViewLeftPadding: CGFloat = 24
            static let stackViewBottomPadding: CGFloat = -40
        }
    }
}
