//
//  CustomTableViewCell.swift
//  BeterAPP
//
//  Created by Юлия on 08.09.2022.
//

import UIKit

final class HeaderGameListTableViewCell: UITableViewCell {

    
    @IBOutlet var teamOneLabel: UILabel!
    @IBOutlet var teamTwoLabel: UILabel!
    
    @IBOutlet var raitingTeamOneLabel: UILabel!
    @IBOutlet var raitingTeamTwoLabel: UILabel!
    
    @IBOutlet var teamOneImageView: UIImageView!
    @IBOutlet var teamTwoImageView: UIImageView!
    
    @IBOutlet var teamCheckButton: UIButton!

    @IBOutlet var ratingTitleLabel: UILabel!
    
    var delegate: GameItemCellDelegator!

    override func awakeFromNib() {

    }

    //MARK: - UITableViewDelegate
    
    @IBAction func teamCheckButtonPressed(_ sender: Any) {
        let index = (sender as AnyObject).tag ?? 0
        guard let delegate = delegate else { return }
        delegate.callSegueFromCell(gameIndex: index)
       }
    }
    

