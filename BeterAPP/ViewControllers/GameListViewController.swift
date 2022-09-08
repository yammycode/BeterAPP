//
//  GameListViewController.swift
//  BeterAPP
//
//  Created by Юлия on 07.09.2022.
//

import UIKit

class GameListViewController: UITableViewController {
    
    private var gameList = Game.getGames()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 130
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameList.count
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
                as? CustomTableViewCell else { return UITableViewCell() }

        let game = gameList[indexPath.row]
        cell.teamOneLabel.text = game.teamOne?.team.rawValue
        cell.teamTwoLabel.text = game.teamTwo?.team.rawValue
        cell.teamOneImageView.image = UIImage(named: String(describing: game.teamOne?.team))
        cell.teamTwoImageView.image = UIImage(named: String(describing: game.teamTwo?.team))

        return cell
    }
    
    //MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = gameList[indexPath.row]
    }
}
    

    
