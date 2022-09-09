//
//  HistoryViewController.swift
//  BeterAPP
//
//  Created by Aleksey Zyamin on 08.09.2022.
//

import UIKit

class HistoreViewController: UITableViewController {
    
    var games = [Game(teamOne: TeamInGame(team: .ahmat, rating: 1.5),
                      teamTwo: TeamInGame(team: .cska, rating: 2),
                      teamOneScore: 0,
                      teamTwoScore: 0,
                      betValue: 10,
                      betTeam: .cska),
                 Game(teamOne: TeamInGame(team: .himki, rating: 1.5),
                                   teamTwo: TeamInGame(team: .dinamo, rating: 6),
                                   teamOneScore: 0,
                                   teamTwoScore: 0,
                                   betValue: 10,
                                   betTeam: .dinamo),
                 Game(teamOne: TeamInGame(team: .fakel, rating: 1.5),
                      teamTwo: TeamInGame(team: .krasnodar, rating: 3),
                                   teamOneScore: 0,
                                   teamTwoScore: 0,
                                   betValue: 10,
                                   betTeam: .krasnodar),
                 Game(teamOne: TeamInGame(team: .lokomotiv, rating: 1.5),
                      teamTwo: TeamInGame(team: .zenit, rating: 4),
                                   teamOneScore: 0,
                                   teamTwoScore: 0,
                                   betValue: 10,
                                   betTeam: .zenit),
                 Game(teamOne: TeamInGame(team: .lokomotiv, rating: 1.5),
                      teamTwo: TeamInGame(team: .zenit, rating: 4),
                                   teamOneScore: 0,
                                   teamTwoScore: 0,
                                   betValue: 10,
                                   betTeam: .zenit),
                 Game(teamOne: TeamInGame(team: .lokomotiv, rating: 1.5),
                      teamTwo: TeamInGame(team: .zenit, rating: 4),
                                   teamOneScore: 0,
                                   teamTwoScore: 0,
                                   betValue: 10,
                                   betTeam: .zenit),
                 Game(teamOne: TeamInGame(team: .lokomotiv, rating: 1.5),
                      teamTwo: TeamInGame(team: .zenit, rating: 4),
                                   teamOneScore: 0,
                                   teamTwoScore: 0,
                                   betValue: 10,
                                   betTeam: .zenit)
                 ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        games.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Infos", for: indexPath)
        
        let game = games[indexPath.section]
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
        cell?.teamOneLabel.text = games[section].teamOne.team.rawValue
        cell?.teamTwoLabel.text = games[section].teamTwo.team.rawValue
        cell?.teamTwoImage.image = UIImage(named: String(describing: games[section].teamTwo.team))
        cell?.teamOneImage.image = UIImage(named: String(describing: games[section].teamOne.team))
        
        return cell
    }
}
