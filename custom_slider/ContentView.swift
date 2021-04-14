//
//  ContentView.swift
//  custom_slider
//
//  Created by Deep Sathwara on 2021-03-25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View{
    @State var maxHeight: CGFloat = UIScreen.main.bounds.height / 3
    
    @State var sliderProgress: CGFloat = 0
    @State var sliderHeight: CGFloat = 0
    @State var lastDragValue: CGFloat = 0
    
    var body: some View{
        NavigationView{
            VStack{
                ZStack(alignment: .bottom, content:{
                        Rectangle()
                            .fill(Color("slider").opacity(0.15))
                            
                        Rectangle()
                            .fill(Color("slider"))
                            .frame(height: sliderHeight)
                    
                            
                })
                .frame(width: 100, height: maxHeight)
                .cornerRadius(35)
                .overlay(
                    Text("\(Int(sliderProgress * 100))%")
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.vertical, 10)
                        .padding(.horizontal,18)
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.vertical, 30)
                        .offset( y: sliderHeight < maxHeight - 105 ? -sliderHeight : -maxHeight + 105)
                    
                    ,alignment: .bottom
                )
                .gesture(DragGesture(minimumDistance: 0).onChanged({
                    (value) in
                    let translation = value.translation
                    
                    sliderHeight = -translation.height +
                    lastDragValue

                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
                    
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0
                    
                    
                    let progress = sliderHeight / maxHeight
                    sliderProgress = progress <= 1.0 ? progress : 1

                }).onEnded({ (value) in
                    
                    sliderHeight = sliderHeight > maxHeight ? maxHeight : sliderHeight
               
                    sliderHeight = sliderHeight >= 0 ? sliderHeight : 0

                    
                    lastDragValue = sliderHeight
                    
                  
                }))
              
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color("bg").ignoresSafeArea())
            .preferredColorScheme(.dark)
            .navigationTitle("Dashboard")
            
        }
    }
}
