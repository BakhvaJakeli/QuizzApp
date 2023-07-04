//
//  CompletionAlert.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

protocol CompletionAlertDelegate: AnyObject {
    func didTapNoOnCompletion()
}

final class CompletionAlertViewController: UIViewController {
    
    weak var delegate: CompletionAlertDelegate?
    
    // MARK: Components
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColor.buttonColor
        view.layer.cornerRadius = Constants.AlertView.radius
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
        label.text = Constants.CongratulationsLabel.text
        label.font = Constants.CongratulationsLabel.font
        label.textColor = .systemBackground
        label.textAlignment = .center
        
        return label
    }()
    
    private let pointsLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.PointsLabel.text
        label.font = Constants.PointsLabel.font
        label.textAlignment = .center
        label.textColor = .link
        
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [congratulationsLabel, pointsLabel])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
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
        configuration.title = Constants.CloseButton.title
        configuration.baseBackgroundColor = .clear
        button.configuration = configuration
        button.addTarget(self,
                         action: #selector(didTapClose),
                         for: .touchUpInside)
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
        [alertImageView, stackView, dividerView, closeButton].forEach{ alertView.addSubview($0) }
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
                                               constant: Constants.AlertView.leftPadding),
            alertView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor,
                                           constant: Constants.AlertView.topPadding)
        ])
    }
    
    // MARK: Alert Image View Constraints
    func alertImageViewConstraints() {
        NSLayoutConstraint.activate([
            alertImageView.topAnchor.constraint(equalTo: alertView.topAnchor,
                                                constant: Constants.AlertImageView.topPadding),
            alertImageView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor)
        ])
    }
    
    // MARK: StackView Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: alertImageView.bottomAnchor,
                                           constant: Constants.StackView.topPadding),
            stackView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                               constant: Constants.StackView.leftPadding)
        ])
    }
    
    // MARK: Divider View Constraints
    func dividerViewConstraints() {
        NSLayoutConstraint.activate([
            dividerView.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            dividerView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: Constants.DividerView.height),
            dividerView.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                             constant: Constants.DividerView.topPadding)
        ])
    }
    
    // MARK: Close Button Constraint
    func closeButtonConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: dividerView.bottomAnchor,
                                             constant: Constants.CloseButton.topPadding),
            closeButton.centerXAnchor.constraint(equalTo: alertView.centerXAnchor),
            closeButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor,
                                                 constant: Constants.CloseButton.leftPadding),
            closeButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor,
                                                constant: Constants.CloseButton.bottomPadding)
        ])
    }
    
    // MARK: Close Function
    @objc func didTapClose() {
        dismiss(animated: true)
        delegate?.didTapNoOnCompletion()
    }
}

// MARK: - Constants
private extension CompletionAlertViewController {
    enum Constants {
        static let backgroundViewColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)
        enum AlertView {
            static let radius: CGFloat = 31
            static let leftPadding: CGFloat = 53
            static let topPadding: CGFloat = 350
        }
        enum CongratulationsLabel {
            static let text = "გილოცავ!"
            static let font: UIFont = .boldMyriadGeo(ofSize: 16)
        }
        enum PointsLabel {
            static let text = "შენ დააგროვე 14 ქულა"
            static let font: UIFont = .boldMyriadGeo(ofSize: 14)
        }
        enum CloseButton {
            static let title = "დახურვა"
            static let bottomPadding: CGFloat = -12
            static let leftPadding: CGFloat = 24
            static let topPadding: CGFloat = 12.5
        }
        enum AlertImageView {
            static let topPadding: CGFloat = 39
        }
        enum StackView {
            static let leftPadding: CGFloat = 24
            static let topPadding: CGFloat = 17
        }
        enum DividerView {
            static let height: CGFloat = 1
            static let topPadding: CGFloat = 33
        }
    }
}
