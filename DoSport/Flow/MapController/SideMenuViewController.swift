//
//  SideMenuViewController.swift
//  DoSport
//
//  Created by MAC on 04.11.2020.
//  Copyright © 2020 MAC. All rights reserved.
//

import UIKit

class SideMenuViewController: UIViewController {

    // MARK: - Outlets
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let bottomButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "bottomMap").withRenderingMode(.alwaysOriginal).withTintColor(.black), for: .normal)
        return button
    }()

    // MARK: - Properties
    private let typeOfSports = ["Футбол", "Волейбол", "Баскетбол",
                                "Воркаут", "Бег"]

    // MARK: - Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureTableView()
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeOfSports.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = typeOfSports[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18)
        cell.textLabel?.textColor = .black
        cell.textLabel?.textAlignment = .left
        cell.backgroundColor = .clear
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SetupUI
extension SideMenuViewController {

    private func setupUI() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }

        view.addSubview(bottomButton)
        bottomButton.snp.makeConstraints { (make) in
            make.bottom.trailing.equalTo(view).offset(-20)
            make.height.width.equalTo(30)
        }
    }

    private func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 0.860845089, green: 0.898216784, blue: 0.9998374581, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
}
