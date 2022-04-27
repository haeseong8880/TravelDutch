//
//  MemberManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/26.
//

import Foundation
import RealmSwift

class MemberManager {
    static let shared: MemberManager = MemberManager()
    
    func getAllMember() -> [MemberModel] {
        do {
            let realm = try! Realm()
            let allMembers = realm.objects(MemberModel.self)
            return Array(allMembers)
        } catch {
            print("Error getAllMember \(error.localizedDescription)")
        }
    }
    
    func saveMember(members: MemberModel, onSuccess: @escaping ((Bool) -> Void)) {
        do {
            let realm = try! Realm()
            members.id = autoIncrementID()
            try realm.write{
                realm.add(members)
            }
            onSuccess(true)
        } catch {
            print("saveMember => \(error.localizedDescription)")
        }
    }
    
    func autoIncrementID() -> Int {
        let realm = try! Realm()
        return (realm.objects(MemberModel.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func updateMember(with: MemberModel, newData: String, type: MemberEnum ,onSuccess: @escaping((Bool) -> Void)) {
        do {
            let realm = try! Realm()
            guard let data = realm.objects(MemberModel.self).filter("id == %@", with.id).first else { return }
            if type == .name {
                try realm.write {
                    data.name = newData
                }
            }
            else if type == .money {
                try realm.write {
                    data.money = newData
                }
            }
            print(data)
            onSuccess(true)
        } catch {
            print("updateMember => \(error.localizedDescription)")
        }
    }
    
    func deleteMember(with: MemberModel, onSucess: @escaping((Bool) -> Void)) {
        do {
            let realm = try! Realm()
            guard let data = realm.objects(MemberModel.self).filter("id == %@", with.id).first else { return }
            try realm.write {
                realm.delete(data)
            }
            onSucess(true)
        } catch {
            print("deleteMember ====> \(error.localizedDescription)")
        }
    }
}
