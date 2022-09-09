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
    var account: Account!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: false)
        updateGames()
        setTeamsData()
        setInfoText()
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
            } else {
                resultTitleLabel.text = "Вы проиграли!"
                resultTitleLabel.textColor = .red
                resultTextLabel.text = "Вы поставили \(getFormattedBet(gameBetValue))$ и проиграли."
            }

        }
    }

    private func getFormattedBet(_ value: Double) -> String {
        String(format: "%.0f", value)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
