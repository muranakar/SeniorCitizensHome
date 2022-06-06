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
    case communityCareForDementiaSupportingResidents320
    case specifiedInstitutionalResidentialCarFeeBasedNursingHome331
    case specifiedFacilityResidentialCareLightCostSeniorCitizensHome332
    case specifiedFacilityResidentialCareResidenceForTheElderlyWithServices334
    case specifiedFacilityResidentLifeCareFeeBasedSeniorCitizenHomeExternalServiceUseType335
    case specifiedFacilityResidentialCareLightCostSeniorCitizensHomeExternalServiceUseType336
    case specifiedFacilityResidentialCareResidencesForTheElderlyWithServicesAndExternalServices337
    case communityBasedSpecifiedInstitutionalResidentialCareFeeBasedNursingHomeForTheElderly361
    case communityBasedSpecifiedInstitutionalCareForResidentsLightCostSeniorCitizenHomes362
    case communityBasedSpecifiedInstitutionalCareForResidentsResidencesForTheElderlyWithServices364
    case nursingCareFacilityForTheElderly510
    case nursingCareHealthFacilityForTheElderly520
    case nursingCareHospital530
    case communityBasedLongTermCareWelfareFacilityForTheElderlyResidents540
}
extension FilterServiceType {
    var string: String {
        switch self {
        case .all:
            return "全てのサービス"
        case .communityCareForDementiaSupportingResidents320:
            return "認知症対応型共同生活介護"
        case .specifiedInstitutionalResidentialCarFeeBasedNursingHome331:
            return "特）有料老人ホーム"
        case .specifiedFacilityResidentialCareLightCostSeniorCitizensHome332:
            return "特）軽費老人ホーム"
        case .specifiedFacilityResidentialCareResidenceForTheElderlyWithServices334:
            return "特）サービス付き高齢者向け住宅"
        case .specifiedFacilityResidentLifeCareFeeBasedSeniorCitizenHomeExternalServiceUseType335:
            return "特）有料老人ホーム・外部サービス利用型"
        case  .specifiedFacilityResidentialCareLightCostSeniorCitizensHomeExternalServiceUseType336:
            return "特）軽費老人ホーム・外部サービス利用型"
        case .specifiedFacilityResidentialCareResidencesForTheElderlyWithServicesAndExternalServices337:
            return "特）サービス付き高齢者向け住宅・外部サービス利用型"
        case .communityBasedSpecifiedInstitutionalResidentialCareFeeBasedNursingHomeForTheElderly361:
            return "地) 有料老人ホーム"
        case .communityBasedSpecifiedInstitutionalCareForResidentsLightCostSeniorCitizenHomes362:
            return "地) 軽費老人ホーム"
        case .communityBasedSpecifiedInstitutionalCareForResidentsResidencesForTheElderlyWithServices364:
            return "地) サービス付き高齢者向け住宅"
        case .nursingCareFacilityForTheElderly510:
            return "介護老人福祉施設"
        case .nursingCareHealthFacilityForTheElderly520:
            return "介護老人保健施設"
        case .nursingCareHospital530:
            return "介護療養型医療施設"
        case .communityBasedLongTermCareWelfareFacilityForTheElderlyResidents540:
            return "地域密着型介護老人福祉施設入居者生活介護"
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
