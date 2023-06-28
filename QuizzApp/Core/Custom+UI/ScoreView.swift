//
//  ScoreView.swift
//  QuizzApp
//
//  Created by bakhva  on 15.06.23.
//

import UIKit

protocol ScoreViewDelegate: AnyObject {
    func didTapScoreView()
}

final class ScoreView: UIView {
    
    weak var delegate: ScoreViewDelegate?
    
    // MARK: Components
    private let gpaLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: Constants.gpaLabel.gpaText)
        let initialAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBackground,
            .font: UIFont.systemFont(ofSize: Constants.gpaLabel.gpaLabelFont)
        ]
        let yellowBoldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: QuizzAppColor.buttonColor,
            .font: UIFont.boldSystemFont(ofSize: Constants.gpaLabel.gpaLabelFont)
        ]
        attributedString.addAttributes(initialAttributes,
                                       range: NSRange(location: Constants.gpaLabel.defaultAttributeLocation,
                                                      length: Constants.gpaLabel.defaultAttributeLength))
        attributedString.addAttributes(yellowBoldAttributes,
                                       range: NSRange(location: Constants.gpaLabel.defaultAttributeLength,
                                                      length: Constants.gpaLabel.gpaText.count - Constants.gpaLabel.defaultAttributeLength))
        label.attributedText = attributedString
        label.backgroundColor = QuizzAppColor.blueSecondaryLight
        label.layer.cornerRadius = Constants.gpaLabel.gpaLabelCornerRadius
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.detailLabel.detailLabelText
        label.font = .boldSystemFont(ofSize: Constants.detailLabel.detailLabelFont)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemBackground
        
        return label
    }()
    
    private let arrowImageVIew: UIImageView = {
        let imageView = UIImageView()
        imageView.image = QuizzAppImage.detailsArrow
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setConstraints()
        didTapView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Private Functions
private extension ScoreView {
    // MARK: Add SubViews
    func addViews() {
        addSubview(gpaLabel)
        addSubview(detailLabel)
        addSubview(arrowImageVIew)
    }
    
    // MARK: Add Constraints
    func setConstraints() {
        gpaLabelConstrints()
        detailsLabelConstraints()
        arrowImageConstraints()
    }
    
    // MARK: View Gesture
    func didTapView() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }
    
    // MARK: GPA Label Constraints
    func gpaLabelConstrints() {
        NSLayoutConstraint.activate([
            gpaLabel.topAnchor.constraint(equalTo: topAnchor,
                                          constant: Constants.gpaLabel.gpaLabelTopPadding),
            gpaLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: Constants.gpaLabel.gpaLabelLeftPadding),
            gpaLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gpaLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.gpaLabel.gpaLabelMaxWidth)
        ])
    }
    
    // MARK: Details Label Constraints
    func detailsLabelConstraints() {
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: topAnchor,
                                             constant: Constants.detailLabel.detailsLabelTopPadding),
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: Arrow Image Constraints
    func arrowImageConstraints() {
        NSLayoutConstraint.activate([
            arrowImageVIew.topAnchor.constraint(equalTo: topAnchor,
                                                constant: Constants.arrowImageView.arrowImageTopPadding),
            arrowImageVIew.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageVIew.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.arrowImageView.arrowImageRigtPadding),
            arrowImageVIew.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor,
                                                    constant: Constants.arrowImageView.arrowImageLeftPadding)
        ])
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        delegate?.didTapScoreView()
    }}

// MARK: - Constants
private extension ScoreView {
    enum Constants {
        enum gpaLabel {
            static let gpaText = "GPA - 4.0"
            static let gpaLabelCornerRadius: CGFloat = 15
            static let gpaLabelTopPadding: CGFloat = 20
            static let gpaLabelLeftPadding: CGFloat = 18
            static let gpaLabelMaxWidth: CGFloat = 82
            static let gpaLabelFont: CGFloat = 16
            static let defaultAttributeLocation = 0
            static let defaultAttributeLength = 6
        }
        enum detailLabel {
            static let detailLabelText = "დეტალურად"
            static let detailsLabelTopPadding: CGFloat = 28
            static let detailLabelFont: CGFloat = 12
        }
        enum arrowImageView {
            static let arrowImageTopPadding: CGFloat = 30
            static let arrowImageRigtPadding: CGFloat = 34
            static let arrowImageLeftPadding: CGFloat = 4
        }
    }
}
