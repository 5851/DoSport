//
//  MainMenuTabController.swift
//  DoSportProject
//
//  Created by MAC on 19.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class MainMenuTabController: UITabBarController {

    var customTabBar: CustomTabView!
    var tabBarHeight: CGFloat = 80.0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTabBar()
        delegate = self
    }

    private func loadTabBar() {
        let tabItems: [TabItem] = [.mainMenu, .chat, .privatCabinet]
        self.setupCustomTabBar(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        self.selectedIndex = 0
    }

    private func setupCustomTabBar(_ items: [TabItem],
                                   completion: @escaping ([UIViewController]) -> Void) {
        let frame = CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.x, width: tabBar.frame.width, height: tabBarHeight)

        var controllers = [UIViewController]()

        tabBar.isHidden = true

        self.customTabBar = CustomTabView(menuItems: items, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.itemTapped = self.changeTab

        self.view.addSubview(customTabBar)

        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.widthAnchor.constraint(equalToConstant: tabBar.frame.width),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])

        for item in 0 ..< items.count {
            controllers.append(items[item].viewController)
        }

        self.view.layoutIfNeeded()
        completion(controllers)
    }

    func changeTab(tab: Int) {
        self.selectedIndex = tab
        print("selected: \(self.selectedIndex) ")
        print("controller: \(self.viewControllers![self.selectedIndex])")
    }
}

// Animation change viewControllers
extension MainMenuTabController: UITabBarControllerDelegate {

    func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MyTransition(viewControllers: tabBarController.viewControllers)
    }
}

class MyTransition: NSObject, UIViewControllerAnimatedTransitioning {

    let viewControllers: [UIViewController]?
    let transitionDuration: Double = 0.25

    init(viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(for: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(for: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart

        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(withDuration: self.transitionDuration, animations: {
                fromView.frame = fromFrameEnd
                toView.frame = frame
            }, completion: {success in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(success)
            })
        }
    }

    func getIndex(for controller: UIViewController) -> Int? {
        guard let vcs = self.viewControllers else { return nil }
        for (index, thisVC) in vcs.enumerated() {
            if thisVC == controller {
                return index
            } else {

            }
        }
        return nil
    }
}
