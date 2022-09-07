//
//  GameEvent.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

struct GameEvent {
    let time: Int
    let description: String
    let team: Team
    let isGoal: Bool

    /// Метод, которые подставляет в текст события название команды
    // Он находит вхождение подстроки {{TEAM}} в строке и заменяет на название команды из енума
    func getFormattedDescription() -> String {
        let text = description.replacingOccurrences(of: "{{TEAM}}",
                                                    with: team.rawValue,
                                                    options: .literal,
                                                    range: nil)
        return text
    }

}
