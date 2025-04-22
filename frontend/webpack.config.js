const Encore = require('@symfony/webpack-encore');
const CopyWebpackPlugin = require('copy-webpack-plugin');
const fs = require('fs');
const path = require('path');

Encore
    .setOutputPath('public/build/')
    .setPublicPath('/build')
    .addEntry('app', './assets/js/app.js')
    .addStyleEntry('base', './assets/css/base.css')
    .enableSingleRuntimeChunk()
    .cleanupOutputBeforeBuild()
    .enableBuildNotifications()
    .enableSourceMaps(!Encore.isProduction())
    .enableVersioning(Encore.isProduction())
    .configureBabelPresetEnv((config) => {
        config.useBuiltIns = 'usage';
        config.corejs = '3.23';
    });

// Add CopyWebpackPlugin only if assets/images/ contains files
const imagesPath = path.resolve(__dirname, 'assets/images');
if (fs.existsSync(imagesPath) && fs.readdirSync(imagesPath).length > 0) {
    Encore.addPlugin(new CopyWebpackPlugin({
        patterns: [
            { from: './assets/images', to: 'images/[path][name].[ext]' },
        ],
    }));
}

module.exports = Encore.getWebpackConfig();
