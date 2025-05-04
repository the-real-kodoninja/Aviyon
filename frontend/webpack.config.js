const Encore = require('@symfony/webpack-encore');
const fs = require('fs');
const path = require('path');

Encore
    .setOutputPath('public/build/')
    .setPublicPath('/build')

    // JavaScript and CoffeeScript entries
    .addEntry('user', './assets/js/components/header/user.coffee')
    .addEntry('app', './assets/js/app.coffee')
    .addEntry('ticker', './assets/js/components/ticker.coffee')
    .addEntry('header', './assets/js/components/header.coffee')
    .addEntry('nimbus_popup', './assets/js/components/nimbus_popup.coffee')
    .addEntry('newsletter', './assets/js/components/footer/newsletter.coffee')
    .addEntry('marketCharts', './assets/js/pages/landing/marketCharts.coffee')
    .addEntry('landing', './assets/js/components/landing/landing.coffee')
    .addEntry('feed', './assets/js/components/feed/feed.coffee')
    .addEntry('postPopup', './assets/js/components/postPopup/postPopup.coffee')
    .addEntry('bulletinboard_new', './assets/js/components/bulletinboard/bulletinboard_new.coffee')
    .addEntry('pages/about/team', './assets/js/pages/about/team.coffee')
 
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
    
    // Handle images as assets
    .addRule({
        test: /\.(jpg|jpeg|png|gif|svg)$/,
        type: 'asset/resource',
        generator: {
            filename: 'images/[name][ext][query]'
        }
    })
    
    // Handle videos as assets
    .addRule({
        test: /\.(mp4|webm|ogg)$/,
        type: 'asset/resource',
        generator: {
            filename: 'videos/[name][ext][query]'
        }
    })
    
    // Optimize for production
    .configureTerserPlugin((options) => {
        options.terserOptions = {
            compress: {
                drop_console: Encore.isProduction(),
            },
        };
    })
    
    // Add aliases for easier imports
    .addAliases({
        '@js': path.resolve(__dirname, 'assets/js'),
        '@css': path.resolve(__dirname, 'assets/css'),
        '@images': path.resolve(__dirname, 'assets/images'),
    });

module.exports = Encore.getWebpackConfig();
