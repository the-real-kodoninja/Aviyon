<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\HttpClient\HttpClient;

class TickerController extends AbstractController
{
    #[Route('/api/ticker', name: 'api_ticker', methods: ['GET'])]
    public function getTickerData(): JsonResponse
    {
        // Sample data (fallback)
        $symbols = [
            ['symbol' => 'AAPL', 'type' => 'stock', 'price' => 175.32, 'change' => 2.3],
            ['symbol' => 'MSFT', 'type' => 'stock', 'price' => 420.45, 'change' => -0.5],
            ['symbol' => 'GOOGL', 'type' => 'stock', 'price' => 150.25, 'change' => 1.8],
            ['symbol' => 'AMZN', 'type' => 'stock', 'price' => 185.67, 'change' => -1.2],
            ['symbol' => 'TSLA', 'type' => 'stock', 'price' => 265.89, 'change' => 3.5],
            ['symbol' => 'NVDA', 'type' => 'stock', 'price' => 870.12, 'change' => 2.1],
            ['symbol' => 'META', 'type' => 'stock', 'price' => 495.34, 'change' => -0.9],
            ['symbol' => 'JPM', 'type' => 'stock', 'price' => 195.78, 'change' => 0.7],
            ['symbol' => 'V', 'type' => 'stock', 'price' => 275.56, 'change' => 1.3],
            ['symbol' => 'WMT', 'type' => 'stock', 'price' => 60.23, 'change' => -0.3],
            ['symbol' => 'DIS', 'type' => 'stock', 'price' => 115.89, 'change' => 0.9],
            ['symbol' => 'NFLX', 'type' => 'stock', 'price' => 625.45, 'change' => -1.5],
            ['symbol' => 'AMD', 'type' => 'stock', 'price' => 165.78, 'change' => 2.7],
            ['symbol' => 'INTC', 'type' => 'stock', 'price' => 40.12, 'change' => -0.8],
            ['symbol' => 'CSCO', 'type' => 'stock', 'price' => 50.34, 'change' => 0.4],
            ['symbol' => 'BTC', 'type' => 'crypto', 'price' => 62450.00, 'change' => 3.1],
            ['symbol' => 'ETH', 'type' => 'crypto', 'price' => 3250.75, 'change' => -0.6],
            ['symbol' => 'BNB', 'type' => 'crypto', 'price' => 580.23, 'change' => 1.9],
            ['symbol' => 'ADA', 'type' => 'crypto', 'price' => 0.58, 'change' => -2.1],
            ['symbol' => 'XRP', 'type' => 'crypto', 'price' => 0.62, 'change' => 0.8],
            ['symbol' => 'SOL', 'type' => 'crypto', 'price' => 175.45, 'change' => 2.3],
            ['symbol' => 'DOGE', 'type' => 'crypto', 'price' => 0.18, 'change' => -1.7],
            ['symbol' => 'SPY', 'type' => 'index', 'price' => 510.25, 'change' => -1.2],
            ['symbol' => 'DIA', 'type' => 'index', 'price' => 385.67, 'change' => 0.5],
            ['symbol' => 'QQQ', 'type' => 'index', 'price' => 435.89, 'change' => -0.9],
            ['symbol' => 'IWM', 'type' => 'index', 'price' => 205.34, 'change' => 1.1],
            ['symbol' => 'GOLD', 'type' => 'commodity', 'price' => 2350.60, 'change' => 0.9],
            ['symbol' => 'OIL', 'type' => 'commodity', 'price' => 85.23, 'change' => -0.4],
            ['symbol' => 'SILVER', 'type' => 'commodity', 'price' => 27.45, 'change' => 1.2],
            ['symbol' => 'CORN', 'type' => 'commodity', 'price' => 450.78, 'change' => -0.7],
        ];

        // Simulate API call (to be replaced with real API)
        try {
            $client = HttpClient::create();
            $cryptoResponse = $client->request('GET', 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&ids=bitcoin,ethereum,binancecoin,cardano,ripple,solana,dogecoin');
            $cryptoData = $cryptoResponse->toArray();

            foreach ($cryptoData as $coin) {
                $symbol = strtoupper($coin['symbol']);
                foreach ($symbols as &$item) {
                    if ($item['symbol'] === $symbol && $item['type'] === 'crypto') {
                        $item['price'] = $coin['current_price'];
                        $item['change'] = $coin['price_change_percentage_24h'];
                    }
                }
            }

            // Alpha Vantage API (requires API key)
            // Uncomment and add your API key to fetch stock data
            /*
            $stockResponse = $client->request('GET', 'https://www.alphavantage.co/query?function=GLOBAL_QUOTE&symbol=AAPL&apikey=YOUR_API_KEY');
            $stockData = $stockResponse->toArray();
            if (isset($stockData['Global Quote'])) {
                foreach ($symbols as &$item) {
                    if ($item['symbol'] === 'AAPL' && $item['type'] === 'stock') {
                        $item['price'] = $stockData['Global Quote']['05. price'];
                        $item['change'] = $stockData['Global Quote']['10. change percent'];
                    }
                }
            }
            */
        } catch (\Exception $e) {
            // Fallback to sample data if API fails
            // Log error in production
        }

        return new JsonResponse($symbols);
    }
}
