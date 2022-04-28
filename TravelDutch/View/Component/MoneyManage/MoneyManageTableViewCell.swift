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
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .systemGray2
    }
    
    private let payTypeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 26, weight: .bold)
    }
    
    private let moneyHistoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 1
    }
    
    private let PayCommentLabel = UITextView().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.textContainer.maximumNumberOfLines = 2
        $0.textAlignment = .center
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
        moneyHistoryLabel.text = item.moneyHistory
    }
    
    // MARK: - Layout
    private func layout() {
        [ payTypeLabel, moneyHistoryLabel, timeStampLabel, PayCommentLabel ].forEach { addSubview($0) }
        
        timeStampLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(150)
        }
        
        payTypeLabel.snp.makeConstraints {
            $0.leading.equalTo(timeStampLabel.snp.leading)
            $0.top.equalTo(timeStampLabel.snp.bottom).offset(10)
            $0.width.equalTo(150)
        }
        
        PayCommentLabel.snp.makeConstraints {
            //            $0.centerY.equalTo(self)
            $0.leading.equalTo(payTypeLabel.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.top.equalTo(payTypeLabel.snp.top)
//            $0.bottom.equalTo(moneyHistoryLabel.snp.bottom)
        }
        
        moneyHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(PayCommentLabel.snp.bottom).offset(5)
            $0.leading.equalTo(PayCommentLabel.snp.leading)
            $0.trailing.equalToSuperview()
        }
    }
}
