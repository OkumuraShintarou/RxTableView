//
//  ViewController.swift
//  RxTableView
//
//  Created by 奥村晋太郎 on 2017/12/02.
//  Copyright © 2017年 ShintarouOkumura. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ViewController: UIViewController {
    
    enum ProfileSection: Int {
        case profile
        case settingProfile
        
        enum ProfileSectionType: Int {
            case name
            case mail
            case password
        }

        enum SettingProfileSection: Int {
            case changeName
            case registerPhoneNumber
        }
    }
    
    fileprivate let bag = DisposeBag()
    fileprivate let vm = TableViewModel()
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 16
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header: UITableViewHeaderFooterView = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = UIColor.black
        header.textLabel?.font      = R.systemFont.hiraginoSansW3(size: 13)
        header.contentView.backgroundColor = UIColor.white
    }
}

fileprivate extension ViewController {
    func configure() {
        configureUI()
        configureTableView()
    }
    
    func deselectRow() {
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = UIColor.white
        tableView.backgroundColor = UIColor.white
        tableView.separatorColor = UIColor.black
    }
    
    private func configureTableView() {
        tableView.register(R.nib.settingCell)
        let dataSource = ViewController.dataSource()
        
        vm
            .item$
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.rx
            .itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let wself = self else { return }
                switch ProfileSection(rawValue: indexPath.section)! {
                case .profile:
                    switch ProfileSection.ProfileSectionType(rawValue: indexPath.row)! {
                    case .name:
                        print("name")
                    case .mail:
                        print("mail")
                    case .password:
                        print("password")
                    }
                case .settingProfile:
                    switch ProfileSection.SettingProfileSection(rawValue: indexPath.row)! {
                    case .changeName:
                        print("")
                    case .registerPhoneNumber:
                        print("")
                    }

                }
            })
            .disposed(by: bag)
        
        tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
    }
}

fileprivate extension ViewController {
    // コモンセクションから
    static func dataSource() -> RxTableViewSectionedAnimatedDataSource<CommonSection> {
        return RxTableViewSectionedAnimatedDataSource<CommonSection>(
            configureCell: { _ ,table, indexPath, text in
                switch ProfileSection(rawValue: indexPath.section)! {
                case .profile:
                    // reuseIdentifierは自分で作る?
                    let cell = table.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tableViewCell, for: indexPath)!
                    cell.configure(text)
                    return cell
                case .settingProfile:
                    let cell = table.dequeueReusableCell(withIdentifier: R.reuseIdentifier.tableViewCell, for: indexPath)!
                    cell.configure(text)
                    return cell
                }
        },
        titleForHeaderInSection: { dataSource, index in
            dataSource[index].header
            
            }
        )
    }
}



