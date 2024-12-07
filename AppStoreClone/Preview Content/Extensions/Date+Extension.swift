//
//
// Date+Extension.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//

import Foundation

extension Date {
    func formattedDateAndMonth() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM"
        return dateFormatter.string(from: self)
    }
}
