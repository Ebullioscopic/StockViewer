# StockViewer

StockViewer is an iOS application built with Swift and SwiftUI that allows users to access real-time forex exchange rates, stock market data, news sentiment, and top-traded stocks. The app utilizes the AlphaVantage and Polygon.io APIs to retrieve the necessary data.

## Features

### 1. Stock News Sentiment
- Retrieve real-time sentiment analysis for stocks using AlphaVantage's **NEWS_SENTIMENT** feature.

![Stock News Sentiment](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/News-StockViewer-v2.png)

### 2. Top-Traded Stocks
- Display a list of top gainers and losers using the **TOP_GAINERS_LOSERS** function from AlphaVantage.

![Top-Traded Stocks](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/TopTickers-StockViewer-v2.png)

### 3. Previous Close Data
- Get previous close price for a specific stock ticker via the Polygon.io API.

![Previous Close Data](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/SearchBar-StockViewer-v2.png)

### 4. Detailed Stock Data
- Fetch a detailed historical analysis of a stock using the **TICKER DETAIL** function from Polygon.io.

![Detailed Stock Data](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/TickerDetail-StockViewer-v2.png)

### 5. Search Stock Symbol
- Search for stock tickers using **SYMBOL_SEARCH** provided by AlphaVantage.

![Search Stock Symbol](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/SearchBar-StockViewer-v2.png)

### 6. Market Status
- Check whether the market is open or closed using the **MARKET_STATUS** function from AlphaVantage.

![Market Status](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/MarketStatus-StockViewer-v2.png)

### 7. Forex Exchange Rate
- The app allows users to convert between different currencies.
- Two services are provided for this:
    - **Polygon API**: For getting exchange rates between currencies.
    - **AlphaVantage API**: An alternate API for fetching forex exchange rates.

![Forex Exchange Rate](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/Forex-StockViewer-v2.png)

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/StockViewer.git
   cd StockViewer
   ```

2. Open the `StockViewer.xcodeproj` file in Xcode.

   ```bash
   open StockViewer.xcodeproj
   ```

3. Install all required dependencies. If you are using Swift Package Manager (SPM), it will automatically resolve and download the dependencies when you open the project.

4. **Set up API Keys**:
   - The application relies on both **AlphaVantage** and **Polygon.io** APIs.
   - You will need to create an `APIKeys.plist` file in the project to store your API keys.

### Creating the `APIKeys.plist` File:

   1. Navigate to your project folder and create a new `.plist` file.
   2. Name the file `APIKeys.plist`.
   3. Add the following keys and values to the plist file:
   
      ```xml
      <?xml version="1.0" encoding="UTF-8"?>
      <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
      <plist version="1.0">
      <dict>
          <key>POLYGON_API_KEY</key>
          <string>Your Polygon API Key</string>
          <key>API_kEY</key>
          <string>Your AlphaVantage API Key</string>
      </dict>
      </plist>
      ```
   4. Replace `Your Polygon API Key` and `Your AlphaVantage API Key` with the actual API keys obtained from the respective websites.

### Obtaining API Keys:

- **AlphaVantage**: Register and get your API key from [AlphaVantage](https://www.alphavantage.co/support/#api-key).
- **Polygon.io**: Sign up and get your API key from [Polygon.io](https://polygon.io/).

### Adding the `APIKeys.plist` to Xcode:
1. Open Xcode, and in the Project Navigator, right-click on the `Resources` folder (or create one if it doesn't exist).
2. Click **Add Files to "StockViewer"** and select the `APIKeys.plist` file.
3. Ensure the file is added to the target (StockViewer app).

## Running the Application

Once you have set up the API keys, follow these steps to run the app:

1. Select your target device or simulator in Xcode.
2. Build and run the project by pressing `Cmd + R` or by clicking the **Play** button in the toolbar.

## Usage

### 1. **Forex Conversion**:
   - Users can select two currencies and input an amount to see the conversion rate between them.
   - The app provides conversion via both Polygon.io and AlphaVantage APIs, with a fallback mechanism.

### 2. **Stock Sentiment**:
   - Navigate to the "News Sentiment" section to view the latest sentiment analysis for stocks.
   - Currently set for Apple Inc. (AAPL), but you can modify it for other tickers.

### 3. **Top-Traded Stocks**:
   - View a list of the top-gaining and top-losing stocks for the day using the AlphaVantage API.

### 4. **Previous Close and Ticker Detail**:
   - Users can input a stock symbol to get the previous close price or detailed historical data for the stock.

### 5. **Search Stock Symbol**:
   - The app allows users to search for stock symbols using keywords, fetching the results from AlphaVantage.

### 6. **Market Status**:
   - The app provides the current market status (open/closed).

## Project Structure

- **View Layer**:
  - `ForexView.swift`: Manages the UI for forex exchange rate conversion.
  - `StockDetailView.swift`: Handles displaying detailed stock information.
  - `TopTradedView.swift`: Shows top traded stocks (gainers and losers).
  
- **ViewModel Layer**:
  - `ForexViewModel.swift`: Handles the logic behind the forex exchange functionality.
  - `StockViewModel.swift`: Fetches stock data, top traded stocks, and ticker details.
  
- **Service Layer**:
  - `StockService.swift`: Contains methods to fetch data from AlphaVantage and Polygon.io APIs.

## API Service

This app uses two main APIs for fetching financial and market data:

1. **AlphaVantage API**:
   - Provides data for forex exchange, news sentiment, top traded stocks, stock symbol search, and market status.
   - API Documentation: [AlphaVantage API](https://www.alphavantage.co/documentation/)

2. **Polygon.io API**:
   - Provides stock-related data, including previous close price and detailed stock analysis.
   - API Documentation: [Polygon.io API](https://polygon.io/docs/)

## Example Requests

### Forex Exchange Example (AlphaVantage):

Request URL:
```
https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=USD&to_currency=EUR&apikey=YOUR_API_KEY
```

### Stock News Sentiment Example (AlphaVantage):

Request URL:
```
https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=AAPL&apikey=YOUR_API_KEY
```

### Previous Close Example (Polygon.io):

Request URL:
```
https://api.polygon.io/v2/aggs/ticker/AAPL/prev?adjusted=true&apiKey=YOUR_API_KEY
```

## Dependencies

- Swift 5.7+
- SwiftUI
- Xcode 14.0 or later

## Troubleshooting

### Common Issues:

1. **Invalid API Key**:
   - Ensure you have correctly set up your API keys in the `APIKeys.plist` file.
   - Verify your API key on the AlphaVantage or Polygon.io dashboard.

2. **Network Errors**:
   - Check your internet connection.
   - Verify the status of the AlphaVantage or Polygon.io API servers.

3. **Invalid URL**:
   - Ensure that the currency codes or stock symbols used in requests are valid.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

