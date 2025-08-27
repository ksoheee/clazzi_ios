//
//  CreateVoteView.swift
//  Clazzi
//
//  Created by Admin on 8/26/25.
//

import SwiftUI

struct CreateVoteView: View {
    //뒤로가기 (모달 바텀시트) 닫기
    @Environment(\.dismiss) private var dismiss
    
    @State private var title : String = ""
    @State private var options : [String] = ["",""]
    
    //투표 목록 화면에서 전달해줄 콜백 메서드 함수를 받아서 원하는 때에 실행
    var onSave: (Vote) -> Void
    
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
                .navigationBarTitle("투표 생성")
                //생성하기 버튼
                Button(action: {
                    let vote = Vote(title: title, options: options)
                    onSave(vote) //받은 함수 실행한느 순간
                    dismiss()
                }){
                    Text("생성하기")
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
    CreateVoteView(){vote in
        
    }
}
