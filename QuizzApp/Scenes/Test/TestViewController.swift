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
    
    // MARK: Components
    private let scoreProgressView: ScoreProgressBarView = {
        let progressView = ScoreProgressBarView()
        progressView.updateProgessBar(count: 8,
                                      total: 10)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    private let completionViewController = CompletionAlertViewController()
    
    private let logOutAlertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.logOutAlert.alertTitleLabelText)
        
        return view
    }()
    
    private let questionView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColor.questionBackgroundColor
        view.layer.cornerRadius = Constants.questionView.questionViewRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var quitButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.image = QuizzAppImage.xMark
        configuration.cornerStyle = .capsule
        configuration.baseBackgroundColor = .clear
        button.configuration = configuration
        button.addTarget(self,
                         action: #selector(didTapQuit),
                         for: .touchUpInside)
        
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: Constants.titleLabel.titleLabelFont)
        label.textColor = .black
        label.text = Constants.titleLabel.titleLabelText
        label.textAlignment = .center
        
        return label
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.questionLabel.questionLabelFont)
        label.text = Constants.questionLabel.questionLabelText
        label.numberOfLines = Constants.questionLabel.questionLabelNumberOfLines
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var questionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.registerCell(AnswerTableViewCell.self)
        
        return tableView
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = QuizzAppColor.buttonColor
        configuration.title = Constants.nextButton.nextButtonTitle
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        
        return button
    }()
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addSubViews()
        setConstraints()
    }
    
}

// MARK: - Private Functions
private extension TestViewController {
    // MARK: Config UI
    func configUI() {
        view.backgroundColor = .systemBackground
        logOutAlertView.delegate = self
        completionViewController.delegate = self
    }
    
    // MARK: Add Sub Views
    func addSubViews() {
        view.addSubview(quitButton)
        view.addSubview(titleLabel)
        view.addSubview(scoreProgressView)
        view.addSubview(questionView)
        questionView.addSubview(questionLabel)
        view.addSubview(questionsTableView)
        view.addSubview(nextButton)
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        quitButtonConstraints()
        titleLabelConstraints()
        scoreProgressViewConstraints()
        questionViewConstraints()
        questionLabelConstraints()
        questionsTableViewConstraints()
        nextButtonConstraints()
    }
    
    // MARK: Quit Button Constraints
    func quitButtonConstraints() {
        NSLayoutConstraint.activate([
            quitButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.quitButton.quitButtonTopPadding),
            quitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: Constants.quitButton.quitButtonRightPadding)
        ])
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.titleLabel.titleLabelLeftPadding),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.titleLabel.titleLabelTopPadding)
        ])
    }
    
    // MARK: Score Progress View Constraints
    func scoreProgressViewConstraints() {
        NSLayoutConstraint.activate([
            scoreProgressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                   constant: Constants.scoreProgressView.scoreProgressViewTopPadding),
            scoreProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.scoreProgressView.scoreProgressViewLeftPadding)
        ])
    }
    
    // MARK: Question View Constraints
    func questionViewConstraints() {
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: scoreProgressView.bottomAnchor,
                                              constant: Constants.questionView.questionViewTopPadding),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.questionView.questionViewLeftPadding),
            questionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionView.bottomAnchor.constraint(greaterThanOrEqualTo: questionsTableView.topAnchor,
                                                 constant: -Constants.questionTableView.questionTableViewTopPadding)
        ])
    }
    
    // MARK: Question Label Constraints
    func questionLabelConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: questionView.centerYAnchor),
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor,
                                               constant: Constants.questionLabel.questionLabelTopPadding),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor,
                                                   constant: Constants.questionLabel.questionLabelLeftPadding)
        ])
    }
    
    // MARK: Questions Table View Constraints
    func questionsTableViewConstraints() {
        NSLayoutConstraint.activate([
            questionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.questionTableView.questionsTableViewLeftPadding),
            questionsTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: 300)
        ])
    }
    
    // MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: questionsTableView.bottomAnchor,
                                            constant: Constants.nextButton.nextButtonTopPadding),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.nextButton.nextButtonLeftPadding),
            nextButton.bottomAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: Constants.nextButton.nextButtonBottomPadding),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.nextButton.nextButtonHeight)
        ])
    }
    
    func showFinishedQuizzAlert() {
        completionViewController.modalPresentationStyle = .overFullScreen
        present(completionViewController, animated: true)
    }
    
    // MARK: Quit Action
    @objc func didTapQuit() {
        logOutAlertView.modalPresentationStyle = .overFullScreen
        present(logOutAlertView, animated: true)
    }
}

// MARK: - Table View Functions
extension TestViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnswerTableViewCell = tableView.dequeReusableCell(for: indexPath)
        let answer = answers[indexPath.row]
        cell.configure(with: answer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AnswerTableViewCell else {return}
        tableView.allowsSelection = false
        if indexPath.row == 2 {
            cell.correctAnswerSelected()
            cell.setCorrectAnswerColor()
        } else {
            cell.setIncorrectAnswerColor()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(Constants.completionAlert.delayForCompletionAlert)) {[weak self] in
            guard let self = self else {return}
            self.showFinishedQuizzAlert()
            tableView.allowsSelection = true
        }
    }
}

// MARK: - Log out Alert View Delegate
extension TestViewController: logOutAlertDelegate {
    func didTapYesOnLogout() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapNoOnLogOut() {
        logOutAlertView.dismiss(animated: true)
    }
}

// MARK: - Completion Alert View Delegate
extension TestViewController: CompletionAlertDelegate {
    func didTapNoOnCompletion() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - Constants
private extension TestViewController {
    enum Constants {
        enum titleLabel {
            static let titleLabelText = "პროგრამირება"
            static let titleLabelFont: CGFloat = 16
            static let titleLabelLeftPadding: CGFloat = 128
            static let titleLabelTopPadding: CGFloat = 8
        }
        enum questionLabel {
            static let questionLabelFont: CGFloat = 14
            static let questionLabelText = "რომელია ყველაზე პოპულარული პროგრამირების ენა?"
            static let questionLabelNumberOfLines = 0
            static let questionLabelTopPadding: CGFloat = 34
            static let questionLabelLeftPadding: CGFloat = 56
        }
        enum nextButton {
            static let nextButtonTitle = "შემდეგი"
            static let nextButtonTopPadding: CGFloat = 10
            static let nextButtonLeftPadding: CGFloat = 16
            static let nextButtonBottomPadding: CGFloat = -115
            static let nextButtonHeight: CGFloat = 60
        }
        enum quitButton {
            static let quitButtonTopPadding: CGFloat = 6
            static let quitButtonRightPadding: CGFloat = -16
        }
        enum scoreProgressView {
            static let scoreProgressViewTopPadding: CGFloat = 16
            static let scoreProgressViewLeftPadding: CGFloat = 16
        }
        enum questionView {
            static let questionViewTopPadding: CGFloat = 32
            static let questionViewLeftPadding: CGFloat = 16
            static let questionViewRadius: CGFloat = 26
        }
        enum questionTableView {
            static let questionsTableViewLeftPadding: CGFloat = 16
            static let questionTableViewTopPadding: CGFloat = 58
        }
        enum logOutAlert {
            static let alertTitleLabelText = "ნამდვილად გსურს ქვიზის \nშეწყვეტა?"
            static let logOutAlertAnimationDuration: CGFloat = 0.3
        }
        enum completionAlert {
            static let comletionAlertAnimationDuration: CGFloat = 1
            static let delayForCompletionAlert = 1
        }
    }
}
