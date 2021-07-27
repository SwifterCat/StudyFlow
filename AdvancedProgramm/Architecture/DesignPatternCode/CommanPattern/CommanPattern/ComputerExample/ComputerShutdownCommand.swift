//
//  ComputerShutdownCommand.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/13.
//

import Foundation

///Retain the receiver, and excute the sepefic operation.

class ComputerShutdownCommand: NSObject, ComputerCommandProtocol {
    
    private var receiver: ComputerReceiver
    
    init(receiver: ComputerReceiver) {
        self.receiver = receiver
        super.init()
    }
    
    func excute() {
        self.receiver.shutdown()
    }
    
}
