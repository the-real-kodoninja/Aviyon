fetch('https://api.coingecko.com/api/v3/simple/price?ids=bitcoin,ethereum,internet-computer&vs_currencies=usd')
    .then(response => response.json())
    .then(data => {
        const tickerItems = document.getElementById('ticker-items');
        Object.keys(data).forEach(coin => {
            const div = document.createElement('div');
            div.className = 'ticker-item mx-4';
            div.textContent = `${coin.toUpperCase()}: $${data[coin].usd}`;
            tickerItems.appendChild(div);
        });
    });
