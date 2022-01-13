//
//  MainViewController.swift
//  AccordionSection
//
//  Created by William on 13/01/22.
//

import UIKit

class MainViewController: UIViewController {
    private lazy var header: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue
        return view
    }()
    private lazy var scrollView = UIScrollView()
    private lazy var scrollContainer = UIView()
    private lazy var accordion = AccordionTableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        setupUI()
        setupConstraint()

        loadAccordion()
    }

    private func setupUI() {
        self.view.backgroundColor = .white
        scrollContainer.addSubview(accordion)
        scrollView.addSubview(scrollContainer)
        self.view.addSubviews(header, scrollView)
    }

    private func setupConstraint() {
        header.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(56)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(header.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        scrollContainer.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(view.snp.width).multipliedBy(1)
            $0.height.equalTo(view.snp.height).priority(.low)
        }
        accordion.snp.makeConstraints {
            $0.edges.equalTo(scrollContainer)
        }
    }

    private func loadAccordion() {
        // Single Section
        accordion.data = [
            
            [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday",
            ],
            [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday",
            ],
            [
                "Monday",
                "Tuesday",
                "Wednesday",
                "Thursday",
                "Friday",
                "Saturday",
                "Sunday"
            ]
        ]

        // Nested Section
//        let subSection = [AccordionSubSectionModel(subSection: "1 January", child: ["Morning", "Day", "Night"])]
//        let section = AccordionSectionModel(section: "Monday", subSection: subSection)
//        accordion.nestedData = [section]
    }
}
