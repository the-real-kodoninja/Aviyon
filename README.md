# Aviyon: A Cyberpunk Coding Platform

Welcome to Aviyon, a cyberpunk coding platform where neon pulses through every line of code. Built with a Laravel frontend and a Kotlin/Spring Boot backend, Aviyon thrusts developers into a futuristic world of glowing interfaces, immersive challenges, and underground collaboration. Whether you’re a solo hacker crafting apps in a virtual city or a crew tackling missions under a digital moon, Aviyon is your portal to a dystopian coding revolution.

Table of Contents

Project Vision
Aviyon isn’t just a tool—it’s a defiance of dull coding spaces. Inspired by cyberpunk’s neon-drenched chaos—holographic billboards, rain-slicked streets, and synthwave hums—Aviyon redefines development as an adventure. We’re building a platform where coding feels like infiltrating a megacorp’s mainframe. Our vision includes:

Immersive Learning: Tutorials styled as high-stakes "missions" in a cyberpunk saga.
Creative Forge: A sandbox for building projects with a neon aesthetic.
Neon Network: A community hub for coders to connect in a digital underworld.
Aviyon is for those who code with rebellion in their veins, where every function is a spark in a futuristic night.

Features
Neon Interface: Dark, cyberpunk-themed UI with purple, cyan, and white hues, powered by Tailwind CSS.
Secure Auth: JWT-based login and signup via Spring Boot.
Coding Missions: Interactive challenges framed as cyberpunk jobs (coming soon).
Code Editor: Planned in-browser editor with syntax highlighting (Monaco or CodeMirror).
Collaboration: Real-time multiplayer coding (future feature).
Responsive Design: Seamless across holo-screens, tablets, and mobile implants.
API-Driven: RESTful endpoints for extensibility and integrations.
Architecture Overview
Aviyon is a full-stack app split into a frontend and backend, linked by REST APIs. Here’s the layout:

Frontend
Framework: Laravel 12.x for robust PHP routing and templating.
Styling: Tailwind CSS for utility-first, neon designs.
Assets: Vite for fast JavaScript and CSS bundling.
Templates: Blade for dynamic, server-side views.
Structure:

frontend/
├── app/                    # Laravel core logic
├── resources/
│   ├── css/              # Tailwind CSS (app.css)
│   ├── js/               # JavaScript (app.js)
│   ├── views/            # Blade templates (welcome.blade.php, auth/login.blade.php)
├── routes/                # Routes (web.php)
├── public/                # Static assets and Vite output (build/)
Backend
Framework: Spring Boot 3.2.0 with Kotlin for scalable, type-safe APIs.
Security: Spring Security with JWT for authentication.
Modules:
auth: Handles login/signup.
logging: Centralized logging (in progress).
config: Shared configs (in progress).
Structure:

core/
├── auth/
│   ├── src/main/kotlin/com/aviyon/auth/  # Kotlin source (AuthApplication.kt)
│   ├── pom.xml                           # Maven build
├── logging/
├── config/
Flow: Frontend sends HTTP requests (e.g., POST /api/auth/login) to the backend, which responds with JSON.
Technology Stack
Component	Technology	Version
Frontend	Laravel	12.8.1
PHP	8.3.x
Tailwind CSS	Latest
Vite	6.2.6
Backend	Spring Boot	3.2.0
Kotlin	1.9.0
Maven	3.9.9
Environment	Codeanywhere	Latest
JDK	21.0.4
Node.js	Latest
Prerequisites
To jack into Aviyon, ensure you have:

Codeanywhere account for cloud development.
Node.js and npm for frontend assets.
PHP and Composer for Laravel.
JDK 21 for Kotlin/Spring Boot.
Maven for backend builds.
Git for version control.
Terminal access in Codeanywhere.
Setup Instructions
Here’s how to boot up Aviyon in Codeanywhere’s digital sprawl.

Codeanywhere Environment
Create a workspace in Codeanywhere with an Ubuntu stack. Ensure Node.js, PHP, JDK 21, and Maven are installed.
Clone the repo: git clone https://github.com/your-username/aviyon.git /workspaces/Aviyon and navigate with cd /workspaces/Aviyon.
Check the domain: echo $DAYTONA_WS_DOMAIN. Expect app.codeanywhere.com.
Frontend Setup
Go to the frontend: cd /workspaces/Aviyon/frontend.
Install PHP dependencies: composer install.
Set up .env: Copy with cp .env.example .env, then edit:

