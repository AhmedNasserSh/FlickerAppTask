//
//  MockRepo.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/22/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import ObjectMapper
class MockRepo<T> where T:Mappable{
    func generateMockup(resourcePath:String) -> T?{
        LoggerRepo.logInfo("MockRepo<T>:generateMockup")
        LoggerRepo.logDebug("MockRepo<T>:generateMockup,Parmters:(resourcePath:String) -> T?")
        guard let filepath = Bundle.main.path(forResource: resourcePath, ofType: "") else{
            LoggerRepo.logWarn("MockRepo<T>:generateMockup ,Error:Path for resource is nil")
            return nil 
        }
        let contents = try? String(contentsOfFile: filepath)
        let model = Mapper<T>().map(JSONString: contents ?? "{}")
        return model
    }
}
