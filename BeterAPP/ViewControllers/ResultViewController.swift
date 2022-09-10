//
//  ResultViewController.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 09.09.2022.
//

import UIKit

final class ResultViewController: UIViewController {

    @IBOutlet var teamOneLabel: UILabel!
    @IBOutlet var teamOneImage: UIImageView!
    @IBOutlet var teamOneScoreLabel: UILabel!

    @IBOutlet var teamTwoLabel: UILabel!
    @IBOutlet var teamTwoImage: UIImageView!
    @IBOutlet var teamTwoScoreLabel: UILabel!

    @IBOutlet var resultTitleLabel: UILabel!
    @IBOutlet var resultTextLabel: UILabel!

    var games: [Game]!
    var game: Game!
    var deltaForBudget: Double?
    var account: Account!


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)

        if game.isUserWin {
            view.backgroundColor = UIColor(red: 0.95, green: 1, blue: 0.95, alpha: 1.0)
        } else {
            view.backgroundColor = UIColor(red: 1, green: 0.95, blue: 0.95, alpha: 1.0)
        }

        updateGames()
        setTeamsData()
        setInfoText()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let mainTabBarVC = segue.destination as? MainTabBarViewController else { return }
        mainTabBarVC.games = games
        account.budget += deltaForBudget ?? 0
        mainTabBarVC.account = account
    }

    

    private func setTeamsData() {
        teamOneLabel.text = game.teamOne.team.rawValue
        teamOneImage.image = UIImage(named: String(describing: game.teamOne.team))
        teamOneScoreLabel.text = String(game.teamOneScore)

        teamTwoLabel.text = game.teamTwo.team.rawValue
        teamTwoImage.image = UIImage(named: String(describing: game.teamTwo.team))
        teamTwoScoreLabel.text = String(game.teamTwoScore)
    }

    private func setInfoText() {
        if game.winner == nil, let gameBetValue = game.betValue {
            resultTitleLabel.text = "Ничья"
            resultTitleLabel.textColor = .gray
            resultTextLabel.text = "На ваш счет вернулась ставка в размере \(getFormattedBet(gameBetValue))$."
        } else if let gameWinner = game.winner, let gameBetValue = game.betValue {

            let betRatingSum = gameWinner.rating * gameBetValue

            if game.isUserWin {
                resultTitleLabel.text = "Поздравляем!"
                resultTitleLabel.textColor = .systemGreen
                resultTextLabel.text = "Вы поставили \(getFormattedBet(gameBetValue))$ и выиграли \(getFormattedBet(betRatingSum))$."
                deltaForBudget = betRatingSum - gameBetValue

            } else {
                resultTitleLabel.text = "Вы проиграли!"
                resultTitleLabel.textColor = .red
                resultTextLabel.text = "Вы поставили \(getFormattedBet(gameBetValue))$ и проиграли."
                deltaForBudget = -gameBetValue
            }

        }
    }

    private func getFormattedBet(_ value: Double) -> String {
        String(format: "%.0f", value)
    }


}

extension ResultViewController {
    private func updateGames() {
        for (index, gameObject) in games.enumerated() {
            if gameObject.teamOne.team == game.teamOne.team &&
                gameObject.teamTwo.team == game.teamTwo.team {
                games[index] = game
            }
        }
    }
}
