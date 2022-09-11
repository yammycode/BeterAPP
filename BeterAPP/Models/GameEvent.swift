//
//  GameEvent.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

struct GameEvent {
    let data = DataStore.shared

    let team: Team
    let isGoal: Bool
    let description: String
    let time: Int

    init(teamOne: Team, teamTwo: Team, time: Int) {
        team = Double.random(in: 0...1) > 0.5 ? teamOne : teamTwo
        isGoal = Double.random(in: 0...1) > 0.8

        let eventTexts = isGoal ? data.goalEventTexts : data.notGoalEventTexts
        let eventText = eventTexts.shuffled().first ?? ""

        description = eventText.replacingOccurrences(of: "{{TEAM}}",
                                                     with: team.rawValue,
                                                     options: .literal,
                                                     range: nil)
        self.time = time
    }

}


