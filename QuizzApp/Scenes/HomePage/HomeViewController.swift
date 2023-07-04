//
//  HomePageViewController.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class HomeViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    
    let subjects = [
        TestSubject(image: QuizzAppImage.georgraphy ?? UIImage(),
                title: "გეოგრაფია"),
        TestSubject(image: QuizzAppImage.programming ?? UIImage(),
                title: "პროგრამირება"),
        TestSubject(image: QuizzAppImage.history ?? UIImage(),
                title: "ისტორია"),
        TestSubject(image: QuizzAppImage.physics ?? UIImage(),
                title: "ფიზიკა"),
    ]
    
    // MARK: Components
    let alertView: LogOutAlertViewController = {
        let view = LogOutAlertViewController()
        view.setTitleText(Constants.AlertTitle.text)
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = QuizzAppColor.buttonColor
        label.text = Constants.TitleLabel.text
        label.font = Constants.TitleLabel.font
        
        return label
    }()
    
    private lazy var scoreView: ScoreView = {
        let view = ScoreView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = QuizzAppColor.blueSecondaryDefault
        view.layer.cornerRadius = Constants.ScoreView.cornerRadius
        view.delegate = self
        
        return view
    }()
    
    private let chooseSubjectLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = Constants.ChooseSubjectLabel.font
        label.text = Constants.ChooseSubjectLabel.text
        
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
        viewModel.getData()
        viewModel.reloadTableView = { [weak self] in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.subjectsTableView.reloadData()
            }
        }
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
                                            constant: Constants.TitleLabel.topPadding),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                constant: Constants.TitleLabel.leftPadding),
            titleLabel.heightAnchor.constraint(equalToConstant: Constants.TitleLabel.height)
        ])
    }
    
    // MARK: Score View Constraints
    func scoreViewConstraints() {
        NSLayoutConstraint.activate([
            scoreView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                           constant: Constants.ScoreView.topPadding),
            scoreView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scoreView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                               constant: Constants.ScoreView.leftPadding)
        ])
    }
    
    // MARK: Choose Subject Label Constraints
    func chooseSubjectLabelConstraints() {
        NSLayoutConstraint.activate([
            chooseSubjectLabel.topAnchor.constraint(equalTo: scoreView.bottomAnchor,
                                                    constant: Constants.ChooseSubjectLabel.topPadding),
            chooseSubjectLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: Constants.ChooseSubjectLabel.leftPadding),
            chooseSubjectLabel.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor,
                                                         constant: Constants.ChooseSubjectLabel.rightPadding)
        ])
    }
    
    // MARK: Subjects Table View Constraints
    func subjectsTableViewConstraints() {
        NSLayoutConstraint.activate([
            subjectsTableView.topAnchor.constraint(equalTo: chooseSubjectLabel.bottomAnchor,
                                                   constant: Constants.SubjectsTableView.topPadding),
            subjectsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subjectsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                       constant: Constants.SubjectsTableView.leftPadding),
        ])
    }
    
    // MARK: Separator View Constraints
    func separatorViewConstraints() {
        NSLayoutConstraint.activate([
            separatorView.topAnchor.constraint(lessThanOrEqualTo: subjectsTableView.bottomAnchor,
                                               constant: Constants.SeparatorView.topPadding),
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
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        subjects.count
        viewModel.subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SubjectsTableViewCell = tableView.dequeReusableCell(for: indexPath)
        let subject = viewModel.subjects[indexPath.row]
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
        enum TitleLabel {
            static let text = "გამარჯობა, ირაკლი"
            static let font: UIFont = .boldMyriadGeo(ofSize: 16)
            static let topPadding: CGFloat = 8
            static let leftPadding: CGFloat = 16
            static let height: CGFloat = 21
        }
        enum ScoreView {
            static let cornerRadius: CGFloat = 26
            static let topPadding: CGFloat = 20
            static let leftPadding: CGFloat = 16
        }
        enum ChooseSubjectLabel {
            static let text = "აირჩიე საგანი"
            static let font: UIFont = .myriaGeo(ofSize: 16)
            static let topPadding: CGFloat = 32
            static let leftPadding: CGFloat = 16
            static let rightPadding: CGFloat = 253
        }
        enum SubjectsTableView {
            static let topPadding: CGFloat = 16
            static let leftPadding: CGFloat = 16
        }
        enum SeparatorView {
            static let topPadding: CGFloat = 20
            static let leftPadding: CGFloat = 0
            static let height: CGFloat = 2
        }
        enum LogOutButton {
            static let topPadding: CGFloat = 12
            static let rightPadding: CGFloat = -16
            static let bottomPadding: CGFloat = -11
        }
        enum AlertTitle {
            static let text = "ნამდვილად გსურს გასვლა?"
        }
    }
}
