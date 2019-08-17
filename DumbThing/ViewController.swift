//
//  ViewController.swift
//  DumbThing
//
//  Created by Jeffrey Blagdon on 8/8/17.
//  Copyright © 2017 Jeff. All rights reserved.
//

import UIKit

extension UIColor {
    static func random() -> UIColor {
        let (r, g, b) = (arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255))
        return UIColor(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: 1)
    }
}

class DumbCell: UITableViewCell {
    lazy var vConstraint: NSLayoutConstraint = {
        NSLayoutConstraint(item: self.contentView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        vConstraint.isActive = true
    }

    override func prepareForReuse() {
        vConstraint.constant = 100
    }
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let hConstraints = NSLayoutConstraint.constraints(withVisualFormat: "|[table]|", options: [], metrics: nil, views: ["table": tableView])
        let vConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[tlg][table][blg]", options: [], metrics: nil, views: ["tlg": topLayoutGuide, "table": tableView, "blg": bottomLayoutGuide])
        NSLayoutConstraint.activate(hConstraints + vConstraints)
        tableView.register(DumbCell.self)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: DumbCell = tableView.dequeue() else { return UITableViewCell() }
        cell.contentView.backgroundColor = .random()
        if indexPath.row == 4 {
            DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + .milliseconds(300)) {
                DispatchQueue.main.async {
                    tableView.beginUpdates()
                    cell.vConstraint.constant = 300
                    tableView.endUpdates()
                }
            }
        }
        return cell
    }
}

