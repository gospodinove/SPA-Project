//
//  Criterion.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import Foundation

class Criterion {
    private var selectedCount = 1
    
    let title: String
    let points: Points
    let additionalDocuments: [Document]?
    
    var directlySelectable: Bool { points.stepsCount == 1 }
    var accumulatedPoints: Int { selectedCount * points.rawValue }
    
    init(title: String, points: Points = .one, additionalDocuments: [Document]? = nil) {
        self.title = title
        self.points = points
        self.additionalDocuments = additionalDocuments
    }
    
    func updateSelectedCount(to count: Int) {
        selectedCount = count
    }
    
    func getSelectedCount() -> Int {
        return selectedCount
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
        case deceasedParent
        case unableToWork
        case extraordinaryConditions
        case principalDecision
        
        var stepsCount: Int {
            switch self {
            case .parent, .deceasedParent, .principalDecision:
                return 2
            case .extraordinaryConditions:
                return 6
            case .sibling, .unableToWork:
                return 10
            default:
                return 1
            }
        }
        
        var rawValue: Int {
            switch self {
            case .two, .unableToWork:
                return 2
            case .three, .deceasedParent:
                return 3
            default:
                return 1
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
            case .deceasedParent:
                return "по 3 т. за починал родител"
            case .unableToWork:
                return "по 2 т. за всеки нетрудо-способен член от сем."
            case .extraordinaryConditions:
                return "0 до 6 т. с комисия"
            case .principalDecision:
                return "2 т. само за съответ-ната градина"
            }
        }
        
        var countLabelText: String? {
            switch self {
            case .parent:
                return "родители"
            case .sibling:
                return "братя/сестри"
            case .deceasedParent:
                return "починали родители"
            case .unableToWork:
                return "нетрудоспособни в семейството"
            case .extraordinaryConditions:
                return "точки от комисия"
            default:
                return nil
            }
        }
    }
}
