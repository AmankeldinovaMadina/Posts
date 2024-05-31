import Foundation
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "vkProfile")
    
    init() {
        container.loadPersistentStores{ desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved successfully!")
        } catch {
            print("Data was not saved")
        }
    }
    
    
    func addPost(text: String, image: URL?, context: NSManagedObjectContext) {
        let post = Post(context: context)
        post.id = UUID()
        post.date = Date()
        post.text = text
        post.image = image
        post.isLiked = false
        
        save(context: context)
    }
    
    
    func editStatus(post: Post, text: String, image: URL, context: NSManagedObjectContext) {
        post.date = Date()
        post.text = text
        post.image = image
        
        save(context: context)
    }
    
    func addImage(image: URL, context: NSManagedObjectContext ) {
        let picture = Photo(context: context)
        picture.id = UUID()
        picture.image = image
        
        save(context: context)
    }
}

