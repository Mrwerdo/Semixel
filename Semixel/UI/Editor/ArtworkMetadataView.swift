//
//  ArtworkMetadataView.swift
//  Semixel
//
//  Created by Andrew Thompson on 22/1/21.
//  Copyright © 2021 Andrew Thompson. All rights reserved.
//

import SwiftUI

struct ArtworkMetadataView: View {
    @EnvironmentObject var metadata: ArtworkMetadata
    @EnvironmentObject var store: ArtworkStore
    @EnvironmentObject var artwork: SemanticArtwork
    
    @Binding var isPresented: Bool
    @Binding var showGrid: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                Text(metadata.title)
                    .font(Font.title3)
                Spacer()
                Button {
                    isPresented = false
                } label: {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .foregroundColor(Color(UIColor.secondarySystemFill))
                            .font(.system(size: 31))
                        Image(systemName: "xmark")
                            .foregroundColor(Color.secondary)
                            .font(.system(size: 15, weight: .bold))
                    }
                }
            }
            .padding()
            .padding(.leading)
            .padding(.trailing)
            .background(Color(UIColor.secondarySystemGroupedBackground))
            Divider()
            List {
                Section {
                    action(title: showGrid ? "Hide Grid" : "Show Grid", icon: "squareshape.split.3x3", dismisses: false) {
                        showGrid.toggle()
                    }
                    action(title: "Horizontal Flip", icon: ToolType.hflip.iconName, dismisses: false) {
                        let region = SelectedRegion(size: artwork.image.size, default: true)
                        artwork.transform(selection: region, horizontalFlip: true)
                    }
                    action(title: "Vertical Flip", icon: ToolType.vflip.iconName, dismisses: false) {
                        let region = SelectedRegion(size: artwork.image.size, default: true)
                        artwork.transform(selection: region, verticalFlip: true)
                    }
                }
                Section {
                    textfield("Title", for: $metadata.title)
                    textfield("Path", for: $metadata.path)
                        .keyboardType(.default)
                        .disableAutocorrection(true)
                }
                Section {
                    field("Size", "\(metadata.size.width)x\(metadata.size.height)")
                    field("Type", metadata.pixelType.rawValue)
                    field("Id", metadata.id)
                }
            }
            .onAppear {
                UITableView.appearance().isScrollEnabled = false
            }
            .onDisappear {
                UITableView.appearance().isScrollEnabled = true
            }
        }
        .listStyle(InsetGroupedListStyle())
        .accentColor(Color.black)
        .background(Color(UIColor.secondarySystemBackground))
    }
    
    func field(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
            Spacer()
            Text(value)
        }
    }
    
    func textfield(_ title: String, for binding: Binding<String>) -> some View {
        HStack {
            Text(title)
            Spacer()
            TextField(title, text: binding, onCommit:  {
                ignoreErrors {
                    try store.saveMetadata()
                }
            })
        }
    }
    
    func action(title: String, icon: String, dismisses: Bool = true, callback: @escaping () -> ()) -> some View {
        Button {
            callback()
            if dismisses {
                isPresented = false
            }
        } label: {
            HStack {
                Text(title)
                Spacer()
                Image(systemName: icon)
                    .font(Font.title3)
            }
        }
    }
}


