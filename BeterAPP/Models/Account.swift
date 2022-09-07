//
//  Account.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

struct Account {
    let userName: String
    var history: [Game] = []
    // Обратите внимание, что свойство приватное!
    private var budget = 0.0

    /// Метод для получения текущего бюджета
    func getBudget() -> Double {
        budget
    }

    /// Метод для утсановления стартового значения бюджета
    mutating func initBudget(with money: Double) {
        budget = money
    }

    mutating func updateBudget(after game: Game) {
        // Внимание кто будет реализовывать экраны 5 или 2!
        // Надо реализовать этот метод.
        // Суть в том, чтобы определить по игре выиграл ли юзер или проиграл
        // и в соотвентствии с этим изменить бюджет
    }
}

extension Account {
    // Это временный метод пока не соберем все вместе
    static func getFakeAccount() -> Account {
        Account(userName: "TestUser", history: [], budget: 100)
    }
}
