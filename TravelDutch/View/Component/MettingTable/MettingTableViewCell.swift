//
//  MettingTableViewCell.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/09.
//

import Foundation
import UIKit
import SnapKit

class MettingTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    private let tmpLabel = UILabel().then {
        $0.text = "임시 모임"
    }
    private let mainClickImage = UIImageView().then {
        $0.image = UIImage(systemName: "checkmark")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
    }
    
    // MARK: - LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - configure
    private func configure() {
        self.layer.cornerRadius = 5
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16))
        
    }
    
    // MARK: - layout
    private func layout() {
        [ tmpLabel, mainClickImage ].forEach { addSubview($0) }

        mainClickImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.leading.centerY.equalToSuperview()
        }

        tmpLabel.snp.makeConstraints {
            $0.leading.equalTo(mainClickImage.snp.trailing).offset(10)
            $0.top.bottom.equalToSuperview().offset(10)
        }
    }
}
