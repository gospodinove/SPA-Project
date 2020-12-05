//
//  CriteriaManager.swift
//  SPA Project
//
//  Created by Emanuil Gospodinov on 5.12.20.
//

import Foundation

struct Document {
    let description: String
    
    static let student = Document(description: "За студенти: Служебна бележка от акредитиран ВУЗ и бележка за настоящ адрес на територията на Столична община")
    static let insurance = Document(description: "Служебна бележка от работодателя или от НОИ (за самоосигуряващи се)")
    static let motherhood = Document(description: "За отпуск по майчинство: Служебна бележка, че родителят е в отпуск по майчинство")
    static let dayCare = Document(description: "Служебна бележка от държавна детска ясла на територията на Столична община")
    static let noRights = Document(description: "За отнети права: Съдебно решение")
    static let deathCertificate = Document(description: "Смъртен акт")
    static let disability = Document(description: "Протокол на ТЕЛК")
    static let socialAid = Document(description: "Съдебно решение или писмо от съответната дирекция \"Социално подпомагане\"")
    static let childDefence = Document(description: "Писмо от Агенцията за закрила на детето")
    static let regionalInseptorateOfEducation = Document(description: "Решение от Комисия ЕКП към Регионалния инспекторат по образование (РИО)")
    static let educationDirective = Document(description: "Решение на Комисия за изключителни обстоятелства към Дирекция \"Образование\"")
    static let school = Document(description: "Служебна бележка от училище на територията на Столична община")
    static let kindergarted = Document(description: "Служебна бележка от детска градина на Столична община")
    static let commissionDecision = Document(description: "Решение на комисията")
}

class CriteriaManager {
    private var selectedCriteria = [Criterion]()
    private var points = 0
    
    static let shared = CriteriaManager()
    
    let sections: [Section]
    
    init() {
        let mainSection = Section(variant: .main, criteria: [
            Criterion(title: "Поне един родител има постоянен адрес на територията на Столична община или поне един родител е редовен студент във ВУЗ и има настоящ адрес на територията на Столична община", additionalDocuments: [.student]),
            Criterion(title: "Работещ родител (или в отпуск по майчинство), който е социално осигурен или родител, който е редовен студент във ВУЗ на територията на Столична община", points: .parent, additionalDocuments: [.insurance, .motherhood, .student]),
            Criterion(title: "Детето е близнак/тризнак или има брат/сестра родени с разлика не по-голяма от 2 години"),
            Criterion(title: "Детето има братя/сестри до 18 г.", points: .sibling),
            Criterion(title: "Детето има брат/сестра, които са записани в детска градина в момента и ще посещават детската градина след прием на детето", points: .garden),
            Criterion(title: "Детето посещава държавна детска ясла на територията на Столична община най-малко 6 месеца преди записване", points: .allDayGarden, additionalDocuments: [.dayCare])
        ])
        
        let socialDocumentSection = Section(variant: .socialDocument, criteria: [
            Criterion(title: "Детето има неизвестен родител в удостоверението за раждане или отнети родителски права", points: .two, additionalDocuments: [.noRights]),
            Criterion(title: "Детето има починал родител", points: .deceasedParent, additionalDocuments: [.deathCertificate]),
            Criterion(title: "Един или повече членове на семейството има нетрудоспособност над 70%", points: .unableToWork, additionalDocuments: [.disability]),
            Criterion(title: "Детето е настанено в приемно семейство или семейство на роднини и близки по ЗЗД", points: .three, additionalDocuments: [.socialAid]),
            Criterion(title: "Детето е в риск по ЗЗД", points: .three, additionalDocuments: [.childDefence]),
            Criterion(title: "Детето има специални образователни потребности и може да се интегрира в обща група", points: .three, additionalDocuments: [.regionalInseptorateOfEducation])
        ])
        
        let socialCommissionSection = Section(variant: .socialComission, criteria: [
            Criterion(title: "Изключителни обстоятелства", points: .extraordinaryConditions, additionalDocuments: [.educationDirective])
        ])
        
        let professionalSection = Section(variant: .professional, criteria: [
            Criterion(title: "Детето има поне един родител или баба/дядо, които работят в детска градина на Столична община", points: .three, additionalDocuments: [.kindergarted]),
            Criterion(title: "Детето има поне един родител, който работи като педагогически персонал в основни и средни училища на територията на Столична община", additionalDocuments: [.school]),
            Criterion(title: "По преценка на комисия, назначена от Директор на градина (максимум 1 дете на група)", points: .principalDecision, additionalDocuments: [.commissionDecision])
        ])
        
        sections = [mainSection, socialDocumentSection, socialCommissionSection, professionalSection]
    }
    
    func select(_ criterion: Criterion) {
        selectedCriteria.append(criterion)
        points += criterion.getSelectedCount() * criterion.points.rawValue
    }
    
    func deselect(_ criterion: Criterion) {
        selectedCriteria = selectedCriteria.filter({ $0.title != criterion.title })
        points -= criterion.getSelectedCount() * criterion.points.rawValue
    }
    
    func isSelected(_ criterion: Criterion) -> Bool {
        return selectedCriteria.contains(where: { $0.title == criterion.title })
    }
}

extension CriteriaManager {
    struct Section {
        enum Variant {
            case main
            case socialDocument
            case socialComission
            case professional
            
            var title: String? {
                switch self {
                case .main:
                    return nil
                case .socialDocument:
                    return "Социални критерии по документи"
                case .socialComission:
                    return "Социални критерии с комисия"
                case .professional:
                    return "Служебни критерии"
                }
            }
        }
        
        let variant: Variant
        let criteria: [Criterion]
    }
}
