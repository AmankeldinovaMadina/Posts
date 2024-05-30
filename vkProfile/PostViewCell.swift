import UIKit
import SnapKit
import Kingfisher

class PostViewCell: UITableViewCell {
    let postTextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let likeButton: UIButton = {
        let button = UIButton(type: .system)
        return button
    }()
    
    let timestampLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .gray
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(postTextLabel)
        contentView.addSubview(postImageView)
        contentView.addSubview(likeButton)
        contentView.addSubview(timestampLabel)
        contentView.addSubview(editButton)
        
        // Set up constraints
        postTextLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        postImageView.snp.makeConstraints { make in
            make.top.equalTo(postTextLabel.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(200)
        }
        
        likeButton.snp.makeConstraints { make in
            make.top.equalTo(postImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-8)
        }
        
        timestampLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-8)
            make.right.equalToSuperview().offset(-16)
        }
        
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-16)
        }
    }
    
    func configure(with post: Post) {
        postTextLabel.text = post.text
        if let imageUrl = post.image {
            postImageView.kf.setImage(with: imageUrl)
        }
        timestampLabel.text = calcTimeSince(date: post.date ?? Date())
        updateLikeButton(isLiked: post.isLiked)
    }
    
    private func updateLikeButton(isLiked: Bool) {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            likeButton.tintColor = .red
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
            likeButton.tintColor = .gray
        }
    }
}
