//
//  AccordionTableView.swift
//  AccordionSection
//
//  Created by William on 13/01/22.
//

import UIKit

class AccordionTableView: UIView {
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.backgroundColor = .clear
        table.isScrollEnabled = false
        table.sectionHeaderTopPadding = 0
        return table
    }()

    /// Array of data in section
    open var data = [[String]]() {
        didSet {
            tableView.reloadData()
        }
    }

    /// Array of Sections
    var hiddenSections = Set<Int>()

    /// Array of `IndexPath` objects for all of the expanded cells.
    open var expandedIndexPaths = [IndexPath]()
    
    /// Flag that indicates if cell toggle should be animated. Defaults to `true`.
    open var isToggleAnimated = true
    
    /// Flag that indicates if `tableView` should scroll after cell is expanded,
    /// in order to make it completely visible (if it's not already). Defaults to `true`.
    open var shouldScrollIfNeededAfterCellExpand = true
    
    /// Closure that will be called after any cell expand is completed.
    open var expandCompletionHandler: () -> Void = {}
    
    /// Closure that will be called after any cell collapse is completed.
    open var collapseCompletionHandler: () -> Void = {}

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.register(
            AccordionSectionCell.self,
            forCellReuseIdentifier: AccordionSectionCell.reuseIdentifier
        )
    }

    // MARK: Actions
    /**
        Expand or collapse the cell.
    
        - parameter cell: Cell that should be expanded or collapsed.
        - parameter animated: If `true` action should be animated.
    */
    open func toggleCell(_ cell: BaseAccordionTableViewCell, animated: Bool) {
        if cell.expanded {
            collapseCell(cell, animated: animated)
        } else {
            expandCell(cell, animated: animated)
        }
    }

    // MARK: Helper
    private func expandCell(_ cell: BaseAccordionTableViewCell, animated: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            if !animated {
                addToExpandedIndexPaths(indexPath)
                cell.setExpanded(true, animated: false)
                tableView.reloadData()
                scrollIfNeededAfterExpandingCell(at: indexPath)
                expandCompletionHandler()
            } else {
                CATransaction.begin()
                
                CATransaction.setCompletionBlock { [weak self] in
                    self?.scrollIfNeededAfterExpandingCell(at: indexPath)
                    self?.expandCompletionHandler()
                }
                
                tableView.beginUpdates()
                addToExpandedIndexPaths(indexPath)
                cell.setExpanded(true, animated: true)
                tableView.endUpdates()
                
                CATransaction.commit()
            }
        }
    }
    
    private func collapseCell(_ cell: BaseAccordionTableViewCell, animated: Bool) {
        if let indexPath = tableView.indexPath(for: cell) {
            if !animated {
                cell.setExpanded(false, animated: false)
                removeFromExpandedIndexPaths(indexPath)
                tableView.reloadData()
                collapseCompletionHandler()
            } else {
                CATransaction.begin()
                CATransaction.setCompletionBlock { [weak self] in
                    self?.collapseCompletionHandler()
                }
                
                tableView.beginUpdates()
                cell.setExpanded(false, animated: true)
                removeFromExpandedIndexPaths(indexPath)
                tableView.endUpdates()

                CATransaction.commit()
            }
        }
    }

    private func addToExpandedIndexPaths(_ indexPath: IndexPath) {
        expandedIndexPaths.append(indexPath)
    }

    private func removeFromExpandedIndexPaths(_ indexPath: IndexPath) {
        if let index = expandedIndexPaths.firstIndex(of: indexPath) {
            expandedIndexPaths.remove(at: index)
        }
    }

    private func scrollIfNeededAfterExpandingCell(at indexPath: IndexPath) {
        guard shouldScrollIfNeededAfterCellExpand,
            let cell = tableView.cellForRow(at: indexPath) as? BaseAccordionTableViewCell else {
            return
        }
        let cellRect = tableView.rectForRow(at: indexPath)
        let isCompletelyVisible = tableView.bounds.contains(cellRect)
        if cell.expanded && !isCompletelyVisible {
            tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
        }
    }

    @objc
    private func hideSection(sender: UIButton) {
        // Create section let
        // Add indexPathsForSection method
        // Logic to add/remove sections to/from hiddenSections, and delete and insert functionality for tableView

        let section = sender.tag
        
        func indexPathsForSection() -> [IndexPath] {
            var indexPaths = [IndexPath]()
            
            for row in 0..<self.data[section].count {
                indexPaths.append(
                    IndexPath(
                        row: row,
                        section: section
                    )
                )
            }

            return indexPaths
        }

        if !self.hiddenSections.contains(section) {
            self.hiddenSections.insert(section)
            self.tableView.insertRows(at: indexPathsForSection(),
                                      with: .fade)
        } else {
            self.hiddenSections.remove(section)
            self.tableView.deleteRows(
                at: indexPathsForSection(),
                with: .fade
            )
        }
    }
}

// MARK: - Single Section
extension AccordionTableView: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if hiddenSections.contains(section) {
            return data[section].count
        }

        return 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // 1
        let sectionButton = UIButton()
        
        // 2
        sectionButton.setTitle(String(section),
                               for: .normal)
        
        // 3
        sectionButton.backgroundColor = .systemBlue
        
        // 4
        sectionButton.tag = section
        
        // 5
        sectionButton.addTarget(
            self,
            action: #selector(self.hideSection(sender:)),
            for: .touchUpInside
        )

        return sectionButton
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? BaseAccordionTableViewCell {
            let expanded = expandedIndexPaths.contains(indexPath)
            cell.setExpanded(expanded, animated: false)
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: AccordionSectionCell.reuseIdentifier,
            for: indexPath
        ) as? AccordionSectionCell else {
            return UITableViewCell()
        }
        cell.section.text = data[indexPath.section][indexPath.row]
        cell.img.image = UIImage(named: "0\(indexPath.row + 1)")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? BaseAccordionTableViewCell {
            toggleCell(cell, animated: isToggleAnimated)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return expandedIndexPaths.contains(indexPath) ? 220 : 68
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < 0 {
            return CGFloat.leastNormalMagnitude
        }

        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
