//
//  MainMenuTabController.swift
//  DoSportProject
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class CustomTabView: UIView {

    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        self.isUserInteractionEnabled = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowOpacity = 0.7
        self.layer.shadowRadius = 4

        for item in 0..<menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = itemWidth * CGFloat(item)
            let itemView = self.createTabItem(item: menuItems[item])
            itemView.tag = item
            self.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false

            NSLayoutConstraint.activate([
                    itemView.heightAnchor.constraint(equalTo: self.heightAnchor),
                    itemView.widthAnchor.constraint(equalToConstant: itemWidth),
                    itemView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                    itemView.topAnchor.constraint(equalTo: self.topAnchor)
                ])
        }
        self.setNeedsLayout()
        self.layoutIfNeeded()
        self.activateTab(tab: 0)
    }

    func createTabItem(item: TabItem) -> UIView {
        let tabBarItem = UIView()
        let itemTitleLabel = UILabel()
        let itemIconView = UIImageView()
        let itemView = UIView()

        itemView.tag = 10
        itemView.translatesAutoresizingMaskIntoConstraints = false
        itemView.layer.backgroundColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)

        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.font = UIFont.systemFont(ofSize: 12)
        itemTitleLabel.textColor = .white
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.numberOfLines = 0

        itemIconView.image = item.icon!.withRenderingMode(.automatic)
        itemIconView.contentMode = .scaleAspectFit
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true

        tabBarItem.addSubview(itemView)
        itemView.addSubview(itemIconView)
        itemView.addSubview(itemTitleLabel)

        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: tabBarItem.topAnchor),
            itemView.bottomAnchor.constraint(equalTo: tabBarItem.bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: tabBarItem.leadingAnchor),
            itemView.trailingAnchor.constraint(equalTo: tabBarItem.trailingAnchor),

            itemIconView.heightAnchor.constraint(equalToConstant: 20),
            itemIconView.widthAnchor.constraint(equalToConstant: 20),
            itemIconView.topAnchor.constraint(equalTo: itemView.topAnchor, constant: 7),
            itemIconView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            itemIconView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),

            itemTitleLabel.topAnchor.constraint(equalTo: itemIconView.bottomAnchor, constant: -5),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            itemTitleLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
            itemTitleLabel.centerYAnchor.constraint(equalTo: itemView.centerYAnchor)
        ])

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap))
        tabBarItem.addGestureRecognizer(tapGesture)
        return tabBarItem
    }

    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, too: sender.view!.tag)
    }

    func switchTab(from: Int, too: Int) {
        deActivateTab(tab: from)
        activateTab(tab: too)
    }

    func activateTab(tab: Int) {
        let tabToActivate = self.subviews[tab]
        tabToActivate.viewWithTag(10)?.backgroundColor = #colorLiteral(red: 0.2595242858, green: 0.4154637456, blue: 0.9985032678, alpha: 1)
        self.itemTapped?(tab)
        self.activeItem = tab
    }

    func deActivateTab(tab: Int) {
        let inactiveTab = self.subviews[tab]
        inactiveTab.viewWithTag(10)?.backgroundColor = #colorLiteral(red: 0.3619202375, green: 0.4967799783, blue: 1, alpha: 1)
    }
}
