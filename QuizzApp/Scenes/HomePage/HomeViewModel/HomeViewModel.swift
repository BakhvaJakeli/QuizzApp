//
//  HomeViewModel.swift
//  QuizzApp
//
//  Created by Bakhva Jakeli on 04.07.23.
//

import Foundation

final class HomeViewModel {
    
    private (set) var subjects = [Subject]() {
        didSet {
            reloadTableView?()
        }
    }
    
    var reloadTableView:(() -> ())?
    
    func getData() {
        SubjectManager.shared.fetchQuestions { [weak self] data in
            guard let self = self else { return }
            self.subjects = data
        }
    }
    
}
