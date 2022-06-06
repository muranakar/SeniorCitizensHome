//
//  CSVConversion.swift
//  CoreLocationSample
//
//  Created by 村中令 on 2022/05/05.
//

import Foundation

struct UseCaseFilterFacilityInformation {
    static func filterFacilityInformationFromDataBase(filterServiceType: FilterServiceType) -> [FacilityInformation] {
        var facilityInformations: [FacilityInformation] = []
        switch filterServiceType {
        case .all:
            let allServiceType = ServiceType.allCases
            allServiceType.forEach { serviceType in
                let array = CsvConversion.convertFacilityInformationFromCsv(serviceType: serviceType)
                facilityInformations += array
            }
        case .communityCareForDementiaSupportingResidents320:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .communityCareForDementiaSupportingResidents320
            )
        case .specifiedInstitutionalResidentialCarFeeBasedNursingHome331:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedInstitutionalResidentialCarFeeBasedNursingHome331
            )
        case .specifiedFacilityResidentialCareLightCostSeniorCitizensHome332:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedFacilityResidentialCareLightCostSeniorCitizensHome332
            )
        case .specifiedFacilityResidentialCareResidenceForTheElderlyWithServices334:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedFacilityResidentialCareResidenceForTheElderlyWithServices334
            )
        case .specifiedFacilityResidentLifeCareFeeBasedSeniorCitizenHomeExternalServiceUseType335:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedFacilityResidentLifeCareFeeBasedSeniorCitizenHomeExternalServiceUseType335
            )
        case .specifiedFacilityResidentialCareLightCostSeniorCitizensHomeExternalServiceUseType336:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedFacilityResidentialCareLightCostSeniorCitizensHomeExternalServiceUseType336
            )
        case .specifiedFacilityResidentialCareResidencesForTheElderlyWithServicesAndExternalServices337:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .specifiedFacilityResidentialCareResidencesForTheElderlyWithServicesAndExternalServices337
            )
        case .communityBasedSpecifiedInstitutionalResidentialCareFeeBasedNursingHomeForTheElderly361:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .communityBasedSpecifiedInstitutionalResidentialCareFeeBasedNursingHomeForTheElderly361
            )
        case .communityBasedSpecifiedInstitutionalCareForResidentsLightCostSeniorCitizenHomes362:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .communityBasedSpecifiedInstitutionalCareForResidentsLightCostSeniorCitizenHomes362
            )
        case .communityBasedSpecifiedInstitutionalCareForResidentsResidencesForTheElderlyWithServices364:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .communityBasedSpecifiedInstitutionalCareForResidentsResidencesForTheElderlyWithServices364
            )
        case .nursingCareFacilityForTheElderly510:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .nursingCareFacilityForTheElderly510
            )
        case .nursingCareHealthFacilityForTheElderly520:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .nursingCareHealthFacilityForTheElderly520
            )
        case .nursingCareHospital530:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .nursingCareHospital530
            )
        case .communityBasedLongTermCareWelfareFacilityForTheElderlyResidents540:
            facilityInformations = CsvConversion.convertFacilityInformationFromCsv(
                serviceType: .communityBasedLongTermCareWelfareFacilityForTheElderlyResidents540
            )
        }
        print(facilityInformations[1])
        return facilityInformations
    }
}
