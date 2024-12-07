//
//
// TodayHeaderView.swift
// AppStoreClone
//
// Created by Nand on 05/12/24
//
        

import SwiftUI

struct TodayHeaderView: View {
    var body: some View {
        VStack {
            HStack(alignment: .center) {
                HStack(alignment: .firstTextBaseline) {
                    Text("Today")
                        .font(.l1)
                        .bold()
                    
                    Text(Date().formattedDateAndMonth())
                        .font(.h2)
                        .bold()
                        .foregroundStyle(.gray)
                }
                
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .resizable()
                    .frame(width: Dimens.Size.unit24, height: Dimens.Size.unit24)
            }
            .padding()
        }
    }
}

#Preview {
    TodayHeaderView()
}
