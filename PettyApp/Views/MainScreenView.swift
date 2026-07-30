//
//  MainScreenView.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 28/07/2026.
//

import SwiftUI

struct MainScreenView: View {
    
    @State private var model = MainScreenViewModel()
    
    @Binding var path: NavigationPath
    
    var body: some View {
        
        VStack(spacing: 35) {
            HStack {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Hello!")
                        .foregroundStyle(Color.black)
                    Text("Let's grow together.")
                        .font(.title)
                    
                }
                Spacer()
                Image("cat-main-scene")
                    .resizable()
                    .frame(width: 180, height: 180)
            }
            .padding(20)
            
            HStack(spacing: 20) {
                
                VStack {
                    Text("Curren Streak")
                    HStack {
                        Image("flame")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("6").font(.title)
                            .fontWeight(.bold)
                        Text("Days")
                    }
                    Text("Keep it up!")
                }.frame(width: 180, height: 180)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(
                                red: 255 / 255,
                                green: 249 / 255,
                                blue: 230 / 255
                            ))
                    )
                
                VStack(spacing: 18) {
                    Text("Total Focus Time")
                    
                    if model.isLoading {
                        ProgressView()
                    } else {
                        HStack {
                            Text(model.totalFocusedHours)
                                .font(.title)
                                .fontWeight(.bold)
                            Text(model.totalFocusedMinutes)
                                .font(.title)
                                .fontWeight(.bold)
                        }
                    }
                
                    Text("This week")
                }.frame(width: 180, height: 180)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(
                                red: 255 / 255,
                                green: 249 / 255,
                                blue: 230 / 255
                            ))
                    )
                
                
            }.padding()
            
            Button() {
                path.append(Route.selection)
            } label: {
                HStack(spacing: 15) {
                    
                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.black)
                    
                    VStack(alignment: .leading) {
                        Text("Start Focus")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Let's get productive!")
                    }
                    
                    Spacer()
                    
                    Image("cat-focus-menu")
                        .resizable()
                        .frame(width: 90, height: 70)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(
                            Color(
                                red: 242 / 255,
                                green: 202 / 255,
                                blue: 121 / 255
                            )
                        )
                )
                .padding(.horizontal, 20)
            }
            .buttonStyle(.plain)
            
            Spacer()
            
        }.frame(maxWidth: .infinity)
            .background {
                Rectangle()
                    .foregroundStyle(Color(red: 255 / 255, green: 240 / 255, blue: 218 / 255))
                    .ignoresSafeArea()
            }
            .task({
                await model.startInitialUpdate()
            })
            .navigationTitle("Petty")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        print("Settings tapped")
                    } label: {
                        Image(systemName: "gearshape.fill")
                    }
                }
            }
    }
}
    
#Preview {
    NavigationStack {
        MainScreenView(path: .constant(NavigationPath()))
    }
}
