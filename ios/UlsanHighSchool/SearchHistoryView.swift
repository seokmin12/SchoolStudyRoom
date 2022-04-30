//
//  SearchHistoryView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/02/08.
//

import Foundation
import SwiftUI

struct SearchedHistory: Codable, Identifiable {
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

class SearchHistoryData: ObservableObject {
    @Published var historys = [SearchedHistory]()

    func SearchHistory(date: String) {
        guard let url = URL(string: "http://ulsan-hs.kro.kr/app/app_search_history.php?date=\(date)") else {
            print("Invaild URL")
            return
        }
        let data = try? Data(contentsOf: url)
        let historys = try? JSONDecoder().decode([SearchedHistory].self, from: data!)
        self.historys = historys!
        print("\(historys!)")
        
    }
}

struct SearchHistoryView: View {
    @State private var SearchDate = Date()
    @ObservedObject var searchinghistory = SearchHistoryData()
    
    static let dateFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        return formatter
    }()
    
    var body: some View {
        VStack(spacing: 0) {
            Form {
                DatePicker(selection: $SearchDate, in: ...Date(), displayedComponents: .date) {
                    Text("날짜를 선택해 주세요.")
                }
                Text("선택한 날짜: \(SearchDate, formatter: SearchHistoryView.dateFormat)")
                Button(action: {
                    searchinghistory.SearchHistory(date: SearchHistoryView.dateFormat.string(from: SearchDate))
                }, label: {
                    Label("검색", systemImage: "magnifyingglass")
                })
                Section {
                    List {
                        if searchinghistory.historys.isEmpty {
                            Label(title: {
                                Text("Empty Set").foregroundColor(.gray)
                            }, icon: {
                                
                            })
                        } else {
                            ForEach(searchinghistory.historys) {
                                member in
                                NavigationLink(destination: {
                                    List {
                                        HStack {
                                            Text("입실: \(member.enter_time)")
                                            Spacer()
                                            Text("퇴실: \(member.leave_time)")
                                        }
                                    }
                                }, label: {
                                    Label(title: {
                                        Text("\(member.grade) \(member.name)")
                                    }, icon: {
                                        Image(systemName: "person")
                                    })
                                })
                            }
                        }
                    }
                }
            }
        }
    }
}
