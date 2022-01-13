//
//  AccordionModel.swift
//  AccordionSection
//
//  Created by William on 13/01/22.
//

import Foundation

struct AccordionModel {
    let section: [AccordionSectionModel]
}

/// Parent Section
struct AccordionSectionModel {
    let section: String
    var sectionOpened: Bool
    let subSection: [AccordionSubSectionModel]

    init(
        section: String,
        sectionOpened: Bool = false,
        subSection: [AccordionSubSectionModel]
    ) {
        self.section = section
        self.sectionOpened = sectionOpened
        self.subSection = subSection
    }
}

/// Sub Section include child
struct AccordionSubSectionModel {
    let subSection: String
    let childOpened: Bool
    let child: [String]

    init(
        subSection: String,
        childOpened: Bool = false,
        child: [String]
    ) {
        self.subSection = subSection
        self.childOpened = childOpened
        self.child = child
    }
}
