//
//  LoggerRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/23/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import os
class LoggerRepo {
    static func logInfo(_ text:String){
        os_log(.info, log: OSLog.default, "%@", text)
    }
    
    static func logDebug(_ text:String){
        os_log(.debug, log: OSLog.default, "%@", text)
    }
    
    static func logError(_ text:String){
        os_log(.error, log: OSLog.default, "%@", text)
    }
    
    static func logWarn(_ text:String){
        os_log(.default, log: OSLog.default, "%@", text)
    }
}
