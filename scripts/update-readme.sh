#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Ensure output directory exists for snake and other assets
mkdir -p assets
mkdir -p output

# --- Configuration & Secrets ---
GH_USERNAME="Thugger069" # <<-- UPDATE THIS IF YOUR GITHUB USERNAME IS DIFFERENT

# For Spotify (using a public service for ease, replace if you build custom API integration)
# Note: spotify-github-profile.vercel.app is maintained by another developer.
# If you prefer full control, you'd need to set up Spotify API credentials
# (SPOTIFY_CLIENT_ID, SPOTIFY_CLIENT_SECRET, SPOTIFY_REFRESH_TOKEN) as GitHub Secrets
# and implement the OAuth flow and API calls directly in Python/Node.js.
# For now, this badge only works if the service can find a username matching your GH_USERNAME.

# For Dev.to (replace with your Dev.to username)
DEVTO_USERNAME="d3_glitch" # <<-- CRITICAL: UPDATE THIS WITH YOUR DEV.TO USERNAME, OR LEAVE EMPTY TO SKIP

# --- Dynamic Variables & Placeholders (Customize these) ---
CURRENT_DATE=$(date -u +"%Y-%m-%d %H:%M:%S")

# Time-based greeting (using UTC for consistency in GitHub Actions)
HOUR=$(date +"%H" -u)
GREETING=""
if (( HOUR >= 5 && HOUR < 12 )); then
  GREETING="Good Morning, Coder! ☀️"
elif (( HOUR >= 12 && HOUR < 18 )); then
  GREETING="Good Afternoon, Developer! ☕"
else
  GREETING="Good Evening, Night Owl! 🌙"
fi

