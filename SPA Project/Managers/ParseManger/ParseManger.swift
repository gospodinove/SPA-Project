//
//  ParseManger.swift
//  SPA Project
//
//  Created by Mitko on 4.12.20.
//

import Foundation

enum InstitutionCategories: String {

    case area = "\"Област\""
    case municipality = "\"Община\""
    case populatedPlace = "\"Населено място\""
    case region = "\"Район\""
    case name = "\"Име на институцията\""
    case type = "\"Вид на институцията\""
    case typeDetailed = "\"Вид на институцията - детайлен\""
    case typeFinance = "\"Вид на институцията според начина на финансиране\""
}

struct Institution {
    
    var area: String
    var municipality: String
    var populatedPlace: String
    var region: String
    var name: String
    var type: String
    var typeDetailed: String
    var typeFinance: String
}

class ParseManager {
    
    private var institutions: [Institution] = []

    static let shared = ParseManager()
    
    func parseCSV() {

        guard let path = Bundle.main.path(forResource: "data", ofType: "csv") else { return }

        do {

            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            institutions = rows.map { getInsitution(fromRow: $0) }
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
    private func getInsitution(fromRow row: [String: String]) -> Institution {

        let newInstitution = Institution(
            area: row[InstitutionCategories.area.rawValue] ?? "",
            municipality: row[InstitutionCategories.municipality.rawValue] ?? "",
            populatedPlace: row[InstitutionCategories.populatedPlace.rawValue] ?? "",
            region: row[InstitutionCategories.region.rawValue] ?? "",
            name: row[InstitutionCategories.name.rawValue] ?? "",
            type: row[InstitutionCategories.type.rawValue] ?? "",
            typeDetailed: row[InstitutionCategories.typeDetailed.rawValue] ?? "",
            typeFinance: row[InstitutionCategories.typeFinance.rawValue] ?? ""
        )

        return newInstitution
    }
}
