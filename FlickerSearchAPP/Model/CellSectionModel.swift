//
//  CellSectionModel.swift
//  FlickerSearchAPP
//
//  Created by Ahmed Nasser on 6/21/19.
//  Copyright © 2019 AvaVaas. All rights reserved.
//

import Foundation
import RxDataSources
import ObjectMapper
struct CellSectionModel {
    var header: String
    var items: [Item]
}
extension CellSectionModel: SectionModelType {
    typealias Item = Mappable
    
    init(original: CellSectionModel, items: [Item]) {
        LoggerRepo.logInfo("CellSectionModel:init")
        LoggerRepo.logDebug("CellSectionModel:init ,Parmters:(original: CellSectionModel, items: [Item])")
        self = original
        self.items = items
    }
}
