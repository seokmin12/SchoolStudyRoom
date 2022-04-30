//
//  RegisterView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct RegisterView: View {
    enum ActiveAlert {
        case success, already, fail, blank, chk_pw
    }
    @State var grade : String = ""
    @State var name : String = ""
    @State private var password: String = ""
    @State private var pw_chk: String = ""
    @State private var showingAlert = false
    
    @State private var activeRegisterAlert: ActiveAlert = .success
    
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    func register() {
        if grade.isEmpty || name.isEmpty || password.isEmpty || pw_chk.isEmpty {
            showingAlert = true
            self.activeRegisterAlert = .blank
            return
        } else if password != pw_chk {
            showingAlert = true
            self.activeRegisterAlert = .chk_pw
            return
        }else {
            let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_register.php")
            var request = URLRequest(url:myurl!)
            request.httpMethod = "POST"
            
            let postString = "grade=\(grade)&name=\(name)&password=\(password)"
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
                                    self.activeRegisterAlert = .success
                                }
                                if result == "fail" {
                                    showingAlert = true
                                    self.activeRegisterAlert = .fail
                                }
                                if result == "already" {
                                    showingAlert = true
                                    self.activeRegisterAlert = .already
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
        VStack {
            Form {
                Section(header: Text("학년 반 번호").font(.system(size: 15)), content: {
                    TextField("예) 10412", text: $grade).keyboardType(.numberPad)
                })
                Section(header: Text("이름").font(.system(size: 15)), content: {
                    TextField("예) 홍길동", text: $name)
                })
                Section(header: Text("비밀번호").font(.system(size: 15)), content: {
                    SecureField("비밀번호 입력", text: $password).keyboardType(.numberPad)
                })
                Section(header: Text("비밀번호 확인").font(.system(size: 15)), content: {
                    SecureField("비밀번호 입력", text: $pw_chk).keyboardType(.numberPad)
                })
                Section {
                    Button(action: register) {
                        Text("회원가입 하기")
                    }.alert(isPresented: $showingAlert) {
                        switch activeRegisterAlert {
                            case .success:
                                return Alert(title: Text("성공!"),message: Text("성공적으로 회원가입 되었습니다."),  dismissButton: .default(Text("Ok"), action: {
                                    self.mode.wrappedValue.dismiss()
                                }))
                            case .already:
                                return Alert(title: Text("이미 가입되었습니다."), dismissButton: .default(Text("Ok"), action: {
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
            }.navigationTitle("회원가입")
        }
    }
}
