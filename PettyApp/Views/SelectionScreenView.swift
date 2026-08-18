//
//  SelectionScreenView.swift
//  PettyApp
//
//  Created by Viktoriia Savchuk  on 25/07/2026.
//

import SwiftUI

struct SelectionScreenView: View {
    
    @State private var selectionModel = SelectionScreenViewModel()
    
    @Binding var path: NavigationPath
    @State private var selectedHour = 1
    @State private var selectedMinute = 30

    var body: some View {
        
        VStack {
            Image("selection-cat")
                .resizable()
                .frame(width: 300, height: 200)
            Text("How long will your focus session be?").font(.title)
                .fontWeight(.bold)
            HStack {
                Picker("Hours", selection: $selectedHour) {
                        ForEach(0...12, id: \.self) { hour in
                                Text("\(hour) h")
                                    .tag(hour)
                        }
                    
                    }
                    .pickerStyle(.wheel)
                    .frame(width: 100, height: 150)
                    .clipped()
                    
                
                Picker("Minutes", selection: $selectedMinute) {
                    ForEach(1...59, id: \.self) { minute in
                        Text("\(minute) m").tag(minute)
                    }
                }
                .pickerStyle(.wheel)
                .frame(width: 100, height: 150)
                .clipped()

            }
            HStack(spacing: 50) {
                Button() {
                    selectionModel.minusButtonClicked()
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color(
                            red: 242 / 255,
                            green: 202 / 255,
                            blue: 121 / 255
                        ))
                }
                VStack {
                    HStack {
                        Image("tea").resizable()
                            .frame(width: 40, height: 35)
                        Text("Break time")
                    }
                    HStack {
                        Text("\(selectionModel.breakTime)").font(.title2)
                            .fontWeight(.bold)
                        Text("min")
                    }
                }
                Button() {
                    selectionModel.plusButtonClicked()
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.largeTitle)
                        .foregroundStyle(Color(
                            red: 242 / 255,
                            green: 202 / 255,
                            blue: 121 / 255
                        ))
                }
            }.padding(10)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(
                            red: 255 / 255,
                            green: 249 / 255,
                            blue: 230 / 255
                        ))
                )
                .padding(.horizontal, 20)
            
            Button() {
                path.append(
                    Route.session(
                        totalTimeSeconds: selectedHour * 3600 + selectedMinute * 60, breakTime: selectionModel.breakTime
                        
                    )
                )
            } label: {
                HStack(spacing: 15) {

                    Image(systemName: "play.fill")
                        .font(.largeTitle)
                        .foregroundStyle(.black)

                    VStack(alignment: .leading) {
                        Text("Start Session")
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
        
    }
}

#Preview {
    NavigationStack {
        SelectionScreenView(
            path: .constant(NavigationPath()))
    }
}

