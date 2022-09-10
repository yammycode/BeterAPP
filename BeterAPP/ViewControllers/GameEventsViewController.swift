//
//  GameEventsViewController.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 07.09.2022.
//

import UIKit

final class GameEventsViewController: UITableViewController {


    let games = Game.getGames()
    var game: Game!
    let account = Account(userName: "test", history: [], budget: 1000)



    /// Общее время матча
    private let gameTime = 10
    /// Текущее время матча
    private var currentTime = 0
    /// Шаг времени матча для настройки частоты наступления событий
    private var addTimeValue = 2
    private var events: [GameEvent] = []

    private var isGameInProcess: Bool {
        currentTime < gameTime
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        game = games.first
        game.betValue = 100
        game.betTeam = game.teamOne.team
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addEvent()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let resultVC = segue.destination as? ResultViewController else { return }
        resultVC.games = games
        resultVC.game = game
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isGameInProcess ? events.count + 1 : events.count + 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        var content = cell.defaultContentConfiguration()

        if indexPath.row == 0 {
            content.text = "Матч начался!"
            content.secondaryText = "Смотрим за событиями в реальном времени"
        }
        // events.count + 1 потому что у нас 2 доп. строки - начало матча и завершение
        else if !isGameInProcess && indexPath.row == events.count + 1 {
                content.text = "Матч завершен!"
                content.secondaryText = "Спасибо за просмотр"
        }
        else {
            let cellEvent = events[indexPath.row - 1] // исключаем 1-ю ячейку
            content.text = cellEvent.description
            content.secondaryText = "\(cellEvent.time)-я минута матча"

            if cellEvent.isGoal {
                content.image = UIImage(systemName: "star.fill")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
            } else {
                content.image = UIImage(systemName: "info.circle")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
            }
        }

        cell.contentConfiguration = content

        return cell
    }

}


// MARK: - add event extension
extension GameEventsViewController {
    private func addEvent() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500), execute: { [self] in
            generateNewEvent()


            if isGameInProcess {
                addEvent()
            }

            tableView.reloadData()
            scrollToBottom()
        })
        currentTime += addTimeValue
    }

    private func generateNewEvent() {
        // Для динамики определяем, наступило ли событие в единице времени или нет
        if Double.random(in: 0...1) > 0.6 { return }
        if !isGameInProcess { return }

        let newEvent = GameEvent(teamOne: game.teamOne.team,
                                 teamTwo: game.teamTwo.team,
                                 time: currentTime)
        events.append(newEvent)
        if newEvent.isGoal {
            if newEvent.team == game.teamOne.team {
                game.teamOneScore += 1

            } else {
                game.teamTwoScore += 1
            }
        }
    }

}

// MARK: - Table scroll extension
extension GameEventsViewController {
    func scrollToBottom(){
        DispatchQueue.main.async {
            if self.events.count > 0 {
                let scrollIndex = self.isGameInProcess ? self.events.count : self.events.count + 1
                let indexPath = IndexPath(row: scrollIndex, section: 0)
                self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
            }

        }
    }
}

// MARK: - UITableViewDelegate
extension GameEventsViewController {
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "totalResultCell") as? TotalResultTableViewCell

        cell?.teamOneLabel.text = game.teamOne.team.rawValue
        cell?.teamOneImage.image = UIImage(named: String(describing: game.teamOne.team))
        cell?.teamOneScoreLabel.text = String(game.teamOneScore)

        cell?.teamTwoLabel.text = game.teamTwo.team.rawValue
        cell?.teamTwoImage.image = UIImage(named: String(describing: game.teamTwo.team))
        cell?.teamTwoScoreLabel.text = String(game.teamTwoScore)

        if isGameInProcess {
            cell?.resultButton.isEnabled = false
            cell?.resultButton.setTitle("Матч в процессе", for: .normal)
        } else {
            cell?.resultButton.isEnabled = true
            cell?.resultButton.setTitle("Матч завершен. Перейти к результатам", for: .normal)
        }

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        130
    }
}
