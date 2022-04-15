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
    var items: MoneyManageEntity?
    
    private let payTypeLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 26, weight: .bold)
    }
    
    private let moneyHistoryLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.numberOfLines = 1
    }
    
    private let timeStampLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15, weight: .medium)
        $0.textColor = .systemGray2
    }
    
    private let PayCommentLabel = UITextView().then {
        $0.font = .systemFont(ofSize: 20, weight: .regular)
        $0.textContainer.maximumNumberOfLines = 2
    }
    
    // MARK: - action
    private func dateToString(with: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd HH:mm"

        return dateFormatter.string(from: with)
    }

    // MARK: - layoutSubViews
    override func layoutSubviews() {
        super.layoutSubviews()
        
        configure()
        layout()
    }
    
    // MARK: - configure
    private func configure() {
        payTypeLabel.text = items?.payType
        timeStampLabel.text = dateToString(with: items!.timeStamp)
        PayCommentLabel.text = items?.PayComment
        moneyHistoryLabel.text = items?.moneyHistory
    }
    
    // MARK: - Layout
    private func layout() {
        [ payTypeLabel, moneyHistoryLabel, timeStampLabel, PayCommentLabel ].forEach { addSubview($0) }
        
        timeStampLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalToSuperview().inset(10)
        }
        
        payTypeLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.top.equalTo(timeStampLabel.snp.bottom)
            $0.width.equalTo(120)
        }

        moneyHistoryLabel.snp.makeConstraints {
            $0.top.equalTo(payTypeLabel.snp.bottom)
            $0.leading.equalToSuperview().inset(10)
            $0.trailing.equalTo(payTypeLabel.snp.trailing)
        }

//        PayCommentLabel.snp.makeConstraints {
////            $0.top.equalTo(timeStampLabel.snp.bottom)
////            $0.centerY.equalTo(self).offset(9)
//            $0.leading.equalTo(timeStampLabel.snp.leading).inset(-5)
//            $0.trailing.equalToSuperview().inset(20)
//            $0.bottom.equalToSuperview().inset(5)
//        }
    }
}
