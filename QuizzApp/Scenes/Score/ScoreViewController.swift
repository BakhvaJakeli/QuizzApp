//
//  ScoreViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class ScoreViewController: UIViewController {
    
    let scores: [SubjectScore] = [
//        Score(image: QuizzAppImages.georgraphy ?? UIImage(), title: "გეოგრაფია", score: 2),
//        Score(image: QuizzAppImages.programming ?? UIImage(), title: "პროგრამირება", score: 4),
//        Score(image: QuizzAppImages.history ?? UIImage(), title: "ისტორია", score: 2),
//        Score(image: QuizzAppImages.physics ?? UIImage(), title: "ფიზიკა", score: 5),
    ]
    
    // MARK: Components    
    private let alertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.alert.alertTitleLabelText)
        
        return view
    }()
    
    private let noScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Constants.noScoreLabel.noScoreLabelText
        label.font = .systemFont(ofSize: Constants.noScoreLabel.noScoreLabelFont)
        label.textColor = .black
        label.numberOfLines = Constants.noScoreLabel.noScoreLabelNumberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var scoreTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ScoreTableViewCell.self,
                           forCellReuseIdentifier: ScoreTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundView = noScoreLabel
        
        return tableView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColor.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = QuizzAppColor.buttonColor
        configuration.image = QuizzAppImage.logOut
        configuration.cornerStyle = .capsule
        button.configuration = configuration
        button.addTarget(self,
                         action: #selector(logOut),
                         for: .touchUpInside)
        
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
private extension ScoreViewController {
    //MARK: Config UI
    func configUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.backItem?.title = ""
        navigationController?.navigationBar.topItem?.title = Constants.navigationBar.navigationTitle
        alertView.delegate = self
    }
    
    // MARK: Add Sub Views
    func addSubViews() {
        view.addSubview(scoreTableView)
        view.addSubview(separatorView)
        view.addSubview(logOutButton)
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        separatorViewConstraints()
        scoreTableViewConstraints()
        logOutButtonConstraints()
        noScoreLabelConstraints()
    }
    
    // MARK: No Score Label Constraints
    func noScoreLabelConstraints() {
        guard let tableBackground = scoreTableView.backgroundView else {return}
        NSLayoutConstraint.activate([
            tableBackground.centerYAnchor.constraint(equalTo: scoreTableView.centerYAnchor),
            tableBackground.centerXAnchor.constraint(equalTo: scoreTableView.centerXAnchor)
        ])
    }
    
    // MARK: Score Table View Constraints
    func scoreTableViewConstraints() {
        NSLayoutConstraint.activate([
            scoreTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scoreTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreTableView.bottomAnchor.constraint(equalTo: separatorView.topAnchor),
            scoreTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                    constant: Constants.scoreTableView.scoreTableViewLeftPadding)
        ])
    }
    
    // MARK: Separator View Constraints
    func separatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Constants.separatorView.separatorViewLeftPadding),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorView.separatorViewHeight)
        ])
    }
    
    // MARK: Log Out Button Constraints
    func logOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                              constant: Constants.logOutButton.logOutButtonTopPadding),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Constants.logOutButton.logOutButtonRightPadding),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                 constant: Constants.logOutButton.logOutButtonBottomPadding)
        ])
    }
    
    // MARK: Log Out
    @objc func logOut() {
        alertView.modalPresentationStyle = .overFullScreen
        present(alertView,
                animated: true)
    }
}

// MARK: - Table View Functions
extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScoreTableViewCell.identifier) as? ScoreTableViewCell else {return UITableViewCell()}
        let score = scores[indexPath.row]
        cell.configure(with: score)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        UITableView.automaticDimension
    }
}

// MARK: - Log Out Alert Delegate
extension ScoreViewController: logOutAlertDelegate {
    func pressedYesOnLogOut() {
        dismiss(animated: true)
    }
    
    func pressedNoOnLogOut() {
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Constants
private extension ScoreViewController {
    enum Constants {
        enum navigationBar {
            static let navigationTitle = "დაგროვილი ქულები ⭐"
        }
        enum separatorView {
            static let separatorViewTopPadding: CGFloat = 81
            static let separatorViewLeftPadding: CGFloat = 0
            static let separatorViewHeight: CGFloat = 2
        }
        enum logOutButton {
            static let logOutButtonTopPadding: CGFloat = 12
            static let logOutButtonRightPadding: CGFloat = -16
            static let logOutButtonBottomPadding: CGFloat = -11
        }
        enum noScoreLabel {
            static let noScoreLabelText = "🧐 \nსამწუხაროდ,\nქულები ჯერ არ გაქვს \nდაგროვილი."
            static let noScoreLabelFont: CGFloat = 18
            static let noScoreLabelNumberOfLines = 0
        }
        enum scoreTableView {
            static let scoreTableViewLeftPadding: CGFloat = 16
        }
        enum alert {
            static let alertTitleLabelText = "ნამდვილად გსურს გასვლა?"
        }
    }
}
