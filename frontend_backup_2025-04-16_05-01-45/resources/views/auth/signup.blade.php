<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup | Aviyon</title>
    @vite(['resources/css/app.css', 'resources/js/app.js'])
</head>
<body class="bg-cyber-dark font-sans">
    <div class="container mx-auto p-6 max-w-md">
        <h2 class="text-3xl font-mono text-cyber-neon mb-4">Signup</h2>
        <form action="/api/auth/signup" method="POST">
            @csrf
            <div class="mb-4">
                <input type="text" name="username" placeholder="Username" class="w-full p-2 bg-cyber-dark border border-cyber-purple text-cyber-white rounded">
            </div>
            <div class="mb-4">
                <input type="email" name="email" placeholder="Email" class="w-full p-2 bg-cyber-dark border border-cyber-purple text-cyber-white rounded">
            </div>
            <div class="mb-4">
                <input type="password" name="password" placeholder="Password" class="w-full p-2 bg-cyber-dark border border-cyber-purple text-cyber-white rounded">
            </div>
            <button type="submit" class="button w-full">Signup</button>
        </form>
        <p class="mt-4 text-cyber-white">Already have an account? <a href="/login" class="text-cyber-neon">Login</a></p>
    </div>
</body>
</html>
