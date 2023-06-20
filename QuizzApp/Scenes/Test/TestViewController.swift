//
//  TestViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 15.06.23.
//

import UIKit

final class TestViewController: UIViewController {
    
    let answers = [
        "Python",
        "Java",
        "C++",
        "Kotlin"
    ]
    
    //MARK: Components
    let alertView: LogOutAlert = {
        let view = LogOutAlert()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleText(Constants.alertTitleLabelText)
        
        return view
    }()
    
    private let testCoverImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = QuizzAppImages.testCover
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()

    private lazy var quitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.image = QuizzAppImages.xMark
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .clear
        button.configuration = configuration
        button.addTarget(self,
                         action: #selector(quit)
                         , for: .touchUpInside)
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.titleLabelFont)
        label.textColor = .black
        label.text = Constants.titleLabelText
        label.textAlignment = .center
        
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.questionLabelFont)
        label.text = Constants.questionLabelText
        label.numberOfLines = Constants.questionLabelNumberOfLines
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var questionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AnswerTableViewCell.self,
                           forCellReuseIdentifier: AnswerTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = QuizzAppColors.buttonColor
        configuration.title = Constants.nextButtonTitle
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        
        return button
    }()
    
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addSubViews()
        addConstraints()
    }
    
}

//MARK: -Private Functions
private extension TestViewController {
    //MARK: Config UI
    func configUI() {
        view.backgroundColor = .systemBackground
        alertView.delegate = self
    }
    
    //MARK: Add Sub Views
    func addSubViews() {
        view.addSubview(testCoverImageView)
        testCoverImageView.addSubview(quitButton)
        testCoverImageView.addSubview(titleLabel)
        testCoverImageView.addSubview(questionLabel)
        view.addSubview(questionsTableView)
        view.addSubview(nextButton)
    }
    
    //MARK: Add Constraints
    func addConstraints() {
        testCoverImageViewConstraints()
        quitButtonConstraints()
        titleLabelConstraints()
        questionLabelConstraints()
        questionsTableViewConstraints()
        nextButtonConstraints()
    }
    
    //MARK: Test Cover Image View Constraints
    func testCoverImageViewConstraints() {
        NSLayoutConstraint.activate([
            testCoverImageView.topAnchor.constraint(equalTo: view.topAnchor),
            testCoverImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            testCoverImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    //MARK: Quit Button Constraints
    func quitButtonConstraints() {
        NSLayoutConstraint.activate([
            quitButton.topAnchor.constraint(equalTo: testCoverImageView.topAnchor,
                                            constant: Constants.quitButtonTopPadding),
            quitButton.trailingAnchor.constraint(equalTo: testCoverImageView.trailingAnchor,
                                                 constant: Constants.quitButtonRightPadding)
        ])
    }
    
    //MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: testCoverImageView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: testCoverImageView.leadingAnchor,
                                                constant: Constants.titleLabelLeftPadding),
            titleLabel.topAnchor.constraint(equalTo: testCoverImageView.topAnchor,
                                            constant: Constants.titleLabelTopPadding)
        ])
    }
    
    //MARK: Question Label Constraints
    func questionLabelConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                               constant: Constants.quitButtonTopPadding),
            questionLabel.centerXAnchor.constraint(equalTo: testCoverImageView.centerXAnchor),
            questionLabel.leadingAnchor.constraint(equalTo: testCoverImageView.leadingAnchor,
                                                   constant: Constants.questionLabelLeftPadding),
            questionLabel.bottomAnchor.constraint(greaterThanOrEqualTo: testCoverImageView.bottomAnchor,
                                                  constant: Constants.questionLabelBottomPadding)
        ])
    }
    
    //MARK: Questions Table View Constraints
    func questionsTableViewConstraints() {
        NSLayoutConstraint.activate([
            questionsTableView.topAnchor.constraint(equalTo: testCoverImageView.bottomAnchor,
                                                    constant: Constants.questionsTableViewTopPadding),
            questionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.questionsTableViewLeftPadding)
        ])
    }
    
    //MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(equalTo: questionsTableView.bottomAnchor,
                                            constant: Constants.nextButtonTopPadding),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.nextButtonLeftPadding),
            nextButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: Constants.nextButtonBottomPadding),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.nextButtonHeight)
        ])
    }
    
    //MARK: Alert View Constraints
    func alertViewConstraints() {
        NSLayoutConstraint.activate([
            alertView.topAnchor.constraint(equalTo: view.topAnchor),
            alertView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            alertView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            alertView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    //MARK: Quit Action
    @objc func quit() {
        view.addSubview(alertView)
        alertViewConstraints()
        alertView.alpha = 0
        UIView.animate(withDuration: 0.3,
                       animations: {
            self.alertView.alpha = 1
        },completion: nil)
    }
}

//MARK: -Table View Functions
extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerTableViewCell.identifier) as? AnswerTableViewCell else {return UITableViewCell()}
        let answer = answers[indexPath.row]
        cell.configCell(with: answer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: -Alert View Delegate
extension TestViewController: logOutAlertProtocol {
    func pressYes() {
        navigationController?.popViewController(animated: true)
    }
    
    func pressNo() {
        alertView.removeFromSuperview()
    }
}

//MARK: -Constants
private extension TestViewController {
    enum Constants {
        static let titleLabelText = "პროგრამირება"
        static let titleLabelFont: CGFloat = 16
        static let questionLabelFont: CGFloat = 14
        static let questionLabelText = "რომელია ყველაზე პოპულარული პროგრამირების ენა?"
        static let questionLabelNumberOfLines = 0
        static let nextButtonTitle = "შემდეგი"
        static let quitButtonTopPadding: CGFloat = 54
        static let quitButtonRightPadding: CGFloat = -16
        static let titleLabelLeftPadding: CGFloat = 128
        static let titleLabelTopPadding: CGFloat = 52
        static let questionLabelTopPadding: CGFloat = 48
        static let questionLabelLeftPadding: CGFloat = 72
        static let questionLabelBottomPadding: CGFloat = -62
        static let questionsTableViewTopPadding: CGFloat = 74
        static let questionsTableViewLeftPadding: CGFloat = 16
        static let nextButtonTopPadding: CGFloat = 10
        static let nextButtonLeftPadding: CGFloat = 16
        static let nextButtonBottomPadding: CGFloat = -140
        static let nextButtonHeight: CGFloat = 60
        static let alertTitleLabelText = "ნამდვილად გსურს ქვიზის \nშეწყვეტა?"
    }
}
