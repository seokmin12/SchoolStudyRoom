//
//  WriteNoticeView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct WriteNoticeView: View {
    enum ActiveAlert {
        case success, fail, blank
    }
    @State var title: String = ""
    @State var content: String = ""
    @Binding var UserName: String
    @State private var showingAlert = false
    @State private var activeNoticeAlert: ActiveAlert = .success
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func writenotice() {
        if title.isEmpty || content.isEmpty {
            showingAlert = true
            activeNoticeAlert = .blank
            return
        } else {
            let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_notice.php")
            var request = URLRequest(url:myurl!)
            request.httpMethod = "POST"
            
            let postString = "title=\(title)&content=\(content)&writer=\(UserName)"
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
                                print("notice: \(result!)")
                                if result == "success" {
                                    showingAlert = true
                                    activeNoticeAlert = .success
                                }
                                if result == "fail" {
                                    showingAlert = true
                                    activeNoticeAlert = .fail
                                }
                                
                            }
                        } catch {
                            print(error)
                        }
                    }
                    task.resume()
        }
    }
    var body: some View {
        VStack(spacing: 0) {
            Form {
                Section(header: Text("공지사항 제목").font(.system(size: 20)), content: {
                    TextField("제목", text: $title)
                })
                Section(header: Text("공지사항 내용").font(.system(size: 20)), content: {
                    TextField("내용", text: $content).frame(height: 100)
                })
                Section {
                    Button(action: {
                        writenotice()
                    }, label: {
                        Text("저장하기")
                    }).alert(isPresented: $showingAlert) {
                        switch activeNoticeAlert {
                        case .success:
                            return Alert(title: Text("성공적으로 저장되었습니다!"), dismissButton: .default(Text("Ok"), action: {
                                self.mode.wrappedValue.dismiss()
                            }))
                        case .fail:
                            return Alert(title: Text("저장하는 과정에서 문제가 생겼습니다."), message: Text("관리자에게 문의하세요."), dismissButton: .default(Text("Ok")))
                        case .blank:
                            return Alert(title: Text("빈칸을 모두 채워주세요."), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
            }
        }
    }
}
