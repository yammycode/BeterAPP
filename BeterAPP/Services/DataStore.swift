//
//  DataStore.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

class DataStore {

    static let shared = DataStore()

    let goalEventTexts = [
        "ГОЛ! Команда {{TEAM}} забивает мяч в ворота противника!",
        "ГООООЛ! Мяч в сетке.",
        "{{TEAM}} забивает очередной гол!"
    ]

    let notGoalEventTexts = [
        "Опасный момент! Но команда {{TEAM}} не смогла им воспользоваться",
        "Пенальти! Посмотрим, сможет ли {{TEAM}} что-то сделать с этим",
        "Штанга! Еще немного и {{TEAM}} закатили бы мяч в сетку"
    ]

    private init() {}
}

enum Team: String, CaseIterable {
    case zenit = "Зенит"
    case cska = "ЦСКА"
    case krasnodar = "Краснодар"
    case dinamo = "Динамо"
    case spartak = "Спартак"
    case rostov = "Ростов"
    case sochi = "Сочи"
    case ahmat = "Ахмат"
    case lokomotiv = "Локомотив"
    case pari = "Пари НН"
    case kryliya = "Крылья Советов"
    case orenburg = "Оренбург"
    case himki = "Химки"
    case fakel = "Факел"
    case torpedo = "Торпедо"
    case ural = "Урал"
}
