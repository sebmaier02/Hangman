//
//  StartGameview.swift
//  GuessTheSong
//
//  Created by Sebastian Maier on 02.02.24.
//

import SwiftUI

struct StartGameView: View {
    @AppStorage("highscore") var highscore: Double = 0
    @AppStorage("streak") var streak: Double = 0
    
    @State var showInfo: Bool = false
    @State var categoryEnabled: Bool = false
    
    let categories: [Category] = Category.allCases
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Stats")
                        .font(.largeTitle)
                        .foregroundStyle(.BWL)
                        .bold()
                        .padding(.leading, 10)
                    Spacer()
                }
                
                HStack {
                    Group {
                        VStack {
                            Text("Longest Streak")
                            
                            Text("\(String(format: "%.0f", streak))")
                        }
                        
                        VStack {
                            Text("Highest points")
                            
                            Text("\(String(format: "%.0f", highscore))")
                        }
                    }
                    .padding()
                    .font(.title2)
                    .foregroundStyle(.BWL)
                    .background(.gray.opacity(0.3))
                    .clipShape(.rect(cornerRadius: 20))
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
                
                Spacer()
            }
            
            VStack {
                Spacer(minLength: 200)
                
                HStack {
                    VStack{
                        Toggle(isOn: $categoryEnabled){
                            Text("Categories")
                                .font(.largeTitle)
                                .foregroundStyle(.BWL)
                                .bold()
                        }
                        .tint(.correct)
                    }
                }
                .padding(.horizontal)
                
                Spacer(minLength: 20)
                
                ScrollViewReader { scrollView in
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: [GridItem(.flexible(), spacing: 0), GridItem(.flexible(), spacing: 0)], spacing: 16) {
                            ForEach(categories, id: \.self) { category in
                                cCV(text: category.rawValue, allSelected: $categoryEnabled)
                                    .id(category)
                            }
                        }
                        .onChange(of: categoryEnabled) {
                            if !categoryEnabled {
                                withAnimation {
                                    scrollView.scrollTo(categories.first, anchor: .top)
                                }
                            }
                        }
                        
                        Spacer(minLength: 120)
                    }
                    .opacity(categoryEnabled ? 1 : 0.3)
                    .scrollDisabled(!categoryEnabled)
                }
            }
            
            VStack {
                Spacer()
                
                NavigationLink{
                    PlayControllerView()
                } label: {
                    Text("Start")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .bold()
                        .foregroundStyle(.WWL)
                        .padding()
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .background(.BWL)
                        .clipShape(.rect(cornerRadius: 20))
                        .shadow(color: .BWL.opacity(0.5), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/, x: 0, y: 5)
                        .padding(.horizontal, 70)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("\(Image(systemName: "chevron.left"))")
                        .fontWeight(.bold)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "info.circle")
                    .onTapGesture {
                        showInfo.toggle()
                    }
                    .fullScreenCover(isPresented: $showInfo, content: {
                        sheetView
                    })
            }
            
        })
    }
    
    var sheetView: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Rules")
                        .font(.largeTitle)
                        .foregroundStyle(.WWL)
                        .bold()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(cSB().foregroundStyle(.BWL).ignoresSafeArea(edges: .top))
                
                Spacer(minLength: 100)
                
                VStack {
                    Text("In this mode, you'll receive a random English word. Each character you guess brings you either closer to the correct answer or closer to revealing the 'hangman'. Now, aim high and reach for the stars!")
                        .padding()
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    Text("Starting with 100 points, each incorrect guess deducts 10 points. However, correctly guessing the word propels you to the next round with a 10% point increase. For instance, reaching the second round boosts your starting points to 110.")
                        .padding()
                        .background(.gray.opacity(0.3))
                        .clipShape(.rect(cornerRadius: 20))
                        .font(.title2)
                        .foregroundColor(.BWL)
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 50)
            }
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.WWL)
                        .onTapGesture {
                            showInfo.toggle()
                        }
                }
            }
        }
    }
}

struct cCV: View {
    var text: String
    @State var selected: Bool = false
    @Binding var allSelected: Bool
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundStyle(.BWL)
            .frame(width: 130, height: 120)
            .padding(.horizontal)
            .background(selected ? Color.correct.opacity(0.3) : Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .onTapGesture {
                if allSelected {
                    selected.toggle()
                }
            }
            .onChange(of: allSelected) {
                if !allSelected {
                    if selected {
                        selected.toggle()
                    }
                }
            }
    }
}

struct cSB: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: rect.minX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.height))
            path.addQuadCurve(to: CGPoint(x: rect.minX, y: rect.height), control: CGPoint(x: rect.midX, y: rect.height*1.5))
        }
    }
}

#Preview {
    StartGameView()
}
