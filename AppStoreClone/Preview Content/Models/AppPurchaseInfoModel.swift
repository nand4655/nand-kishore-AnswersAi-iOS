//
//
// AppInfoModel.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//
    
import SwiftUI

enum AppInstallStatus: String, Decodable {
    case installed
    case notInstalled
    case installing
    case fetchingInfo
    case installedInPast
}

struct AppPurchaseInfoModel: Identifiable, Decodable {
    let id = UUID()
    var installStatus: AppInstallStatus
    let image: String
    let appName: String?
    let productLine: String?
    let userEmail: String?
    let publisher: String?
    var progress: Int = 0
    
    enum CodingKeys: CodingKey {
        case installStatus
        case image
        case appName
        case productLine
        case userEmail
        case publisher
    }
    
    mutating func updateProgress(with progress: Int) {
        self.progress = progress
    }
    
    mutating func updateStatus(with status: AppInstallStatus) {
        self.installStatus = status
    }
}
