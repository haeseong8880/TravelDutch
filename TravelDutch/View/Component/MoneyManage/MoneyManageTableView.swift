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
    private var moneyHistoryList: [MoneyHistoryModel] = []
    
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
        let moneyHistory = MoneyHistoryManager.shared.getAllMoneyHistory()
        if !moneyHistory.isEmpty {
            moneyHistoryList = moneyHistory
        }
    }
    
    // MARK: - Layout
    private func layout() {
        
    }
    
    func tableReload(history: MoneyHistoryModel){
        DispatchQueue.main.async {
            self.moneyHistoryList.append(history)
            self.reloadData()
        }
    }
}

extension MoneyManageTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moneyHistoryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MoneyManageTableViewCell.id, for: indexPath) as? MoneyManageTableViewCell else { return UITableViewCell() }
        moneyHistoryList.forEach { result in
            cell.item = result
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
