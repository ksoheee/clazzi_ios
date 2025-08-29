//
//  MyPageView.swift
//  Clazzi
//
//  Created by Admin on 8/28/25.
//

import SwiftUI

struct MyPageView: View {
    //@Binding var isLoggedIn : Bool
    @Binding var currentUserID : UUID?
    var body: some View {
        NavigationStack{
            VStack{
                Text("로그인 된 이메일:")
                Text("가짜 이메일")
                Button(action:{
                    currentUserID = nil
                    //isLoggedIn = false
                    //UserDefaults.standard.set(false, forKey: "isLoggedIn")
                    UserDefaults.standard.removeObject(forKey: "currentUserID")
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

struct MyPageView_PreViews: PreviewProvider {
    struct Wrapper: View{
        //@State var isLoggedIn: Bool = false
        @State var currentUserID: UUID? = nil
        var body: some View{
            MyPageView(currentUserID: $currentUserID)
        }
    }
    static var previews: some View{
        Wrapper()
    }
}


//#Preview {
//    MyPageView()
//}
