//
//  ContentView.swift
//  RandomPic
//
//  Created by User03 on 2020/12/17.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    init() {
        imageLoader = ImageLoader(urlString: "https://loremflickr.com/320/240")
    }
    var body: some View {
        
        VStack{
            Text(imageLoader.category)
            Image(uiImage:imageLoader.data != nil ? UIImage(data: imageLoader.data!)!:UIImage()).resizable().scaledToFit()
            Button(action:{
                imageLoader.changePhoto()
            }){
                Text("Change photo")
            }
            Button(action:{
                imageLoader.changeURL()
            }){
                Text("Change category")
            }
        }
        
    }
}

class ImageLoader: ObservableObject {
    @Published var data:Data?
    @Published var category:String = "cat"
    var urlString: String = "https://loremflickr.com/320/240"
    @State var change:Int?
    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
    func changePhoto()
    {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async{
                self.data = data
                
            }
        }
        task.resume()
    }
    func changeURL(){
        if(self.urlString == "https://loremflickr.com/320/240"){
            category = "picsum"
            self.urlString = "https://picsum.photos/200/300"
            changePhoto()
        }
        else{
            category = "cat"
            self.urlString = "https://loremflickr.com/320/240"
            changePhoto()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
