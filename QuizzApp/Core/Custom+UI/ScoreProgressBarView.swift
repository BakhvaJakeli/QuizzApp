//
//  ScoreProgressBarView.swift
//  QuizzApp
//
//  Created by Bakhva Jakeli on 23.06.23.
//

import UIKit

final class ScoreProgressBarView: UIView {
    
    // MARK: Components
    private let onGoingLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.OnGoingLabel.text
        label.font = Constants.OnGoingLabel.font
        label.textColor = QuizzAppColor.buttonColor
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let onGoingScoreLabel: UILabel = {
        let labal = UILabel()
        labal.font = Constants.OnGoingScoreLabel.font
        labal.textColor = QuizzAppColor.buttonColor
        labal.text = Constants.OnGoingScoreLabel.text
        
        return labal
    }()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = Constants.CountLabel.font
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let progressBar: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressTintColor = QuizzAppColor.progressBarColor
        progressView.translatesAutoresizingMaskIntoConstraints = false
        
        return progressView
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [onGoingLabel, onGoingScoreLabel])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateProgessBar(count: Int, total: Int) {
        let progress = Float(count) / Float(total)
        progressBar.progress = progress
        countLabel.text = "\(count)/\(total)"
    }
}

// MARK: - Private Functions
private extension ScoreProgressBarView {
    // MARK: Add Sub Views
    func addViews() {
        addSubview(countLabel)
        addSubview(stackView)
        addSubview(progressBar)
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        countLabelConstraints()
        stackViewConstraints()
        progressBarConstraints()
    }
    
    // MARK: Count Label Constraints
    func countLabelConstraints() {
        NSLayoutConstraint.activate([
            countLabel.topAnchor.constraint(equalTo: topAnchor),
            countLabel.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
    
    // MARK: Stack View Constraints
    func stackViewConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARK: Progress Bar Constraints
    func progressBarConstraints() {
        NSLayoutConstraint.activate([
            progressBar.topAnchor.constraint(equalTo: countLabel.bottomAnchor,
                                             constant: Constants.ProgressBar.topPadding),
            progressBar.topAnchor.constraint(equalTo: stackView.bottomAnchor,
                                             constant: Constants.ProgressBar.topPadding),
            progressBar.centerXAnchor.constraint(equalTo: centerXAnchor),
            progressBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            progressBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            progressBar.heightAnchor.constraint(equalToConstant: Constants.ProgressBar.height)
        ])
    }
}

// MARK: - Constants
private extension ScoreProgressBarView {
    enum Constants {
        enum OnGoingScoreLabel {
            static let text = "1 ★"
            static let font: UIFont = .boldMyriadGeo(ofSize: 12)
        }
        enum OnGoingLabel {
            static let text = "მიმდინარე ქულა:"
            static let font: UIFont = .myriaGeo(ofSize: 12)
        }
        enum CountLabel {
            static let font: UIFont = .boldMyriadGeo(ofSize: 14)
        }
        enum ProgressBar {
            static let topPadding: CGFloat = 6
            static let height: CGFloat = 9
        }
    }
}
