//
//  DataViewController.swift
//  Swift-Sample-UIPageViewController+modal
//
//  Created by A10 Lab Inc. nobuy on 2018/07/11.
//  Copyright © 2018年 A10 Lab Inc. nobuy. All rights reserved.
//

import UIKit

class DataViewController: UIViewController {

    let item: DataItem

    private let identifier = "cell"

    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 10))
        tableView.tableFooterView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 10))
        tableView.rowHeight = UITableViewAutomaticDimension
        return tableView
    }()

    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.layer.cornerRadius = 10
        button.setTitleColor(UIColor.white, for: UIControlState())
        button.titleLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 20)
        button.setTitle("close", for: UIControlState())
        return button
    }()

    init(item: DataItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.item = DataItem(title: "red", color: .red, contents: ["hoge"])
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        closeButton.addTarget(self, action: #selector(self.closeTapped(_:)), for: .touchUpInside)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true

        view.addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        closeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }

    @objc func closeTapped(_ sender: UIButton) {
        closeButton.isHidden = true
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension DataViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.contents.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = item.contents[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate
extension DataViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
