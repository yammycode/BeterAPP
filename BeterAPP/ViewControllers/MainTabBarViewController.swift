//
//  MainTabBarViewController.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 10.09.2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    var games = Game.getGames()
    var account = Account(budget: 1000)

    override func viewDidLoad() {
        super.viewDidLoad()
        sendDataToVC()
    }

}


extension MainTabBarViewController {
    private func sendDataToVC() {
        guard let viewControllers = viewControllers else { return }

        viewControllers.forEach {
            guard let navVC = $0 as? UINavigationController else { return }

            if let gameListVC = navVC.topViewController as? GameListViewController {
                gameListVC.gameList = games
                gameListVC.account = account
            } else if let historyVC = navVC.topViewController as? HistoreViewController {
                historyVC.gameList = games
            }
        }
    }
}
