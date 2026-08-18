//
//  SessionScreenView.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 25/07/2026.
//

import SwiftUI

struct SessionScreenView: View {
    
    @Environment(MainScreenViewModel.self) private var mainModel
    @State private var sessionModel = SessionScreenViewModel()
    @Binding var path: NavigationPath
    @State private var showExitAlert = false
    
    let totalTimerSeconds: Int
    let breakTime: Int
    private let second = 10

   
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
            
            Text(sessionModel.timeString)
                .font(.custom("Arial", size: 70)).fontWeight(.bold)
            
            HStack {
                ProgressView(value: sessionModel.progress).tint(Color.orange)
                    .frame(maxWidth: .infinity)
        
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
                        Text("Are you sure about that?")
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
            sessionModel.totalTimerSeconds = totalTimerSeconds

            sessionModel.startTimer()
        }
        .onChange(of: sessionModel.isFinished) { _, finished in
            if finished {
                mainModel.updateTotalFocusedTime()
                
                sessionModel.isTimerFinished()
                sessionModel.isTimerRunning()
                
                path = NavigationPath()
            }
        }
        .onChange(of: sessionModel.secondsRemaining) { _, secondsRemaining in
                mainModel.updateTotalFocusedTime(time: second)
            
        }
    }
}

#Preview {
    NavigationStack {
        SessionScreenView(
            path: .constant(NavigationPath()),
            totalTimerSeconds: 3600 + 1800,
            breakTime: 5
        )
    }
    .environment(MainScreenViewModel())
}
