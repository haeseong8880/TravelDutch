//
//  MoneyTableViewCell.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/15.
//

import UIKit

class MoneyManageTableViewCell: UITableViewCell {
    static let id = "MoneyManageTableViewCell"
    
    // MARK: - Properties
    var item: MoneyHistoryModel = MoneyHistoryModel()
    
    private let timeStampLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .medium)
        $0.textColor = .systemGray2
    }
    
    private let payTypeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let moneyHistoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 17, weight: .regular)
        $0.numberOfLines = 1
        $0.textAlignment = .right
    }
    
    private let PayCommentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 1
        $0.textAlignment = .right
    }
    
    // MARK: - layoutSubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
        layout()
    }
    
    // MARK: - configure
    private func configure() {
        payTypeLabel.text = item.payType
        timeStampLabel.text = item.timeStamp
        PayCommentLabel.text = item.payComment
        moneyHistoryLabel.text = item.moneyHistory + "원"
    }
    
    // MARK: - Layout
    private func layout() {
        [ payTypeLabel, moneyHistoryLabel, timeStampLabel, PayCommentLabel ].forEach { addSubview($0) }
        
        payTypeLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(150)
        }
        
        timeStampLabel.snp.makeConstraints {
            $0.top.equalTo(payTypeLabel.snp.bottom).offset(5)
            $0.leading.equalTo(payTypeLabel.snp.leading)
            $0.width.equalTo(150)
        }
        
        PayCommentLabel.snp.makeConstraints {
            $0.top.equalTo(payTypeLabel.snp.top)
            $0.leading.equalTo(payTypeLabel.snp.trailing).inset(20)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        moneyHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(PayCommentLabel.snp.bottom).offset(5)
            $0.leading.equalTo(payTypeLabel.snp.leading)
            $0.trailing.equalTo(PayCommentLabel.snp.trailing)
        }
    }
}
