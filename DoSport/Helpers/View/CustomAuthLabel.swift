import UIKit

class CustomAuthLabel: UILabel {

    let title: String
    let fontSize: CGFloat
    let fontWeight: UIFont.Weight
    let color: UIColor

    init(title: String, fontSize: CGFloat, fontWeight: UIFont.Weight, color: UIColor) {
        self.title = title
        self.fontSize = fontSize
        self.fontWeight = fontWeight
        self.color = color
        super.init(frame: .zero)
        text = title
        font = UIFont.systemFont(ofSize: fontSize, weight: fontWeight)
        textAlignment = .center
        textColor = color
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
