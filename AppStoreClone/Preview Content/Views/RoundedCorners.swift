//
//
// RoundedCorners.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        

import SwiftUI

struct RoundedCorners: Shape {
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - bl))
        path.addArc(withCenter: CGPoint(x: rect.minX + bl, y: rect.maxY - bl),
                    radius: bl,
                    startAngle: .pi,
                    endAngle: .pi / 2,
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX - br, y: rect.maxY))
        path.addArc(withCenter: CGPoint(x: rect.maxX - br, y: rect.maxY - br),
                    radius: br,
                    startAngle: .pi / 2,
                    endAngle: 0,
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + tr))
        path.addArc(withCenter: CGPoint(x: rect.maxX - tr, y: rect.minY + tr),
                    radius: tr,
                    startAngle: 0,
                    endAngle: -.pi / 2,
                    clockwise: false)
        path.addLine(to: CGPoint(x: rect.minX + tl, y: rect.minY))
        path.addArc(withCenter: CGPoint(x: rect.minX + tl, y: rect.minY + tl),
                    radius: tl,
                    startAngle: -.pi / 2,
                    endAngle: .pi,
                    clockwise: false)
        path.close()
        return Path(path.cgPath)
    }
}
