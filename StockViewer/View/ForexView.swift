//
//  ForexView.swift
//  StockApp
//
//  Created by hariharan mudaliar on 17/10/2024.
//

import SwiftUI

struct ForexView: View {
    
    @State private var forexViewModel = ForexViewModel(stockService: StockService())
   
    
    var body: some View {
        VStack{
                VStack(spacing:24){
                    HStack{
                        Text(forexViewModel.firstCurrencyCode)
                        Image(systemName: "chevron.down")
                            .padding(.trailing,16)
                            .onTapGesture {
                                forexViewModel.showFirstSheet.toggle()
                            }
                        TextField("Enter amount", text: $forexViewModel.firstCurrency)
                            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    .padding(.top,16)
                    HStack{
                        Text(forexViewModel.secondCurrencyCode)
                        Image(systemName: "chevron.down")
                            .padding(.trailing,16)
                            .onTapGesture {
                                forexViewModel.showSecondSheet.toggle()
                            }
                        TextField("Enter amount", text: $forexViewModel.secondCurrency)
                            .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .keyboardType(.numberPad)
                    }
                    
                    Text("\(forexViewModel.exchangeValue , specifier: "%.2f")")
                    
                    if(forexViewModel.isLoading) {
                        ProgressView()
                    }
                    
                    
                    Spacer()
                }
                .onChange(of: [forexViewModel.firstCurrency,forexViewModel.secondCurrency], initial: true, {
                    forexViewModel.calculateCurrencyExchange()
                })
                .sheet(isPresented: $forexViewModel.showFirstSheet) {
                    MyPickerView(myCurrencyCode: $forexViewModel.firstCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel,forexViewModel: $forexViewModel)
                }
                .sheet(isPresented: $forexViewModel.showSecondSheet) {
                    MyPickerView(myCurrencyCode: $forexViewModel.secondCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel,forexViewModel: $forexViewModel)
                }
                
            
            
        }
        .navigationTitle("Forex")
        .onAppear {
            forexViewModel.readCsv(inputFile: "physical_currency_list.csv")
            forexViewModel.dataw()
        }
        .onChange(of: [forexViewModel.firstCurrencyCode,forexViewModel.secondCurrencyCode], initial: true) {
            Task{
                    await forexViewModel.currencyExchangeRate()

            }
        }
        
    }
}

struct MyPickerView:View {
    
    @Binding var myCurrencyCode : String
    @Binding var currencyCode : [CurrencyModel]
    @Binding var forexViewModel: ForexViewModel
    
    var body: some View {
        
        VStack{
            
            TextField("Search", text: $forexViewModel.searchTextField)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Picker("Picker", selection: $myCurrencyCode) {
                ForEach(currencyCode) { datum in
                    HStack(spacing:16){
                        Text(datum.currencyName)
                        Spacer()
                        Text(datum.currencyCode)
                    }
                    
                }
            }
            .pickerStyle(.wheel)
            .presentationDetents([.medium])
            
        }
        .padding()
        .onChange(of: forexViewModel.searchTextField, initial: false) { oldValue, newValue in
            
           forexViewModel.searchCountry()
            
        }
        
       
    }
}


#Preview {
    NavigationStack{
        ForexView()
    }
}
////////////////////////////////////////////////////////////_________________________________________
//import SwiftUI
//
//struct ForexView: View {
//    
//    @State private var forexViewModel = ForexViewModel(stockService: StockService())
//    
//    var body: some View {
//        VStack(spacing: 20) {
//            // Currency Input Fields
//            currencyInputSection(
//                currencyCode: forexViewModel.firstCurrencyCode,
//                amount: $forexViewModel.firstCurrency,
//                showSheet: $forexViewModel.showFirstSheet
//            )
//            
//            currencyInputSection(
//                currencyCode: forexViewModel.secondCurrencyCode,
//                amount: $forexViewModel.secondCurrency,
//                showSheet: $forexViewModel.showSecondSheet
//            )
//            
//            // Exchange Value Display
//            Text("Exchange Value: \(forexViewModel.exchangeValue, specifier: "%.2f")")
//                .font(.largeTitle) // Increase font size for better visibility
//                .padding(.top, 10)
//
//            // Show loading indicator if needed
//            if forexViewModel.isLoading {
//                ProgressView()
//                    .progressViewStyle(CircularProgressViewStyle(tint: .blue))
//                    .scaleEffect(1.0) // Default scale
//                    .padding()
//            }
//            
//            Spacer()
//        }
//        .padding()
//        .navigationTitle("Forex")
//        .onAppear {
//            forexViewModel.readCsv(inputFile: "physical_currency_list.csv")
//            forexViewModel.dataw()
//        }
//        .onChange(of: forexViewModel.firstCurrencyCode) { _ in
//            Task {
//                await forexViewModel.currencyExchangeRate()
//            }
//        }
//        .onChange(of: forexViewModel.secondCurrencyCode) { _ in
//            Task {
//                await forexViewModel.currencyExchangeRate()
//            }
//        }
//        .sheet(isPresented: $forexViewModel.showFirstSheet) {
//            MyPickerView(myCurrencyCode: $forexViewModel.firstCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel, forexViewModel: $forexViewModel)
//                .presentationDetents([.height(300)]) // Set a fixed height for the picker
//        }
//        .sheet(isPresented: $forexViewModel.showSecondSheet) {
//            MyPickerView(myCurrencyCode: $forexViewModel.secondCurrencyCode, currencyCode: $forexViewModel.searchCurrencyModel, forexViewModel: $forexViewModel)
//                .presentationDetents([.height(300)]) // Set a fixed height for the picker
//        }
//    }
//    
//    // Function to create a Currency Input Section
//    private func currencyInputSection(currencyCode: String, amount: Binding<String>, showSheet: Binding<Bool>) -> some View {
//        HStack {
//            Text(currencyCode)
//                .font(.title) // Make currency code larger
//                .padding(.trailing, 8)
//            
//            Image(systemName: "chevron.down")
//                .foregroundColor(.gray)
//                .onTapGesture {
//                    showSheet.wrappedValue.toggle()
//                }
//            
//            TextField("Enter amount", text: amount)
//                .keyboardType(.decimalPad)
//                .font(.title) // Increase font size for the text field
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .frame(maxWidth: 100) // Limit input field width for a clean look
//        }
//        .padding()
//        .background(Color(.systemBackground)) // Match iOS design
//        .cornerRadius(8)
//        .shadow(radius: 1)
//    }
//}
//
//// Picker View for selecting currency
//struct MyPickerView: View {
//    
//    @Binding var myCurrencyCode: String
//    @Binding var currencyCode: [CurrencyModel]
//    @Binding var forexViewModel: ForexViewModel
//    
//    var body: some View {
//        VStack {
//            TextField("Search", text: $forexViewModel.searchTextField)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            List {
//                ForEach(currencyCode) { datum in
//                    HStack {
//                        Text(datum.currencyName)
//                        Spacer()
//                        Text(datum.currencyCode)
//                    }
//                    .contentShape(Rectangle()) // Make the entire row tappable
//                    .onTapGesture {
//                        myCurrencyCode = datum.currencyCode
//                        forexViewModel.showFirstSheet.toggle() // Dismiss sheet after selection
//                    }
//                }
//            }
//            .navigationTitle("Select Currency")
//            .navigationBarTitleDisplayMode(.inline)
//        }
//        .onChange(of: forexViewModel.searchTextField) { newValue in
//            forexViewModel.searchCountry()
//        }
//    }
//}
//
//#Preview {
//    NavigationStack {
//        ForexView()
//    }
//}
