//
//  SearchUseCase.swift
//  ChildDevelopmentSupport
//
//  Created by 村中令 on 2022/05/30.
//

import Foundation

struct UseCaseSearch {
    static func filteredSearchFacilityInformation(
        filterServiceType: FilterServiceType,
        filterSearch: FilterSearch,
        string: String
    ) -> [FacilityInformation] {
        let allFacilityInformation =
        UseCaseFilterFacilityInformation.filterFacilityInformationFromDataBase(filterServiceType: filterServiceType)
        var filterFacilityInformation: [FacilityInformation]
        switch filterSearch {
        case .officeNameAndOfficeNameKana:
            filterFacilityInformation = allFacilityInformation
                .filter { $0.officeName.contains(string) || $0.officeNameKana.contains(string) }
        case .corporateNameAndCoporateKana:
            filterFacilityInformation = allFacilityInformation
                .filter { $0.corporateName.contains(string) || $0.corporateKana.contains(string) }
        case .address:
            filterFacilityInformation = allFacilityInformation
                .filter { $0.address.contains(string) }
        }
        return filterFacilityInformation
    }
}

enum FilterServiceType: CaseIterable {
    case all
    case selfRelianceTrainingFunctionalTraining
    case selfRelianceTrainingLifeTraining
    case homestayTypeSelfRelianceTraining
    case laborMigrationSupport
    case workforceRehabilitationSupportTypeA
    case workforceRehabilitationSupportTypeB
    case workForceSupport
}
extension FilterServiceType {
    var string: String {
        switch self {
        case .all:
            return "全てのサービス"
        case .selfRelianceTrainingFunctionalTraining:
            return "自立訓練(機能訓練)"
        case .selfRelianceTrainingLifeTraining:
            return "自立訓練(生活訓練)"
        case .homestayTypeSelfRelianceTraining:
            return "宿泊型自立訓練"
        case .laborMigrationSupport:
            return "就労移行支援"
        case .workforceRehabilitationSupportTypeA:
            return "就労継続支援Ａ型"
        case .workforceRehabilitationSupportTypeB:
            return "就労継続支援Ｂ型"
        case .workForceSupport:
            return "就労定着支援"
        }
    }
}

enum FilterSearch {
    init(string: String) {
        switch string {
        case "事業所名":
            self = .officeNameAndOfficeNameKana
        case "会社名":
            self = .corporateNameAndCoporateKana
        case "住所":
            self = .address
        default:
            fatalError("FilterSearchに値が設定されていません。")
        }
    }
    case officeNameAndOfficeNameKana
    case corporateNameAndCoporateKana
    case address
}
