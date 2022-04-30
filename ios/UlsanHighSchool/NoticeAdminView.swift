//
//  NoticeAdminView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct NoticeAdminView: View {
    enum AlertActice {
        case success, fail, yet
    }
    @State private var isActive = false
    @ObservedObject var datas = NoticeReadData()
    @State var showingAlert = false
    @State var showingDeleteCheckAlert = false
    @State var activeNoticeDeleteAlert: AlertActice = .yet
    @Binding var UserName: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func NoticeDelete() {
        
    }

    var body: some View {
        NavigationView {
            if datas.notices.isEmpty {
                List {
                    Text("Empty Set").foregroundColor(.gray)
                }.refreshable{
                    datas.select_notice()
                }.toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Menu(content: {
                            Button(action: {
                                self.isActive = true
                            }, label: {
                                Label("새 공지사항 만들기", systemImage: "doc")
                            })
                        }, label: {
                            Label("더보기", systemImage: "ellipsis.circle").font(.system(size: 30))
                        }).background(
                            NavigationLink(destination: WriteNoticeView(UserName: $UserName), isActive: $isActive) {
                                EmptyView()
                            }
                        )
                    })
                })
            } else {
                List(datas.notices) {
                    notice in
                    NavigationLink(destination: {
                        VStack(spacing: 0) {
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
                            Button(action: {
                                self.showingAlert = true
                            }, label: {
                                Label("삭제", systemImage: "trash").foregroundColor(.red)
                            }).padding().font(.system(size: 20)).alert(isPresented: $showingAlert) {
                                switch activeNoticeDeleteAlert {
                                case .yet:
                                    return Alert(title: Text("삭제"), message: Text("정말 삭제하시겠습니까?"), primaryButton: .default(Text("취소")), secondaryButton: .destructive(Text("삭제"), action: { showingAlert = false
                                        let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_notice_delete.php")
                                        var request = URLRequest(url:myurl!)
                                        request.httpMethod = "POST"
                                        
                                        let postString = "title=\(notice.title)"
                                        request.httpBody = postString.data(using: String.Encoding.utf8);
                                        
                                        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                                                    
                                                    if error != nil
                                                    {
                                                        print("error=\(String(describing: error))")
                                                        return
                                                    }

                                                    do {
                                                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                                                        
                                                        if let parseJSON = json {
                                                            
                                                            let result = parseJSON["result"] as? String
                                                            print("delete: \(result!)")
                                                            if result == "success" {
                                                                showingAlert = true
                                                                activeNoticeDeleteAlert = .success
                                                            }
                                                            if result == "fail" {
                                                                showingAlert = true
                                                                activeNoticeDeleteAlert = .fail
                                                            }
                                                            
                                                        }
                                                    } catch {
                                                        print(error)
                                                    }
                                                }
                                                task.resume()
                                    }))
                                case .success:
                                    return Alert(title: Text("성공!"), message: Text("성공적으로 삭제했습니다."), dismissButton: .default(Text("Ok"), action: {
                                        self.mode.wrappedValue.dismiss()
                                    }))
                                case .fail:
                                    return Alert(title: Text("삭제하는 과정에서 문제가 생겼습니다."), message: Text("관리자에게 문의하세요."), dismissButton: .default(Text("Ok")))
                                }
                            }
                            Spacer()
                            Spacer()
                        }.background(Color(uiColor: .systemGray6))
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
                }.toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Menu(content: {
                            Button(action: {
                                self.isActive = true
                            }, label: {
                                Label("새 공지사항 만들기", systemImage: "doc")
                            })
                        }, label: {
                            Label("더보기", systemImage: "ellipsis.circle").font(.system(size: 30))
                        }).background(
                            NavigationLink(destination: WriteNoticeView(UserName: $UserName), isActive: $isActive) {
                                EmptyView()
                            }
                        )
                    })
                })
            }
        }
    }
}
