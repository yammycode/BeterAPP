//
//  HistoryViewController.swift
//  BeterAPP
//
//  Created by Aleksey Zyamin on 08.09.2022.
//

import UIKit

final class HistoreViewController: UITableViewController {
    
    var gameList: [Game]!
    var gamesWithResults: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getDoneGames()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        gamesWithResults.isEmpty ? 1 : gamesWithResults.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gamesWithResults.isEmpty ? 1 : 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Infos", for: indexPath)
        var content = cell.defaultContentConfiguration()

        if gamesWithResults.isEmpty {
            content.text = "Нет завершенных матчей"
            content.secondaryText = "Здесь будет выведена история завершенных матчей. Возвращайтесь на эту страницу, когда будет сыгран хотя бы один матч."
            content.image = UIImage(systemName: "info.circle")?.withTintColor(.orange, renderingMode: .alwaysOriginal)
        } else {
            let game = gamesWithResults[indexPath.section]
            let score = ("\(game.teamOneScore) : \(game.teamTwoScore)")

            switch indexPath.row {
            case 0:
                content.text = "Счет матча"
                content.secondaryText = score
            case 1:
                content.text = ("Ставка на команду \(game.betTeam?.rawValue ?? "")")
                content.secondaryText = ("\(game.betValue ?? 0)$")
            case 2:
                content.text = "Коэффициент на \(game.teamOne.team.rawValue)"
                content.secondaryText = "\(game.teamOne.rating)"
            case 3:
                content.text = "Коэффициент на \(game.teamTwo.team.rawValue)"
                content.secondaryText = "\(game.teamTwo.rating)"
            case 4:

                if game.teamOneScore == game.teamTwoScore {
                    content.text = "Ничья"
                } else {
                    guard let winner = game.winner, let gameBetValue = game.betValue else { break }

                    if game.isUserWin {
                        content.text = "Вы выиграли"
                        content.secondaryText = getFormattedBet(winner.rating * (game.betValue ?? 1)) + "$"
                    } else {
                        content.text = "Вы проиграли"
                        content.secondaryText = "-\(getFormattedBet(winner.rating * gameBetValue))$"
                    }
                }

            default:
                break
            }
        }

        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        if gamesWithResults.isEmpty {
            return nil
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "headerInfos") as? HeaderHistoryTableViewCell
        
        cell?.teamOneLabel.text = gamesWithResults[section].teamOne.team.rawValue
        cell?.teamTwoLabel.text = gamesWithResults[section].teamTwo.team.rawValue
        cell?.teamTwoImage.image = UIImage(named: String(describing: gamesWithResults[section].teamTwo.team))
        cell?.teamOneImage.image = UIImage(named: String(describing: gamesWithResults[section].teamOne.team))
        
        if gamesWithResults[section].isUserWin {
            cell?.backgroundColor = UIColor(red: 0.95, green: 1, blue: 0.95, alpha: 1.0)
        } else if gamesWithResults[section].winner == nil {
            cell?.backgroundColor = .white
        } else {
            cell?.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.95, alpha: 1.0)
        }

        
        return cell
    }

    private func getDoneGames() {
        for game in gameList {
            if game.betTeam != nil {
                gamesWithResults.append(game)
            }
        }
    }

    private func getFormattedBet(_ value: Double) -> String {
        String(format: "%.2f", value)
    }

}

