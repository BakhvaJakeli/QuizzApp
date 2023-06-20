//
//  QuestionTableViewCell.swift
//  QuizzApp
//
//  Created by bakhva  on 19.06.23.
//

import UIKit

final class AnswerTableViewCell: UITableViewCell {
    
    static let identifier = "AnswerTableViewCell"
    
    //MARK: Components
    private let mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = Constants.mainViewCornerRadius
        view.backgroundColor = QuizzAppColors.cellViewColor
        
        return view
    }()
    
    private let answerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: Constants.answerLabelFont)
        
        return label
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
    
    func configCell(with answer: String) {
        answerLabel.text = answer
    }
    
}

//MARK: -Private Functions
private extension AnswerTableViewCell {
    //MARK: Add Sub Views
    func addViews() {
        contentView.addSubview(mainView)
        mainView.addSubview(answerLabel)
    }
    
    //MARK: Add Constraints
    func constraints() {
        mainViewConstraints()
        answerLabelConstraints()
    }
    
    //MARK: Main View Constraints
    func mainViewConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                          constant: Constants.mainViewBottomPadding),
            mainView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                             constant: -Constants.mainViewBottomPadding)
        ])
    }
    
    func answerLabelConstraints() {
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: mainView.topAnchor,
                                             constant: Constants.answerLabelTopPadding),
            answerLabel.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            answerLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor,
                                                 constant: Constants.answerLabelLeftPadding)
        ])
    }
}

//MARK: -Constants
private extension AnswerTableViewCell {
    enum Constants {
        static let mainViewCornerRadius: CGFloat = 22
        static let answerLabelFont: CGFloat = 14
        static let mainViewBottomPadding: CGFloat = 6
        static let answerLabelTopPadding: CGFloat = 22
        static let answerLabelLeftPadding: CGFloat = 30
    }
}
