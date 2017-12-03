//
//  CommonSection.swift
//  RxTableView
//
//  Created by 奥村晋太郎 on 2017/12/02.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import Foundation
import RxDataSources

struct CommonSection {
    var header: String
    var items: [Item]
}

extension CommonSection: AnimatableSectionModelType {
    typealias Item = String
    
    var identity: String {
        return header
    }
    
    init(original: CommonSection, items: [Item]) {
        self = original
        self.items = items
    }
}
