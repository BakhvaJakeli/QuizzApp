//
//  HomePageViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let subjects = [
        Subject(image: QuizzAppImage.georgraphy ?? UIImage(),
                title: "გეოგრაფია"),
        Subject(image: QuizzAppImage.programming ?? UIImage(),
                title: "პროგრამირება"),
        Subject(image: QuizzAppImage.history ?? UIImage(),
                title: "ისტორია"),
        Subject(image: QuizzAppImage.physics ?? UIImage(),
                title: "ფიზიკა"),
    ]
    
    // MARK: Components
    let alertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.alertTitle.alertTitleLabelText)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = QuizzAppColor.buttonColor
        label.text = Constants.titleLabel.titleLabelText
        label.font = .boldSystemFont(ofSize: Constants.titleLabel.titleLabelFont)
        
        return label
    }()
    
    private lazy var scoreView: ScoreView = {
        let view = ScoreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = QuizzAppColor.blueSecondaryDefault
        view.layer.cornerRadius = Constants.scoreView.scoreViewCornerRadius
        view.delegate = self
        
        return view
    }()
    
    private let chooseSubjectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: QuizzAppFont.myriadGeo, size: Constants.chooseLabel.chooseLabelFont)
        label.text = Constants.chooseLabel.chooseLabelText
        
        return label
    }()
    
    private lazy var subjectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCell(SubjectsTableViewCell.self)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.showsVerticalScrollIndicator = false
        
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
    
    // MARK: View Will Appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configUI()
    }
    
}

// MARK: - Private Functions
private extension HomeViewController {
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
    func setConstraints() {
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
                                            constant: Constants.titleLabel.titleLabelTopPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.titleLabel.titleLabelLeftPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.titleLabel.titleLabelHeight)
        ])
    }
    
    // MARK: Score View Constraints
    func scoreViewConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: Constants.scoreView.scoreViewTopPadding),
            scoreView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.scoreView.scoreViewLeftPadding)
        ])
    }
    
    // MARK: Choose Subject Label Constraints
    func chooseSubjectLabelConstraints() {
        NSLayoutConstraint.activate([
            chooseSubjectLabel.topAnchor.constraint(equalTo: scoreView.bottomAnchor,
                                                    constant: Constants.chooseSubjectLabel.chooseSubjectLabelTopPadding),
            chooseSubjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.chooseSubjectLabel.chooseSubjectLabelLeftPadding),
            chooseSubjectLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,
                                                         constant: Constants.chooseSubjectLabel.chooseSubjectLabelRightPadding)
        ])
    }
    
    // MARK: Subjects Table View Constraints
    func subjectsTableViewConstraints() {
        NSLayoutConstraint.activate([
            subjectsTableView.topAnchor.constraint(equalTo: chooseSubjectLabel.bottomAnchor,
                                                   constant: Constants.subjectsTableView.subjectsTableViewTopPadding),
            subjectsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subjectsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.subjectsTableView.subjectsTableViewLeftPadding),
        ])
    }
    
    // MARK: Separator View Constraints
    func separatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(lessThanOrEqualTo: subjectsTableView.bottomAnchor,
                                               constant: Constants.separatorView.separatorViewTopPadding),
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
    @objc func didTapLogOut() {
        alertView.modalPresentationStyle = .overFullScreen
        present(alertView,
                animated: true)
    }
}

// MARK: - Table View Functions
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubjectsTableViewCell = tableView.dequeReusableCell(for: indexPath)
        let subject = subjects[indexPath.row]
        cell.configure(with: subject)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        navigationController?.pushViewController(TestViewController(), animated: true)
    }
}

// MARK: - Alert View Delegate
extension HomeViewController: logOutAlertDelegate {
    func didTapYesOnLogout() {
        dismiss(animated: true)
    }
    
    func didTapNoOnLogOut() {
        alertView.dismiss(animated: true)
    }
}

// MARK: - Score View Delegate
extension HomeViewController: ScoreViewDelegate {
    func didTapScoreView() {
        navigationController?.pushViewController(ScoreViewController(),
                                                 animated: true)
    }
}

// MARK: - Constants
private extension HomeViewController {
    enum Constants {
        enum titleLabel {
            static let titleLabelText = "გამარჯობა, ირაკლი"
            static let titleLabelFont: CGFloat = 16
            static let titleLabelTopPadding: CGFloat = 8
            static let titleLabelLeftPadding: CGFloat = 16
            static let titleLabelHeight: CGFloat = 21
        }
        enum scoreView {
            static let scoreViewCornerRadius: CGFloat = 26
            static let scoreViewTopPadding: CGFloat = 20
            static let scoreViewLeftPadding: CGFloat = 16
        }
        enum chooseLabel {
            static let chooseLabelText = "აირჩიე საგანი"
            static let chooseLabelFont: CGFloat = 16
        }
        enum chooseSubjectLabel {
            static let chooseSubjectLabelTopPadding: CGFloat = 32
            static let chooseSubjectLabelLeftPadding: CGFloat = 16
            static let chooseSubjectLabelRightPadding: CGFloat = 253
        }
        enum subjectsTableView {
            static let subjectsTableViewTopPadding: CGFloat = 16
            static let subjectsTableViewLeftPadding: CGFloat = 16
        }
        enum separatorView {
            static let separatorViewTopPadding: CGFloat = 20
            static let separatorViewLeftPadding: CGFloat = 0
            static let separatorViewHeight: CGFloat = 2
        }
        enum logOutButton {
            static let logOutButtonTopPadding: CGFloat = 12
            static let logOutButtonRightPadding: CGFloat = -16
            static let logOutButtonBottomPadding: CGFloat = -11
        }
        enum alertTitle {
            static let alertTitleLabelText = "ნამდვილად გსურს გასვლა?"
        }
    }
}
