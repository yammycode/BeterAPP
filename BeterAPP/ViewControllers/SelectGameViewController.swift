//
//  SelectGameViewController.swift
//  BeterAPP
//
//  Created by Юлия on 09.09.2022.
//

import UIKit

final class SelectGameViewController: UIViewController {

    // MARK: - @IBOutlet
    
    @IBOutlet var teamOneLabel: UILabel!
    @IBOutlet var teamTwoLabel: UILabel!
    
    @IBOutlet var teamOneImageView: UIImageView!
    @IBOutlet var teamTwoImageView: UIImageView!

    @IBOutlet var raitingTeamOneLabel: UILabel!
    @IBOutlet var raitingTeamTwoLabel: UILabel!
    
    @IBOutlet var selectTeamSegmentedControl: UISegmentedControl!

    @IBOutlet var userBetTF: UITextField!
    @IBOutlet var betSlider: UISlider!
    
    var games: [Game]!
    var gameIndex = 0
    var game: Game!

    var teamChecked: Team!
    var account: Account!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = games[gameIndex]
        teamChecked = game.teamOne.team
        transmitData()

        setSelectedTeamColor()

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let gameEvensNavigationVC = segue.destination as? UINavigationController else { return }
        guard let gameEventsVC = gameEvensNavigationVC.topViewController as? GameEventsViewController else { return }

        games[gameIndex].betTeam = game.teamOne.team

        guard let betSumInput = userBetTF.text else { return }
        
        games[gameIndex].betValue = Double(betSumInput) ?? 0
        games[gameIndex].betTeam = teamChecked

        gameEventsVC.games = games
        gameEventsVC.gameIndex = gameIndex
        gameEventsVC.account = account
    }

    // MARK: - @IBAction
    
//    @IBAction func helpButtonPressed() {
//        showAlert(title: "Внимание!", message: "Введите целое число больше 0. Сумма ставки не должны превышать сумму текущего баланса")
//    }
    
    @IBAction func selectSegmentalControl() {
        teamChecked = selectTeamSegmentedControl.selectedSegmentIndex == 0 ? game.teamOne.team : game.teamTwo.team
        setSelectedTeamColor()
    }
    
    @IBAction func betSliderAction() {
        userBetTF.text = String(format: "%.2ff", betSlider.value)
    }
    
    @IBAction func startGameButtonPressed() {
    }
    
    
    // MARK: - Function

    private func setSelectedTeamColor() {
        if selectTeamSegmentedControl.selectedSegmentIndex == 0 {
            teamOneLabel.textColor = UIColor(red: 196/255, green: 164/255, blue: 57/255, alpha: 1)
            raitingTeamOneLabel.textColor = UIColor(red: 196/255, green: 164/255, blue: 57/255, alpha: 1)

            teamTwoLabel.textColor = .black
            raitingTeamTwoLabel.textColor = .black
        } else {
            teamTwoLabel.textColor = UIColor(red: 196/255, green: 164/255, blue: 57/255, alpha: 1)
            raitingTeamTwoLabel.textColor = UIColor(red: 196/255, green: 164/255, blue: 57/255, alpha: 1)

            teamOneLabel.textColor = .black
            raitingTeamOneLabel.textColor = .black
        }
    }
    
   private func transmitData() {

       teamOneLabel.text = game.teamOne.team.rawValue
       teamTwoLabel.text = game.teamTwo.team.rawValue

       teamOneImageView.image = UIImage(named: String(describing: game.teamOne.team))
       teamTwoImageView.image = UIImage(named: String(describing: game.teamTwo.team))
       
       raitingTeamOneLabel.text = String(game.teamOne.rating)
       raitingTeamTwoLabel.text = String(game.teamTwo.rating)
       
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - UIAlertController
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    
    //MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let gameEventsVC = segue.destination as? GameEventsViewController else { return }
//        gameEventsVC.game.betTeam = betTeam
//        gameEventsVC.game.betValue = betValue
//    }
}

