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
    
    //let options = ["포케","파스타"]
    @State private var selectedOption: Int? = nil
    
    let vote: Vote
    
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
                        Text(vote.options[index].name)
                            .frame(maxWidth: 200)
                            .padding()
                            .background(index == selectedOption ?
                                        Color.green.opacity(0.9) :
                                        Color.gray.opacity(0.3))
                            .foregroundColor(.white) //글자 색
                            .clipShape(Capsule()) //둥글기
                            .font(.headline)
                        
                    }
                }
                
                Spacer()
                
                Button(action:{
                    print("투표 항목은 \(vote.options[selectedOption ?? 0]) 입니다.")
                    dismiss()
                }){
                    Text("투표하기")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white) //글자 색
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }

            }
            .navigationTitle(Text("투표 화면"))
            .padding()
        }
    }
}

#Preview {
    VoteView(vote: Vote(title: "첫 번째 투표", options: [
        VoteOption(name: "옵션 1"),
        VoteOption(name: "옵션 2"),
        
    ]))
}
