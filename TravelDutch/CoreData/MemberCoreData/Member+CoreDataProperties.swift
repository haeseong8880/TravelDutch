//
//  Member+CoreDataProperties.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/20.
//
//

import Foundation
import CoreData


extension MemberMoney {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MemberMoney> {
        return NSFetchRequest<MemberMoney>(entityName: "MemberMoney")
    }

    @NSManaged public var id: Int64
    @NSManaged public var memberName: String?
    @NSManaged public var getMoney: Int64

}

extension MemberMoney : Identifiable {

}
