//
//  ContentView.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI

struct VoteView: View {
    //뒤로 가기
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    
    //let options = ["포케","파스타"]
    @State private var selectedOption: Int = 0
    
    @Bindable var vote: Vote
    
    //let vote: Vote
    @Binding var currentUserID: UUID?
    
    //현재 유저가 이미 투표 했는지
    private var hasVoted: Bool{
        vote.options.contains(where: {$0.voters.contains(currentUserID ?? UUID() )})
    }
    
    var body: some View {
        NavigationStack{
            VStack{
                Spacer()
                Text(vote.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                
                ForEach(vote.options.indices, id: \.self){ index in
                    Button(action:{
                        selectedOption = index
                    }){
                        HStack {
                            
                            Text(vote.options[index].name)
                            Spacer()
                            //내가 이미 투표한 경우 표시
                            if vote.options[index].voters.first(where: {$0 == currentUserID}) != nil {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundStyle(.yellow)
                            }
                            Text("\(vote.options[index].votes)")
                            
                            
                        }
                        .padding(.horizontal)
                        .frame(maxWidth: 200)
                        .padding()
                        .background(index == selectedOption ?
                                    Color.green.opacity(0.9) :
                                        Color.gray.opacity(0.3))
                        .foregroundColor(.white) //글자 색
                        .clipShape(Capsule()) //둥글기
                        .font(.headline)
                        
                    }
                    .disabled(hasVoted)
                }
                
                Spacer()
                //투표하기
                Button(action:{
                    guard let currentUserID = currentUserID, !hasVoted else{
                        print("이미 투표했거나 유저 ID가 없습니다.")
                        return
                    }
                    //투표 데이터 업데이트
                    vote.options[selectedOption].voters.append(currentUserID)
                    
                    //모델 컨텍스트에 변경사항 저장
                    do{
                        try modelContext.save()
                        print("투표 저장 성공: \(vote.options[selectedOption].name)")
                    }catch{
                        print("투표 저장 실패: \(error)")
                    }
                    
                }){
                    Text("투표하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white) //글자 색
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }
                .disabled(hasVoted)

            }
            .navigationTitle(Text("투표 화면"))
            .padding()
        }
    }
}

#Preview {
    @Previewable @State var currentUserID: UUID? = nil
    VoteView(vote: Vote(title: "첫 번째 투표", options: [
        VoteOption(name: "옵션 1"),
        VoteOption(name: "옵션 2")
        
    ]), currentUserID : $currentUserID)
}
