//
//  ViewController.swift
//  ExpandableTableView
//
//  Created by Takeru Sato on 2018/12/30.
//  Copyright © 2018 son. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {
    
    private var tableView: UITableView!
    
    private var isIndexPathShown = false
    
    private var twoDimensionArray = [
        ExpandableNames(isExpanded: true, names: ["son", "sato", "takru", "jobs", "steve", "elon", "mask"]),
        ExpandableNames(isExpanded: true, names: ["sam", "json", "max", "jodan"]),
        ExpandableNames(isExpanded: true, names: ["david", "dan"]),
        ExpandableNames(isExpanded: true, names: ["mark", "walberg"])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        addConstraint()
    }
    
    private func setupSubview() {
        navigationItem.title = "Contact"
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show IndexPath", style: .plain, target: self, action: #selector(showIndexPathButtonTapped))
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.description())
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
    }
    
    private func addConstraint() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    @objc private func showIndexPathButtonTapped() {
        var indexPathsToReload = [IndexPath]()
        for section in twoDimensionArray.indices {
            for row in twoDimensionArray[section].names.indices {
                let indexPath = IndexPath(row: row, section: section)
                indexPathsToReload.append(indexPath)
            }
        }
        isIndexPathShown.toggle()
        let animationStyle = isIndexPathShown ? UITableView.RowAnimation.right : .left
        tableView.reloadRows(at: indexPathsToReload, with: animationStyle)
    }
    
    @objc private func scaleSectionButtonTapped(button: UIButton) {
        let section = button.tag
        var indexPaths = [IndexPath]()
        for row in twoDimensionArray[section].names.indices {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        let isExpanded = twoDimensionArray[section].isExpanded
        twoDimensionArray[section].isExpanded = !isExpanded
        button.setTitle(isExpanded ? "Open" : "Close", for: .normal)
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        } else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(scaleSectionButtonTapped), for: .touchUpInside)
        button.tag = section
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 34
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return twoDimensionArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if !twoDimensionArray[section].isExpanded {
            return 0
        }
        return twoDimensionArray[section].names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.description(), for: indexPath)
        let name = twoDimensionArray[indexPath.section].names[indexPath.row]
        cell.textLabel?.text = name
        if isIndexPathShown {
            cell.textLabel?.text = "\(name)    section: \(indexPath.section) row: \(indexPath.row)"
        }
        cell.selectionStyle = .none
        return cell
    }
}

