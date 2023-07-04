//
//  UIFont+Extension.swift
//  QuizzApp
//
//  Created by Bakhva Jakeli on 04.07.23.
//

import UIKit

extension UIFont {
    static func myriaGeo(ofSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "myriad_geo", size: ofSize) else { return .systemFont(ofSize: ofSize) }
        
        return font
    }
    
    static func boldMyriadGeo(ofSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "MyriadGEO-Bold", size: ofSize) else { return .systemFont(ofSize: ofSize) }
        
        return font
    }
}
