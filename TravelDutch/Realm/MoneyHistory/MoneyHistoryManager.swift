//
//  MoneyHistoryManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/27.
//

import Foundation
import RealmSwift

class MoneyHistoryManager {
    static let shared: MoneyHistoryManager = MoneyHistoryManager()
    
    func getAllMoneyHistory() -> [MoneyHistoryModel] {
        do {
            let realm = try! Realm()
            let allMembers = realm.objects(MoneyHistoryModel.self)
            return Array(allMembers)
        } catch {
            print("Error getAllMember \(error.localizedDescription)")
        }
    }
}
