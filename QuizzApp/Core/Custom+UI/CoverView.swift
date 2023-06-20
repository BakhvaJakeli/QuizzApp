//
//  LogInScreen.swift
//  QuizzApp
//
//  Created by bakhva  on 14.06.23.
//

import UIKit

final class CoverView: UIView {
    
    //MARK: Components
    private let title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.text = Constants.titleText
        label.font = .boldSystemFont(ofSize: Constants.titleFontSize)
        label.textColor = .white
        label.textAlignment = .center
        
        return label
    }()
    
    private let logInImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = QuizzAppImages.myFirstQuizzImage
        imageView.backgroundColor = .clear
        
        return imageView
    }()
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configUI()
        addViews()
        constraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Config UI
    private func configUI() {
        backgroundColor = .clear
    }
    
    //MARK: Add Views
    private func addViews() {
        addSubview(title)
        addSubview(logInImageView)
    }
    
    //MARK: Add constraints
    private func constraints() {
        titleConstraints()
        logInImageConstraints()
    }
    
    //MARK: Title Constraints
    private func titleConstraints() {
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: Constants.titleTopPadding),
            title.centerXAnchor.constraint(equalTo: centerXAnchor),
            title.bottomAnchor.constraint(equalTo: logInImageView.topAnchor, constant: Constants.titleBottomPadding)
        ])
    }
    
    // MARK: Log In Image Constraints
    private func logInImageConstraints() {
        NSLayoutConstraint.activate([
            logInImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logInImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.logInImageBottomPadding)
        ])
    }
    
    //MARK: Bazier Path
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let cornerRadius = rect.height / 2
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
        gradientLayer.backgroundColor = QuizzAppColors.blueSecondaryDefault.cgColor
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
        QuizzAppColors.blueSecondaryLight.setFill()
        path.fill()
    }
}

private extension CoverView {
    enum Constants {
        static let titleFontSize: CGFloat = 20
        static let titleTopPadding: CGFloat = 121
        static let titleBottomPadding: CGFloat = -34
        static let logInImageBottomPadding: CGFloat = -23
        static let titleText = "ჩემი პირველი ქვიზი"
    }
}
