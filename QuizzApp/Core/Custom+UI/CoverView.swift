//
//  LogInScreen.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class CoverView: UIView {
    
    // MARK: Components
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = Constants.Title.titleText
        label.font = Constants.Title.font
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let logInImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = QuizzAppImage.myFirstQuizzImage
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        addViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config UI
    private func configureUI() {
        backgroundColor = .clear
    }
    
    // MARK: Add Views
    private func addViews() {
        addSubview(title)
        addSubview(logInImageView)
    }
    
    // MARK: Add constraints
    private func setConstraints() {
        titleConstraints()
        logInImageConstraints()
    }
    
    // MARK: Title Constraints
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor,
                                       constant: Constants.Title.topPadding),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.bottomAnchor.constraint(equalTo: logInImageView.topAnchor,
                                          constant: Constants.Title.bottomPadding)
        ])
    }
    
    // MARK: Log In Image Constraints
    private func logInImageConstraints() {
        NSLayoutConstraint.activate([
            logInImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logInImageView.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                   constant: Constants.LogInImageView.bottomPadding)
        ])
    }
    
    // MARK: Bazier Path
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = rect.height / 2.5
        let path = UIBezierPath()
        
        // Top left corner (curved)
        path.move(to: CGPoint(x: rect.minX, y: rect.minY + cornerRadius))
        path.addArc(withCenter: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                    radius: cornerRadius,
                    startAngle: CGFloat.pi,
                    endAngle: CGFloat.pi * 1.5,
                    clockwise: true)
        
        // Fill the top left side with a darker blue color
        let topEdgePoint = CGPoint(x: rect.minX, y: rect.minY)
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.backgroundColor = QuizzAppColor.blueSecondaryDefault.cgColor
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = rect
        
        let maskLayer = CAShapeLayer()
        let maskPath = UIBezierPath()
        maskPath.move(to: topEdgePoint)
        maskPath.addArc(withCenter: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: CGFloat.pi,
                        endAngle: CGFloat.pi * 1.5,
                        clockwise: true)
        maskPath.close()
        maskLayer.path = maskPath.cgPath
        
        gradientLayer.mask = maskLayer
        
        layer.addSublayer(gradientLayer)
        
        // Top right corner (pointy)
        path.addLine(to: CGPoint(x: rect.maxY, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        
        // Bottom right corner (curved)
        path.addArc(withCenter: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                    radius: cornerRadius,
                    startAngle: 0,
                    endAngle: CGFloat.pi * 0.5,
                    clockwise: true)
        
        // Bottom left corner (pointy)
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        
        // Close the path
        path.close()
        
        // Set the fill color
        QuizzAppColor.blueSecondaryLight.setFill()
        path.fill()
    }
}

// MARK: - Constants
private extension CoverView {
    enum Constants {
        enum Title {
            static let font: UIFont = .boldMyriadGeo(ofSize: 20)
            static let topPadding: CGFloat = 121
            static let bottomPadding: CGFloat = -34
            static let titleText = "ჩემი პირველი ქვიზი"
        }
        enum LogInImageView{
            static let bottomPadding: CGFloat = -23
        }
    }
}
