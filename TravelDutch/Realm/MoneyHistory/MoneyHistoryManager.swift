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
    
    func saveMoneyHistory(history: MoneyHistoryModel, onSuccess: @escaping((Bool) -> Void)) {
        do {
            let realm = try! Realm()
            history.id = autoIncrementID()
            try realm.write{
                realm.add(history)
            }
            onSuccess(true)
        } catch {
            print("Error saveMoneyHistory \(error.localizedDescription)")
        }
    }
    
    private func autoIncrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(MoneyHistoryModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}
