//
//  ContentView.swift
//  Bin2Dec
//
//  Created by Javlonbek on 16/02/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State var bin = ""
    @State var action = false
    var body: some View {
        NavigationView {
            VStack{
                TextField("bin", text: $bin).padding()
                    .background(.gray.opacity(0.2)).cornerRadius(5)
                    .keyboardType(.numberPad)
                    .onReceive(Just(bin)) { newValue in
                        if bin.count > 8 {
                            bin = String(bin.prefix(8))
                            self.action = true
                        }
                        let filtered = newValue.filter { "01".contains($0)}
                        if filtered != newValue {
                            self.bin = filtered
                            self.action = true
                            
                        }
                    }
                    .alert("Please enter only 0 or 1 numbers", isPresented: $action) {}
                Text("Decimal: \(bin2String(bString: bin))")
                Spacer()
            }.font(.system(size: 30)).padding()
            .navigationTitle("Bin2Dec")
        }
    }
    
    func bin2String(bString: String) -> Int {
        if let binInt = Int(bString) {
            return bin2dec(bInt: binInt)
        }
        return 0
    }
    
    func bin2dec(bInt: Int) -> Int {
        if bInt/10 > 0 {
            return bInt%10 + 2*bin2dec(bInt: bInt/10)
        } else {
            return bInt%10
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
