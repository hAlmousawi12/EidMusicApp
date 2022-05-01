//
//  ContentViewModel.swift
//  MusicApp
//
//  Created by Hussain on 10/5/21.
//

import SwiftUI
import AVFoundation
import MediaPlayer


class ContentViewModel: NSObject, ObservableObject {
    @Published var music: AVAudioPlayer!
    @Published var isPlaying = false
    @Published var i = 0
    @Published var currentMusic: Music = musics[0]
    
    
    func setupAVAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
            try AVAudioSession.sharedInstance().setActive(true)
            debugPrint("AVAudioSession is Active and Category Playback is set")
            UIApplication.shared.beginReceivingRemoteControlEvents()
            setupCommandCenter()
        } catch {
            debugPrint("Error: \(error)")
        }
    }
    
    func playMusic() {
        playOrPause()
    }
    
    func prevMusic() {
        if isPlaying {
            music.stop()
            isPlaying = false
        }
        if i != 0 {
            i -= 1
            self.currentMusic = musics[self.i]
        } else {
            i = (musics.count - 1)
            self.currentMusic = musics[self.i]
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.playOrPause()
        }
    }
    
    func NextMusic() {
        if isPlaying {
            music.stop()
            isPlaying = false
        }
        if i != (musics.count - 1) {
            i += 1
            self.currentMusic = musics[self.i]
        } else {
            i = 0
            self.currentMusic = musics[self.i]
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.playOrPause()
        }
    }
    
    
    private func setupCommandCenter() {
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyTitle: "Eid Music"]
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.isEnabled = true
        commandCenter.pauseCommand.isEnabled = true
        commandCenter.nextTrackCommand.isEnabled = true
        commandCenter.previousTrackCommand.isEnabled = true
        
        commandCenter.playCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.music.play()
            return .success
        }
        commandCenter.pauseCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.music.pause()
            return .success
        }
        commandCenter.nextTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.NextMusic()
            return .success
        }
        commandCenter.previousTrackCommand.addTarget { [weak self] (event) -> MPRemoteCommandHandlerStatus in
            self?.prevMusic()
            return .success
        }
    }
    
    private func playOrPause() {
        if let musicURL = Bundle.main.url(forResource: musics[self.i].pathName, withExtension: "mp3") {
            if let audioPlayer = try? AVAudioPlayer(contentsOf: musicURL) {
                
                music = audioPlayer
                music.delegate = self
                music.numberOfLoops = 0
                if isPlaying {
                    music.pause()
                } else {
                    music.play()
                }
                isPlaying.toggle()
            } else {
                print("something went wrong \(musicURL)")
            }
        }
    }
}

extension ContentViewModel: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        guard flag else { return }

        self.NextMusic()
    }
}
