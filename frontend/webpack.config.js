const Encore = require('@symfony/webpack-encore');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const fs = require('fs');
const path = require('path');

Encore
    .setOutputPath('public/build/')
    .setPublicPath('/build')

    // JavaScript and CoffeeScript entries
    .addEntry('user', './assets/js/components/header/user.coffee')
    .addEntry('app', './assets/js/app.coffee') // Updated to app.coffee
    .addEntry('ticker', './assets/js/components/ticker.coffee')
    .addEntry('header', './assets/js/components/header.coffee')
    .addEntry('nimbus_popup', './assets/js/components/nimbus_popup.coffee')
    .addEntry('newsletter', './assets/js/components/footer/newsletter.coffee')
    .addEntry('marketCharts', './assets/js/pages/landing/marketCharts.coffee')
    .addEntry('landing', './assets/js/components/landing/landing.coffee')
    .addEntry('feed', './assets/js/components/feed/feed.coffee')
    .addEntry('postPopup', './assets/js/components/postPopup/postPopup.coffee')
    .addEntry('bulletinboard_new', './assets/js/components/bulletinboard/bulletinboard_new.coffee')
    
    // CSS entry
    .addStyleEntry('base', './assets/css/base.css')
   
    // Encore settings
    .enableSingleRuntimeChunk()
    .cleanupOutputBeforeBuild()
    .enableBuildNotifications()
    .enableSourceMaps(!Encore.isProduction())
    .enableVersioning(Encore.isProduction())
   
    // Babel configuration for modern JavaScript 
    .configureBabelPresetEnv((config) => {
        config.useBuiltIns = 'usage';
        config.corejs = '3.23';
    })
    
    // Enable SCSS support
    .enableSassLoader()
    
    // Enable PostCSS and Tailwind CSS
    .enablePostCssLoader((options) => {
        options.postcssOptions = {
            plugins: [
                require('tailwindcss'),
                require('autoprefixer'),
            ],
        };
    })
    
    // Enable CoffeeScript support
    .addLoader({
        test: /\.coffee$/,
        use: ['coffee-loader']
    })
    
    // Optimize for production
    .configureTerserPlugin((options) => {
        options.terserOptions = {
            compress: {
                drop_console: Encore.isProduction(), // Remove console.logs in production
            },
        };
    })
    
    // Add aliases for easier imports
    .addAliases({
        '@js': path.resolve(__dirname, 'assets/js'),
        '@css': path.resolve(__dirname, 'assets/css'),
    });

    // Add CopyWebpackPlugin for images, videos, and other static assets
const patterns = [];
if (fs.existsSync('assets/images')) {
    patterns.push({ from: 'assets/images', to: 'images', globOptions: { dot: true, ignore: ['**/*.DS_Store'] } });
}
if (fs.existsSync('assets/videos')) {
    patterns.push({ from: 'assets/videos', to: 'videos', globOptions: { dot: true, ignore: ['**/*.DS_Store'] } });
}

if (patterns.length > 0) {
    Encore.addPlugin(new CopyWebpackPlugin({
        patterns: patterns,
    }));
}

module.exports = Encore.getWebpackConfig();
