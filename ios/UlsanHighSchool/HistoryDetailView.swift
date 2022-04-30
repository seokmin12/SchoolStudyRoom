//
//  HistoryDetailView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/02/16.
//

import Foundation
import SwiftUI

struct History: Codable, Identifiable {
    enum CodingKeys: CodingKey {
            case grade
            case name
            case enter_date
            case enter_time
            case leave_date
            case leave_time
        }
        
        var id = UUID()
        var grade: String
        var name: String
        var enter_date: String
        var enter_time: String
        var leave_date: String
        var leave_time: String
}

class ReadHistoryData: ObservableObject {
    @Published var historys = [History]()

    func GetHistory(grade: String) {
        guard let url = URL(string: "http://ulsan-hs.kro.kr/app/app_select_history.php?grade=\(grade)") else {
            print("Invaild URL")
            return
        }
        let data = try? Data(contentsOf: url)
        let historys = try? JSONDecoder().decode([History].self, from: data!)
        self.historys = historys!
        print("\(historys!)")
        
    }
}

struct HistoryDetailView: View {
    @Binding var grade: String
    @ObservedObject var historydatas = ReadHistoryData()
    
    @State private var isHistoryLoading = true
    
    var body: some View {
        VStack(spacing: 0) {
            Text("입퇴실 기록").font(.largeTitle.bold())
            List {
                if historydatas.historys.isEmpty {
                    Label(title: {
                        Text("Empty Set").foregroundColor(.gray)
                    }, icon: {
                        
                    })
                } else {
                    ForEach(historydatas.historys) {
                        history in
                        Label(title: {
                            VStack(alignment: .leading) {
                                Text("날짜: \(history.enter_date)")
                                Spacer()
                                HStack {
                                    Text("입실: \(history.enter_time)")
                                    Text("퇴실: \(history.leave_time)")
                                }
                            }
                        }, icon: {
                            
                        })
                    }
                }
            }.onAppear(perform: {
                historydatas.GetHistory(grade: grade)
                isHistoryLoading = false
            }).refreshable {
                historydatas.GetHistory(grade: grade)
            }
        }.background(Color(uiColor: .systemGray6))
    }
}
