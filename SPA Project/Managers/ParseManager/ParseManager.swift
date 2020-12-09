//
//  ParseManager.swift
//  SPA Project
//
//  Created by Mitko on 4.12.20.
//

import Foundation

enum InstitutionType: String {

    case kindergarten = "\"детска градина\""
}
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
    
    var unfilteredInstitutions: [Institution] = []
    var filteredInstitutions: [Institution] = []

    static let shared = ParseManager()
    
    func parseCSV(region: String) {

        guard let path = Bundle.main.path(forResource: "data", ofType: "csv") else { return }

        do {

            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            unfilteredInstitutions = rows.map { getInsitution(fromRow: $0) }
            filteredInstitutions = filterInstitutions(forRegion: region)

            print(filteredInstitutions)
            print(unfilteredInstitutions)
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }

    private func filterInstitutions(forRegion region: String) -> [Institution] {

        return unfilteredInstitutions.filter { $0.region == region && $0.type == InstitutionType.kindergarten.rawValue}
    }
    
    func removeQuotes(_ text: String) -> String {

        return text.replacingOccurrences(of: "\"", with: "")
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
