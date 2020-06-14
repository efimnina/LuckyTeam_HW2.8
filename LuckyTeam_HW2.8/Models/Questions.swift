//
//  Questions.swift
//  LuckyTeam_HW2.8
//
//  Created by mac on 14.06.2020.
//  Copyright © 2020 KozhanovMikhail. All rights reserved.
//

struct Question {
    var text: String
}

extension Question {
    static func getQuestions() -> [Question] {
        return [
            Question(
                text: "Дата рождения?"
            ),
            Question(
                text: "Ваш пол?"
            ),
            Question(
                text: "Ваша профессия?"
            ),
            Question(
                text: "Ваш стаж?"
            )
        ]
    }
}
