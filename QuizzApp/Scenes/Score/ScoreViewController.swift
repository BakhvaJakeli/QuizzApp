//
//  ScoreViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class ScoreViewController: UIViewController {
    
    let scores: [SubjectScore] = [
//        SubjectScore(image: QuizzAppImage.georgraphy ?? UIImage(), title: "გეოგრაფია", score: 2),
//        SubjectScore(image: QuizzAppImage.georgraphy ?? UIImage(), title: "გეოგრაფია", score: 2),
//        SubjectScore(image: QuizzAppImage.georgraphy ?? UIImage(), title: "გეოგრაფია", score: 2),
//        SubjectScore(image: QuizzAppImage.georgraphy ?? UIImage(), title: "გეოგრაფია", score: 2),
    ]
    
    // MARK: Components    
    private let alertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.Alert.text)
        
        return view
    }()
    
    private let noScoreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Constants.NoScoreLabel.text
        label.font = Constants.NoScoreLabel.font
        label.textColor = .black
        label.numberOfLines = Constants.NoScoreLabel.numberOfLines
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var scoreTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.registerCell(ScoreTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.backgroundView = noScoreLabel
        checkScore(tableView.backgroundView)
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
                         action: #selector(didTapLogOut),
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
        navigationController?.navigationBar.topItem?.title = Constants.NavigationBar.title
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
    
    // MARK: Check Score
    func checkScore(_ backgroundView: UIView?) {
        guard let view = backgroundView else {return}
        if scores.count > 0 {
            view.isHidden = true
        }
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
                                                    constant: Constants.ScoreTableView.leftPadding)
        ])
    }
    
    // MARK: Separator View Constraints
    func separatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Constants.SeparatorView.leftPadding),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.SeparatorView.height)
        ])
    }
    
    // MARK: Log Out Button Constraints
    func logOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                              constant: Constants.LogOutButton.topPadding),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Constants.LogOutButton.rightPadding),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                 constant: Constants.LogOutButton.bottomPadding)
        ])
    }
    
    // MARK: Log Out
    @objc func didTapLogOut() {
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
        let cell: ScoreTableViewCell = tableView.dequeReusableCell(for: indexPath)
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
    func didTapYesOnLogout() {
        dismiss(animated: true)
    }
    
    func didTapNoOnLogOut() {
        navigationController?.isNavigationBarHidden = false
    }
}

// MARK: - Constants
private extension ScoreViewController {
    enum Constants {
        enum NavigationBar {
            static let title = "დაგროვილი ქულები ⭐"
        }
        enum SeparatorView {
            static let topPadding: CGFloat = 81
            static let leftPadding: CGFloat = 0
            static let height: CGFloat = 2
        }
        enum LogOutButton {
            static let topPadding: CGFloat = 12
            static let rightPadding: CGFloat = -16
            static let bottomPadding: CGFloat = -11
        }
        enum NoScoreLabel {
            static let text = "🧐 \nსამწუხაროდ,\nქულები ჯერ არ გაქვს \nდაგროვილი."
            static let font: UIFont = .myriaGeo(ofSize: 18)
            static let numberOfLines = 0
        }
        enum ScoreTableView {
            static let leftPadding: CGFloat = 16
        }
        enum Alert {
            static let text = "ნამდვილად გსურს გასვლა?"
        }
    }
}
