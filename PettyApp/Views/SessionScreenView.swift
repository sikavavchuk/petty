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
    
    let totalFocusTimerSeconds: Int
    let breakTime: Int
    private let second = 10

    var body: some View {
        VStack(spacing: 30) {
            
            Spacer()
            
            HStack {
                Image(sessionModel.pauseTimerRunning ? "pause-flame" : "flame").resizable().frame(width: 45, height: 45)
                VStack {
                    Text("Focus Session").font(.title3).fontWeight(.bold)
                    Text("Break time: \(breakTime) min")
                }
            }.padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundStyle(
                            sessionModel.pauseTimerRunning
                                ? Color(red: 185 / 255, green: 209 / 255, blue: 117 / 255)
                                : Color(
                                    red: 255 / 255,
                                    green: 249 / 255,
                                    blue: 230 / 255
                                )
                        )
                )
                .padding(.horizontal, 80)
            
            Image(sessionModel.pauseTimerRunning ? "pause-cat" : "selection-cat")
                .resizable()
                .frame(width: 300, height: 200)
            
            Spacer()
            
            //UI if timer is active
            if sessionModel.pauseTimerRunning {
                
                VStack(spacing: 20) {
                    Text("Break Time")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(height: 30)
                    
                    Text(sessionModel.pauseTimeString)
                        .font(.custom("Arial", size: 70))
                        .fontWeight(.bold)
                    
                    Text("Take a little rest.")
                        .font(.title3)
                        .frame(height: 1)
                }
                .transition(.opacity)
                
            } else {
                VStack {
                    Text(sessionModel.focusTimeString)
                        .font(.custom("Arial", size: 70))
                        .fontWeight(.bold)
                    
                    HStack {
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                Capsule()
                                    .fill(Color.white.opacity(0.8))

                                Capsule()
                                    .fill(.orange)
                                    .frame(
                                        width: geometry.size.width * sessionModel.focusProgress
                                    )
                            }
                        }
                        .frame(height: 16)
                    }
                    .transition(.opacity)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(
                                sessionModel.focusTimerRunning
                                    ? Color(
                                        red: 255 / 255,
                                        green: 249 / 255,
                                        blue: 230 / 255
                                    )
                                    : Color(
                                        red: 255 / 255,
                                        green: 110 / 255,
                                        blue: 130 / 255
                                    )
                            )
                    )
                    .padding(.horizontal, 20)
                }
                .transition(.opacity)
            }
            HStack(spacing: 100) {
                Button {
                    if sessionModel.pauseTimerRunning {
                        // End the current break
                        sessionModel.stopPauseTimer()
                    } else {
                        // Start a new break
                        sessionModel.startPauseTimer()
                    }
                    
                } label: {
                    Image(
                        systemName: sessionModel.pauseTimerRunning
                            ? "play.fill"
                            : "pause.fill"
                    )
                    .font(.title)
                    .foregroundStyle(.black)
                    .frame(width: 72, height: 72)
                    .background(
                        sessionModel.pauseTimerRunning
                            ? Color(red: 185 / 255, green: 209 / 255, blue: 117 / 255)
                            : Color.yellow
                    )
                    .clipShape(Circle())
                }
                
                Button() {
                    showExitAlert = true
                } label: {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.title)
                        .foregroundStyle(.white)
                        .frame(width: 72, height: 72)
                        .background(
                            sessionModel.pauseTimerRunning
                            ? Color.gray
                                : Color.red
                        )
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
                    .foregroundStyle(
                        sessionModel.pauseTimerRunning
                        ? Color(red: 245 / 255, green: 251 / 255, blue: 218 / 255)
                            : Color(red: 1, green: 240 / 255, blue: 218 / 255)
                    )
                    .ignoresSafeArea()
            }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            sessionModel.totalFocusTimerSeconds = totalFocusTimerSeconds
            sessionModel.pauseSecondsRemaining = breakTime * 60 //in seconds
            print(breakTime)
            sessionModel.startFocusTimer()
        }
        .onChange(of: sessionModel.focusTimerFinished) { _, finished in
            if finished {
                mainModel.updateTotalFocusedTime()
                path = NavigationPath()
            }
        }
        .onChange(of: sessionModel.focusSecondsRemaining) { _, secondsRemaining in
                mainModel.updateTotalFocusedTime(time: second)
            
        }
        
    }
}

#Preview {
    NavigationStack {
        SessionScreenView(
            path: .constant(NavigationPath()),
            totalFocusTimerSeconds: 3600 + 1800,
            breakTime: 5
        ).environment(MainScreenViewModel())
    }
}
