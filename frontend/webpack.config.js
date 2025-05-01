const Encore = require('@symfony/webpack-encore');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const fs = require('fs');
const path = require('path');

Encore
    .setOutputPath('public/build/')
    .setPublicPath('/build')
    .addEntry('app', './assets/js/app.js')
    .addEntry('ticker', './assets/js/components/ticker.coffee')
    .addEntry('nimbus_popup', './assets/js/components/nimbus_popup.coffee')
    .addEntry('newsletter', './assets/js/components/footer/newsletter.coffee') // Add newsletter entry
    .addStyleEntry('base', './assets/css/base.css')
    .enableSingleRuntimeChunk()
    .cleanupOutputBeforeBuild()
    .enableBuildNotifications()
    .enableSourceMaps(!Encore.isProduction())
    .enableVersioning(Encore.isProduction())
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

// Add CopyWebpackPlugin for images and other static assets
const imagesPath = path.resolve(__dirname, 'assets/images');
if (fs.existsSync(imagesPath) && fs.readdirSync(imagesPath).length > 0) {
    Encore.addPlugin(new CopyWebpackPlugin({
        patterns: [
            { from: './assets/images', to: 'images/[path][name].[ext]' },
        ],
    }));
}

module.exports = Encore.getWebpackConfig();
