//
//  ClazziApp.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI
import SwiftData

@main
struct ClazziApp: App {
    //로그인 상태
    @State var isLoggedIn: Bool = false
    
    //스위프트 데이터 컨테이너
    var sharedModelcontainer: ModelContainer = {
        let schema = Schema([
            Vote.self,
            VoteOption.self,
            User.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        do{
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        }catch{
            fatalError("모델 컨테이너를 생성하지 못하였습니다. \(error)")
        }
    }()
    var body: some Scene {
        WindowGroup {
            if isLoggedIn{
                VoteListView(isLoggedIn: $isLoggedIn)
            }else{
                AuthView(isLoggedIn: $isLoggedIn)
            }
        }
        .modelContainer(sharedModelcontainer)
    }
}
