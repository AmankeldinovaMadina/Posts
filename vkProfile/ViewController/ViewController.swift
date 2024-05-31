import UIKit
import CoreData
import SnapKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    var posts = [Post]()
    var photos = [Photo]()
    var moc: NSManagedObjectContext!
    let appDelegate = UIApplication.shared.delegate as? AppDelegate

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PostViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.register(ProfileHeaderTableViewCell.self, forCellReuseIdentifier: "ProfileHeaderCell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moc = appDelegate?.persistentContainer.viewContext
        view.backgroundColor = UIColor.white

        setupUI()
        loadData()
        loadPhotos() 
    }

    func setupUI() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self

        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
 
    func loadPhotos() {
        let request: NSFetchRequest<Photo> = Photo.fetchRequest()
        do {
            photos = try moc.fetch(request)
            tableView.reloadData()
        } catch {
            print("Failed to fetch photos: \(error)")
        }
    }
 
    func loadData() {
        let request: NSFetchRequest<Post> = Post.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        
        do {
            posts = try moc.fetch(request)
            tableView.reloadData()
        } catch {
            print("Failed to fetch posts: \(error)")
        }
    }

    @objc func togglePostLike(_ sender: UIButton) {
        let post = posts[sender.tag]
        post.isLiked.toggle()
        appDelegate?.saveContext()
        tableView.reloadData()
    }

    @objc func editPost(_ sender: UIButton) {
        let post = posts[sender.tag]
        presentEditPostAlert(for: post)
    }

    func presentEditPostAlert(for post: Post) {
        let alertController = UIAlertController(title: "Edit Post", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.text = post.text
        }
        alertController.addTextField { textField in
            textField.text = post.image?.absoluteString
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] _ in
            guard let self = self else { return }
            guard let textFields = alertController.textFields,
                  let postText = textFields[0].text, !postText.isEmpty,
                  let imageUrlString = textFields[1].text, !imageUrlString.isEmpty,
                  let imageUrl = URL(string: imageUrlString) else {
                print("Invalid input")
                return
            }
            self.updatePost(post: post, text: postText, imageUrl: imageUrl)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func updatePost(post: Post, text: String, imageUrl: URL) {
        let dataController = DataController()
        dataController.editStatus(post: post, text: text, image: imageUrl, context: moc)
        loadData()
    }

    // MARK: - UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileHeaderCell", for: indexPath) as! ProfileHeaderTableViewCell
            cell.viewAllPhotosButton.addTarget(self, action: #selector(viewAllPhotosTapped), for: .touchUpInside)
            cell.collectionView.delegate = self
            cell.collectionView.dataSource = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostViewCell
            let post = posts[indexPath.row]
            cell.configure(with: post)
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(togglePostLike(_:)), for: .touchUpInside)
            cell.editButton.tag = indexPath.row
            cell.editButton.addTarget(self, action: #selector(editPost(_:)), for: .touchUpInside)
            return cell
        }
    }

    @objc func viewAllPhotosTapped() {
        let allPhotosVC = AllPhotosViewController()
        allPhotosVC.photos = photos
        navigationController?.pushViewController(allPhotosVC, animated: true)
    }

    // MARK: - UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = photos[indexPath.item]
        if let url = photo.image {
            cell.imageView.kf.setImage(with: url)
        }
        return cell
    }

}
