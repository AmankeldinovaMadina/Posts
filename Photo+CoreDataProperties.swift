//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Madina Amankeldinova on 31.05.2024.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var image: URL?
    @NSManaged public var id: UUID?

}
