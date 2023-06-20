//
//  SubjectsTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 16.06.23.
//

import UIKit

final class SubjectsTableViewCell: UITableViewCell {
    
    static let identifier = "SubjectsTableViewCell"
    
    //MARK: Components
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = QuizzAppColors.cellViewColor
        view.layer.cornerRadius = Constants.mainViewCornerRadius
        
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
        label.font = .boldSystemFont(ofSize: Constants.titleLabelFont)
        label.textColor = .black
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.desciptionLabelFont)
        label.text = Constants.descriptionLabelText
        label.textColor = QuizzAppColors.descriptionLabelTextColor
        
        return label
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        var configuration = UIButton.Configuration.filled()
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = QuizzAppColors.buttonColor
        configuration.image = QuizzAppImages.nextArrow
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isUserInteractionEnabled = false
        
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        return stackView
    }()

    //MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Config Cell
    func configCell(with subject: Subject) {
        subjectImageView.image = subject.image
        titleLabel.text = subject.title
    }
}

//MARK: Private Functions
private extension SubjectsTableViewCell {
    //MARK: Add Sub Views
    private func addViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(subjectImageView)
        mainView.addSubview(stackView)
        mainView.addSubview(nextButton)
    }
    
    //MARK: Add Constraints
    func constraints() {
        mainViewConstraints()
        subjectImageViewConstraints()
        stackViewConstraints()
        nextButtonConstraints()
    }
    
    //MARK: Main View Constraints
    func mainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: -Constants.mainViewBottomPadding),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: Constants.mainViewBottomPadding),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    //MARK: Subject Image View Constraint
    func subjectImageViewConstraints() {
        NSLayoutConstraint.activate([
            subjectImageView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                                  constant: Constants.subjectImageViewTopPadding),
            subjectImageView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            subjectImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,
                                                      constant: Constants.subjectImageViewLeftPadding),
        ])
    }
    
    //MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                           constant: Constants.stackViewTopPadding),
            stackView.leadingAnchor.constraint(equalTo: subjectImageView.trailingAnchor,
                                               constant: Constants.stackViewLeftPadding),
            stackView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor,
                                              constant: Constants.stackViewBottomPadding)
        ])
    }
    
    //MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.leadingAnchor.constraint(greaterThanOrEqualTo: stackView.trailingAnchor,
                                                constant: Constants.nextButtonLeftPadding),
            nextButton.topAnchor.constraint(equalTo: mainView.topAnchor,
                                            constant: Constants.nextButtonTopPadding),
            nextButton.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,
                                                 constant: Constants.nextButtonRightPadding),
            nextButton.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: Constants.nextButtonWidthAnchor)
        ])
    }
}

//MARK: -Constants
private extension SubjectsTableViewCell {
    enum Constants {
        static let mainViewCornerRadius: CGFloat = 26
        static let desciptionLabelFont: CGFloat = 12
        static let titleLabelFont: CGFloat = 16
        static let descriptionLabelText = "აღწერა"
        static let subjectImageViewTopPadding: CGFloat = 22
        static let subjectImageViewLeftPadding: CGFloat = 30
        static let stackViewTopPadding: CGFloat = 33
        static let stackViewLeftPadding: CGFloat = 18
        static let stackViewBottomPadding: CGFloat = -34
        static let nextButtonLeftPadding: CGFloat = 27
        static let nextButtonTopPadding: CGFloat = 30
        static let nextButtonRightPadding: CGFloat = -30
        static let nextButtonWidthAnchor: CGFloat = 46
        static let mainViewBottomPadding: CGFloat = -10
    }
}
