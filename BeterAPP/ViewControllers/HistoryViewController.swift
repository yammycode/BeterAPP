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
        
        let game = gamesWithResults[indexPath.section]
        let score = ("\(game.teamOneScore) : \(game.teamTwoScore)")
        var content = cell.defaultContentConfiguration()
        
        
        switch indexPath.row {
        case 0:
            content.text = ("На команду \(game.betTeam?.rawValue ?? "")")
            content.secondaryText = ("Поставили: \(game.betValue ?? 0)")
        case 1:
            content.text = score
        default:
            content.text = ("Коэффициент команды \(game.teamOne.team.rawValue): \(game.teamOne.rating), коэффициент команды \(game.teamTwo.team.rawValue): \(game.teamTwo.rating)")
        }
        cell.contentConfiguration = content
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headerInfos") as? HeaderHistoryTableViewCell
        
        
        cell?.teamOneLabel.text = gamesWithResults[section].teamOne.team.rawValue
        cell?.teamTwoLabel.text = gamesWithResults[section].teamTwo.team.rawValue
        cell?.teamTwoImage.image = UIImage(named: String(describing: gamesWithResults[section].teamTwo.team))
        cell?.teamOneImage.image = UIImage(named: String(describing: gamesWithResults[section].teamOne.team))
        
        if gamesWithResults[section].isUserWin {
            cell?.backgroundColor = .green
        } else if gamesWithResults[section].winner == nil {
            cell?.backgroundColor = .gray
        } else {
            cell?.backgroundColor = .red
        }

        
        return cell
    }
  
    //MARK: - allert
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

