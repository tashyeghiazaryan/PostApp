//
//  PostView.swift
//  PostApp
//
//  Created by Artashes Yeghiazaryan on 25.11.2024.
//

import SwiftUI
import PhotosUI

struct CreatePostView: View {
    @ObservedObject var presenter: PostPresenter
    @Binding var isPresented: Bool
    
    @State private var text: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                // Text Field for Post Content
                TextField("Write something...", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                // Selected Image Preview
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .padding()
                }
                
                // Image Picker Button
                Button(action: {
                    showImagePicker = true
                }) {
                    HStack {
                        Image(systemName: "photo.on.rectangle")
                            .font(.title2)
                        Text(selectedImage == nil ? "Add Image" : "Change Image")
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .padding()
                .sheet(isPresented: $showImagePicker) {
                    ImagePicker(image: $selectedImage)
                }
                
                // Submit Button
                Button(action: {
                    var savedImagePath: String? = nil
                    
                    if let image = selectedImage {
                        savedImagePath = saveImageToDisk(image: image)
                    }
                    
                    presenter.addPost(text: text, image: savedImagePath)
                    isPresented = false
                }) {
                    Text("Submit")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationTitle("Create Post")
            .navigationBarItems(leading: Button("Cancel") {
                isPresented = false
            })
        }
    }
}

extension CreatePostView {
    func saveImageToDisk(image: UIImage) -> String? {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        
        let filename = UUID().uuidString + ".jpg"
        let fileURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)
        
        do {
            try data.write(to: fileURL)
            return fileURL.path
        } catch {
            print("Error saving image: \(error)")
            return nil
        }
    }
}
