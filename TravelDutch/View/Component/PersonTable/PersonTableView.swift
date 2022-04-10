//
//  PersonTableView.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/10.
//

import UIKit

class PersonTableView: UITableView {
    
    //MARK: - Properties
    var tmpList: Array<String> = []
    
    //MARK: - LifeCycle
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.delegate = self
        self.dataSource = self

        register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.id)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableReload(item: String){
        tmpList.append(item)
        self.reloadData()
        print(tmpList)
    }
    
    // MARK: - configure
    private func configure() {
        
    }
    
    // MARK: - layout
    private func layout() {
        
    }
}

extension PersonTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tmpList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.id, for: indexPath) as? PersonTableViewCell else { return UITableViewCell() }
        
        cell.tmpString = tmpList[indexPath.row]
        return cell
    }
    
    
}
