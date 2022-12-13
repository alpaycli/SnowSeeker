//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Alpay Calalli on 30.11.22.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    
    @Environment(\.horizontalSizeClass) var sizeClass
    @Environment(\.dynamicTypeSize) var typeSize
    
    @EnvironmentObject var favorites: Favorites
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                
                Text("📷 Image Credit: ")
                    .fontWeight(.bold)
                +
                Text(resort.imageCredit)
                    .foregroundColor(.secondary)
                
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                
                HStack {
                    if sizeClass == .compact && typeSize > .large {
                        VStack(spacing: 10) { ResortDetailView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailView(resort: resort) }
                    } else {
                        ResortDetailView(resort: resort)
                        SkiDetailView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(Color.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
//                    Text(resort.facilities, format: .list(type: .and))
//                        .padding(.vertical)
                    
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                     .font(.title)
                            }
                        }
                    }
                    
                    Button(favorites.contains(resort) ? "❌ Remove from favorites" : "❤️ Add to favorites") {
                        if favorites.contains(resort) {
                            favorites.remove(resort)
                        } else {
                            favorites.add(resort)
                        }
                    }
                    .frame(width: 240, height: 40)
                    .background(favorites.contains(resort) ? .red : .green)
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .cornerRadius(50)
                    .padding()
                }
                .padding(.horizontal)
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        } message: { facility in
            Text(facility.description )
        }
    }
}

struct ResortView_Previews: PreviewProvider {
    static var previews: some View {
         NavigationView {
            ResortView(resort: Resort.example)
        }
         .environmentObject(Favorites() )
    }
}
