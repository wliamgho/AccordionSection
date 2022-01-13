////
////  AccordionSectionCell.swift
////  AccordionSection
////
////  Created by William on 13/01/22.
////
//
//import SnapKit
//import UIKit
//
//class AccordionSubSectionView: UIView {
//    private lazy var stack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        return stack
//    }()
//
//    private lazy var section: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = .boldSystemFont(ofSize: 12)
//        return label
//    }()
//
//    private lazy var child = AccordionSubChildView()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func bind(data: AccordionSubSectionModel) {
//        section.text = data.subSection
////        data.forEach {
////            let label = UILabel()
////            label.text = $0.subSection
////            label.font = .boldSystemFont(ofSize: 12)
////            stack.addMultipleArrangeSubviews(label)
////        }
//    }
//
//    private func setupUI() {
//        stack.addMultipleArrangeSubviews(section)
//        self.addSubview(stack)
//
//        stack.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(8)
//            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview()
//            $0.bottom.equalToSuperview().offset(-8)
//        }
//    }
//}
//
//class AccordionSubChildView: UIView {
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func setupUI() {}
//}
//
//class AccordionSectionCell: UITableViewCell {
//    private lazy var stack: UIStackView = {
//        let stack = UIStackView()
//        stack.axis = .vertical
//        stack.backgroundColor = .clear
//        return stack
//    }()
//
//    private lazy var sectionLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .black
//        label.font = .boldSystemFont(ofSize: 14)
//        return label
//    }()
//
//    private lazy var subSection = [AccordionSubSectionView]()
//    private(set) var data: AccordionSectionModel?
//
//    var openedSubSection: Int? {
//        didSet {
//            didSelectedSection()
//        }
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupUI()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//        selectionStyle = .none
//    }
//
//    func bind(data: AccordionSectionModel) {
//        self.data = data
//        sectionLabel.text = data.section
//
//        data.subSection.forEach {
//            let item = AccordionSubSectionView()
//            item.bind(data: $0)
//            item.isHidden = true
//            subSection.append(item)
//            stack.addMultipleArrangeSubviews(item)
//        }
//    }
//
//    private func setupUI() {
//        self.backgroundColor = .clear
//        stack.addArrangedSubview(sectionLabel)
//        self.addSubview(stack)
//
//        stack.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(8)
//            $0.leading.equalToSuperview().offset(16)
//            $0.trailing.equalToSuperview().offset(-16)
//            $0.bottom.equalToSuperview().offset(-8)
//        }
//    }
//
//    private func didSelectedSection() {
//        guard let openedSubSection = openedSubSection else { return }
//        subSection[openedSubSection].isHidden = false
////        data?.subSection[openedSubSection]
//    }
//}
