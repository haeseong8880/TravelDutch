//
//  MettingTableView.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import Foundation
import UIKit

class MettingTableView: UITableView {
    
    //MARK: - Properties
    
    //MARK: - LifeCycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self
        
        register(MettingTableViewCell.self, forCellReuseIdentifier: MettingTableViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    private func configure() {
        
    }
    
    // MARK: - layout
    private func layout() {
        
    }
    
}

extension MettingTableView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MettingTableViewCell.id, for: indexPath) as? MettingTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(80.0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print("aaaa \(indexPath.row)")
    }

}
