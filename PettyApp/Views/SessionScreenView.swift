//
//  SessionScreenView.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 25/07/2026.
//

import SwiftUI

struct SessionScreenView: View {
    
    @Environment(MainScreenViewModel.self) private var mainModel
    
    @Binding var path: NavigationPath
    @State private var showExitAlert = false
    
    let hour: Int
    let minutes: Int
    
    @State private var model = SessionScreenViewModel()
   
    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            HStack {
                Image("flame").resizable().frame(width: 45, height: 45)
                VStack {
                    Text("Focus Session").font(.title3).fontWeight(.bold)
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
                .padding(.horizontal, 80)
            
            Image("selection-cat")
                .resizable()
                .frame(width: 300, height: 200)
            
            Spacer()
            
            Text(model.timeString)
                .font(.custom("Arial", size: 70)).fontWeight(.bold)
            
            HStack {
                ProgressView(value: model.progress).tint(Color.orange)
                    .frame(maxWidth: .infinity)
                        
                //Text("\(Int(model.progress * 100))%")
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
                    showExitAlert = true
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(Color.red)
                        .clipShape(Circle())
                }.padding(.horizontal, 20)
                    .alert("Leave session?", isPresented: $showExitAlert) {

                        Button("Stay", role: .cancel) { }

                        Button("Leave", role: .destructive) {
                            path = NavigationPath()
                        }

                    } message: {
                        Text("Your progress won't be saved.")
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
        .onAppear {
            model.hour = hour
            model.minutes = minutes

            model.startTimer()
        }
        .onChange(of: model.isFinished) { _, finished in
            if finished {
                let duration = hour * 3600 + minutes * 60
                
                mainModel.totalFocusTime += duration
                
                mainModel.updateTotalFocusedTime()
                
                model.isFinished = false
                
                model.isRunning = false
                
                path = NavigationPath()
            }
        }
    }
}

#Preview {
    NavigationStack {
        SessionScreenView(
            path: .constant(NavigationPath()),
            hour: 1,
            minutes: 30
        )
        .environment(MainScreenViewModel())
    }
}
