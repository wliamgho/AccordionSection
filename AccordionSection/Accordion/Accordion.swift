//
//  Accordion.swift
//  AccordionSection
//
//  Created by William on 13/01/22.
//

import UIKit
import SnapKit

class Accordion: UIView {
    private lazy var tableView: UITableView = {
        let table = UITableView()
//        table.estimatedRowHeight = 68
        table.rowHeight = UITableView.automaticDimension
        table.register(
            AccordionSectionCell.self,
            forCellReuseIdentifier: "AccordionSectionCell"
        )
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        return table
    }()

    var data = [AccordionSectionModel]()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.addSubview(tableView)

        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}

extension Accordion: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AccordionSectionCell",
            for: indexPath
        ) as! AccordionSectionCell
//        cell.bind(data: data[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! AccordionSectionCell
//        cell.openedSubSection = indexPath.row
    }
}
