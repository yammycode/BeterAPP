//
//  Game.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

import Foundation

struct Game {
    let teamOne: TeamInGame
    let teamTwo: TeamInGame
    // Сюда будем записывать забитые командой мячи
    var teamOneScore = 0
    var teamTwoScore = 0
    /// Ставка пользователя на матч
    var betValue: Double?
    /// На какую команду поставил пользователь
    // По этому параметру будем определять, что матч состоялся
    var betTeam: Team?

    var winner: Team? {
        // Это мне, реализовать когда буду делать 4 экран
        return nil
    }

    // Внимание кто будет делать экран 5!
    // Здесь надо обработать случай с ничьей (то есть матч состоялся, но счет равен).
    // В этом случае тоже нужно вернуть false
    // Логику можно переделать, главное чтобы возвращался nil если матч не состоялся и true / false если состоялся
    var isUserWin: Bool? {
        if winner == nil || betTeam == nil {
            return nil
        }
        return winner == betTeam
    }


}

extension Game {
    static func getGames() -> [Game] {
        var games: [Game] = []
        let teams = Team.allCases.shuffled()

        // Нам для края нужен не последний, а предпоследний элемент, так как мы берем пару команд
        for teamIndex in 0..<(teams.count - 1) {
            // Пропускаем четные команды, так как они - вторые команды в предыдущей итерации
            if teamIndex % 2 != 0 {
                continue
            }
            let game = Game(
                teamOne: TeamInGame(team: teams[teamIndex], rating: getRandomRating()),
                teamTwo: TeamInGame(team: teams[teamIndex + 1], rating: getRandomRating())
            )

            games.append(game)
        }

        return games
    }

    /// Генератор случайного коэффициента с округлением до сотых
    private static func getRandomRating() -> Double {
        let randomValue = Double.random(in: 1.1...2.5)
        return Double(round(100 * randomValue) / 100)
    }
}