# Example of dynamic status messages - will rotate randomly
STATUS_MESSAGES=(
  "Refining CI/CD pipelines for a new microservice"
  "Debugging a tricky C++ memory leak on a personal project"
  "Exploring the latest features in FastAPI and Python 3.12"
  "Contributing to an open-source project focused on web scraping"
  "Learning advanced JavaScript patterns for frontend optimization"
  "Optimizing database queries for a Flask application"
  "Setting up a new Kubernetes cluster in a test environment"
)
RANDOM_INDEX=$(( RANDOM % ${#STATUS_MESSAGES[@]} ))
DYNAMIC_STATUS_MESSAGE="${STATUS_MESSAGES[$RANDOM_INDEX]}"

STATUS_EMOJIS=( "🛠️" "🐛" "💡" "🤝" "📚" "⚙️" "☁️" )
DYNAMIC_STATUS_EMOJI="${STATUS_EMOJIS[$RANDOM_INDEX]}"

# About Me dynamic content
CURRENT_FOCUS="implementing event-driven architectures with RabbitMQ" # <<-- CUSTOMIZE THIS
LEARNING_PATH="Kubernetes for container orchestration and advanced Go concepts" # <<-- CUSTOMIZE THIS
FUN_FACT_ACTIVITY="hiking new trails and practicing amateur astrophotography 🌌" # <<-- CUSTOMIZE THIS

# Social Links
LINKEDIN_URL="https://www.linkedin.com/in/thugger069" # <<-- CRITICAL: UPDATE THIS
EMAIL_ADDRESS="thugger069@gmail.com" # <<-- CRITICAL: UPDATE THIS
TWITTER_HANDLE="d3_glitch" # <<-- CRITICAL: UPDATE THIS


# --- FUNCTIONS FOR DYNAMIC CONTENT ---

# Function to get Spotify "Now Playing" (using a public service for ease)
get_spotify_status() {
    # This badge relies on https://spotify-github-profile.vercel.app/
    # If it doesn't work or you want more control, you'll need to set up
    # Spotify API keys as GitHub Secrets and write a script to fetch and format.
    if [ -n "$GH_USERNAME" ]; then
        echo "![Spotify](https://spotify-github-profile.vercel.app/api/spotify?username=${GH_USERNAME}&theme=dark)"
    else
        echo ""
    fi
}
SPOTIFY_BADGE=$(get_spotify_status)


# Function to get recent Dev.to articles
get_devto_articles() {
    if [ -z "$DEVTO_USERNAME" ] || [ "$DEVTO_USERNAME" == "YOUR_DEVTO_USERNAME" ]; then
        echo "<!-- Dev.to username not configured or is placeholder. Skipping articles. -->"
        return
    fi

    # Fetch articles and handle potential errors
    ARTICLES=$(curl -s "https://dev.to/api/articles?username=${DEVTO_USERNAME}&per_page=3")
    if [ $? -ne 0 ]; then
        echo "<!-- Failed to fetch Dev.to articles (curl error). -->"
        return
    fi
    
    # Check if the response is valid JSON and has articles
    if ! echo "$ARTICLES" | jq -e '.[0]' > /dev/null; then
        echo "<!-- Failed to parse Dev.to articles or no articles found. -->"
        return
    fi

    echo "<h3>📰 Latest Articles on Dev.to</h3>"
    echo "<ul>"
    echo "$ARTICLES" | jq -r '.[] | "<li><a href=\"\(.url)\" target=\"_blank\">\(.title)</a></li>"'
    echo "</ul>"
}
DEVTO_SECTION=$(get_devto_articles)


# Function to get a random featured project
get_featured_project() {
    # CRITICAL: CUSTOMIZE THESE PROJECTS!
    # Format: "REPO_NAME|DESCRIPTION|LANGUAGE_BADGE_URL|LINK"
    # The LANGUAGE_BADGE_URL can be a standard shields.io badge.
    PROJECTS=(
        "MyAwesomeCLI|A powerful command-line interface for daily tasks.|![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white)|https://github.com/${GH_USERNAME}/MyAwesomeCLI"
        "WebScraperFlask|A Flask app to scrape product data from e-commerce sites.|![Python](https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white) ![Flask](https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white)|https://github.com/${GH_USERNAME}/WebScraperFlask"
        "CppGameEngine|An experimental 2D game engine built from scratch for learning purposes.|![C++](https://img.shields.io/badge/C%2B%2B-00599C?style=for-the-badge&logo=c%2B%2B&logoColor=white)|https://github.com/${GH_USERNAME}/CppGameEngine"
        "PortfolioWebsite|My personal portfolio website built with Next.js and Tailwind CSS.|![Next.js](https://img.shields.io/badge/Next.js-black?style=for-the-badge&logo=next.js&logoColor=white) ![React](https://img.shields.io/badge/React-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB)|https://github.com/${GH_USERNAME}/PortfolioWebsite"
        "GoMicroservice|A lightweight microservice built with Go and Docker for scalable operations.|![Go](https://img.shields.io/badge/Go-00ADD8?style=for-the-badge&logo=go&logoColor=white)|https://github.com/${GH_USERNAME}/GoMicroservice"
    )

    if [ ${#PROJECTS[@]} -eq 0 ]; then
        echo "<!-- No featured projects defined. -->"
        return
    fi

    RANDOM_PROJECT_INDEX=$(( RANDOM % ${#PROJECTS[@]} ))
    SELECTED_PROJECT="${PROJECTS[$RANDOM_PROJECT_INDEX]}"

    # Use IFS to split the string into an array, then access elements
    IFS='|' read -r REPO_NAME DESCRIPTION LANGUAGE_BADGE_URL PROJECT_LINK <<< "$SELECTED_PROJECT"

    echo "<h2>✨ Featured Project</h2>"
    echo "<p align=\"center\">"
    echo "  <b><a href=\"${PROJECT_LINK}\" target=\"_blank\">${REPO_NAME}</a></b><br>"
    echo "  ${DESCRIPTION}<br>"
    echo "  ${LANGUAGE_BADGE_URL}"
    echo "</p>"
}
FEATURED_PROJECT_SECTION=$(get_featured_project)


# Function to get a random programming quote
get_random_quote() {
    # Using a simple API for programming quotes
    QUOTE_DATA=$(curl -s "https://programming-quotes-api.herokuapp.com/quotes/random")
    if [ $? -ne 0 ]; then
        echo "<!-- Failed to fetch random quote (curl error). -->"
        return
    fi
    
    if ! echo "$QUOTE_DATA" | jq -e '.' > /dev/null; then
        echo "<!-- Failed to parse random quote (invalid JSON). -->"
        return
    fi

    QUOTE=$(echo "$QUOTE_DATA" | jq -r '.quote')
    AUTHOR=$(echo "$QUOTE_DATA" | jq -r '.author')

    if [ -z "$QUOTE" ]; then
        echo "<!-- Failed to extract quote from JSON. -->"
        return
    fi

    echo "<h3>💡 Programming Wisdom</h3>"
    echo "<p align=\"center\">"
    echo "  <em>\"${QUOTE}\"</em><br>"
    echo "  <b>- ${AUTHOR}</b>"
    echo "</p>"
}
QUOTE_SECTION=$(get_random_quote)

# Conditional badge example: A "Learning Rust" badge that could appear if a flag is set
LEARNING_RUST_FLAG="false" # <<-- Set to "true" when actively learning Rust
RUST_BADGE_SECTION=""
if [ "$LEARNING_RUST_FLAG" == "true" ]; then
    RUST_BADGE_SECTION="<h3 align=\"center\">Currently Learning</h3><p align=\"center\"><img src=\"https://img.shields.io/badge/Rust-black?style=for-the-badge&logo=rust&logoColor=white\" alt=\"Rust\"></p>"
fi


# --- Generate the README Content ---
cat << EOF > README.md
<!-- HEADER START -->
<div align="center">
  <img src="https://github.com/${GH_USERNAME}/${GH_USERNAME}/blob/main/pfp.jpg?raw=true" alt="${GH_USERNAME}'s Profile Picture" width="150" height="150" style="border-radius:50%;">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=Greetings%2C+Fellow+Coder!;${GH_USERNAME}+Here!;Crafting+Digital+Experiences;Exploring+the+DevOps+Frontier;Building+with+Python%2C+JS%2C+C%2B%2B;Open+Source+Advocate;Always+Learning+%F0%9F%92%A1;Welcome+to+my+README!;Let's+Build+Something+Great!" alt="Typing SVG" />
  </a>
  <h2>${GREETING}</h2>
</div>
<!-- HEADER END -->

<!-- PROFILE VIEWS START -->
<div align="center">
  <a href="https://github.com/${GH_USERNAME}">
    <img src="https://komarev.com/ghpvc/?username=${GH_USERNAME}&color=blueviolet&style=flat-square&label=Profile%20Views" alt="Profile views"/>
  </a>
</div>
<!-- PROFILE VIEWS END -->

<hr/>

<!-- SPOTIFY NOW PLAYING START -->
<div align="center">
  ${SPOTIFY_BADGE}
</div>
<!-- SPOTIFY NOW PLAYING END -->

<hr/>

<!-- TERMINAL SIMULATION / DYNAMIC CONTENT START -->
<div align="center">
  <img src="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/main/assets/terminal_animation.gif" alt="Terminal Simulation" width="600" />
  <br/>
  <p>
    <code>✨ What's happening in my dev-world right now:</code><br>
    <code>[${DYNAMIC_STATUS_EMOJI}] ${DYNAMIC_STATUS_MESSAGE}</code>
  </p>
</div>
<!-- TERMINAL SIMULATION / DYNAMIC CONTENT END -->

<hr/>

## 🚀 About Me

I'm an aspiring developer with a strong passion for **backend systems**, **web technologies**, and **low-level programming with C++**. I thrive on challenging problems, transforming complex ideas into elegant, efficient, and scalable software solutions.

-   🔭 **Currently Deep Diving Into:** ${CURRENT_FOCUS}
-   🌱 **Eager to Learn More About:** ${LEARNING_PATH}
-   👯 **Open to Collaborating On:** Innovative open-source projects, especially those involving Python, JavaScript, or C++.
-   💬 **Ask Me About:** Software architecture, performance optimization, or getting started with automation.
-   ⚡ **Fun Fact:** When not coding, I'm often found ${FUN_FACT_ACTIVITY}.

<hr/>

<!-- FEATURED PROJECT START -->
<div align="center">
  ${FEATURED_PROJECT_SECTION}
</div>
<!-- FEATURED PROJECT END -->

<hr/>

<!-- DEV.TO ARTICLES START -->
<div align="center">
  ${DEVTO_SECTION}
</div>
<!-- DEV.TO ARTICLES END -->

<hr/>

<!-- PROGRAMMING WISDOM START -->
<div align="center">
  ${QUOTE_SECTION}
</div>
<!-- PROGRAMMING WISDOM END -->

<hr/>

## 🛠️ Tech Stack & Tools

My development arsenal includes:

${RUST_BADGE_SECTION} <!-- Conditional badge inserted here -->

<h3 align="center">Frontend & Web</h3>
<p align="center">
  <img src="https://img.shields.io/badge/JavaScript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black" alt="JavaScript"/>
  <img src="https://img.shields.io/badge/HTML5-E34F26?style=for-the-badge&logo=html5&logoColor=white" alt="HTML5"/>
  <img src="https://img.shields.io/badge/CSS3-1572B6?style=for-the-badge&logo=css3&logoColor=white" alt="CSS3"/>
  <img src="https://img.shields.io/badge/React-%2320232a.svg?style=for-the-badge&logo=react&logoColor=%2361DAFB" alt="React"/>
  <img src="https://img.shields.io/badge/Next.js-black?style=for-the-badge&logo=next.js&logoColor=white" alt="Next.js"/>
</p>

<h3 align="center">Backend & Core Languages</h3>
<p align="center">
  <img src="https://img.shields.io/badge/Python-3776AB?style=for-the-badge&logo=python&logoColor=white" alt="Python"/>
  <img src="https://img.shields.io/badge/C%2B%2B-00599C?style=for-the-badge&logo=c%2B%2B&logoColor=white" alt="C++"/>
  <img src="https://img.shields.io/badge/Node.js-6DA55F?style=for-the-badge&logo=node.js&logoColor=white" alt="Node.js"/>
  <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white" alt="Flask"/>
  <img src="https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white" alt="FastAPI"/>
</p>

<h3 align="center">DevOps & Tools</h3>
<p align="center">
  <img src="https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white" alt="Git"/>
  <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
  <img src="https://img.shields.io/badge/Linux-FCC624?style=for-the-badge&logo=linux&logoColor=black" alt="Linux"/>
  <img src="https://img.shields.io/badge/VSCode-007ACC?style=for-the-badge&logo=visualstudiocode&logoColor=white" alt="VSCode"/>
  <img src="https://img.shields.io/badge/GitHub%20Actions-2088FF?style=for-the-badge&logo=githubactions&logoColor=white" alt="GitHub Actions"/>
</p>

<hr/>

## 📈 My GitHub Journey

<p align="center">
  <img src="https://github-readme-stats.vercel.app/api?username=${GH_USERNAME}&show_icons=true&theme=radical&hide_border=true&count_private=true&line_height=25&cache_seconds=3600" alt="${GH_USERNAME}'s GitHub Stats"/>
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=${GH_USERNAME}&theme=radical&hide_border=true&cache_seconds=3600" alt="GitHub Streak"/>
  <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=${GH_USERNAME}&layout=compact&theme=radical&hide_border=true&cache_seconds=3600" alt="Top Languages"/>
</p>

<div align="center">
  <img src="https://github-readme-activity-graph.vercel.app/graph?username=${GH_USERNAME}&theme=github-dark&hide_border=true&line=00FF9C&point=00FF9C" alt="${GH_USERNAME}'s Contribution Graph"/>
</div>

<!-- START SNAKE -->
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/output/github-snake-dark.svg" />
  <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/output/github-snake.svg" />
  <img alt="Github Contribution Snake Animation" src="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/output/github-snake.svg" />
</picture>
<!-- END SNAKE -->

<hr/>

## 💬 Let's Connect!

[![GitHub](https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white)](https://github.com/${GH_USERNAME})
[![LinkedIn](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](${LINKEDIN_URL})
[![Email](https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:${EMAIL_ADDRESS})
[![Twitter](https://img.shields.io/badge/X-%23000000.svg?style=for-the-badge&logo=X&logoColor=white)](https://twitter.com/${TWITTER_HANDLE})

<hr/>

<!-- FOOTER START -->
<div align="center">
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&height=100&section=footer"/>
  <p><sub>Last Updated: ${CURRENT_DATE} UTC - Crafted with 💙 and Automation</sub></p>
</div>
<!-- FOOTER END -->
EOF

echo "README.md updated successfully!"