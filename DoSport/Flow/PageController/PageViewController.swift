//
//  PageViewController.swift
//  DoSportProject
//
//  Created by MAC on 11.10.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    // MARK: - Outlets
    var myControllers = [UIViewController]()

    // MARK: - View lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let viewController = UIViewController()
        viewController.view.backgroundColor = .red
        myControllers.append(viewController)

        let viewController1 = UIViewController()
        viewController1.view.backgroundColor = .green
        myControllers.append(viewController1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentPageVC()
    }

    func presentPageVC() {
        guard let first = myControllers.first else {
            return
        }
        let pageVC = UIPageViewController(transitionStyle: .scroll,
                                                  navigationOrientation: .horizontal,
                                                  options: nil)
        pageVC.delegate = self
        pageVC.dataSource = self
        pageVC.setViewControllers([first],
                              direction: .forward,
                              animated: true,
                              completion: nil)
        pageVC.modalPresentationStyle = .fullScreen
        present(pageVC, animated: true)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource
extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index > 0 else {
            return nil
        }
        let before = index - 1

        return myControllers[before]
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = myControllers.firstIndex(of: viewController), index < (myControllers.count - 1) else {
            return nil
        }
        let after = index + 1

        return myControllers[after]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.myControllers.count
    }

//    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
//        return self.currentIndex
//    }
}
