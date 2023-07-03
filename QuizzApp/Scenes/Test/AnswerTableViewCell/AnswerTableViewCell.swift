//
//  QuestionTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

final class AnswerTableViewCell: UITableViewCell {
    
    static let identifier = String(describing: AnswerTableViewCell.self)
    
    private var stackViewIsHidden: Bool = true
    
    // MARK: Components
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.mainView.mainViewCornerRadius
        view.backgroundColor = QuizzAppColor.cellViewColor
        
        return view
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.answerLabel.answerLabelFont)
        
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: QuizzAppFont.myriadGeo, size: Constants.pointLabel.pointLabelFont)
        label.textColor = .systemBackground
        label.text = Constants.pointLabel.pointLabelText
        
        return label
    }()
    
    private let starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = QuizzAppImage.star
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isHidden = true
        
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
    func configure(with answer: String) {
        answerLabel.text = answer
    }
    
    // MARK: Point gets added
    func correctAnswerSelected() {
        stackView.isHidden = false
    }
    
    // MARK: Correct Answer Color Set
    func setCorrectAnswerColor() {
        mainView.backgroundColor = .green
    }
    
    // MARK: Incorrect Answer Color Set
    func setIncorrectAnswerColor() {
        mainView.backgroundColor = .red
    }
}

// MARK: - Private Functions
private extension AnswerTableViewCell {
    // MARK: Add Sub Views
    func addViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(answerLabel)
        stackView.addArrangedSubview(pointLabel)
        stackView.addArrangedSubview(starImageView)
        mainView.addSubview(stackView)
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        mainViewConstraints()
        answerLabelConstraints()
        stackViewConstraints()
    }
    
    // MARK: Main View Constraints
    func mainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Constants.mainView.mainViewBottomPadding),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -Constants.mainView.mainViewBottomPadding)
        ])
    }
    
    // MARK: Answer Label Constraints
    func answerLabelConstraints() {
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: mainView.topAnchor,
                                             constant: Constants.answerLabel.answerLabelTopPadding),
            answerLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,
                                                 constant: Constants.answerLabel.answerLabelLeftPadding)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                           constant: Constants.stackView.stackViewTopPadding),
            stackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,
                                                constant: Constants.stackView.stackViewRightPadding)
        ])
    }
}

// MARK: - Constants
private extension AnswerTableViewCell {
    enum Constants {
        enum mainView {
            static let mainViewCornerRadius: CGFloat = 22
            static let mainViewBottomPadding: CGFloat = 6
        }
        enum answerLabel {
            static let answerLabelFont: CGFloat = 14
            static let answerLabelTopPadding: CGFloat = 22
            static let answerLabelLeftPadding: CGFloat = 30
        }
        enum pointLabel {
            static let pointLabelFont: CGFloat = 14
            static let pointLabelText = "+1"
        }
        enum stackView {
            static let stackViewTopPadding: CGFloat = 22
            static let stackViewRightPadding: CGFloat = -20
        }
    }
}
