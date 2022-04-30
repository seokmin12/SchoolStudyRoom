//
//  NoticeMemberView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct Notice: Codable, Identifiable {
    enum CodingKeys: CodingKey {
            case title
            case content
            case writer
            case created
        }
        
        var id = UUID()
        var title: String
        var content: String
        var writer: String
        var created: String
}

class NoticeReadData: ObservableObject {
    @Published var notices = [Notice]()
    
    init() {
        select_notice()
    }
    
    func select_notice() {
            guard let url = URL(string: "http://ulsan-hs.kro.kr/app/app_select_notice.php") else {
                print("Invaild URL")
                return
            }
            let data = try? Data(contentsOf: url)
            let notices = try? JSONDecoder().decode([Notice].self, from: data!)
            self.notices = notices!
    }
}

struct NoticeMemberView: View {
    @ObservedObject var datas = NoticeReadData()
    var body: some View {
        VStack(spacing: 0) {
            Text("공지사항").font(.system(size: 40, weight: .heavy))
            if datas.notices.isEmpty {
                List {
                    Text("Empty Set").foregroundColor(.gray)
                }.refreshable{
                    datas.select_notice()
                }
            } else {
                List(datas.notices) {
                    notice in
                    NavigationLink(destination: {
                        Form {
                            Section(header: Text("제목").font(.system(size: 20))) {
                                Text("\(notice.title)")
                            }
                            Section(header: Text("내용").font(.system(size: 20))) {
                                Text("\(notice.content)")
                            }
                            Section(header: Text("작성자/ 발행일").font(.system(size: 20))) {
                                Label(title: {
                                    Text("\(notice.writer) 선생님")
                                    Spacer()
                                    Text("\(notice.created)")
                                }, icon: {
                                    
                                })
                            }
                        }
                    }, label: {
                        Label(title: {
                            Text("\(notice.title)")
                            Spacer()
                            Text("\(notice.created)").font(.system(size: 15))
                        }, icon: {
                            
                        })
                    })
                }.refreshable{
                    datas.select_notice()
                }
            }
        }.background(Color(uiColor: .systemGray6))
    }
}
