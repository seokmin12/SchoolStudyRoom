//
//  StudyView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

class StudyReadData: ObservableObject {
    @Published var members = [Member]()
    
    init() {
        select_studying_member()
    }
    
    func select_studying_member() {
            guard let url = URL(string: "http://ulsan-hs.kro.kr/app/app_select_studying_member.php") else {
                print("Invaild URL")
                return
            }
            let data = try? Data(contentsOf: url)
            let members = try? JSONDecoder().decode([Member].self, from: data!)
            self.members = members!
    }
}

struct StudyView: View {
    @ObservedObject var datas = StudyReadData()
    var body: some View {
        NavigationView {
            if datas.members.isEmpty {
                List {
                    Text("Empty Set").foregroundColor(.gray)
                }.refreshable{
                    datas.select_studying_member()
                }
            } else {
                List(datas.members) {
                    member in
                    Label {
                        Text("\(member.grade) \(member.name)")
                        Spacer()
                        Text("경고: \(member.warning)회")
                    } icon: {
                        Image(systemName: "person")
                    }
                }.refreshable{
                    datas.select_studying_member()
                }
            }
        }
    }
}
