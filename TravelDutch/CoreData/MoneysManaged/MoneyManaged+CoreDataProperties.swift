//
//  MoneyManaged+CoreDataProperties.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/21.
//
//

import Foundation
import CoreData


extension MoneysManaged {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoneysManaged> {
        return NSFetchRequest<MoneysManaged>(entityName: "MoneysManaged")
    }

    @NSManaged public var payType: String?
    @NSManaged public var whereUseMoney: String?
    @NSManaged public var useMoney: String?

}

extension MoneysManaged : Identifiable {

}
