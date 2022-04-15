//
//  PersonTableViewCell.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/10.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    static let id = "PersonTableViewCell"
    
    //MARK: - Properties
    var name: String?
    var money: String?
    
    private let nameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let getMoneyLabel = UILabel().then {
        $0.text = "받은 금액 ➡️ "
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    private let moneyLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .semibold)
    }
    
    // MARK: - layoutSubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nameLabel.text = name
        moneyLabel.text = money
        layout()
    }
    
    // MARK: - layout
    private func layout() {
        
        // 전체적으로 손 볼 예정 임시
        [ nameLabel, getMoneyLabel, moneyLabel ].forEach { addSubview($0) }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(30)
            $0.width.equalTo(100)
        }
        
        getMoneyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.trailing.equalTo(moneyLabel.snp.leading)
        }
        
        moneyLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalTo(getMoneyLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
