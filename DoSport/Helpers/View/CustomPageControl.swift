//
//  CustomPageControl.swift
//  DoSport
//
//  Created by MAC on 15.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class CustomPageControl: UIPageControl {

    var pageCount: Int

    init(pageCount: Int) {
        self.pageCount = pageCount
        super.init(frame: .zero)

        currentPage = 0
        numberOfPages = pageCount
        let image = UIImage.outlinedEllipse(size: CGSize(width: 7.0, height: 7.0), color: UIColor.mainBlue)
        pageIndicatorTintColor = UIColor.init(patternImage: image!)
        currentPageIndicatorTintColor = UIColor.mainBlue
        subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
