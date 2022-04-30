//
//  AdminView.swift
//  UlsanHighSchool
//
//  Created by 이석민 on 2022/01/16.
//

import Foundation
import SwiftUI

struct AdminView: View {
    @Binding var TeacherName: String
    var body: some View {
        TabView {
            MemberView(UserName: $TeacherName).tabItem {
                Label("학생 정보", systemImage: "person.fill")
            }
            SearchHistoryView().tabItem {
                Label("기록 검색", systemImage: "magnifyingglass")
            }
            StudyView().tabItem {
                Label("공부중", systemImage: "pencil")
            }
            NoticeAdminView(UserName: $TeacherName).tabItem {
                Label("공지사항", systemImage: "bell.fill")
            }
        }.navigationBarBackButtonHidden(true)
    }
}
