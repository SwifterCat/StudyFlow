//
//  NormalMediaPlayer.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/28.
//

import Cocoa

class NormalMediaPlayer: NSObject, NormalMediaPlayerProtocol {

    var mediaPlayerAdapter: MediaPlayerAdapter?
    
    
    func play(_ mediaType: String, _ fileName: String) {
        
        if mediaType == "mp4" || mediaType == "vlc"{
            self.mediaPlayerAdapter = MediaPlayerAdapter(mediaType: mediaType)
            self.mediaPlayerAdapter?.play(mediaType, fileName)
        } else if  mediaType == "mp3" {
            print("play MP3")
        }else {
            print("The player doesn't support: \(mediaType)")
        }
    }
    
}
