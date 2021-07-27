//
//  ComputerInvoker.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/13.
//

import Foundation

///Retain command instance, and invoke the functions.

class ComputerInvoker: NSObject {

    private var rebootCommand: ComputerRebootCommand
    private var shutdownCommand: ComputerShutdownCommand
    
    init(rebootCommand: ComputerRebootCommand, shutdownCommand: ComputerShutdownCommand) {
        self.rebootCommand = rebootCommand
        self.shutdownCommand = shutdownCommand
        super.init()
    }
    
    func reboot() {
        self.rebootCommand.excute()
    }
    
    func shutdown() {
        self.shutdownCommand.excute()
    }
    
}
