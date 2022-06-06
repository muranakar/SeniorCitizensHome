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
            forResource: "\(serviceType.stringEnglish)",
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
            guard array.count == 29 else { return }
            csvLineTwoDimensional.append(revisionArray)
        }

        // 二次元配列のString型を、共通型に変換
        csvLineTwoDimensional.forEach { array in
            let pediatricWelfareService = FacilityInformation(
                serviceType: array[11],
                corporateName: array[3],
                corporateKana: array[4],
                corporateURL: array[10],
                corporateTelephoneNumber: array[8],
                corporateFax: array[9],
                officeName: array[12],
                officeNameKana: array[13],
                officeURL: array[19],
                officeTelephoneNumber: array[17],
                officeFax: array[18],
                address: array[15] + array[16],
                latitude: array[20],
                longitude: array[21])
            pediatricWelfareServices.append(pediatricWelfareService)
        }
        return pediatricWelfareServices
    }
}

enum ServiceType: CaseIterable {
    case selfRelianceTrainingFunctionalTraining
    case selfRelianceTrainingLifeTraining
    case homestayTypeSelfRelianceTraining
    case laborMigrationSupport
    case workforceRehabilitationSupportTypeA
    case workforceRehabilitationSupportTypeB
    case workForceSupport
}

extension ServiceType {
    var stringJapanese: String {
        switch self {
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
    var stringEnglish: String {
        switch self {
        case .selfRelianceTrainingFunctionalTraining:
            return "SelfRelianceTrainingFunctionalTraining"
        case .selfRelianceTrainingLifeTraining:
            return "SelfRelianceTrainingLifeTraining"
        case .homestayTypeSelfRelianceTraining:
            return "HomestayTypeSelfRelianceTraining"
        case .laborMigrationSupport:
            return "LaborMigrationSupport"
        case .workforceRehabilitationSupportTypeA:
            return "WorkforceRehabilitationSupportTypeA"
        case .workforceRehabilitationSupportTypeB:
            return "WorkforceRehabilitationSupportTypeB"
        case .workForceSupport:
            return "WorkForceSupport"
        }
    }
}
