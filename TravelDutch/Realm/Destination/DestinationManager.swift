//
//  DestinationManager.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/26.
//

import RealmSwift

class DestinationManager {
    static let shared: DestinationManager = DestinationManager()
    
    func getDestination() -> Destination? {
        do {
            let realm = try! Realm()
            let destination = realm.objects(Destination.self).first
            return destination
        } catch {
            print("Error getDestination \(error.localizedDescription)")
        }
    }
    
    func saveDestination(destination: Destination, onSuccess: @escaping ((Bool) -> Void)) {
        do{
            let realm = try! Realm()
            try realm.write{
                realm.add(destination)
            }
            onSuccess(true)
        } catch {
            print("Error saveDestination \(error.localizedDescription)")
        }
    }
    
    func deleteDestination(onSuccess: @escaping ((Bool) -> Void)) {
        do {
            let realm = try! Realm()
            let deleteItem: Destination = self.getDestination()!
            try! realm.write {
                realm.delete(deleteItem)
            }
            onSuccess(true)
        } catch {
            print("Error deleteDestination \(error.localizedDescription)")
        }
    }
}
