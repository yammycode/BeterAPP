//
//  HistoryViewController.swift
//  BeterAPP
//
//  Created by Aleksey Zyamin on 08.09.2022.
//

import UIKit

class HistoreViewController: UITableViewController {
    
    var gameList: [Game]!
    var gamesWithResults: [Game] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for game in gameList {
            if game.betTeam != nil {
                gamesWithResults.append(game)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        gamesWithResults.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Infos", for: indexPath)
        
        let game = gameList[indexPath.section]
        let score = ("\(game.teamOneScore) : \(game.teamTwoScore)")
        let value = ("На команду \(game.betTeam?.rawValue ?? "") поставили \(game.betValue ?? 0)")
        var content = cell.defaultContentConfiguration()
        
        switch indexPath.row {
        case 0:
            content.text = score
        case 1:
            content.text = value
        default:
            content.text = ("\(game.teamOne.rating) : \(game.teamTwo.rating)")
        }
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "hederInfos") as? HeaderHistoryTableViewCell
        cell?.teamOneLabel.text = gameList[section].teamOne.team.rawValue
        cell?.teamTwoLabel.text = gameList[section].teamTwo.team.rawValue
        cell?.teamTwoImage.image = UIImage(named: String(describing: gameList[section].teamTwo.team))
        cell?.teamOneImage.image = UIImage(named: String(describing: gameList[section].teamOne.team))
        
        return cell
    }
}
