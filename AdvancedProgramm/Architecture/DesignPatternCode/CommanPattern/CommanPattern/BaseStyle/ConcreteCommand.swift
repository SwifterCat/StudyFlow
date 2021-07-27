//
//  ConcreteCommand.swift
//  CommanPattern
//
//  Created by Zi on 2021/7/13.
//

import Foundation

class ConcreteCommand: NSObject, CommandProtocol {
    
    func excute() {
        print("Excute sepecifc command")
    }
    
}
