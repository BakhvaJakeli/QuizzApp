//
//  TestViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 15.06.23.
//

import UIKit

final class TestViewController: UIViewController {
    
    private var questionNumber = 0
        
    private let subject: Subject
    
    // MARK: Components
    private lazy var scoreProgressView: ScoreProgressBarView = {
        let progressView = ScoreProgressBarView()
        progressView.updateProgessBar(count: questionNumber,
                                      total: subject.questionsCount)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    private let completionViewController = CompletionAlertViewController()
    
    private let logOutAlertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.LogOutAlert.text)
        
        return view
    }()
    
    private let questionView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColor.questionBackgroundColor
        view.layer.cornerRadius = Constants.QuestionView.radius
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
        label.font = Constants.TitleLabel.font
        label.textColor = .black
        label.text = Constants.TitleLabel.text
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.QuestionLabel.font
//        label.text = Constants.QuestionLabel.text
        label.text = subject.questions[questionNumber].questionTitle
        label.numberOfLines = Constants.QuestionLabel.numberOfLines
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
        configuration.title = Constants.NextButton.title
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
    
    // MARK: Init
    init(subject: Subject) {
        self.subject = subject
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
                                            constant: Constants.QuitButton.topPadding),
            quitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                 constant: Constants.QuitButton.rightPadding)
        ])
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: Constants.TitleLabel.leftPadding),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.TitleLabel.topPadding)
        ])
    }
    
    // MARK: Score Progress View Constraints
    func scoreProgressViewConstraints() {
        NSLayoutConstraint.activate([
            scoreProgressView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                                   constant: Constants.ScoreProgressView.topPadding),
            scoreProgressView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreProgressView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.ScoreProgressView.leftPadding)
        ])
    }
    
    // MARK: Question View Constraints
    func questionViewConstraints() {
        NSLayoutConstraint.activate([
            questionView.topAnchor.constraint(equalTo: scoreProgressView.bottomAnchor,
                                              constant: Constants.QuestionView.topPadding),
            questionView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                  constant: Constants.QuestionView.leftPadding),
            questionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionView.bottomAnchor.constraint(greaterThanOrEqualTo: questionsTableView.topAnchor,
                                                 constant: -Constants.QuestionTableView.topPadding)
        ])
    }
    
    // MARK: Question Label Constraints
    func questionLabelConstraints() {
        NSLayoutConstraint.activate([
            questionLabel.centerXAnchor.constraint(equalTo: questionView.centerXAnchor),
            questionLabel.centerYAnchor.constraint(equalTo: questionView.centerYAnchor),
            questionLabel.topAnchor.constraint(equalTo: questionView.topAnchor,
                                               constant: Constants.QuestionLabel.topPadding),
            questionLabel.leadingAnchor.constraint(equalTo: questionView.leadingAnchor,
                                                   constant: Constants.QuestionLabel.leftPadding)
        ])
    }
    
    // MARK: Questions Table View Constraints
    func questionsTableViewConstraints() {
        NSLayoutConstraint.activate([
            questionsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            questionsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.QuestionTableView.leftPadding),
            questionsTableView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.QuestionTableView.height)
        ])
    }
    
    // MARK: Next Button Constraints
    func nextButtonConstraints() {
        NSLayoutConstraint.activate([
            nextButton.topAnchor.constraint(greaterThanOrEqualTo: questionsTableView.bottomAnchor,
                                            constant: Constants.NextButton.topPadding),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.NextButton.leftPadding),
            nextButton.heightAnchor.constraint(equalToConstant: Constants.NextButton.nextButtonHeight),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(lessThanOrEqualTo: nextButton.bottomAnchor,
                                                             constant: -Constants.NextButton.nextButtonBottomPadding),
            nextButton.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor,
                                              constant: -10)
        ])
    }
    
    func showFinishedQuizzAlert() {
        completionViewController.modalPresentationStyle = .overFullScreen
        present(completionViewController, animated: true)
    }
    
    func didAnswerQuestion() {
        if questionNumber < subject.questionsCount - 1 {
            questionNumber += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
                guard let self = self else {return}
                self.questionLabel.text = subject.questions[questionNumber].questionTitle
            }
        } else {
            questionNumber = 0
        }
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
        subject.questions[questionNumber].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: AnswerTableViewCell = tableView.dequeReusableCell(for: indexPath)
        let answer = subject.questions[questionNumber].answers[indexPath.row]
        cell.configure(with: answer)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AnswerTableViewCell else {return}
        tableView.allowsSelection = false
        if cell.answerLabel.text == subject.questions[questionNumber].correctAnswer {
            cell.correctAnswerSelected()
            cell.setCorrectAnswerColor()
        } else {
            cell.setIncorrectAnswerColor()
        }
        didAnswerQuestion()
        DispatchQueue.main.asyncAfter(deadline: .now() + TimeInterval(Constants.CompletionAlert.delay)) {
//            guard let self = self else {return}
//            self.showFinishedQuizzAlert()
            tableView.reloadData()
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
        enum TitleLabel {
            static let text = "პროგრამირება"
            static let font: UIFont = .boldMyriadGeo(ofSize: 16)
            static let leftPadding: CGFloat = 128
            static let topPadding: CGFloat = 10
        }
        enum QuestionLabel {
            static let font: UIFont = .myriaGeo(ofSize: 14)
            static let text = "რომელია ყველაზე?"
            static let numberOfLines = 0
            static let topPadding: CGFloat = 34
            static let leftPadding: CGFloat = 56
        }
        enum NextButton {
            static let title = "შემდეგი"
            static let topPadding: CGFloat = 10
            static let leftPadding: CGFloat = 16
            static let nextButtonBottomPadding: CGFloat = -115
            static let nextButtonHeight: CGFloat = 60
        }
        enum QuitButton {
            static let topPadding: CGFloat = 0
            static let rightPadding: CGFloat = -16
        }
        enum ScoreProgressView {
            static let topPadding: CGFloat = 16
            static let leftPadding: CGFloat = 16
        }
        enum QuestionView {
            static let topPadding: CGFloat = 32
            static let leftPadding: CGFloat = 16
            static let radius: CGFloat = 26
        }
        enum QuestionTableView {
            static let leftPadding: CGFloat = 16
            static let topPadding: CGFloat = 58
            static let height: CGFloat = 300
        }
        enum LogOutAlert {
            static let text = "ნამდვილად გსურს ქვიზის \nშეწყვეტა?"
            static let animationDuration: CGFloat = 0.3
        }
        enum CompletionAlert {
            static let alertAnimationDuration: CGFloat = 1
            static let delay = 1
        }
    }
}
