//
//  MediaPlayerAdapter.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/28.
//

import Cocoa

class MediaPlayerAdapter: NSObject, NormalMediaPlayerProtocol {

    private let advancedMediaPlayer: AdvancedMediaPlayerProtocol?
    
    init(mediaType: String) {
        if mediaType == "mp4" {
            self.advancedMediaPlayer = AdvancedMp4MediaPlayer()
        } else if mediaType == "vlc" {
            self.advancedMediaPlayer = AdvancedVlcMediaPlayer()
        }else {
            self.advancedMediaPlayer = nil
        }
        super.init()
    }
    
    func play(_ mediaType: String, _ fileName: String) {
        guard let advancedMediaPlayer = advancedMediaPlayer else { return }
        if mediaType == "mp4" {
            advancedMediaPlayer.playMP4(fileName)
        } else if mediaType == "vlc" {
            advancedMediaPlayer.playVlc(fileName)
        }
    }
    
    
}
