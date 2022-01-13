//
//  AccordionSectionCell.swift
//  AccordionSection
//
//  Created by William on 13/01/22.
//

import UIKit

class AccordionSectionCell: BaseAccordionTableViewCell {
    private lazy var stack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .vertical
        return stack
    }()
    private lazy var hStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.axis = .horizontal
        return stack
    }()
    lazy var arrowContainer = UIView()
    lazy var arrow: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "ic_accordion")
        img.tintColor = .white
        return img
    }()

    lazy var section = UILabel()
    lazy var detailView = UIView()
    lazy var img = UIImageView()

    static let reuseIdentifier = "AccordionSectionCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }

    private func setupUI() {
        self.backgroundColor = .clear
        arrowContainer.addSubview(arrow)
        hStack.addMultipleArrangeSubviews(section, arrowContainer)
        detailView.addSubview(img)
        stack.addMultipleArrangeSubviews(hStack, detailView)
        self.addSubview(stack)
        stack.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-16)
        }
        arrow.snp.makeConstraints {
            $0.centerY.centerX.equalTo(arrowContainer)
            $0.width.equalTo(16)
            $0.height.equalTo(16)
        }
        img.snp.makeConstraints {
            $0.edges.equalTo(detailView)
        }
    }

    override func setExpanded(_ expanded: Bool, animated: Bool) {
        super.setExpanded(expanded, animated: animated)

        if animated {
//            let alwaysOptions: UIView.AnimationOptions = [.allowUserInteraction,
//                                                         .beginFromCurrentState,
//                                                         .transitionCrossDissolve]
//            let expandedOptions: UIView.AnimationOptions = [.transitionFlipFromTop, .curveEaseOut]
//            let collapsedOptions: UIView.AnimationOptions = [.transitionFlipFromBottom, .curveEaseIn]
//            let options = expanded ? alwaysOptions.union(expandedOptions) : alwaysOptions.union(collapsedOptions)
//
//            UIView.transition(with: detailView, duration: 0.3, options: options, animations: {
//                self.toggleCell()
//            }, completion: nil)
            
            UIView.animate(withDuration: 0.3) {
                self.toggleCell()
            }
        } else {
            toggleCell()
        }
    }
    
    // MARK: Helpers
    private func toggleCell() {
        detailView.isHidden = !expanded
        arrow.transform = expanded ? CGAffineTransform(rotationAngle: CGFloat.pi) : .identity
    }
}
