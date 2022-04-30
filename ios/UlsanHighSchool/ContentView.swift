//
//  ContentView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/05.
//

import SwiftUI
import Foundation
import UserNotifications

func requestNotificationPermission() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
        if didAllow {
            print("Push: 권한 허용")
        } else {
            print("Push: 권한 거부")
        }
    })
    
    
    let content = UNMutableNotificationContent()
    content.title = "Feed the cat"
    content.subtitle = "It looks hungry"
    content.sound = UNNotificationSound.default

    // show this notification five seconds from now
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

    // choose a random identifier
    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

    // add our notification request
    UNUserNotificationCenter.current().add(request)
}

struct ContentView: View {
    enum ActiveAlert {
        case fail, blank
    }
    @State var grade: String = ""
    @State private var password: String = ""
    
    @State var StudentGrade: String = ""
    @State var StudentName: String = ""
    @State var StudentWarning: String = ""
    
    @State var hi: String = ""
    
    @State var TeacherName: String = ""

    @State private var showingAlert = false
    @State private var GoToMain = false
    @State private var GoToAdmin = false
    @State private var isLoading = false
    
    @State private var activeLoginAlert: ActiveAlert = .fail
    
    func login() {
        if grade.isEmpty || password.isEmpty {
            self.activeLoginAlert = .blank
            showingAlert = true
            return
        } else {
            isLoading = true
            
            let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_login.php")
            var request = URLRequest(url:myurl!)
            request.httpMethod = "POST"
            
            let postString = "grade=\(grade)&password=\(password)"
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
                                let usergrade = parseJSON["grade"] as? String
                                let name = parseJSON["name"] as? String
                                let warning = parseJSON["warning"] as? String
                                
                                let Teachername = parseJSON["teacher_name"] as? String
                                print("Login: \(result!)")
                                if result == "success" {
                                    isLoading = false
                                    GoToMain = true
                                    StudentGrade = usergrade!
                                    StudentName = name!
                                    StudentWarning = warning!
                                    print(usergrade!)
                                    print(name!)
                                    print(warning!)
                                }
                                if result == "teacher_success" {
                                    isLoading = false
                                    GoToAdmin = true
                                    TeacherName = Teachername!
                                }
                                if result == "fail" {
                                    isLoading = false
                                    showingAlert = true
                                    self.activeLoginAlert = .fail
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
        NavigationView {
            VStack(spacing: 0) {
                Text("울산고등학교 면학실").font(.system(size: 30, weight: .heavy))
                Spacer()
                Image(systemName: "lock.fill").font(.system(size: 100))
                Form {
                    Section {
                        TextField("학년 반 번호", text: $grade).keyboardType(.numberPad)
                        SecureField("비밀번호", text: $password).keyboardType(.numberPad)
                    }
                    Section {
                        if isLoading {
                            ProgressView()
                        } else {
                            Button(action: {
                                login()
                            }) {
                                Text("로그인 하기").foregroundColor(.blue)
                                NavigationLink(destination: MainView(grade: $StudentGrade, name: $StudentName, warning: $StudentWarning), isActive: $GoToMain) {
                                    EmptyView()
                                }.frame(width: 0, height: 0).opacity(0)
                                NavigationLink(destination: AdminView(TeacherName: $TeacherName), isActive: $GoToAdmin) {
                                    EmptyView()
                                }.frame(width: 0, height: 0).opacity(0)
                            }.buttonStyle(PlainButtonStyle()).alert(isPresented: $showingAlert) {
                                switch activeLoginAlert {
                                    case .fail:
                                        return Alert(title: Text("잘못된 반 번호나 비밀번호 입니다."), dismissButton: .default(Text("Ok")))
                                    case .blank:
                                        return Alert(title: Text("빈칸을 모두 채워주세요."), dismissButton: .default(Text("Ok")))
                                }
                            }
                        }
                    }
                    NavigationLink(destination: NoticeMemberView(), label: {
                        HStack {
                            Spacer()
                            Text("공지사항 확인하기")
                            Spacer()
                        }.padding().background(Color.orange).foregroundColor(.white).clipShape(RoundedRectangle(cornerRadius: 6))
                    }).padding()
                }
            }.background(Color(uiColor: .systemGray6))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
