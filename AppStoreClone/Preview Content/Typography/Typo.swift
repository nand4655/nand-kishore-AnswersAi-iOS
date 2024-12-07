//
//
// Colors.swift
// AppStoreClone
//
// Created by Nand on 07/12/24
//
        
import SwiftUI

struct CustomColors {}

struct CustomGradeints {
   static let linearWhite = LinearGradient(colors: [Color.white.opacity(0),
                                           Color.white.opacity(0.383),
                                           Color.white.opacity(0.707),
                                           Color.white.opacity(0.924),
                                           Color.white],
                                  startPoint: .top,
                                  endPoint: .bottom)
    
    static let g_green1 = LinearGradient(colors: [Color.green.opacity(0),
                                              Color.green.opacity(0.383),
                                              Color.green.opacity(0.707),
                                              Color.green.opacity(0.924),
                                              Color.green],
                                         startPoint: .topLeading,
                                         endPoint: .bottomTrailing)
    
    static let g_blue1 = LinearGradient(colors: [Color.blue.opacity(0),
                                                  Color.blue.opacity(0.383),
                                                  Color.blue.opacity(0.707),
                                                  Color.blue.opacity(0.924),
                                                  Color.blue],
                                        startPoint: .bottomLeading,
                                        endPoint: .topTrailing)
}
