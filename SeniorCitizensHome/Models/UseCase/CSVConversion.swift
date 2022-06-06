//
//  CSVConversion.swift
//  TrainingAndEmploymentServices
//
//  Created by 村中令 on 2022/06/05.
//

import Foundation
import SwiftUI

struct CsvConversion {
    static func convertFacilityInformationFromCsv (serviceType: ServiceType) -> [FacilityInformation] {
        var csvLineOneDimensional: [String] = []
        var csvLineTwoDimensional: [[String]] = []
        var pediatricWelfareServices: [FacilityInformation] = []
        guard let path = Bundle.main.path(
            forResource: "\(serviceType.fileName)",
            ofType: "csv"
        ) else {
            print("csvファイルがないよ")
            return []
        }
        let csvString = try! String(contentsOfFile: path, encoding: String.Encoding.utf8)
        csvLineOneDimensional = csvString.components(separatedBy: "\r\n")
        // 一次元配列のString型を、二次元配列のString型へ変換
        csvLineOneDimensional.forEach { string in
            var array: [String] = []
            array = string.components(separatedBy: ",")
            let revisionArray = array.map { string -> String in
                let revisonString = string.replacingOccurrences(of: "\"", with: "")
                return revisonString
            }
            guard array.count == 24 else { return }
            csvLineTwoDimensional.append(revisionArray)
        }

        // 二次元配列のString型を、共通型に変換
        csvLineTwoDimensional.forEach { array in
            let pediatricWelfareService = FacilityInformation(
                serviceType: array[6],
                corporateName: array[14],
                // TODO: 値がない場合はどのようにするか？
                corporateKana: "",
                corporateURL: array[19],
                corporateTelephoneNumber: array[11],
                corporateFax: array[12],
                officeName: array[4],
                officeNameKana: array[5],
                officeURL: array[19],
                officeTelephoneNumber: array[11],
                officeFax: array[12],
                address: array[7],
                latitude: array[9],
                longitude: array[10])
            pediatricWelfareServices.append(pediatricWelfareService)
        }
        return pediatricWelfareServices
    }
}

enum ServiceType: CaseIterable {
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

extension ServiceType {
    var stringJapanese: String {
        switch self {
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

    var fileName: String {
        switch self {
        case .communityCareForDementiaSupportingResidents320:
            return "320_認知症対応型共同生活介護"
        case .specifiedInstitutionalResidentialCarFeeBasedNursingHome331:
            return "331_特定施設入居者生活介護（有料老人ホーム）"
        case .specifiedFacilityResidentialCareLightCostSeniorCitizensHome332:
            return "332_特定施設入居者生活介護（軽費老人ホーム）"
        case .specifiedFacilityResidentialCareResidenceForTheElderlyWithServices334:
            return "334_特定施設入居者生活介護（サービス付き高齢者向け住宅）"
        case .specifiedFacilityResidentLifeCareFeeBasedSeniorCitizenHomeExternalServiceUseType335:
            return "335_特定施設入居者生活介護（有料老人ホーム・外部サービス利用型）"
        case .specifiedFacilityResidentialCareLightCostSeniorCitizensHomeExternalServiceUseType336:
            return "336_特定施設入居者生活介護（軽費老人ホーム・外部サービス利用型）"
        case .specifiedFacilityResidentialCareResidencesForTheElderlyWithServicesAndExternalServices337:
            return "337_特定施設入居者生活介護（サービス付き高齢者向け住宅・外部サービス利用型）"
        case .communityBasedSpecifiedInstitutionalResidentialCareFeeBasedNursingHomeForTheElderly361:
            return "361_地域密着型特定施設入居者生活介護（有料老人ホーム）"
        case .communityBasedSpecifiedInstitutionalCareForResidentsLightCostSeniorCitizenHomes362:
            return "362_地域密着型特定施設入居者生活介護（軽費老人ホーム）"
        case .communityBasedSpecifiedInstitutionalCareForResidentsResidencesForTheElderlyWithServices364:
            return "364_地域密着型特定施設入居者生活介護（サービス付き高齢者向け住宅）"
        case .nursingCareFacilityForTheElderly510:
            return "510_介護老人福祉施設"
        case .nursingCareHealthFacilityForTheElderly520:
            return "520_介護老人保健施設"
        case .nursingCareHospital530:
            return "530_介護療養型医療施設"
        case .communityBasedLongTermCareWelfareFacilityForTheElderlyResidents540:
            return "540_地域密着型介護老人福祉施設入居者生活介護"
        }
    }
}
