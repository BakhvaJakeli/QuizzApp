//
//  HomePageViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class HomePageViewController: UIViewController {
    
    let subjects = [
        Subject(image: QuizzAppImages.georgraphy ?? UIImage(),
                title: "გეოგრაფია"),
        Subject(image: QuizzAppImages.programming ?? UIImage(),
                title: "პროგრამირება"),
        Subject(image: QuizzAppImages.history ?? UIImage(),
                title: "ისტორია"),
        Subject(image: QuizzAppImages.physics ?? UIImage(),
                title: "ფიზიკა"),
    ]
    
    // MARK: Components
    let alertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.alertTitleLabelText)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = QuizzAppColors.buttonColor
        label.text = Constants.titleLabelText
        label.font = .boldSystemFont(ofSize: Constants.titleLabelFont)
        
        return label
    }()
    
    private lazy var scoreView: ScoreView = {
        let view = ScoreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = QuizzAppColors.blueSecondaryDefault
        view.layer.cornerRadius = Constants.scoreViewCornerRadius
        
        let tap = UITapGestureRecognizer(target: self,
                                         action: #selector(moveToScore))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private let chooseSubjectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: Constants.chooseLabelFont)
        label.text = Constants.chooseLabelText
        
        return label
    }()
    
    private lazy var subjectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SubjectsTableViewCell.self,
                           forCellReuseIdentifier: SubjectsTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
        return tableView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = QuizzAppColors.lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = QuizzAppColors.buttonColor
        configuration.image = QuizzAppImages.logOut
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
        addConstraints()
    }
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
}

// MARK: - Private Functions
private extension HomePageViewController {
    // MARK: Config UI
    func configUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        alertView.delegate = self
    }
    
    // MARK: Add Sub Views
    func addSubViews() {
        view.addSubview(titleLabel)
        view.addSubview(scoreView)
        view.addSubview(chooseSubjectLabel)
        view.addSubview(subjectsTableView)
        view.addSubview(separatorView)
        view.addSubview(logOutButton)
    }
    
    // MARK: Constraints
    func addConstraints() {
        titleLabelConstraints()
        scoreViewConstraints()
        chooseSubjectLabelConstraints()
        subjectsTableViewConstraints()
        separatorViewConstraints()
        logOutButtonConstraints()
    }
    
    // MARK: Title Label Constraints
    func titleLabelConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: Constants.titleLabelTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.titleLabelLeftPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabelHeight)
        ])
    }
    
    // MARK: Score View Constraints
    func scoreViewConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: Constants.scoreViewTopPadding),
            scoreView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.scoreViewLeftPadding)
        ])
    }
    
    // MARK: Choose Subject Label Constraints
    func chooseSubjectLabelConstraints() {
        NSLayoutConstraint.activate([
            chooseSubjectLabel.topAnchor.constraint(equalTo: scoreView.bottomAnchor,
                                                    constant: Constants.chooseSubjectLabelTopPadding),
            chooseSubjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.chooseSubjectLabelLeftPadding),
            chooseSubjectLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,
                                                         constant: Constants.chooseSubjectLabelRightPadding)
        ])
    }
    
    // MARK: Subjects Table View Constraints
    func subjectsTableViewConstraints() {
        NSLayoutConstraint.activate([
            subjectsTableView.topAnchor.constraint(equalTo: chooseSubjectLabel.bottomAnchor,
                                                   constant: Constants.subjectsTableViewTopPadding),
            subjectsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subjectsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.subjectsTableViewLeftPadding),
        ])
    }
    
    // MARK: Separator View Constraints
    func separatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(lessThanOrEqualTo: subjectsTableView.bottomAnchor,
                                               constant: Constants.separatorViewTopPadding),
            separatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            separatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                   constant: Constants.separatorViewLeftPadding),
            separatorView.heightAnchor.constraint(equalToConstant: Constants.separatorViewHeight)
        ])
    }
    
    // MARK: Log Out Button Constraints
    func logOutButtonConstraints() {
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor,
                                              constant: Constants.logOutButtonTopPadding),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                   constant: Constants.logOutButtonRightPadding),
            logOutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor,
                                                 constant: Constants.logOutButtonBottomPadding)
        ])
    }
    
    // MARK: Move To Score View Controller
    @objc func moveToScore() {
        let viewController = ScoreViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    // MARK: Log Out
    @objc func logOut() {
        alertView.modalPresentationStyle = .overFullScreen
        present(alertView, animated: true)
    }
}

// MARK: - Table View Functions
extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SubjectsTableViewCell.identifier) as? SubjectsTableViewCell else {return UITableViewCell()}
        let subject = subjects[indexPath.row]
        cell.configCell(with: subject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let viewController = TestViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: -Alert View Delegate
extension HomePageViewController: logOutAlertDelegate {
    func pressedYesOnLogOut() {
        dismiss(animated: true)
    }
    
    func pressedNoOnLogOut() {
        alertView.dismiss(animated: true)
    }
}

// MARK: - Constants
private extension HomePageViewController {
    enum Constants {
        static let titleLabelText = "გამარჯობა, ირაკლი"
        static let titleLabelFont: CGFloat = 16
        static let scoreViewCornerRadius: CGFloat = 26
        static let chooseLabelText = "აირჩიე საგანი"
        static let chooseLabelFont: CGFloat = 16
        static let titleLabelTopPadding: CGFloat = 8
        static let titleLabelLeftPadding: CGFloat = 16
        static let titleLabelHeight: CGFloat = 21
        static let scoreViewTopPadding: CGFloat = 20
        static let scoreViewLeftPadding: CGFloat = 16
        static let chooseSubjectLabelTopPadding: CGFloat = 32
        static let chooseSubjectLabelLeftPadding: CGFloat = 16
        static let chooseSubjectLabelRightPadding: CGFloat = 253
        static let subjectsTableViewTopPadding: CGFloat = 16
        static let subjectsTableViewLeftPadding: CGFloat = 16
        static let separatorViewTopPadding: CGFloat = 20
        static let separatorViewLeftPadding: CGFloat = 0
        static let separatorViewHeight: CGFloat = 2
        static let logOutButtonTopPadding: CGFloat = 12
        static let logOutButtonRightPadding: CGFloat = -16
        static let logOutButtonBottomPadding: CGFloat = -11
        static let alertTitleLabelText = "ნამდვილად გსურს გასვლა?"
    }
}
