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
    
    
  private  let game = Game.getGames()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transmitData()

    }
    // MARK: - @IBAction
    
    @IBAction func backButtonPressed() {
    }
    
    @IBAction func helpButtonPressed() {
        showAlert(title: "Внимание!", message: "Введите целое число больше 0. Сумма ставки не должны превышать сумму текущего баланса")
    }
    
    @IBAction func selectSegmentalControl() {
    }
    
    @IBAction func betSliderAction() {
        userBetTF.text = String(format: "%.2ff", betSlider.value)
    }
    
    
    @IBAction func startGameButtonPressed() {
    }
    
    
    // MARK: - Function
    
   private func transmitData() {
       
        
     //  let gameList = game[index]
        
//       teamOneLabel.text = gameList.teamOne.team.rawValue
//       teamTwoLabel.text = gameList.teamTwo.team.rawValue
//       
//       teamOneImageView.image = UIImage(named: String(describing: gameList.teamOne.team))
//       teamTwoImageView.image = UIImage(named: String(describing: gameList.teamTwo.team))
       
  //     raitingTeamOneLabel.text = String(describing: teamInGame.raitig)
   //    raitingTeamTwoLabel.text = String(describing: teamInGame.raitig)
       
       
       
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

