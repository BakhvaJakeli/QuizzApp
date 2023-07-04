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
        let attributedString = NSMutableAttributedString(string: Constants.GpaLabel.text)
        let initialAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.systemBackground,
//            .font: UIFont.systemFont(ofSize: Constants.GpaLabel.gpaLabelFont)
            .font: Constants.GpaLabel.defaultFont
        ]
        let yellowBoldAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: QuizzAppColor.buttonColor,
//            .font: UIFont.boldSystemFont(ofSize: Constants.GpaLabel.gpaLabelFont)
            .font: Constants.GpaLabel.boldFont
        ]
        attributedString.addAttributes(initialAttributes,
                                       range: NSRange(location: Constants.GpaLabel.defaultAttributeLocation,
                                                      length: Constants.GpaLabel.defaultAttributeLength))
        attributedString.addAttributes(yellowBoldAttributes,
                                       range: NSRange(location: Constants.GpaLabel.defaultAttributeLength,
                                                      length: Constants.GpaLabel.text.count - Constants.GpaLabel.defaultAttributeLength))
        label.attributedText = attributedString
        label.backgroundColor = QuizzAppColor.blueSecondaryLight
        label.layer.cornerRadius = Constants.GpaLabel.cornerRadius
        label.clipsToBounds = true
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let detailLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.DetailLabel.text
        label.font = Constants.DetailLabel.font
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
                                          constant: Constants.GpaLabel.topPadding),
            gpaLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                              constant: Constants.GpaLabel.leftPadding),
            gpaLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            gpaLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: Constants.GpaLabel.maxWidth)
        ])
    }
    
    // MARK: Details Label Constraints
    func detailsLabelConstraints() {
        NSLayoutConstraint.activate([
            detailLabel.topAnchor.constraint(equalTo: topAnchor,
                                             constant: Constants.DetailLabel.topPadding),
            detailLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    // MARK: Arrow Image Constraints
    func arrowImageConstraints() {
        NSLayoutConstraint.activate([
            arrowImageVIew.topAnchor.constraint(equalTo: topAnchor,
                                                constant: Constants.ArrowImageView.topPadding),
            arrowImageVIew.centerYAnchor.constraint(equalTo: centerYAnchor),
            arrowImageVIew.trailingAnchor.constraint(equalTo: trailingAnchor,
                                                     constant: -Constants.ArrowImageView.rigtPadding),
            arrowImageVIew.leadingAnchor.constraint(equalTo: detailLabel.trailingAnchor,
                                                    constant: Constants.ArrowImageView.leftPadding)
        ])
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        delegate?.didTapScoreView()
    }}

// MARK: - Constants
private extension ScoreView {
    enum Constants {
        enum GpaLabel {
            static let text = "GPA - 4.0"
            static let cornerRadius: CGFloat = 15
            static let topPadding: CGFloat = 20
            static let leftPadding: CGFloat = 18
            static let maxWidth: CGFloat = 82
            static let defaultFont: UIFont = .myriaGeo(ofSize: 16)
            static let boldFont: UIFont = .boldMyriadGeo(ofSize: 16)
            static let defaultAttributeLocation = 0
            static let defaultAttributeLength = 6
        }
        enum DetailLabel {
            static let text = "დეტალურად"
            static let topPadding: CGFloat = 28
            static let font: UIFont = .boldMyriadGeo(ofSize: 12)
        }
        enum ArrowImageView {
            static let topPadding: CGFloat = 30
            static let rigtPadding: CGFloat = 34
            static let leftPadding: CGFloat = 4
        }
    }
}
