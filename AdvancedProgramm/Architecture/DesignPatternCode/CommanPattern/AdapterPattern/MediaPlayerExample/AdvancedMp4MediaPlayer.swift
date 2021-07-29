//
//  AdvancedMp4MediaPlayer.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/28.
//

import Cocoa

class AdvancedMp4MediaPlayer: NSObject, AdvancedMediaPlayerProtocol {

    func playVlc(_ fileName: String) {
        print("play Vlc file")
    }
    
    func playMP4(_ fileName: String) {
        print("do nothing")
    }
    
}
