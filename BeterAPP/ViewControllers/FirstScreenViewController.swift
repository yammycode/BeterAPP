//
//  FirstScreenViewController.swift
//  BeterAPP
//
//  Created by Anton Saltykov on 10.09.2022.
//

import UIKit
import AVFoundation

final class FirstScreenViewController: UIViewController {

    @IBOutlet var videoView: UIView!
    @IBOutlet var baseWindow: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        playVideo()
    }

    private func playVideo() {
        guard let path = Bundle.main.path(forResource: "videoplayback", ofType: "mp4") else { return }

        let player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = view.bounds
        playerLayer.videoGravity = .resizeAspectFill
        videoView.layer.addSublayer(playerLayer)

        videoView.bringSubviewToFront(baseWindow)

        player.play()
    }
}
