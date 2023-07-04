//
//  ScoreTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

final class ScoreTableViewCell: UITableViewCell {
    
    // MARK: Components
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = QuizzAppColor.cellViewColor
        view.layer.cornerRadius = Constants.MainView.cornerRadius
        
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
        label.font = Constants.TitleLabel.font
        label.textColor = .black
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.DescriptionLabel.font
        label.text = Constants.DescriptionLabel.text
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
                                          constant: -Constants.MainView.bottomPadding),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: Constants.MainView.bottomPadding),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    // MARK: Subject Image View Constraint
    func subjectImageViewConstraints() {
        NSLayoutConstraint.activate([
            subjectImageView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                                  constant: Constants.SubjectImageView.topPadding),
            subjectImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            subjectImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,
                                                      constant: Constants.SubjectImageView.leftPadding),
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                           constant: Constants.StackView.topPadding),
            stackView.leadingAnchor.constraint(equalTo: subjectImageView.trailingAnchor,
                                               constant: Constants.StackView.leftPadding),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,
                                              constant: Constants.StackView.bottomPadding)
        ])
    }
    
    // MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            scoreButton.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor,
                                                 constant: Constants.NextButton.leftPadding),
            scoreButton.topAnchor.constraint(equalTo: mainView.topAnchor,
                                             constant: Constants.NextButton.topPadding),
            scoreButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,
                                                  constant: Constants.NextButton.rightPadding),
            scoreButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            scoreButton.widthAnchor.constraint(equalToConstant: Constants.NextButton.width)
        ])
    }
}

// MARK: - Constants
private extension ScoreTableViewCell {
    enum Constants {
        enum MainView {
            static let cornerRadius: CGFloat = 26
            static let bottomPadding: CGFloat = -10
        }
        enum DescriptionLabel {
            static let font: UIFont = .myriaGeo(ofSize: 12)
            static let text = "აღწერა"
        }
        enum TitleLabel {
            static let font: UIFont = .boldMyriadGeo(ofSize: 16)
        }
        enum SubjectImageView {
            static let topPadding: CGFloat = 22
            static let leftPadding: CGFloat = 30
        }
        enum StackView {
            static let topPadding: CGFloat = 33
            static let leftPadding: CGFloat = 18
            static let bottomPadding: CGFloat = -34
        }
        enum NextButton {
            static let leftPadding: CGFloat = 27
            static let topPadding: CGFloat = 30
            static let rightPadding: CGFloat = -30
            static let width: CGFloat = 46
        }
    }
}
