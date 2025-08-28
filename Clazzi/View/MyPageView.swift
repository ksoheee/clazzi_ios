//
//  MyPageView.swift
//  Clazzi
//
//  Created by Admin on 8/28/25.
//

import SwiftUI

struct MyPageView: View {
    @Binding var isLoggedIn : Bool
    var body: some View {
        NavigationStack{
            VStack{
                Text("로그인 된 이메일:")
                Text("가짜 이메일")
                Button(action:{
                    isLoggedIn = false
                }){
                    Text("로그아웃")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundStyle(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            .navigationTitle(Text("마이페이지"))
        }
    }
}

//#Preview {
//    MyPageView()
//}
