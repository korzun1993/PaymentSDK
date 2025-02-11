//
//  ContentView.swift
//  PaymentSDKExample
//
//  Created by Vladyslav Korzun on 11/02/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var viewModel: ContentViewModel = .init()
    
    var body: some View {
        VStack {
            Button("Send request") {
                viewModel.sendRequest()
            }
            .padding()
            switch viewModel.result {
            case .success(let transactionId):
                Text("Transation compleated with id: \(transactionId)")
            case .failure(let error):
                Text("Transaction faild with error: \(error.localizedDescription)")
            case .none: Text("No response recived yet")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
