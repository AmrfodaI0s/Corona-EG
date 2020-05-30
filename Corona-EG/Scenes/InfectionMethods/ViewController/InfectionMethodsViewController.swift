//
//  InfectionMethodsViewController.swift
//  Corona-EG
//
//  Created by Abdelrhman Eliwa on 5/29/20.
//  Copyright © 2020 Abdelrhman Eliwa. All rights reserved.
//

import UIKit

class InfectionMethodsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let data = InfectionMethodData().data
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}


// MARK: - Setup TableView
extension InfectionMethodsViewController: UITableViewDelegate, UITableViewDataSource {
    private enum Constants {
        static let nibName = "InfectionMethodCell"
        static let cellIdentifier = "InfectionMethodCell"
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(
            UINib(nibName: Constants.nibName, bundle: nil),
            forCellReuseIdentifier: Constants.cellIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath) as! InfectionMethodCell
        cell.questionLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: data[indexPath.row].question, comment: "")
        cell.answerLabel.text = LocalizationSystem.sharedInstance.localizedStringForKey(key: data[indexPath.row].answer, comment: "")
        return cell
    }
    
}
