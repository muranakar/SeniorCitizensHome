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
        case .selfRelianceTrainingFunctionalTraining:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .selfRelianceTrainingFunctionalTraining)
        case .selfRelianceTrainingLifeTraining:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .selfRelianceTrainingLifeTraining)
        case .homestayTypeSelfRelianceTraining:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .homestayTypeSelfRelianceTraining)
        case .laborMigrationSupport:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .laborMigrationSupport)
        case .workforceRehabilitationSupportTypeA:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .workforceRehabilitationSupportTypeA)
        case .workforceRehabilitationSupportTypeB:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .workforceRehabilitationSupportTypeB)
        case .workForceSupport:
            facilityInformations =
            CsvConversion.convertFacilityInformationFromCsv(serviceType: .workForceSupport)
        }
        return facilityInformations
    }
}
