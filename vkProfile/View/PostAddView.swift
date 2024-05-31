import UIKit
import SnapKit

class PostAddView: UIView {
    
    let postTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter post text"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let imageUrlTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter image URL"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    
    let submitButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    let formStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        // Add subviews
        addSubview(formStackView)
        formStackView.addArrangedSubview(postTextField)
        formStackView.addArrangedSubview(imageUrlTextField)
        formStackView.addArrangedSubview(submitButton)
        
        // Setup constraints using SnapKit
        formStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(20)
        }
    }
}
