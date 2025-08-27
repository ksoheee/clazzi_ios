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
    
    //투표 생성
    @State private var isPresentingCreate = false
    //투표 수정
    @State private var isPresentingEdit = false
    
    //투표 삭제 관련
    @State private var showDeleteAlert = false
    @State private var voteToDelete: Vote? = nil
    
    

    var body: some View {
        NavigationStack {
            //리스트로 삭제하는 방법
            /*List{
                ForEach(votes) { vote in
                    NavigationLink(destination: VoteView(vote:vote)){
                        VoteCardView(vote: vote)
                    }
                }
                .onDelete{ indexSet in //SwiftUI의 List에서 스와이프(왼쪽으로 밀기) 제스처로 항목을 삭제할 때 실행되는 modifier
                    votes.remove(atOffsets: indexSet)
                }
            }
            .listStyle(.grouped)*/
            
            ZStack { //겹쳐 쌓기 위해(IScrollView 위에 Button을 겹쳐서 올려놓을 수 있음)
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(votes.indices, id: \.self) { index in //votes의 인덱스를 가져오기 위해 indices
                            let vote = votes[index]
                            NavigationLink(destination: VoteView(vote:vote)){
                                VoteCardView(vote: vote) {
                                    voteToDelete = vote
                                    showDeleteAlert = true
                                    votes.remove(at: index) //바로 삭제
                                } onEdit: {
                                    isPresentingEdit = true
                                }
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
//                    Button(action:{
//                        isPresentingCreate = true
//                    }){
//                        Image(systemName: "plus")
//                    }
                }
            }
            //화면 이동 방법 2: 상태를 이용한 이동 방법
            .navigationDestination(isPresented: $isPresentingCreate){
                CreateVoteView(){ vote in //클로저
                    votes.append(vote)
                }
            }
            //수정화면 띄우기
            .navigationDestination(isPresented: $isPresentingEdit){
                CreateVoteView(){ vote in //클로저
                    votes.append(vote)
                }
            }
//            //모달(바텀시트)를 활용한 화면 띄우는 방법(상태 이용
//            .sheet(isPresented: $isPresentingCreate){
//                CreateVoteView(){ vote in
//                    votes.append(vote)
//                }
//            }
            
            //삭제 alert
            .alert("투표를 삭제하시겠습니까?", isPresented: $showDeleteAlert){
                Button("삭제", role: .destructive){
                    if let target = voteToDelete ,let index =
                        votes.firstIndex(where: {$0.id == target.id}) { //인덱스 중에 가장 첫번째
                        votes.remove(at: index)
                    }
                }
                Button("취소", role: .cancel){}
            } message:{
                if let target = voteToDelete {
                    Text("'\(target.title)' 투표가 삭제됩니다.")
                }
            }
            
            
        }
    }
}//

struct VoteCardView: View {
    let vote: Vote
    let onDelete: () -> Void //콜백함수, 클로저
    let onEdit: () -> Void
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text(vote.title)
                    .font(.title2)
                    .foregroundColor(.white)
                Text("투표 항목 보기")
                    .font(.caption2)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action:{
                onEdit()
            }){
                Image(systemName: "pencil")
                    .foregroundStyle(.white)
            }
            Button(action:{
                onDelete()
            }){
                Image(systemName: "trash")
                    .foregroundStyle(.white)
            }
            
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
