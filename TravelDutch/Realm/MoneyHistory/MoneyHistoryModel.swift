//
//  MoneyHistoryModel.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/27.
//

import Foundation
import RealmSwift

class MoneyHistoryModel: Object {
    @Persisted var id: Int = 0
    @Persisted var moneyHistory: String = ""
    @Persisted var payComment: String = ""
    @Persisted var payType: String = ""
    @Persisted var timeStamp: String = ""
    
    // id 가 고유 값입니다.
    override static func primaryKey() -> String? {
        return "id"
    }
}
