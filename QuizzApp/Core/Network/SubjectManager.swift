//
//  SubjectManager.swift
//  QuizzApp
//
//  Created by Bakhva Jakeli on 04.07.23.
//

import Foundation

protocol SubjectManagerProtocol: AnyObject {
    func fetchQuestions(completion: @escaping ((Subjects) -> Void))
}

class SubjectManager: SubjectManagerProtocol {

    static let shared = SubjectManager()
    
    private init() {}
    
    func fetchQuestions(completion: @escaping ((Subjects) -> Void)) {
        let url = "https://run.mocky.io/v3/8ade4e0b-bee1-4eae-a98b-47edeea68324"
        NetworkManager.shared.get(url: url) { (result: Result<Subjects, Error>) in
            switch result {
            case .success(let success):
                completion(success)
            case .failure(let error):
                print(error)
            }
        }
    }
}
