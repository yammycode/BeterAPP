
import UIKit

protocol GameItemCellDelegator {
    func callSegueFromCell(gameIndex: Int)
}

final class GameListViewController: UITableViewController {
    
    var gameList: [Game]!
    var account: Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100

        if let navigationBar = self.navigationController?.navigationBar {
            let firstFrame = CGRect(x: 20, y: 0, width: navigationBar.frame.width, height: navigationBar.frame.height - 40)

            let firstLabel = UILabel(frame: firstFrame)
            firstLabel.text = "Ваш баланс составояет \(account.budget)$"

            navigationBar.addSubview(firstLabel)

        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let selectGameVC = segue.destination as? SelectGameViewController else { return }
        guard let gameIndex = (sender as? Int) else { return }
        selectGameVC.games = gameList
        selectGameVC.gameIndex = gameIndex
        selectGameVC.account = account
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        gameList?.count ?? 0
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath)
                as? HeaderGameListTableViewCell else { return UITableViewCell() }
        
        let game = gameList[indexPath.row]
        cell.teamOneLabel.text = game.teamOne.team.rawValue
        cell.teamTwoLabel.text = game.teamTwo.team.rawValue

        if game.betTeam != nil {
            cell.raitingTeamOneLabel.text = String(game.teamOneScore)
            cell.raitingTeamOneLabel.textColor = .black
            cell.raitingTeamTwoLabel.text = String(game.teamTwoScore)
            cell.raitingTeamTwoLabel.textColor = .black

            cell.ratingTitleLabel.text = "Матч завершен"

            cell.teamCheckButton.isHidden = true
        } else {
            cell.raitingTeamOneLabel.text = String(game.teamOne.rating)
            cell.raitingTeamTwoLabel.text = String(game.teamTwo.rating)
        }

        
        cell.teamOneImageView.image = UIImage(named: String(describing: game.teamOne.team))
        cell.teamTwoImageView.image = UIImage(named: String(describing: game.teamTwo.team))

        cell.teamCheckButton.tag = indexPath.row

        cell.delegate = self
        

        return cell
    }

    
    //MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _ = gameList[indexPath.row]
    }
}

extension GameListViewController: GameItemCellDelegator {
    func callSegueFromCell(gameIndex: Int) {
        self.performSegue(withIdentifier: "goToSelectGame", sender: gameIndex )
    }
}



    // MARK: - Navigation

