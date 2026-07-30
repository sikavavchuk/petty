//
//  SessionScreenView.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 25/07/2026.
//

import SwiftUI

struct SessionScreenView: View {
    
    @Binding var path: NavigationPath
    @State private var progress = 0.48
    @State private var showExitAlert = false
    
    var body: some View {
        VStack(spacing: 30) {
            
            HStack() {
                Button {
                    showExitAlert = true
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2)
                        .foregroundStyle(.black)
                        .frame(width: 50, height: 50)
                        .background(.white)
                        .clipShape(Circle())
                }
                
                Spacer()
            }.padding(.horizontal, 20)
                .alert("Leave session?", isPresented: $showExitAlert) {

                    Button("Stay", role: .cancel) { }

                    Button("Leave", role: .destructive) {
                        path = NavigationPath()
                    }

                } message: {
                    Text("Your progress won't be saved.")
                }
            
            HStack {
                Image("flame").resizable().frame(width: 45, height: 45)
                VStack {
                    Text("Round: 1/4").font(.title3).fontWeight(.bold)
                    Text("Break: 5 min")
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(
                            red: 255 / 255,
                            green: 249 / 255,
                            blue: 230 / 255
                        ))
                )
                .padding(.horizontal, 100)
            
            Image("selection-cat")
                .resizable()
                .frame(width: 300, height: 200)
            
            Text("24:56")
                .font(.custom("Arial", size: 70)).fontWeight(.bold)
            
            HStack {
                ProgressView(value: progress).tint(Color.orange)
                    .frame(maxWidth: .infinity)
                        
                Text("\(Int(progress * 100))%")
            }.padding()
                .frame(maxWidth: .infinity)
                .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(
                    red: 255 / 255,
                    green: 249 / 255,
                    blue: 230 / 255))
                )
                .padding(.horizontal, 20)
            
            HStack(spacing: 100) {
                Button() {
                    
                } label: {
                    Image(systemName: "pause.fill")
                        .font(.title)
                        .foregroundStyle(.black)
                        .frame(width: 72, height: 72)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }
                
                Button() {
                    
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(Color.red)
                        .clipShape(Circle())
                }
            }.padding()
            
            Spacer()
            
        }
        .frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .foregroundStyle(Color(red: 255 / 255, green: 240 / 255, blue: 218 / 255))
                    .ignoresSafeArea()
            }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NavigationStack {
        SessionScreenView(path: .constant(NavigationPath()))
    }
}

