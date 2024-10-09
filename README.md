# StockViewer

StockViewer is an iOS application built with **Swift** and **SwiftUI** that provides users with real-time forex exchange rates, stock market data, news sentiment analysis, and the latest information on top-traded stocks. The app leverages both **AlphaVantage** and **Polygon.io** APIs to retrieve this data efficiently.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/ScreenRecordings/v2/ScreenRecording-StockViewer-v2.gif" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/ScreenRecordings/v2/ScreenRecording-StockViewer-v2.gif)


## Navigation

- [Features](#features)
  - [1. Stock News Sentiment](#1-stock-news-sentiment)
  - [2. Top-Traded Stocks](#2-top-traded-stocks)
  - [3. Previous Close Data](#3-previous-close-data)
  - [4. Detailed Stock Data](#4-detailed-stock-data)
  - [5. Search Stock Symbol](#5-search-stock-symbol)
  - [6. Market Status](#6-market-status)
  - [7. Forex Exchange Rate](#7-forex-exchange-rate)
- [Installation](#installation)
  - [Steps to Set Up](#steps-to-set-up)
  - [Setting Up API Keys](#setting-up-api-keys)
  - [Adding `APIKeys.plist` to Xcode](#adding-apikeysplist-to-xcode)
- [Running the Application](#running-the-application)
- [Usage](#usage)
  - [Forex Conversion](#7-forex-exchange-rate)
  - [Stock Sentiment](#1-stock-news-sentiment)
  - [Top-Traded Stocks](#2-top-traded-stocks)
  - [Previous Close Data](#3-previous-close-data)
  - [Search Stock Symbol](#5-search-stock-symbol)
  - [Market Status](#6-market-status)
- [Project Structure](#project-structure)
- [API Services](#api-services)
- [Example API Requests](#example-api-requests)
- [Troubleshooting](#troubleshooting)
  - [Common Issues](#common-issues)
- [License](#license)
- [Contributors](#contributors)

---

## Features

### 1. [Stock News Sentiment](#1-stock-news-sentiment)
- Get real-time sentiment analysis for stocks using AlphaVantage's **NEWS_SENTIMENT** feature.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/News-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/News-StockViewer-v2.png)

### 2. [Top-Traded Stocks](#2-top-traded-stocks)
- View a list of top gainers and losers using AlphaVantage's **TOP_GAINERS_LOSERS** function.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/TopTickers-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/TopTickers-StockViewer-v2.png)

### 3. [Previous Close Data](#3-previous-close-data)
- Retrieve the previous closing price for a specific stock using the Polygon.io API.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/SearchBar-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/SearchBar-StockViewer-v2.png)

### 4. [Detailed Stock Data](#4-detailed-stock-data)
- Fetch detailed historical stock data via Polygon.io’s **TICKER DETAIL** function.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/TickerDetail-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/TickerDetail-StockViewer-v2.png)

### 5. [Search Stock Symbol](#5-search-stock-symbol)
- Search for stock tickers using AlphaVantage’s **SYMBOL_SEARCH** function.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/SearchBar-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/SearchBar-StockViewer-v2.png)

### 6. [Market Status](#6-market-status)
- Check if the stock market is currently open or closed using AlphaVantage’s **MARKET_STATUS** function.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/MarketStatus-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/MarketStatus-StockViewer-v2.png)

### 7. [Forex Exchange Rate](#7-forex-exchange-rate)
- Convert between two currencies using services from both the **Polygon.io** and **AlphaVantage** APIs.

[<img src="https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/Forex-StockViewer-v2.png" width="400">](https://github.com/Ebullioscopic/StockViewer/blob/main/Screenshots/v2/Forex-StockViewer-v2.png)


## Installation

### Steps to Set Up:

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/StockViewer.git
   cd StockViewer
   ```

2. Open the project in Xcode:

   ```bash
   open StockViewer.xcodeproj
   ```

3. Install dependencies via **Swift Package Manager** (SPM), which will automatically resolve and install upon opening the project.

### Setting Up API Keys

To use this app, you must configure API keys for both **AlphaVantage** and **Polygon.io** APIs.

1. Create an `APIKeys.plist` file in your project folder.
2. Add the following content to `APIKeys.plist`:

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

3. Replace the placeholder text with your actual API keys from:
   - [AlphaVantage](https://www.alphavantage.co/support/#api-key)
   - [Polygon.io](https://polygon.io/)

### Adding `APIKeys.plist` to Xcode

1. In the **Project Navigator**, right-click on the `Resources` folder (or create one if it doesn’t exist).
2. Select **Add Files to "StockViewer"** and add the newly created `APIKeys.plist`.
3. Ensure that the plist file is included in the correct target (`StockViewer`).

## Running the Application

To run the app:

1. Select a target device or simulator in Xcode.
2. Build and run the project using `Cmd + R` or click the **Play** button.

## Usage

### [Forex Conversion](#7-forex-exchange-rate)
- Select two currencies and input an amount to convert between them.
- The app supports conversion via both Polygon.io and AlphaVantage APIs, with fallback mechanisms in place.

### [Stock Sentiment](#1-stock-news-sentiment)
- Check the latest sentiment analysis for stocks by navigating to the **News Sentiment** section.
- Currently, it displays sentiment for **Apple Inc. (AAPL)**, but this can be adjusted for other stock tickers.

### [Top-Traded Stocks](#2-top-traded-stocks)
- View daily top-gaining and top-losing stocks using the **TOP_GAINERS_LOSERS** function from AlphaVantage.

### [Previous Close Data](#3-previous-close-data)
- Enter a stock symbol to fetch the previous closing price from **Polygon.io**.

### [Search Stock Symbol](#5-search-stock-symbol)
- Use keywords to search for stock symbols via the **SYMBOL_SEARCH** function of AlphaVantage.

### [Market Status](#6-market-status)
- Check whether the market is open or closed via AlphaVantage's **MARKET_STATUS** function.

## Project Structure

- **View Layer**:
  - `ForexView.swift`: Handles the UI for forex exchange rate conversions.
  - `StockDetailView.swift`: Displays detailed stock information.
  - `TopTradedView.swift`: Shows top gainers and losers.

- **ViewModel Layer**:
  - `ForexViewModel.swift`: Manages the logic for forex conversions.
  - `StockViewModel.swift`: Fetches and handles stock data, top-traded stocks, and ticker details.

- **Service Layer**:
  - `StockService.swift`: Contains methods for fetching data from AlphaVantage

 and Polygon.io APIs.

## API Services

The app relies on two APIs for stock market and financial data:

1. **AlphaVantage API**: Provides forex data, news sentiment, top-traded stocks, stock symbol search, and market status.
2. **Polygon.io API**: Supplies detailed stock data and previous closing prices.

## Example API Requests

### AlphaVantage Forex Exchange Request:
```
https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=USD&to_currency=EUR&apikey=YOUR_API_KEY
```

### AlphaVantage Stock News Sentiment Request:
```
https://www.alphavantage.co/query?function=NEWS_SENTIMENT&tickers=AAPL&apikey=YOUR_API_KEY
```

### Polygon.io Previous Close Data Request:
```
https://api.polygon.io/v2/aggs/ticker/AAPL/prev?adjusted=true&apiKey=YOUR_API_KEY
```

## Troubleshooting

### Common Issues

1. **Invalid API Key**: Double-check that your API keys are correctly added to the `APIKeys.plist` file.
2. **Network Errors**: Ensure your device is connected to the internet and that the API services are not down.
3. **Invalid URL**: Ensure that the currency codes or stock symbols in your requests are valid.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributors

- [Ebullioscopic](https://github.com/Ebullioscopic)