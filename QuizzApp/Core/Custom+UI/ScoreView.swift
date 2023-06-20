//
//  ScoreView.swift
//  QuizzApp
//
//  Created by bakhva  on 15.06.23.
//

import Foundation
import UIKit

final class ScoreView: UIView {
    
    //MARK: Components
    private let gpaLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: Constants.gpaText)
        let initialAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBackground,
            .font: UIFont.systemFont(ofSize: Constants.gpaLabelFont)
        ]
        let yellowBoldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: QuizzAppColors.buttonColor,
            .font: UIFont.boldSystemFont(ofSize: Constants.gpaLabelFont)
        ]
        attributedString.addAttributes(initialAttributes,
                                       range: NSRange(location: 0,
                                                      length: 6))
        attributedString.addAttributes(yellowBoldAttributes,
                                       range: NSRange(location: 6,
                                                      length: Constants.gpaText.count - 6))
        label.attributedText = attributedString
        label.backgroundColor = QuizzAppColors.blueSecondaryLight
        label.layer.cornerRadius = Constants.gpaLabelCornerRadius
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.detailLabelText
        label.font = .boldSystemFont(ofSize: Constants.detailLabelFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        
        return label
    }()
    
    private let arrowImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.image = QuizzAppImages.detailsArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Functions
private extension ScoreView {
    //MARK: Add SubViews
    func addViews() {
        addSubview(gpaLabel)
        addSubview(detailLabel)
        addSubview(arrowImageVIew)
    }
    
    //MARK: Add Constraints
    func constraints() {
        gpaLabelConstrints()
        detailsLabelConstraints()
        arrowImageConstraints()
    }
    
    //MARK: GPA Label Constraints
    func gpaLabelConstrints() {
        NSLayoutConstraint.activate([
            gpaLabel.topAnchor.constraint(equalTo: topAnchor,
                                          constant: Constants.gpaLabelTopPadding),
            gpaLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: Constants.gpaLabelLeftPadding),
            gpaLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gpaLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.gpaLabelMaxWidth)
        ])
    }
    
    //MARK: Details Label Constraints
    func detailsLabelConstraints() {
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: topAnchor,
                                             constant: Constants.detailsLabelTopPadding),
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func arrowImageConstraints() {
        NSLayoutConstraint.activate([
            arrowImageVIew.topAnchor.constraint(equalTo: topAnchor,
                                                constant: Constants.arrowImageTopPadding),
            arrowImageVIew.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageVIew.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.arrowImageRigtPadding),
            arrowImageVIew.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor,
                                                    constant: Constants.arrowImageLeftPadding)
        ])
    }
}

private extension ScoreView {
    enum Constants {
        static let gpaText = "GPA - 4.0"
        static let gpaLabelCornerRadius: CGFloat = 15
        static let detailLabelText = "დეტალურად"
        static let gpaLabelTopPadding: CGFloat = 20
        static let gpaLabelLeftPadding: CGFloat = 18
        static let gpaLabelMaxWidth: CGFloat = 82
        static let detailsLabelTopPadding: CGFloat = 28
        static let arrowImageTopPadding: CGFloat = 30
        static let arrowImageRigtPadding: CGFloat = 34
        static let arrowImageLeftPadding: CGFloat = 4
        static let detailLabelFont: CGFloat = 12
        static let gpaLabelFont: CGFloat = 16
    }
}
