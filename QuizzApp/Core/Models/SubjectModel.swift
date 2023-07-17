//
//  SubjectsModel.swift
//  QuizzApp
//
//  Created by bakhva  on 18.06.23.
//

import Foundation

// MARK: - Subject
struct Subject: Codable {
    let id, quizTitle, quizDescription: String
    let quizIcon: String
    let questionsCount: Int
    let questions: [Question]
}

// MARK: - Question
struct Question: Codable {
    let questionTitle: String
    let answers: [String]
    let correctAnswer: String
    let subjectID, questionIndex: Int

    enum CodingKeys: String, CodingKey {
        case questionTitle, answers, correctAnswer
        case subjectID = "subjectId"
        case questionIndex
    }
}

typealias Subjects = [Subject]
