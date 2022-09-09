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
    
    
    let game = Game.getGames()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    // MARK: - @IBAction
    
    @IBAction func backButtonPressed() {
    }
    
    @IBAction func startGameButtonPressed() {
    }
    
    
    // MARK: - Function
    
    func transmitData() {
       //
    }
    
    //MARK: - Navigation
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let gameEventsVC = segue.destination as? GameEventsViewController else { return }
//        gameEventsVC.game.betTeam = betTeam
//        gameEventsVC.game.betValue = betValue
//    }
}

