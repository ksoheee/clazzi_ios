//
//  VoteListView.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI

struct VoteListView: View {
    //let votes = ["첫 번째 투표", "두 번째 투표", "세 번째 투표","4","5","6","7","8"]
    
    @State private var votes = [
        Vote(title: "첫 번째 투표", options: ["옵션1","옵션1"]),
        Vote(title: "두 번째 투표", options: ["옵션3","옵션4"])
    ]
    
    @State private var isPresentingCreate = false

    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(votes) { vote in
                            NavigationLink(destination: VoteView(vote:vote)){
                                VoteCardView(vote: vote)
                            }
                        }
                    }
                }
                VStack{
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action:{
                            isPresentingCreate.toggle()
                        }){
                            Image(systemName: "plus")
                                .foregroundColor(.white)
                                .padding(24)
                                .background(Color.blue)
                                .clipShape(Circle())
                                .shadow(radius: 4)
                        }
                        .padding()
                    }
                }
            }
            
            .padding()
            .navigationTitle(Text("투표 목록"))
            .toolbar{
                ToolbarItem(placement: .navigationBarTrailing){
                    //화면 이동 방법1: 툴바 네이게이션 링크
                    //                    NavigationLink(destination: CreateVoteView()){
                    //                        Image(systemName: "plus")
                    //                    }
                    //화면 이동 방법 2: 상태를 이용한 이동 방법
                    Button(action:{
                        isPresentingCreate = true
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            //화면 이동 방법 2: 상태를 이용한 이동 방법
            .navigationDestination(isPresented: $isPresentingCreate){
                CreateVoteView(){ vote in //클로저
                    votes.append(vote)
                }
            }
            //모달(바텀시트)를 활용한 화면 띄우는 방법(상태 이용
            .sheet(isPresented: $isPresentingCreate){
                CreateVoteView(){ vote in
                    votes.append(vote)
                }
            }
        }
    }
}

struct VoteCardView: View {
    let vote: Vote
    var body: some View {
        VStack(alignment: .leading) {
            Text(vote.title)
                .font(.title2)
                .foregroundColor(.white)
            Text("투표 항목 보기")
                .font(.caption2)
                .foregroundColor(.white)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.gray)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.2), radius: 4, x: 1, y: 4)
    }
}

#Preview {
    VoteListView()
}
