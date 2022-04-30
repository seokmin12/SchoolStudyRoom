//
//  LoginView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct LoginView: View {
    enum ActiveAlert {
        case fail, blank
    }
    @State var grade : String = ""
    @State private var password: String = ""
    
    @State var StudentGrade: String = ""
    @State var StudentName: String = ""
    @State var StudentWarning: String = ""
    
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
                                let grade = parseJSON["grade"] as? String
                                let name = parseJSON["name"] as? String
                                let warning = parseJSON["warning"] as? String
                                
                                let Teachername = parseJSON["teacher_name"] as? String
                                print("Login: \(result!)")
                                if result == "success" {
                                    isLoading = false
                                    GoToMain = true
                                    StudentGrade = grade!
                                    StudentName = name!
                                    StudentWarning = warning!
                                    print(grade!)
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
        VStack(spacing: 0) {
            
        }
    }
}
