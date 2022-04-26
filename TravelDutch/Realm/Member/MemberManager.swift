//
//  MemberManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/26.
//

import Foundation
import RealmSwift

enum MemberEnum {
    case name
    case money
}

class MemberManager {
    static let shared: MemberManager = MemberManager()
    
    func getAllMember() -> [Member] {
        do {
            let realm = try! Realm()
            let allMembers = realm.objects(Member.self)
            return Array(allMembers)
        } catch {
            print("Error getAllMember \(error.localizedDescription)")
        }
    }
    
    func saveMember(members: Member, onSuccess: @escaping ((Bool) -> Void)) {
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
        return (realm.objects(Member.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
    
    func updateMember(members: Member, newData: String, type: MemberEnum ,onSuccess: @escaping((Bool) -> Void)) {
        do {
            let realm = try! Realm()
            guard let data = realm.objects(Member.self).filter("id == %@", members.id).first else { return }
            try realm.write {
                data.name = newData
            }
            onSuccess(true)
        } catch {
            print("updateMember => \(error.localizedDescription)")
        }
    }
}
