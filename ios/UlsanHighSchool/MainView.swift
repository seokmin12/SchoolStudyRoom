//
//  MainView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct MainView: View {
    enum ActiveAlert {
        case success, already, error, today_already
    }
    @State var ShowingEnterAlert = false
    @State var ShowingLeaveAlert = false
    @State private var GoToEdit = false
    @State private var activeEnterAlert: ActiveAlert = .success
    @State private var activeLeaveAlert: ActiveAlert = .success
    @State var EmptySeats : Int = 0
    
    @Binding var grade: String
    @Binding var name: String
    @Binding var warning: String
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    
    func empty_seats() {
        let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_empty_seats.php")
        var request = URLRequest(url:myurl!)
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
                    
                    if error != nil
                    {
                        print("error=\(String(describing: error))")
                        return
                    }
                    
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                        
                        if let parseJSON = json {
                            
                            let result = parseJSON["result"]
                            print("empty seats: \(result!)")
                            EmptySeats = Int(result as! Int32)
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
    }
    
    func enter() {
        let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_enter.php")
        var request = URLRequest(url:myurl!)
        request.httpMethod = "POST"
        
        let postString = "grade=\(grade)&name=\(name)"
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
                            print("enter result: \(result!)")
                            if result == "success" {
                                ShowingEnterAlert = true
                                self.activeEnterAlert = .success
                            }
                            if result == "already" {
                                ShowingEnterAlert = true
                                self.activeEnterAlert = .already
                            }
                            if result == "error" {
                                ShowingEnterAlert = true
                                self.activeEnterAlert = .error
                            }
                            if result == "today_already" {
                                ShowingEnterAlert = true
                                self.activeEnterAlert = .today_already
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
    }
    
    func leave() {
        let myurl = URL(string: "http://ulsan-hs.kro.kr/app/app_leave.php")
        var request = URLRequest(url:myurl!)
        request.httpMethod = "POST"
        
        let postString = "grade=\(grade)&name=\(name)"
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
                            print("leave result: \(result!)")
                            if result == "success" {
                                ShowingLeaveAlert = true
                                self.activeLeaveAlert = .success
                            }
                            if result == "already" {
                                ShowingLeaveAlert = true
                                self.activeLeaveAlert = .already
                            }
                            if result == "error" {
                                ShowingLeaveAlert = true
                                self.activeLeaveAlert = .error
                            }
                        }
                    } catch {
                        print(error)
                    }
                }
                task.resume()
    }
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                Text("\(EmptySeats)석 남았습니다.").font(.system(size: 23, weight: .heavy)).toolbar(content: {
                    ToolbarItem(placement: .navigationBarTrailing, content: {
                        Menu(content: {
                            Button(action: {
    
                            }, label: {
                                Text("\(name)님")
                            })
                            Button(action: {

                            }, label: {
                                Label("경고: \(warning)회", systemImage: "exclamationmark.triangle.fill")
                            })
                            Button(action: {
                                self.GoToEdit = true
                            }, label: {
                                Label("회원정보 수정", systemImage: "square.and.pencil")
                            })
                            Section {
                                Button(role: .destructive, action: {
                                    self.mode.wrappedValue.dismiss()
                                }) {
                                    Text("로그아웃")
                                }
                            }
                        }, label: {
                            Image(systemName: "person.crop.circle.fill").font(.system(size: 30))
                        }).background(NavigationLink(destination: EditProfileView(grade: $grade), isActive: $GoToEdit) {
                            EmptyView()
                        })
                    })
                }).padding([.bottom], 15)
                Button(action: enter) {
                    Text("입실").frame(maxWidth: .infinity)
                }.padding().frame(maxWidth: .infinity).background(Color.blue).foregroundColor(Color.white)
                    .cornerRadius(20)
                    .alert(isPresented: $ShowingEnterAlert) {
                    switch activeEnterAlert {
                    case .success:
                        return Alert(title: Text("입실되었습니다."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    case .already:
                        return Alert(title: Text("이미 입실되었습니다."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    case .error:
                        return Alert(title: Text("저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    case .today_already:
                        return Alert(title: Text("오늘 입실한 기록이 있습니다."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    }
                }
                Button(action: leave) {
                    Text("퇴실").frame(maxWidth: .infinity)
                }.padding().frame(maxWidth: .infinity).background(Color.blue).foregroundColor(Color.white)
                    .cornerRadius(20).padding(.top, 10)
                    .alert(isPresented: $ShowingLeaveAlert) {
                    switch activeLeaveAlert {
                    case .success:
                        return Alert(title: Text("퇴실되었습니다."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    case .already:
                        return Alert(title: Text("이미 퇴실되었습니다."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    case .error:
                        return Alert(title: Text("저장하는 과정에서 문제가 생겼습니다. 관리자에게 문의하세요."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    case .today_already:
                        return Alert(title: Text("오늘 입실한 기록이 있습니다."), dismissButton: .default(Text("Ok"), action: {
                            empty_seats()
                        }))
                    }
                }
                Text("※ 24시간 동안 퇴실하지 않으면 경고 1회입니다.").padding(.top, 15).foregroundColor(.red).font(Font.headline.bold())
                Text("경고가 3회 누적시 불이익이 있을 수 있습니다.").foregroundColor(.red).font(Font.headline.bold())
                Spacer()
                Spacer()
            }.padding()
        }.onAppear(perform: empty_seats).navigationBarBackButtonHidden(true).background(Color(uiColor: .systemGray6))
    }
}
