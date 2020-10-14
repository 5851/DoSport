import UIKit

class CustomTextField: UITextField {

    // MARK: - Variables
    let cornerRadius: CGFloat
    let height: CGFloat
    let fontSize: CGFloat
    let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)

    // MARK: - Init
    init(cornerRadius: CGFloat, height: CGFloat, fontSize: CGFloat, labelText: String) {
        self.cornerRadius = cornerRadius
        self.height = height
        self.fontSize = fontSize
        super.init(frame: .zero)
        let placeholderString = NSAttributedString(
            string: labelText,
            attributes: [NSAttributedString.Key.font: UIFont.halantRegular(size: fontSize)])
        self.attributedPlaceholder = placeholderString
        placeholder = labelText
        textColor = .gray
        backgroundColor = .white
        layer.cornerRadius = cornerRadius
        font = UIFont.halantRegular(size: fontSize)
        delegate = self
        borderStyle = .none
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup UI
    override var intrinsicContentSize: CGSize {
        return .init(width: 0, height: height)
    }
}

// MARK: - UITextFieldDelegate
extension CustomTextField: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
      return bounds.inset(by: padding)
    }
}
