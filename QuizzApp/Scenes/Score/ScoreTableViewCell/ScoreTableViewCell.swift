//
//  ScoreTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {

    static let identifier = "ScoreTableViewCell"
    
    // MARK: Components
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = QuizzAppColor.cellViewColor
        view.layer.cornerRadius = Constants.mainView.mainViewCornerRadius
        
        return view
    }()
    
    private let subjectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.titleLabel.titleLabelFont)
        label.textColor = .black
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: QuizzAppFont.myriadGeo, size: Constants.descriptionLabel.desciptionLabelFont)
        label.text = Constants.descriptionLabel.descriptionLabelText
        label.textColor = QuizzAppColor.descriptionLabelTextColor
        
        return label
    }()
    
    private let scoreButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = QuizzAppColor.buttonColor
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, descriptionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        return stackView
    }()

    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config Cell
    func configure(with score: SubjectScore) {
        subjectImageView.image = score.image
        titleLabel.text = score.title
        scoreButton.setTitle("\(score.score)", for: .normal)
    }
}

// MARK: - Private Functions
private extension ScoreTableViewCell {
    // MARK: Add Sub Views
    private func addViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(subjectImageView)
        mainView.addSubview(stackView)
        mainView.addSubview(scoreButton)
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        mainViewConstraints()
        subjectImageViewConstraints()
        stackViewConstraints()
        nextButtonConstraints()
    }
    
    // MARK: Main View Constraints
    func mainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: -Constants.mainView.mainViewBottomPadding),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: Constants.mainView.mainViewBottomPadding),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: Subject Image View Constraint
    func subjectImageViewConstraints() {
        NSLayoutConstraint.activate([
            subjectImageView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                                  constant: Constants.subjectImageView.subjectImageViewTopPadding),
            subjectImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            subjectImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,
                                                      constant: Constants.subjectImageView.subjectImageViewLeftPadding),
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                           constant: Constants.stackView.stackViewTopPadding),
            stackView.leadingAnchor.constraint(equalTo: subjectImageView.trailingAnchor,
                                               constant: Constants.stackView.stackViewLeftPadding),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,
                                              constant: Constants.stackView.stackViewBottomPadding)
        ])
    }
    
    // MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            scoreButton.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor,
                                                 constant: Constants.nextButton.nextButtonLeftPadding),
            scoreButton.topAnchor.constraint(equalTo: mainView.topAnchor,
                                             constant: Constants.nextButton.nextButtonTopPadding),
            scoreButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,
                                                  constant: Constants.nextButton.nextButtonRightPadding),
            scoreButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            scoreButton.widthAnchor.constraint(equalToConstant: Constants.nextButton.nextButtonWidthAnchor)
        ])
    }
}

// MARK: - Constants
private extension ScoreTableViewCell {
    enum Constants {
        enum mainView {
            static let mainViewCornerRadius: CGFloat = 26
            static let mainViewBottomPadding: CGFloat = -10
        }
        enum descriptionLabel {
            static let desciptionLabelFont: CGFloat = 12
            static let descriptionLabelText = "აღწერა"
        }
        enum titleLabel {
            static let titleLabelFont: CGFloat = 16
        }
        enum subjectImageView {
            static let subjectImageViewTopPadding: CGFloat = 22
            static let subjectImageViewLeftPadding: CGFloat = 30
        }
        enum stackView {
            static let stackViewTopPadding: CGFloat = 33
            static let stackViewLeftPadding: CGFloat = 18
            static let stackViewBottomPadding: CGFloat = -34
        }
        enum nextButton {
            static let nextButtonLeftPadding: CGFloat = 27
            static let nextButtonTopPadding: CGFloat = 30
            static let nextButtonRightPadding: CGFloat = -30
            static let nextButtonWidthAnchor: CGFloat = 46
        }
    }
}
