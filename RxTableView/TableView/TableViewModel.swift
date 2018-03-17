//
//  TableViewModel.swift
//  RxTableView
//
//  Created by 奥村晋太郎 on 2017/12/02.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class TableViewModel {
    let item$: Observable<[CommonSection]>

    init() {
        item$ = Observable.just([
            CommonSection(header: "aa", items: [
                "ニックネーム",
                "メールアドレス",
                "パスワード"
                ]),
            CommonSection(header: "", items: [
                "名前を変更する",
                "電話番号を登録する"
                ])
            ])
    }

}

