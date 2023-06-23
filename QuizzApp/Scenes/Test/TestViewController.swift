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
        progressView.updateProgessBar(count: 8, total: 10)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    private let completionVC = CompletionAlertViewController()
    
    private let logOutAlertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.alertTitleLabelText)
        
        return view
    }()
    
    private let questionView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColors.questionBackgroundColor
        view.layer.cornerRadius = Constants.questionViewRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
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
    
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        addSubViews()
        addConstraints()
    }
    
}

// MARK: -Private Functions
private extension TestViewController {
    // MARK: Config UI
    func configUI() {
        view.backgroundColor = .systemBackground
        logOutAlertView.delegate = self
        completionVC.delegate = self
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
    func addConstraints() {
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
                                            constant: Constants.quitButtonTopPadding),
            quitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: Constants.quitButtonRightPadding)
        ])
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.titleLabelLeftPadding),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.titleLabelTopPadding)
        ])
    }
    
    // MARK: Score Progress View Constraints
    func scoreProgressViewConstraints() {
        NSLayoutConstraint.activate([
            scoreProgressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                   constant: Constants.scoreProgressViewTopPadding),
            scoreProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.scoreProgressViewLeftPadding)
        ])
    }
    
    // MARK: Question View Constraints
    func questionViewConstraints() {
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: scoreProgressView.bottomAnchor,
                                              constant: Constants.questionViewTopPadding),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.questionViewLeftPadding),
            questionView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    // MARK: Question Label Constraints
    func questionLabelConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: questionView.centerYAnchor),
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor,
                                               constant: Constants.questionLabelTopPadding),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor,
                                                   constant: Constants.questionLabelLeftPadding)
        ])
    }
    
    // MARK: Questions Table View Constraints
    func questionsTableViewConstraints() {
        NSLayoutConstraint.activate([
            questionsTableView.topAnchor.constraint(equalTo: questionView.bottomAnchor,
                                                    constant: Constants.questionsTableViewTopPadding),
            questionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.questionsTableViewLeftPadding)
        ])
    }
    
    // MARK: Next Button Constraints
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
    
    func showFinishedQuizzAlert() {
        completionVC.modalPresentationStyle = .overFullScreen
        present(completionVC, animated: true)
    }
    
    // MARK: Quit Action
    @objc func quit() {
        logOutAlertView.modalPresentationStyle = .overFullScreen
        present(logOutAlertView, animated: true)
    }
}

// MARK: -Table View Functions
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AnswerTableViewCell else {return}
        if indexPath.row == 2 {
            cell.correctAnswerSelected()
            cell.setCorrectAnswerColor()
        } else {
            cell.setIncorrectAnswerColor()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(Constants.delayForCompletionAlert)) {[weak self] in
            guard let self = self else {return}
            self.showFinishedQuizzAlert()
        }
    }
}

// MARK: -Log out Alert View Delegate
extension TestViewController: logOutAlertDelegate {
    func pressedYesOnLogOut() {
        navigationController?.popViewController(animated: true)
    }
    
    func pressedNoOnLogOut() {
        logOutAlertView.dismiss(animated: true)
    }
}

// MARK: -Completion Alert View Delegate
extension TestViewController: CompletionAlertDelegate {
    func pressedCloseOnCompletion() {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: -Constants
private extension TestViewController {
    enum Constants {
        static let titleLabelText = "პროგრამირება"
        static let titleLabelFont: CGFloat = 16
        static let questionLabelFont: CGFloat = 14
        static let questionLabelText = "რომელია ყველაზე პოპულარული პროგრამირების ენა?"
        static let questionLabelNumberOfLines = 0
        static let nextButtonTitle = "შემდეგი"
        static let quitButtonTopPadding: CGFloat = 6
        static let quitButtonRightPadding: CGFloat = -16
        static let titleLabelLeftPadding: CGFloat = 128
        static let titleLabelTopPadding: CGFloat = 8
        static let scoreProgressViewTopPadding: CGFloat = 16
        static let scoreProgressViewLeftPadding: CGFloat = 16
        static let questionViewTopPadding: CGFloat = 32
        static let questionViewLeftPadding: CGFloat = 16
        static let questionLabelTopPadding: CGFloat = 34
        static let questionLabelLeftPadding: CGFloat = 56
        static let questionsTableViewTopPadding: CGFloat = 58
        static let questionsTableViewLeftPadding: CGFloat = 16
        static let nextButtonTopPadding: CGFloat = 10
        static let nextButtonLeftPadding: CGFloat = 16
        static let nextButtonBottomPadding: CGFloat = -115
        static let nextButtonHeight: CGFloat = 60
        static let alertTitleLabelText = "ნამდვილად გსურს ქვიზის \nშეწყვეტა?"
        static let comletionAlertAnimationDuration: CGFloat = 1
        static let logOutAlertAnimationDuration: CGFloat = 0.3
        static let delayForCompletionAlert = 1
        static let questionViewRadius: CGFloat = 26
    }
}
