//
//  TableViewCell.swift
//  RxTableView
//
//  Created by 奥村晋太郎 on 2017/12/02.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit

final class SettingCell: UITableViewCell {
    
    @IBOutlet fileprivate weak var titleLabel: UILabel!

    func configure(_ text: String) {
        titleLabel.text = text
    }
    
}
