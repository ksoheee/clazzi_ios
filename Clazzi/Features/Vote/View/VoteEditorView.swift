//
//  CreateVoteView.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI

struct VoteEditorView: View {
    //뒤로가기 (모달 바텀시트) 닫기
    @Environment(\.dismiss) private var dismiss
    
    @State private var title : String = ""
    @State private var options : [String] = ["",""]
    
    //투표 목록 화면에서 전달해줄 콜백 메서드 함수를 받아서 원하는 때에 실행
    var onSave: (Vote) -> Void //Vote라는 매개변수 받고 반환은 Void
    
    private var existingVote: Vote? //새 투표일때는 nil, 수정일때는 Vote객체 받아서 가지고 있음
    /**
     생성자
     투표 생성으로 들어왔을 때는 투표 없어도 되기 때문에 nil
     CreateVoteView()만 호출하면 투표 생성 모드
     CreateVoteView(vote: someVote)처럼 넘겨주면 투표 수정 모드
     저장완료시 실행할 콜백함수
     */
    init(vote: Vote? = nil, onSave: @escaping(Vote)-> Void){
        self.existingVote = vote
        self.onSave = onSave
        //수정일 경우 초기값 설정
        if let vote = vote {
            _title = State(initialValue: vote.title)         //title set으로 바꿔줄 수 없음 private으로 선언된 변수는 _가 필요
            _options = State(initialValue: vote.options.map {$0.name})
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView{
                    VStack(alignment: .leading){
                        TextField("투표 제목", text: $title)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.bottom, 32)
                        HStack{
                            Text("투표 항목")
                                .font(.headline)
                            Spacer()
                            Button("항목 추가"){
                                options.append("")
                            }
                        }
                    
                        .buttonStyle(.bordered)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        ForEach(options.indices, id: \.self){ index in
                            TextField("항목 \(index+1)", text: $options[index])
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.gray, lineWidth: 1)
                                )
                        }
                    
                        
                        Spacer()
                        
                        
                        
                    }
                }
                .navigationBarTitle("투표 \(existingVote == nil ? "생성" : "수정") ")
                //생성하기 버튼
                Button(action: {
                    if let vote = existingVote{
                        //기존 객체를 직접 수정
                        vote.title = title
                        //기존 옵션 삭제 후 새로 생성
                        vote.options = options.map{VoteOption(name: $0)}
                        
                        onSave(vote) //받은 함수 실행, 부모에게 전달
                        
                    }
                    else{
                        //새 객체 생성
                        let newVote = Vote(title: title, options: options.map { VoteOption(name: $0)})
                        onSave(newVote)
                    }
                    dismiss()
                    
                }){
                    Text(existingVote == nil ? "생성하기": "수정하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    VoteEditorView(){vote in //이 클로저를 호출할 때 넘겨받는 Vote를 vote라는 이름으로 사용
        
    }
}
