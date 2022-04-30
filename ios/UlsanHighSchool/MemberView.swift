//
//  MemberView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct Member: Codable, Identifiable {
    enum CodingKeys: CodingKey {
            case grade
            case name
            case warning
            case study_start
            case year
        }
        
        var id = UUID()
        var grade: String
        var name: String
        var warning: String
        var study_start: String
        var year: String
}

class ReadData: ObservableObject {
    @Published var members = [Member]()
    
    init() {
        select_member()
    }
    
    func select_member() {
            guard let url = URL(string: "http://ulsan-hs.kro.kr/app/app_select_member.php") else {
                print("Invaild URL")
                return
            }
            let data = try? Data(contentsOf: url)
            let members = try? JSONDecoder().decode([Member].self, from: data!)
            self.members = members!
    }
}

struct MemberView: View {
    @ObservedObject var datas = ReadData()
    @Binding var UserName: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var body: some View {
        NavigationView {
            List(datas.members) {
                member in
                NavigationLink(destination: {
                    HistoryDetailView(grade: .constant(member.grade))
                }, label: {
                    Label(title: {
                        Text("\(member.grade) \(member.name)")
                        Spacer()
                        Text("경고: \(member.warning)회")
                    }, icon: {
                        Image(systemName: "person")
                    })
                })
            }.refreshable{
                datas.select_member()
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    Menu(content: {
                        Button(action: {
                            
                        }, label: {
                            Text("\(UserName) 선생님")
                        })
                        Section {
                            Button(role: .destructive, action: {
                                self.mode.wrappedValue.dismiss()
                            }) {
                                Text("로그아웃")
                            }
                        }
                    }, label: {
                        Label("프로필", systemImage: "person.crop.circle.fill").font(.system(size: 30))
                    })
                })
            })
        }.navigationBarTitle(Text("관리 페이지"))
    }
}
