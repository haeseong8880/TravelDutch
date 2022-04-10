//
//  PersonTableViewCell.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/10.
//

import UIKit

class PersonTableViewCell: UITableViewCell {
    //MARK: - Properties
    static let id = "PersonTableViewCell"
    
    var tmpString: String?
    
    private let tmpText = UILabel().then {
        $0.backgroundColor = .gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        tmpText.text = tmpString
        
        layout()
    }
    
    private func layout() {
        [ tmpText ].forEach { addSubview($0) }
        
        tmpText.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.equalToSuperview().inset(10)
        }
    }
}
