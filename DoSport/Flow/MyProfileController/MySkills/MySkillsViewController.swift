//
//  MySkillsViewController.swift
//  DoSport
//
//  Created by Sergey on 08.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import UIKit

class MySkillsViewController: UIViewController  {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 100, right: 0)
        return scrollView
    }()
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "DoSport")
        imageView.widthAnchor.constraint(equalToConstant: 101).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 21).isActive = true
        return imageView
    }()
    private let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(dismissController), for: .touchUpInside)
        return button
    }()
    private let headerTextField: UILabel = {
        let textField = UILabel(title: "Личный кабинет", height: 32, fontSize: 20)
        textField.layer.borderWidth = 0
        return textField
    }()
    private let skillsTableView: MySkillsTableView = {
        let tableView = MySkillsTableView()
        return tableView
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureUI()
        setGradientBackground(colorTop: #colorLiteral(red: 0.3607843137, green: 0.4980392157, blue: 1, alpha: 1), colorBottom: #colorLiteral(red: 0.8260528445, green: 0.8579083085, blue: 0.998154223, alpha: 1))
    }
    //MARK: - Actions
    @objc func dismissController() {
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Helpers functions and property
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.bounds.size.height = 100
        return datePicker
    }()
    private func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    //MARK: - SetupUI
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        //Расположение лого картинки и гостевой вход
        let topStackView = UIStackView(arrangedSubviews: [
            logoImageView, headerTextField
        ])
        view.addSubview(topStackView)
        topStackView.alignment = .center
        topStackView.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).offset(-20)
        }
        // Расположение кнопок навигации
        let buttonsStackView = UIStackView(arrangedSubviews: [
            backButton, UIView()
        ])
        scrollView.addSubview(buttonsStackView)
        buttonsStackView.snp.makeConstraints { (make) in
            make.top.equalTo(scrollView).offset(20)
            make.trailing.equalTo(view).offset(-20)
            make.leading.equalTo(view).offset(20)
        }

}
}
//extension MySkillsTableView: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//    
////    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
////
////        let cell = tableView.dequeueReusableCell(withIdentifier: "BasketTableViewCell", for: indexPath) as! BasketTableViewCell
////        cell.configure(productName: viewModel.content[indexPath.row].product_name, productPrice: viewModel.content[indexPath.row].price, productCount: viewModel.content[indexPath.row].quantity)
////        return cell
////    }
//}

