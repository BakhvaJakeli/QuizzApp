//
//  LogOutAlert.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

protocol logOutAlertDelegate: AnyObject {
    func didTapYesOnLogout()
    func didTapNoOnLogOut()
}

final class LogOutAlertViewController: UIViewController {
    
    weak var delegate: logOutAlertDelegate?
    
    // MARK: Components
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColor.buttonColor
        view.layer.cornerRadius = Constants.AlertView.radius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.TitleLabel.font
        label.textColor = .systemBackground
        label.textAlignment = .center
        label.numberOfLines = Constants.TitleLabel.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var yesButton = makeButton(Constants.YesButton.title)
    
    private lazy var noButton = makeButton(Constants.NoButton.title)
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [noButton, yesButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = Constants.StackView.spacing
        
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
                            action: #selector(didTapYes),
                            for: .touchUpInside)
        noButton.addTarget(self,
                           action: #selector(didTapNo),
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
                                               constant: Constants.AlertView.leftPadding),
            alertView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor,
                                           constant: Constants.AlertView.topPadding)
        ])
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: alertView.topAnchor,
                                            constant: Constants.TitleLabel.topPadding),
            titleLabel.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                                constant: Constants.TitleLabel.leftPadding)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: Constants.StackView.topPadding),
            stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                               constant: Constants.StackView.leftPadding),
            stackView.bottomAnchor.constraint(equalTo: alertView.bottomAnchor,
                                              constant: Constants.StackView.bottomPadding)
        ])
    }
    
    // MARK: Yes Pressed Actin
    @objc func didTapYes() {
        dismiss(animated: true)
        delegate?.didTapYesOnLogout()
    }
    
    // MARK: No Pressed Action
    @objc func didTapNo() {
        dismiss(animated: true)
        delegate?.didTapNoOnLogOut()
    }
}

// MARK: - Constants
private extension LogOutAlertViewController {
    enum Constants {
        static let backgroundViewColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)
        enum AlertView{
            static let radius: CGFloat = 31
            static let leftPadding: CGFloat = 53
            static let topPadding: CGFloat = 350
        }
        enum TitleLabel {
            static let font: UIFont = .boldMyriadGeo(ofSize: 16)
            static let topPadding: CGFloat = 40
            static let leftPadding: CGFloat = 24
            static let numberOfLines = 0
        }
        enum YesButton {
            static let title = "კი"
        }
        enum NoButton {
            static let title = "არა"
        }
        enum StackView{
            static let spacing: CGFloat = 10
            static let topPadding: CGFloat = 20
            static let leftPadding: CGFloat = 24
            static let bottomPadding: CGFloat = -40
        }
    }
}
