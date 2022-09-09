//
//  Account.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

public struct Account {
    let userName: String
    var history: [Game] = []
    var budget = 0.0

}

extension Account {
    // Это временный метод пока не соберем все вместе
    static func getFakeAccount() -> Account {
        Account(userName: "TestUser", history: [], budget: 100)
    }
}
