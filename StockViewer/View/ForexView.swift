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
//        VStack {
//            VStack(spacing: 24) {
//                
//                // First currency selection and input
//                HStack {
//                    Text(forexViewModel.firstCurrencyCode)
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    
//                    Image(systemName: "chevron.down")
//                        .padding(.trailing, 16)
//                        .onTapGesture {
//                            forexViewModel.showFirstSheet.toggle()
//                        }
//                    
//                    TextField("Enter amount", text: $forexViewModel.firstCurrency)
//                        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.decimalPad)
//                }
//                .padding(.top, 16)
//                
//                // Second currency selection and input
//                HStack {
//                    Text(forexViewModel.secondCurrencyCode)
//                        .font(.title2)
//                        .fontWeight(.bold)
//                    
//                    Image(systemName: "chevron.down")
//                        .padding(.trailing, 16)
//                        .onTapGesture {
//                            forexViewModel.showSecondSheet.toggle()
//                        }
//                    
//                    TextField("Enter amount", text: $forexViewModel.secondCurrency)
//                        .frame(maxWidth: UIScreen.main.bounds.size.width * 0.6)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .keyboardType(.decimalPad)
//                }
//                
//                // Display the calculated exchange value
//                Text("Exchange Value: \(forexViewModel.exchangeValue, specifier: "%.2f")")
//                    .font(.title3)
//                    .fontWeight(.medium)
//                
//                // Loading indicator while fetching data
//                if forexViewModel.isLoading {
//                    ProgressView()
//                }
//                
//                Spacer()
//            }
//            .padding()
//            
//            // Update exchange rate on currency code changes
//            .onChange(of: [forexViewModel.firstCurrencyCode, forexViewModel.secondCurrencyCode]) {
//                Task {
//                    await forexViewModel.currencyExchangeRate()
//                }
//            }
//            // Update exchange calculation on value changes
//            .onChange(of: [forexViewModel.firstCurrency, forexViewModel.secondCurrency]) {
//                forexViewModel.calculateCurrencyExchange()
//            }
//            // Show sheets for currency pickers
//            .sheet(isPresented: $forexViewModel.showFirstSheet) {
//                CurrencyPickerView(currencyCode: $forexViewModel.firstCurrencyCode, forexViewModel: $forexViewModel)
//            }
//            .sheet(isPresented: $forexViewModel.showSecondSheet) {
//                CurrencyPickerView(currencyCode: $forexViewModel.secondCurrencyCode, forexViewModel: $forexViewModel)
//            }
//        }
//        .navigationTitle("Forex Converter")
//        .onAppear {
//            forexViewModel.readCsv(inputFile: "physical_currency_list.csv")
//            forexViewModel.dataw()
//        }
//    }
//}
//
//// Currency Picker View for selecting currencies
//struct CurrencyPickerView: View {
//    
//    @Binding var currencyCode: String
//    @Binding var forexViewModel: ForexViewModel
//    
//    var body: some View {
//        VStack {
//            // Search text field
//            TextField("Search", text: $forexViewModel.searchTextField)
//                .textFieldStyle(RoundedBorderTextFieldStyle())
//                .padding()
//            
//            // Currency list picker
//            Picker("Select Currency", selection: $currencyCode) {
//                ForEach(forexViewModel.searchCurrencyModel) { currency in
//                    HStack {
//                        Text(currency.currencyName)
//                        Spacer()
//                        Text(currency.currencyCode)
//                    }
//                }
//            }
//            .pickerStyle(WheelPickerStyle())
//            .presentationDetents([.medium])
//        }
//        .padding()
//        .onChange(of: forexViewModel.searchTextField) {
//            forexViewModel.searchCountry()
//        }
//    }
//}
//
//// Preview for the ForexView
//#Preview {
//    NavigationStack {
//        ForexView()
//    }
//}
