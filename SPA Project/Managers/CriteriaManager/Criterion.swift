//
//  Criterion.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import Foundation

struct Criterion {
    let title: String
    let points: Points
    let additionalDocuments: [Document]?
    
    init(title: String, points: Points = .one, additionalDocuments: [Document]? = nil) {
        self.title = title
        self.points = points
        self.additionalDocuments = additionalDocuments
    }
}


extension Criterion {
    enum Points {
        case one
        case two
        case three
        case parent
        case sibling
        case garden
        case allDayGarden
        case noParent
        case unableToWork
        case extraordinaryConditions
        case principalDecision
        
        var maxPoints: Int {
            switch self {
            case .one, .garden, .allDayGarden:
                return 1
            case .two, .parent, .sibling, .principalDecision:
                return 2
            case .three:
                return 3
            case .noParent, .extraordinaryConditions:
                return 6
            case .unableToWork:
                return 10
            }
        }
        
        var increment: Int? {
            switch self {
            case .parent, .sibling:
                return 1
            case .unableToWork:
                return 2
            case .noParent:
                return 3
            default:
                return nil
            }
        }
        
        var text: String {
            switch self {
            case .one:
                return "1 т."
            case .two:
                return "2 т."
            case .three:
                return "3 т."
            case .parent:
                return "по 1 т. за родител"
            case .sibling:
                return "по 1 т. за брат/сестра"
            case .garden:
                return "1 т. само за съответната градина"
            case .allDayGarden:
                return "1 т. само за ЦДГ"
            case .noParent:
                return "по 3 т. за починал родител"
            case .unableToWork:
                return "по 2 т. за всеки нетрудо-способен член от сем."
            case .extraordinaryConditions:
                return "0 до 6 т. с комисия"
            case .principalDecision:
                return "2 т. само за съответ-ната градина"
            }
        }
    }
}
