//
//  PlaySongModel.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 09.05.2021.
//

import Foundation
import Combine

class PlaySongModel : ObservableObject {
    @Published var item: SongData
    
    var timeElapsed: Float = 0
    var songFinished = false
    var previousSliderValue: Float = 0
    
    @Published var sliderPercent: Float = 0
    @Published var sliderValue: Float = 0
    
    @Published var timeElapsedString = ""
    
    @Published var isPlaying: Bool = false 
    
    var playTimer: Timer!
    var sliderTimer: Timer!
    
    init(item: SongData){
        self.item = item
    }
    
    func play(){
        MediaPlayer.shared.play(track: item.songURL)
        
        playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
        
        sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        self.isPlaying = true
    }
    
    func onDisappear(){
        playTimer.invalidate()
        sliderTimer.invalidate()
    }
    
    func updateUserInterface() {
       /* songName.text = song
        guard let url = URL(string: imageURL) else {
            return
        }
        do {
            let data = try Data(contentsOf: url)
            albumCoverImage.image = UIImage(data: data)
        } catch {
            print("ERROR: error trying to get data from URL \(url)")
        }
        
        slider.isContinuous = false
        */
    }
    
    @objc func updatePlayButton(){
       if !MediaPlayer.shared.isPlaying && sliderPercent >= 100 {
           // playButton.image = UIImage(named: "play")
            songFinished = true
        self.isPlaying = false
            playTimer.invalidate()
            sliderTimer.invalidate()
        } else {
            self.isPlaying = true
          //  playButton.image = UIImage(named: "pause")
        }
        
    }
    
    @objc func updateSlider() {
        timeElapsed += 1
        sliderPercent = (Float(timeElapsed) / Float(item.durationInSeconds))
        print("***\(sliderPercent)")
        print("elapsed: \(timeElapsed)")
        timeElapsedString = "\(timeElapsed) : \(item.durationInSeconds)"
    }
    
    
    func sliderDragged(sliderValue: Float, percent: Float) {
        self.sliderPercent = percent
        
        if songFinished {
            MediaPlayer.shared.play(track: item.songURL)
            MediaPlayer.shared.seek(progress: percent, songDuration: item.durationInSeconds)
            songFinished = false
            self.isPlaying = false
            if !playTimer.isValid && !sliderTimer.isValid {
                print("Song finished but slider dragged - turn timers back on.")
                playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)

                sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            }
            
        } else {
            self.isPlaying = true
            MediaPlayer.shared.seek(progress: percent, songDuration: item.durationInSeconds)
        }
        
        //update timeElapsed in song
        timeElapsed = percent * Float(item.durationInSeconds)
        print("elapsed: \(timeElapsed)")
    }
    
    
    func playButtonTapped() {
        if MediaPlayer.shared.isPlaying {
            MediaPlayer.shared.pause()
            self.isPlaying = false
            //playButton.image = UIImage(named: "play")
            
            if playTimer.isValid && sliderTimer.isValid {
                print("Turn timers off after pause button tapped.")
                playTimer.invalidate()
                sliderTimer.invalidate()
            }
            
        } else {
            if sliderPercent == 1 {
                timeElapsed = 0
                print("Play button tapped. Song is finished. Play from beginning.")
                MediaPlayer.shared.play(track: item.songURL)
            } else {
                MediaPlayer.shared.resume()
            }
            self.isPlaying = true
            //playButton.image = UIImage(named: "pause")

            if !playTimer.isValid && !sliderTimer.isValid {
                print("Turn timers on after play button tapped.")
                playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
                
                sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            }
        }
        
    }

}
