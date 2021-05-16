//
//  PlaySongModel.swift
//  swiftui_spotify_sample
//
//  Created by Anna Zharkova on 09.05.2021.
//

import Foundation
import Combine

class PlaySongModel : ObservableObject, IModel {
    @Published var currentItem: SongData? = nil
    @Published var hasNext: Bool = true
    @Published var hasPrevious: Bool = true
    @Published var playEnabled: Bool = true 
        
    var songItems: [SongData] = [SongData]()
    
    var currentIndex: Int = -1
    
    var timeElapsed: Float = 0 {
        didSet {
            guard let song = self.currentItem else {return}
            timeElapsedString = "\(Int(timeElapsed).minuteSecondMS) : \(song.durationInSeconds.minuteSecondMS)"
        }
    }
    var songFinished = false
    var previousSliderValue: Float = 0
    
    @Published var sliderPercent: Float = 0 {
        didSet {
            guard let song = self.currentItem else {return}
            timeElapsedString = "\(Int(timeElapsed).minuteSecondMS) : \(song.durationInSeconds.minuteSecondMS)"
        }
    }
    
    var sliderValue: Float = 0
    
    @Published var timeElapsedString: String = ""
    
    @Published var isPlaying: Bool = false 
    
    var playTimer: Timer? = nil
    var sliderTimer: Timer? = nil
    
    init(items: [SongData], currentIndex: Int){
        self.songItems.append(contentsOf: items)
        self.currentIndex = currentIndex < self.songItems.count ? currentIndex : 0
        self.setupItem(index: self.currentIndex)
    }
    
    func setupItem(index: Int){
        self.songFinished = true
        self.previousSliderValue = 0
        self.isPlaying = false
        self.timeElapsedString = ""
        self.timeElapsed = 0
        self.sliderValue = 0
        self.sliderPercent = 0
        playTimer?.invalidate()
        sliderTimer?.invalidate()
        self.currentItem = nil 
        MediaPlayer.shared.pause()
        if index < self.songItems.count {
            self.currentItem = self.songItems[index]
            self.currentIndex = index
            self.hasPrevious = self.currentIndex > 0
            self.hasNext = self.currentIndex < (self.songItems.count - 1)
        }
    }
    
    func play(){
        guard  let song = self.currentItem else {
            return
        }
        
        MediaPlayer.shared.play(track: song.songURL)
        
        playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
        
        sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
        self.isPlaying = true
    }
    
    func resetPlayer(item: SongData) {
        self.currentItem = item
        self.play()
    }
    
    func playNext() {
        if self.currentIndex + 1 < self.songItems.count {
            self.setupItem(index: self.currentIndex + 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.play()
            }
        }
    }
    
    func playPrevious() {
        if self.currentIndex - 1 >= 0 {
            self.setupItem(index: self.currentIndex - 1)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.play()
            }
        }
    }
    
    func onDisappear(){
        playTimer?.invalidate()
        sliderTimer?.invalidate()
        MediaPlayer.shared.pause()
    }
    
    
    @objc func updatePlayButton(){
        if !MediaPlayer.shared.isPlaying && sliderPercent >= 100 {
            songFinished = true
            self.isPlaying = false
            playTimer?.invalidate()
            sliderTimer?.invalidate()
        } else {
            self.isPlaying = true
        }
        
    }
    
    @objc func updateSlider() {
        guard  let song = self.currentItem else {
            return
        }
        timeElapsed += 1
        sliderPercent = (Float(timeElapsed) / Float(song.durationInSeconds))
        print("***\(sliderPercent)")
        print("elapsed: \(timeElapsed)")
        
    }
    
    
    func sliderDragged(sliderValue: Float, percent: Float) {
        self.sliderPercent = percent
        guard  let song = self.currentItem else {
            return
        }
        if songFinished {
            MediaPlayer.shared.play(track: song.songURL)
            MediaPlayer.shared.seek(progress: percent, songDuration: song.durationInSeconds)
            songFinished = false
            self.isPlaying = false
            if !playTimer!.isValid && !sliderTimer!.isValid {
                print("Song finished but slider dragged - turn timers back on.")
                playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
                
                sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            }
            
        } else {
            self.isPlaying = true
            
            MediaPlayer.shared.seek(progress: percent, songDuration: song.durationInSeconds)
        }
        
        //update timeElapsed in song
        timeElapsed = percent * Float(song.durationInSeconds)
        print("elapsed: \(timeElapsed)")
    }
    
    
    func playButtonTapped() {
        guard  let song = self.currentItem else {
            return
        }
        if MediaPlayer.shared.isPlaying {
            MediaPlayer.shared.pause()
            self.isPlaying = false
            
            if playTimer!.isValid && sliderTimer!.isValid {
                print("Turn timers off after pause button tapped.")
                playTimer?.invalidate()
                sliderTimer?.invalidate()
            }
            
        } else {
            if sliderPercent == 100 {
                timeElapsed = 0
                print("Play button tapped. Song is finished. Play from beginning.")
                MediaPlayer.shared.play(track: song.songURL)
            } else {
                MediaPlayer.shared.resume()
            }
            self.isPlaying = true
            if !playTimer!.isValid && !sliderTimer!.isValid {
                print("Turn timers on after play button tapped.")
                playTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updatePlayButton), userInfo: nil, repeats: true)
                
                sliderTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            }
        }
        
    }
    
}
