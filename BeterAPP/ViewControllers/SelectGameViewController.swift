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

    // MARK: - Properties
    
    var games: [Game]!
    var gameIndex = 0
    var game: Game!
    var teamChecked: Team!
    var account: Account!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        game = games[gameIndex]
        teamChecked = game.teamOne.team
        betSlider.maximumValue = Float(account.budget)

        transmitData()
        setSelectedTeamColor()

        userBetTF.delegate = self

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

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {

        if userBetTF.text == "" {
            showAlert(title: "Введите сумму ставки", message: "Необходимо ввести сумму ставки на команду")
            return false
        }

        guard let betValue = Int(userBetTF.text ?? "0") else {
            showAlert(title: "Некорректное значение", message: "Необходимо ввести сумму ставки на команду в виде целого числа")
            return false
        }

        if betValue <= 0 || Double(betValue) > account.budget {
            showAlert(title: "Недопустимое значение", message: "Сумма ставки долна быть от 0 до \(account.budget)$")
            return false
        }

        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    // MARK: - @IBAction
    @IBAction func selectSegmentalControl() {
        teamChecked = selectTeamSegmentedControl.selectedSegmentIndex == 0 ? game.teamOne.team : game.teamTwo.team
        setSelectedTeamColor()
    }
    
    @IBAction func betSliderAction() {
        userBetTF.text = String(format: "%.0f", betSlider.value)
    }
    
    
    // MARK: - private functions
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
}

extension SelectGameViewController {
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.userBetTF.text = String(format: "%.0f", self.account.budget)
            self.betSlider.value = Float(self.account.budget)
        }


        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

// MARK: - connect TextField And Slider
extension SelectGameViewController: UITextFieldDelegate {

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let newValue = textField.text else { return }
        guard let numberValue = Int(newValue) else { return }
        betSlider.value = Float(numberValue)
    }

}
