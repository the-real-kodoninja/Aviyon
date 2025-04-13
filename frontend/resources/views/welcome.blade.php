<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aviyon - Cyberpunk Coding Platform</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-cyber-dark font-sans">
    <nav class="p-6 border-b border-cyber-purple">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-mono text-cyber-neon">Aviyon</h1>
            <ul class="flex space-x-6">
                <li><a href="/ide" class="nav-link">IDE</a></li>
                <li><a href="/deploy" class="nav-link">Deploy</a></li>
                <li><a href="/host" class="nav-link">Host</a></li>
                <li><a href="/login" class="nav-link">Login</a></li>
                <li><a href="/signup" class="button">Signup</a></li>
            </ul>
        </div>
    </nav>
    <div class="container mx-auto p-6 text-center">
        <h2 class="text-5xl font-mono text-cyber-cyan mb-4">Code the Future</h2>
        <p class="text-xl text-cyber-white mb-6">Aviyon: Minimal, action-packed platform for coding, deploying, and hosting with a cyberpunk edge.</p>
        <a href="/signup" class="button text-lg">Get Started Free</a>
    </div>
</body>
</html>
