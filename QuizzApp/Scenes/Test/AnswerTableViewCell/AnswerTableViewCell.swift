//
//  QuestionTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

final class AnswerTableViewCell: UITableViewCell {
        
    private var stackViewIsHidden: Bool = true
    
    // MARK: Components
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.MainView.cornerRadius
        view.backgroundColor = QuizzAppColor.cellViewColor
        
        return view
    }()
    
    let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = Constants.AnswerLabel.font
        
        return label
    }()
    
    private let pointLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Constants.PointLabel.font
        label.textColor = .systemBackground
        label.text = Constants.PointLabel.text
        
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.stackView.isHidden = true
        }
    }
    
    // MARK: Correct Answer Color Set
    func setCorrectAnswerColor() {
        mainView.backgroundColor = .green
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.mainView.backgroundColor = QuizzAppColor.cellViewColor
        }
    }
    
    // MARK: Incorrect Answer Color Set
    func setIncorrectAnswerColor() {
        mainView.backgroundColor = .red
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.mainView.backgroundColor = QuizzAppColor.cellViewColor
        }
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
                                          constant: Constants.MainView.bottomPadding),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -Constants.MainView.bottomPadding)
        ])
    }
    
    // MARK: Answer Label Constraints
    func answerLabelConstraints() {
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: mainView.topAnchor,
                                             constant: Constants.AnswerLabel.topPadding),
            answerLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,
                                                 constant: Constants.AnswerLabel.leftPadding)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: mainView.topAnchor,
                                           constant: Constants.StackView.topPadding),
            stackView.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            stackView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor,
                                                constant: Constants.StackView.rightPadding)
        ])
    }
}

// MARK: - Constants
private extension AnswerTableViewCell {
    enum Constants {
        enum MainView {
            static let cornerRadius: CGFloat = 22
            static let bottomPadding: CGFloat = 6
        }
        enum AnswerLabel {
            static let font: UIFont = .myriaGeo(ofSize: 14)
            static let topPadding: CGFloat = 22
            static let leftPadding: CGFloat = 30
        }
        enum PointLabel {
            static let font: UIFont = .myriaGeo(ofSize: 14)
            static let text = "+1"
        }
        enum StackView {
            static let topPadding: CGFloat = 22
            static let rightPadding: CGFloat = -20
        }
    }
}