APP_URL=http://127.0.0.1:8001
APP_DEBUG=true
LOG_LEVEL=debug
Install Node dependencies: npm install -D tailwindcss@latest @tailwindcss/postcss autoprefixer@latest and npm install.
Build assets: npm run build.
Generate app key: php artisan key:generate.
Backend Setup
Navigate to backend: cd /workspaces/Aviyon/core/auth.
Verify pom.xml includes:
xml
```bash
<project>
    <modelVersion>4.0.0</modelVersion>
    <groupId>com.aviyon</groupId>
    <artifactId>auth</artifactId>
    <version>1.0-SNAPSHOT</version>
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>3.2.0</version>
    </parent>
    <properties>
        <java.version>17</java.version>
        <kotlin.version>1.9.0</kotlin.version>
    </properties>
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-security</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.jetbrains.kotlin</groupId>
            <artifactId>kotlin-stdlib</artifactId>
            <version>${kotlin.version}</version>
        </dependency>
        <dependency>
            <groupId>io.jsonwebtoken</groupId>
            <artifactId>jjwt</artifactId>
            <version>0.9.1</version>
        </dependency>
    </dependencies>
    <build>
        <sourceDirectory>${project.basedir}/src/main/kotlin</sourceDirectory>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
                <configuration>
                    <mainClass>com.aviyon.auth.AuthApplication</mainClass>
                </configuration>
            </plugin>
            <plugin>
                <groupId>org.jetbrains.kotlin</groupId>
                <artifactId>kotlin-maven-plugin</artifactId>
                <version>${kotlin.version}</version>
                <executions>
                    <execution>
                        <id>compile</id>
                        <phase>compile</phase>
                        <goals>
                            <goal>compile</goal>
                        </goals>
                    </execution>
                </executions>
                <configuration>
                    <compilerPlugins>
                        <plugin>spring</plugin>
                    </compilerPlugins>
                </configuration>
                <dependencies>
                    <dependency>
                        <groupId>org.jetbrains.kotlin</groupId>
                        <artifactId>kotlin-maven-allopen</artifactId>
                        <version>${kotlin.version}</version>
                    </dependency>
                </dependencies>
            </plugin>
        </plugins>
    </build>
</project>
```
Build: mvn clean install.
Check AuthApplication.kt:
kotlin

package com.aviyon.auth

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class AuthApplication

```bash
fun main(args: Array<String>) {
    runApplication<AuthApplication>(*args)
}
```

Running the Application
Running the Frontend
Start Laravel: cd /workspaces/Aviyon/frontend and php artisan serve --port=8001.
Access at http://127.0.0.1:8001 or https://<workspace>.app.codeanywhere.com.
Run Vite: npm run dev. Visit http://localhost:5173 (or 5174 if needed).
Expect a dark welcome page with neon-styled text.
Running the Backend
Start Spring Boot: cd /workspaces/Aviyon/core/auth and mvn spring-boot:run -Dspring-boot.run.main=com.aviyon.auth.AuthApplication. Or use java -jar target/auth-1.0-SNAPSHOT.jar.
Verify port: netstat -tuln | grep 8080.
Test API: curl -X POST http://localhost:8080/api/auth/login -H "Content-Type: application/json" -d '{"username":"test","password":"pass"}'.
Troubleshooting
Frontend Issues
404 Error:
Cause: Routes not loaded.
Fix: Ensure app/Providers/RouteServiceProvider.php has:
php

```bash
$this->routes(function () {
    Route::middleware('web')->group(base_path('routes/web.php'));
});
```

Clear caches: php artisan cache:clear, php artisan view:clear, php artisan route:clear, php artisan config:clear. Check: php artisan route:list.
Tailwind Failure:
Cause: Scanner missing classes.
Fix: Update tailwind.config.js:
javascript

content: ['./resources/views/**/*.blade.php', './resources/js/**/*.js']
Rebuild: npm run build. Verify CSS size: ls -la public/build/assets/app-*.css (>10 kB).
Port Conflict:
Fix: Check: lsof -i :8001. Kill: kill -9 <PID>.
Backend Issues
No Main Method:
Cause: Kotlin compilation error.
Fix: Confirm AuthApplication.kt has fun main. Add spring plugin to pom.xml. Rebuild: mvn clean install.
8080 Refused:
Cause: Backend not running.
Fix: Check logs. Verify port: netstat -tuln | grep 8080.
Codeanywhere:
Use https://<workspace>.app.codeanywhere.com. Check JDK: java -version (expect 21.0.4).
Contributing
Ready to hack the neon grid? Contribute with:

Fork: git clone https://github.com/your-username/aviyon.git.
Branch: git checkout -b feature/your-feature.
Commit: git commit -m "Add neon feature".
Push and PR: git push origin feature/your-feature.
Follow Laravel/Spring Boot styles and use Prettier.
Roadmap
 Laravel/Tailwind frontend.
 Kotlin/Spring Boot auth.
 Narrative coding missions.
 In-browser editor.
 Multiplayer coding.
 Achievements and ranks.
 Mobile app.
License
Aviyon is under the . Modify and share, but keep the cyberpunk vibe alive.

Contact
Got a spark? Reach out:

GitHub: Aviyon Issues
Discord: Neon server (coming soon)
In Aviyon, code is rebellion. Light up the dark.
