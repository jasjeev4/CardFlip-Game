//
//  MusicPlayer.swift
//  MemoryGame
//
//  Created by Jasjeev on 8/7/21.
//

import Foundation
import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic() {
        if let bundle = Bundle.main.path(forResource: "Dee Yan-Key - Chill Out", ofType: "mp3") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.prepareToPlay()
                audioPlayer.play()
                print("Playing audio")
            } catch {
                print(error)
            }
        }
    }
}
