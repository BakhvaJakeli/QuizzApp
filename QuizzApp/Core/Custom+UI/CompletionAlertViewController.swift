//
//  CompletionAlert.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

protocol CompletionAlertDelegate: AnyObject {
    func pressedCloseOnCompletion()
}

final class CompletionAlertViewController: UIViewController {
    
    weak var delegate: CompletionAlertDelegate?
    
    // MARK: Components
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColor.buttonColor
        view.layer.cornerRadius = Constants.alertView.alertViewRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = QuizzAppImage.confetti
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let congratulationsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.congratulationsLabel.congratulationsLabelText
        label.font = .boldSystemFont(ofSize: Constants.congratulationsLabel.congratulationsLabeFont)
        label.textColor = .systemBackground
        label.textAlignment = .center
        
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.pointsLabel.pointsLabelText
        label.font = .boldSystemFont(ofSize: Constants.pointsLabel.pointsLabelFont)
        label.textAlignment = .center
        label.textColor = .link
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(congratulationsLabel)
        stackView.addArrangedSubview(pointsLabel)
        
        return stackView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.title = Constants.closeButton.closeButtonTitle
        configuration.baseBackgroundColor = .clear
        button.configuration = configuration
        button.addTarget(self, action: #selector(close), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addViews()
        setConstraints()
    }
}

// MARK: - Private Functions
private extension CompletionAlertViewController {
    // MARK: Config UI
    func configureUI() {
        view.backgroundColor = Constants.backgroundViewColor
    }
    
    // MARK: Add Sub Views
    func addViews() {
        view.addSubview(alertView)
        [alertImageView,stackView,dividerView,closeButton].forEach{ alertView.addSubview($0) }
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        alertViewConstraints()
        alertImageViewConstraints()
        stackViewConstraints()
        dividerViewConstraints()
        closeButtonConstraints()
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
    
    // MARK: Alert Image View Constraints
    func alertImageViewConstraints() {
        NSLayoutConstraint.activate([
            alertImageView.topAnchor.constraint(equalTo: alertView.topAnchor,
                                                constant: Constants.alertImageView.alertImageViewTopPadding),
            alertImageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor)
        ])
    }
    
    // MARK: StackView Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: alertImageView.bottomAnchor,
                                           constant: Constants.stackView.stackViewTopPadding),
            stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                               constant: Constants.stackView.stackViewLeftPadding)
        ])
    }
    
    // MARK: Divider View Constraints
    func dividerViewConstraints() {
        NSLayoutConstraint.activate([
            dividerView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            dividerView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: Constants.dividerView.dividerViewHeight),
            dividerView.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                             constant: Constants.dividerView.dividerViewTopPadding)
        ])
    }
    
    // MARK: Close Button Constraint
    func closeButtonConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor,
                                             constant: Constants.closeButton.closeButtonTopPadding),
            closeButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            closeButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                                 constant: Constants.closeButton.closeButtonLeftPadding),
            closeButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor,
                                                constant: Constants.closeButton.closeButtonBottomPadding)
        ])
    }
    
    // MARK: Close Function
    @objc func close() {
        dismiss(animated: true)
        delegate?.pressedCloseOnCompletion()
    }
}

// MARK: - Constants
private extension CompletionAlertViewController {
    enum Constants {
        static let backgroundViewColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        enum alertView {
            static let alertViewRadius: CGFloat = 31
            static let alertViewLeftPadding: CGFloat = 53
            static let alertViewTopPadding: CGFloat = 350
        }
        enum congratulationsLabel {
            static let congratulationsLabelText = "გილოცავ!"
            static let congratulationsLabeFont: CGFloat = 16
        }
        enum pointsLabel {
            static let pointsLabelText = "შენ დააგროვე 14 ქულა"
            static let pointsLabelFont: CGFloat = 14
        }
        enum closeButton {
            static let closeButtonTitle = "დახურვა"
            static let closeButtonBottomPadding: CGFloat = -12
            static let closeButtonLeftPadding: CGFloat = 24
            static let closeButtonTopPadding: CGFloat = 12.5
        }
        enum alertImageView {
            static let alertImageViewTopPadding: CGFloat = 39
        }
        enum stackView {
            static let stackViewLeftPadding: CGFloat = 24
            static let stackViewTopPadding: CGFloat = 17
        }
        enum dividerView {
            static let dividerViewHeight: CGFloat = 1
            static let dividerViewTopPadding: CGFloat = 33
        }
    }
}
