import UIKit
import SnapKit

class ProfileHeaderTableViewCell: UITableViewCell {
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "avatar")
        return imageView
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Ryu Seon-Jae"  
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = .white
        label.shadowColor = UIColor.black.withAlphaComponent(0.5)
        label.shadowOffset = CGSize(width: 1, height: 1)
        return label
    }()

    let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "I am a top star who has been in the spotlight since his debut."
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        label.shadowColor = UIColor.black.withAlphaComponent(0.5)
        label.shadowOffset = CGSize(width: 1, height: 1)
        label.numberOfLines = 0
        return label
    }()

    let addPostButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Post", for: .normal)
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
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bioLabel)
        contentView.addSubview(addPostButton)

        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(200)
        }

        nameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(profileImageView.snp.bottom).offset(-20)
            make.left.equalTo(profileImageView.snp.left).offset(20)
            make.right.equalTo(profileImageView.snp.right).offset(-20)
        }

        bioLabel.snp.makeConstraints { make in
            make.bottom.equalTo(nameLabel.snp.top).offset(-4)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(nameLabel.snp.right)
        }

        addPostButton.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
    }
}
