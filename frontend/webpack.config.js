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
    .addEntry('bulletinboard', './assets/js/components/bulletinboard/bulletinboard.coffee')
    .addEntry('pages/about/team', './assets/js/pages/about/team.coffee')
    .addEntry('aviyon_notes', './Aviyon-Notes/assets/js/aviyon_notes.coffee')
    .addEntry('messages_chat', './assets/js/dashboard/components/messages/chat.js.coffee')
    .addEntry('messages_conversation', './assets/js/dashboard/components/messages/conversation.js.coffee')
    .addEntry('messages_extras', './assets/js/dashboard/components/messages/extras.js.coffee')
    // Careers components
    .addEntry('careers/job_filters', './assets/js/components/careers/job_filters.coffee')
    .addEntry('careers/ai_recommendations', './assets/js/components/careers/ai_recommendations.coffee')
    .addEntry('careers/modal_handler', './assets/js/components/careers/modal_handler.coffee')
    .addEntry('careers/virtual_tour', './assets/js/components/careers/virtual_tour.js.coffee')
    .addEntry('careers/live_chat', './assets/js/components/careers/live_chat.coffee')
    .addEntry('careers/application_portal', './assets/js/components/careers/application_portal.js.coffee')
    // Investing entry
    .addEntry('investing', './assets/js/components/investing/main.coffee')
    // Domain entry
    .addEntry('domain/main', './assets/js/components/domain/main.coffee')
    // Hosting entry
    .addEntry('hosting/main', './assets/js/components/hosting/main.coffee')
    // Articles entry
    .addEntry('article', './assets/js/components/articles/article.coffee')

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

    // Handle models as assets
    .addRule({
        test: /\.(gltf|glb)$/,
        type: 'asset/resource',
        generator: {
            filename: 'models/[name][ext][query]'
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
    })

    // Copy static assets to the build directory
    .copyFiles([
        {
            from: './assets/images',
            to: 'images/[path][name].[ext]',
            pattern: /\.(jpg|jpeg|png|gif|svg)$/
        },
        {
            from: './assets/models',
            to: 'models/[path][name].[ext]',
            pattern: /\.(gltf|glb)$/
        },
        {
            from: './assets/videos',
            to: 'videos/[path][name].[ext]',
            pattern: /\.(mp4|webm|ogg)$/
        }
    ])

    // Add external libraries to avoid bundling
    .addExternals({
        'three': 'THREE',
        'chart.js': 'Chart',
        'chartjs-chart-financial': 'chartjsChartFinancial'
    });

// Support CoffeeScript resolution
const webpackConfig = Encore.getWebpackConfig();
console.log('Entry points:', webpackConfig.entry); // Debug entry points
webpackConfig.resolve = webpackConfig.resolve || {};
webpackConfig.resolve.extensions = webpackConfig.resolve.extensions || [];
webpackConfig.resolve.extensions.push('.coffee');

module.exports = webpackConfig;
