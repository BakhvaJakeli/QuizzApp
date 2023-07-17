//
//  SubjectsTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 16.06.23.
//

import UIKit

final class SubjectsTableViewCell: UITableViewCell {
        
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
        label.textColor = QuizzAppColor.descriptionLabelTextColor
        label.numberOfLines = Constants.DescriptionLabel.numberOfLines
        
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = QuizzAppColor.buttonColor
        configuration.image = QuizzAppImage.nextArrow
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        
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
        selectionStyle = .none
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config Cell
    func configure(with subject: Subject) {
        titleLabel.text = subject.quizTitle
        ImageManager.shared.loadImage(from: subject.quizIcon) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.subjectImageView.image = image
            }
        }
        descriptionLabel.text = subject.quizDescription
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if isSelected {
            backgroundColor = .clear
            contentView.backgroundColor = .clear
        }
    }
}

// MARK: - Private Functions
private extension SubjectsTableViewCell {
    // MARK: Add Sub Views
    private func addViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(subjectImageView)
        mainView.addSubview(stackView)
        mainView.addSubview(nextButton)
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
            subjectImageView.widthAnchor.constraint(equalToConstant: Constants.SubjectImageView.width),
            subjectImageView.heightAnchor.constraint(equalToConstant: Constants.SubjectImageView.height)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                           constant: Constants.StackView.topPadding),
            stackView.leadingAnchor.constraint(equalTo: subjectImageView.trailingAnchor,
                                               constant: Constants.StackView.leftPadding),
            stackView.bottomAnchor.constraint(greaterThanOrEqualTo: mainView.bottomAnchor,
                                              constant: Constants.StackView.bottomPadding)
        ])
    }
    
    // MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor,
                                                constant: Constants.NextButton.leftPadding),
            nextButton.topAnchor.constraint(equalTo: mainView.topAnchor,
                                            constant: Constants.NextButton.topPadding),
            nextButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,
                                                 constant: Constants.NextButton.rightPadding),
            nextButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: Constants.NextButton.widthAnchor)
        ])
    }
}

// MARK: - Constants
private extension SubjectsTableViewCell {
    enum Constants {
        enum MainView {
            static let cornerRadius: CGFloat = 26
            static let bottomPadding: CGFloat = -10
        }
        enum DescriptionLabel {
            static let font: UIFont = .myriaGeo(ofSize: 12)
            static let numberOfLines = 0
        }
        enum TitleLabel {
            static let font: UIFont = .boldMyriadGeo(ofSize: 16)
        }
        enum SubjectImageView {
            static let topPadding: CGFloat = 22
            static let leftPadding: CGFloat = 30
            static let height: CGFloat = 62
            static let width: CGFloat = 64
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
            static let widthAnchor: CGFloat = 46
        }
    }
}
