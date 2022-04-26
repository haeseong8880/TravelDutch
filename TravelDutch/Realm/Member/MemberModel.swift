//
//  MemberModel.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/26.
//

import Foundation
import RealmSwift

class Member: Object {
    @Persisted var id: Int = 0
    @Persisted var money: String = ""
    @Persisted var name: String = ""
    
    // id 가 고유 값입니다.
    override static func primaryKey() -> String? {
        return "id"
    }
}
