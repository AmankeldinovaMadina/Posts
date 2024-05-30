 
import Foundation
import CoreData


extension Post {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Post> {
        return NSFetchRequest<Post>(entityName: "Post")
    }

    @NSManaged public var text: String?
    @NSManaged public var image: URL?
    @NSManaged public var id: UUID?
    @NSManaged public var date: Date?
    @NSManaged public var isLiked: Bool

}
