//
//  MoneyTableView.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/15.
//

import Foundation
import UIKit

class MoneyManageTableView: UITableView {
    
    // MARK: - Properties
    var moneyManageList: [MoneyManageEntity] = []
    
    // MARK: - LifeCycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        configure()
        layout()
        
        self.delegate = self
        self.dataSource = self
        self.allowsSelection = false
        
        self.rowHeight = UITableView.automaticDimension
        
        self.register(MoneyManageTableViewCell.self, forCellReuseIdentifier: MoneyManageTableViewCell.id)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configure() {
        
    }
    
    // MARK: - Layout
    private func layout() {
        
    }
}

extension MoneyManageTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoneyManageTableViewCell.id, for: indexPath) as? MoneyManageTableViewCell else { return UITableViewCell() }
        
        cell.items = MoneyManageEntity(payType: "교통 🚎", payTypeNum: 2, PayComment: "방콕까지 비행기 값방콕까지 비행기 값방콕까지 비행기 값방콕까지 비행기 값", moneyHistory: "40000000원", timeStamp: Date.now)
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}
