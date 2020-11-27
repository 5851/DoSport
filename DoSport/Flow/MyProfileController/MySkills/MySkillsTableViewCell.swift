//
//  MySkillsTableViewCell.swift
//  DoSport
//
//  Created by Sergey on 09.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit

class MySkillsTableViewCell:  UITableViewCell {
    
    private let sportType: UILabel = {
        let label = UILabel()
        return label
    }()
    private let skillRate: StarIcon = {
        let view = StarIcon()
        return view
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.sportType.font = UIFont.halantRegular(size: 10)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func configure(sportType: String, skillRate: Int) {
//        self.sportType.text = String(productPrice)
//        self.skillRate.text = String(productCount)
    }
        override func prepareForReuse() {
            super.prepareForReuse()
        }
}

class StarIcon: UIView {
    
    var starStackView = UIStackView()
    var arrImageViews = [UIImageView]()
    let starsQuantity = 5
    var ratingNumber = 0
    init(){
        super.init(frame: .zero)
        setUpStarStack()
        setUpUnfilledStars()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpStarStackWithStars(_ stars: Int) {
        for index in 0..<stars {
            arrImageViews[index].image = UIImage(named: "starFillIcon")
        }
    }
    func setUpUnfilledStars() {
        for _ in 0..<starsQuantity {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "starIcon")
            imageView.tintColor = .red
            starStackView.addArrangedSubview(imageView)
            arrImageViews.append(imageView)
        }
    }
    func setUpStarStack() {
        starStackView.axis = .horizontal
        starStackView.distribution = .fillEqually
        starStackView.alignment = .fill
        starStackView.spacing = 24
        starStackView.tag = 5007
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(starStackView)
        starStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        starStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        starStackView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        starStackView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
    }
    func handleTouchAtLocation(withTouches touches:Set<UITouch>) {
        let touchLocation = touches.first
        let location = touchLocation?.location(in: starStackView)
        if(touchLocation?.view?.tag == 5007) {
            
            arrImageViews.forEach({ (imageView) in
                if ((location?.x)! > imageView.frame.origin.x) {
                    let index = arrImageViews.firstIndex(of: imageView)
                    ratingNumber = index! + 1
                    imageView.image = UIImage(named: "starFillIcon")
                } else {
                    if(imageView.tag != 5100){
                        imageView.image = UIImage(named: "starIcon")
                    }
                }
            })
        }
    }
}

//override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        starIconView.handleTouchAtLocation(withTouches: touches)
//        print("\(#function) \(starIconView.ratingNumber)")
//    }
//    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        starIconView.handleTouchAtLocation(withTouches: touches)
//        print("\(#function) \(starIconView.ratingNumber)")
//    }
