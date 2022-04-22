//
//  Destination+CoreDataProperties.swift
//  TravelDutch
//
//  Created by haeseongJung on 2022/04/19.
//
//

import Foundation
import CoreData


extension Destination {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Destination> {
        return NSFetchRequest<Destination>(entityName: "Destination")
    }
    
    @NSManaged public var destination_ko: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double

}

extension Destination : Identifiable {

}
