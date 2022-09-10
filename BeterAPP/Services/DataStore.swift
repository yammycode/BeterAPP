//
//  DataStore.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

class DataStore {

    static let shared = DataStore()

    let games = Game.getGames()

    let goalEventTexts = [
        "ГОЛ! Команда {{TEAM}} забивает мяч в ворота противника!",
        "ГООООЛ! Мяч в сетке. {{TEAM}}, вперед!",
        "{{TEAM}} забивает очередной гол!",
        "Удар и ГОЛ! {{TEAM}} смогла реализовать опасный момент у ворот противника",
        "Мяч в сетке! {{TEAM}} забивает красивый и очень нужный гол"
    ]

    let notGoalEventTexts = [
        "Опасный момент! Но команда {{TEAM}} не смогла им воспользоваться",
        "Пенальти! Посмотрим, сможет ли {{TEAM}} что-то сделать с этим",
        "Штанга! Еще немного и {{TEAM}} закатили бы мяч в сетку",
        "Штрафной удар. Но {{TEAM}} не смогли реализовать опасный момент",
        "В команде {{TEAM}} замена.",
        "{{TEAM}} полностью контролирует ход матча",
        "Нарушение правил. Судья дает желтую карточку игроку команды {{TEAM}}"
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
