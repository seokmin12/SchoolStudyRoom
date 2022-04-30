//
//  EditProfileView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/02/09.
//

import Foundation
import SwiftUI

struct EditProfileView: View {
    enum ActiveAlert {
        case success, fail, blank, chk_pw
    }
    @Binding var grade: String
    @State private var NewPassword: String = ""
    @State private var CheckPassword: String = ""
    @State private var showingAlert = false
    
    @State private var activeEditAlert: ActiveAlert = .success
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func editprofile() {
        if NewPassword.isEmpty || CheckPassword.isEmpty {
            showingAlert = true
            self.activeEditAlert = .blank
            return
        } else if NewPassword != CheckPassword {
            showingAlert = true
            self.activeEditAlert = .chk_pw
            return
        }else {
            let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_edit_profile.php")
            var request = URLRequest(url:myurl!)
            request.httpMethod = "POST"
            
            let postString = "grade=\(grade)&new_pw=\(NewPassword)"
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
                                print("Register: \(result!)")
                                if result == "success" {
                                    showingAlert = true
                                    self.activeEditAlert = .success
                                }
                                if result == "fail" {
                                    showingAlert = true
                                    self.activeEditAlert = .fail
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
            Text("비밀번호 변경").font(.largeTitle).bold().padding()
            Form {
                Section(header: Text("변경할 비밀번호").font(.system(size: 15)), content: {
                    SecureField("비밀번호 입력", text: $NewPassword).keyboardType(.numberPad)
                })
                Section(header: Text("비밀번호 확인").font(.system(size: 15)), content: {
                    SecureField("비밀번호 입력", text: $CheckPassword).keyboardType(.numberPad)
                })
                Section {
                    Button(action: editprofile) {
                        Text("수정하기")
                    }.alert(isPresented: $showingAlert) {
                        switch activeEditAlert {
                        case .success:
                            return Alert(title: Text("성공적으로 변경되었습니다."), dismissButton: .default(Text("Ok"), action: {
                                self.mode.wrappedValue.dismiss()
                            }))
                        case .fail:
                            return Alert(title: Text("저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요."), dismissButton: .default(Text("Ok")))
                        case .blank:
                            return Alert(title: Text("빈칸을 모두 채워주세요."), dismissButton: .default(Text("Ok")))
                        case .chk_pw:
                            return Alert(title: Text("비밀번호가 일치하지 않습니다."), dismissButton: .default(Text("Ok")))
                        }
                    }
                }
            }
        }.background(Color(uiColor: .systemGray6))
    }
}
