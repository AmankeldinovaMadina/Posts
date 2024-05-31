//
//  Post+CoreDataProperties.swift
//  
//
//  Created by Madina Amankeldinova on 31.05.2024.
//
//

import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var image: URL?
    @NSManaged public var isLiked: Bool
    @NSManaged public var text: String?

}
