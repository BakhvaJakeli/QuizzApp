//
//  UITableView+Extension.swift
//  QuizzApp
//
//  Created by Bakhva Jakeli on 28.06.23.
//

import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cellClass: T.Type) {
        let className = String(describing: cellClass)
        register(cellClass, forCellReuseIdentifier: className)
    }
    
    func dequeReusableCell<Cell: UITableViewCell>(for indexPath: IndexPath) -> Cell {
        let identifier = String(describing: Cell.self)
        guard let cell = dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? Cell else {return Cell()}
        return cell
    }
}
