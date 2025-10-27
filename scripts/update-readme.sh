#!/bin/bash
set -e # Exit immediately if a command exits with a non-zero status.

# Ensure output directory exists for snake and other assets
mkdir -p assets
mkdir -p output

# --- Configuration & Secrets (Read from Environment) ---
# These are passed from the .yml file's 'env:' block
GH_USERNAME="${GH_USERNAME}"
GH_TOKEN="${GH_TOKEN}"
DEVTO_USERNAME="${SECRET_DEVTO_USERNAME}"
LINKEDIN_URL="${SECRET_LINKEDIN_URL}"
TWITTER_HANDLE="${SECRET_TWITTER_HANDLE}"
EMAIL_ADDRESS="${SECRET_EMAIL_ADDRESS}"
WAKATIME_USERNAME="${SECRET_WAKATIME_USERNAME}"

# --- Dynamic Variables & Placeholders ---
CURRENT_DATE=$(date -u +"%Y-%m-%d %H:%M:%S")
CURRENT_YEAR=$(date -u +"%Y")

# Time-based greeting
HOUR=$(date +"%H" -u) # Use UTC for consistency
GREETING=""
if (( HOUR >= 5 && HOUR < 12 )); then
  GREETING="Good Morning, Coder! ☀️"
elif (( HOUR >= 12 && HOUR < 18 )); then
  GREETING="Good Afternoon, Developer! ☕"
else
  GREETING="Good Evening, Night Owl! 🌙"
fi

# Example of dynamic status messages
STATUS_MESSAGES=(
  "Refining CI/CD pipelines for a new microservice"
  "Debugging a tricky C++ memory leak on a personal project"
  "Exploring the latest features in FastAPI and Python 3.12"
  "Contributing to an open-source project focused on web scraping"
  "Learning advanced JavaScript patterns for frontend optimization"
)
RANDOM_INDEX=$(( RANDOM % ${#STATUS_MESSAGES[@]} ))
DYNAMIC_STATUS_MESSAGE="${STATUS_MESSAGES[$RANDOM_INDEX]}"
STATUS_EMOJIS=( "🛠️" "🐛" "💡" "🤝" "📚" )
DYNAMIC_STATUS_EMOJI="${STATUS_EMOJIS[$RANDOM_INDEX]}"

CURRENT_FOCUS="implementing event-driven architectures with RabbitMQ"
LEARNING_PATH="Kubernetes for container orchestration and advanced Go concepts"
FUN_FACT_ACTIVITY="hiking new trails and practicing amateur astrophotography 🌌"

# --- FUNCTIONS FOR DYNAMIC CONTENT ---

# Function to get Spotify "Now Playing"
get_spotify_status() {
    if [ -n "$GH_USERNAME" ]; then
        echo "![Spotify](https://spotify-github-profile.vercel.app/api/spotify?username=${GH_USERNAME}&theme=dark)"
    else
        echo ""
    fi
}
SPOTIFY_BADGE=$(get_spotify_status)

# Function to get recent Dev.to articles
get_devto_articles() {
    if [ -z "$DEVTO_USERNAME" ]; then
        echo ""
        return
    fi

    ARTICLES=$(curl -s "https://dev.to/api/articles?username=${DEVTO_USERNAME}&per_page=3")
    if [ $? -ne 0 ] || [ -z "$ARTICLES" ] || [ "$(echo "$ARTICLES" | jq 'length')" -eq 0 ]; then
        echo ""
        return
    fi

    echo "<h3>📰 Latest Articles on Dev.to</h3>"
    echo "<table width='100%'>"
    echo "$ARTICLES" | jq -r '.[] | 
      "<tr>" +
      "<td width=\"90%\"><a href=\"\(.url)\" target=\"_blank\">\(.title)</a></td>" +
      "<td width=\"10%\" align=\"right\">❤️ \(.public_reactions_count)</td>" +
      "</tr>"
    '
    echo "</table>"
}
DEVTO_SECTION=$(get_devto_articles)

# [ --- NEW: DYNAMIC FEATURED PROJECTS --- ]
# Function to get top 3 starred projects
get_featured_projects() {
    if [ -z "$GH_USERNAME" ] || [ -z "$GH_TOKEN" ]; then
        echo ""
        return
    fi

    PROJECTS_DATA=$(curl -s -H "Authorization: token ${GH_TOKEN}" \
      "https://api.github.com/users/${GH_USERNAME}/repos?sort=stargazers&per_page=3&type=owner")

    if [ $? -ne 0 ] || [ -z "$PROJECTS_DATA" ] || [ "$(echo "$PROJECTS_DATA" | jq 'length')" -eq 0 ]; then
        echo ""
        return
    fi

    echo "<h2>✨ My Top Projects</h2>"
    echo "<table width=\"100%\">"
    
    echo "$PROJECTS_DATA" | jq -r '.[] | 
      "<tr>" +
      "<td width=\"70%\"><b><a href=\"\(.html_url)\" target=\"_blank\">\(.name)</a></b></td>" +
      "<td width=\"30%\" align=\"right\">⭐ \(.stargazers_count) | 🍴 \(.forks_count)</td>" +
      "</tr>" +
      "<tr><td colspan=\"2\">\(.description // "No description")</td></tr>" +
      "<tr><td colspan=\"2\" height=\"10\"></td></tr>" # Spacer row
    '
    
    echo "</table>"
}
FEATURED_PROJECT_SECTION=$(get_featured_projects)


# Function to get a random programming quote
get_random_quote() {
    QUOTE_DATA=$(curl -s "https://programming-quotes-api.herokuapp.com/quotes/random")
    if [ $? -ne 0 ] || [ -z "$QUOTE_DATA" ] || ! echo "$QUOTE_DATA" | jq . > /dev/null 2>&1; then
        echo ""
        return
    fi

    QUOTE=$(echo "$QUOTE_DATA" | jq -r '.quote')
    AUTHOR=$(echo "$QUOTE_DATA" | jq -r '.author')

    if [ -z "$QUOTE" ] || [ "$QUOTE" == "null" ]; then
        echo ""
        return
    fi

    echo "<h3>💡 Programming Wisdom</h3>"
    echo "<p align=\"center\">"
    echo "  <em>\"${QUOTE}\"</em><br>"
    echo "  <b>- ${AUTHOR}</b>"
    echo "</p>"
}
QUOTE_SECTION=$(get_random_quote)

# [ --- NEW: WAKATIME CARD --- ]
get_wakatime_card() {
    if [ -z "$WAKATIME_USERNAME" ]; then
        echo ""
        return
    fi
    
    echo "<h3>📊 My Weekly Coding Activity</h3>"
    echo "<a href=\"https://wakatime.com/@${WAKATIME_USERNAME}\">"
    echo "  <img src=\"https://github-readme-stats.vercel.app/api/wakatime?username=${WAKATIME_USERNAME}&theme=tokyonight&layout=compact&hide_border=true\" alt=\"WakaTime Stats\" />"
    echo "</a>"
}
WAKATIME_SECTION=$(get_wakatime_card)

# --- Generate the README Content ---
cat << EOF > README.md
<div align="center">
  <img src="https://github.com/Thugger069/Thugger069/blob/main/pfp.jpg?raw=true" alt="Thugger069's Profile Picture" width="150" height="150" style="border-radius:50%;">
  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Ubuntu+Mono&duration=3000&pause=1000&color=00FF9C&center=true&vCenter=true&width=435&lines=Greetings%2C+Fellow+Coder!;Thugger069+Here!;Crafting+Digital+Experiences;Exploring+the+DevOps+Frontier;Building+with+Python%2C+JS%2C+C%2B%2B;Open+Source+Advocate;Always+Learning+%F0%9F%92%A1;Welcome+to+my+README!;Let's+Build+Something+Great!" alt="Typing SVG" />
  </a>
  <h2>${GREETING}</h2>
</div>
<div align="center">
  <a href="https://github.com/${GH_USERNAME}">
    <img src="https://komarev.com/ghpvc/?username=${GH_USERNAME}&color=blueviolet&style=flat-square&label=Profile%20Views" alt="Profile views"/>
  </a>
</div>
<hr/>

<div align="center">
  ${SPOTIFY_BADGE}
</div>
<hr/>

<div align="center">
  <img src="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/main/assets/terminal_animation.gif" alt="Terminal Simulation" width="600" />
  <br/>
  <p>
    <code>✨ What's happening in my dev-world right now:</code><br>
    <code>[${DYNAMIC_STATUS_EMOJI}] ${DYNAMIC_STATUS_MESSAGE}</code>
  </p>
</div>
<hr/>

## 🚀 About Me

I'm an aspiring developer with a strong passion for **backend systems**, **web technologies**, and **low-level programming with C++**. I thrive on challenging problems, transforming complex ideas into elegant, efficient, and scalable software solutions.

-   🔭 **Currently Deep Diving Into:** ${CURRENT_FOCUS}
-   🌱 **Eager to Learn More About:** ${LEARNING_PATH}
-   👯 **Open to Collaborating On:** Innovative open-source projects, especially those involving Python, JavaScript, or C++.
-   💬 **Ask Me About:** Software architecture, performance optimization, or getting started with automation.
-   ⚡ **Fun Fact:** When not coding, I'm often found ${FUN_FACT_ACTIVITY}.

<hr/>

<div align="center">
  ${FEATURED_PROJECT_SECTION}
</div>
<hr/>

<div align="center">
  ${DEVTO_SECTION}
</div>
<hr/>

<div align="center">
  ${QUOTE_SECTION}
</div>
<hr/>

## 🛠️ Tech Stack & Tools

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
  <img src="https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white" alt="Node.js"/>
  <img src="https://img.shields.io/badge/FastAPI-009688?style=for-the-badge&logo=fastapi&logoColor=white" alt="FastAPI"/>
  <img src="https://img.shields.io/badge/Flask-000000?style=for-the-badge&logo=flask&logoColor=white" alt="Flask"/>
</p>

<h3 align="center">Databases & DevOps</h3>
<p align="center">
  <img src="https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white" alt="PostgreSQL"/>
  <img src="https://img.shields.io/badge/MongoDB-4EA94B?style=for-the-badge&logo=mongodb&logoColor=white" alt="MongoDB"/>
  <img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker"/>
  <img src="https://img.shields.io/badge/git-%23F05033.svg?style=for-the-badge&logo=git&logoColor=white" alt="Git"/>
  <img src="https://img.shields.io/badge/GitHub_Actions-2088FF?style=for-the-badge&logo=github-actions&logoColor=white" alt="GitHub Actions"/>
</p>

<hr/>

## 📊 GitHub Stats & Activity

<div align="center">
  
  <img src="https://github-readme-stats.vercel.app/api?username=${GH_USERNAME}&show_icons=true&theme=tokyonight&hide_border=true&include_all_commits=true&count_private=true" alt="GitHub Stats" width="49%"/>
  
  <img src="https://github-readme-stats.vercel.app/api/top-langs/?username=${GH_USERNAME}&layout=compact&theme=tokyonight&hide_border=true" alt="Top Languages" width="49%"/>
  
  <br/>
  
  <img src="https://github-readme-streak-stats.herokuapp.com/?user=${GH_USERNAME}&theme=tokyonight&hide_border=true" alt="GitHub Streak" width="70%"/>
</div>

<div align="center">
  ${WAKATIME_SECTION}
</div>

<hr/>

## 🐍 GitHub Contribution Snake

<div align="center">
  <img src="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/main/output/github-snake.svg" alt="github contribution snake" />
  
  <picture>
    <source media="(prefers-color-scheme: dark)" srcset="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/main/output/github-snake-dark.svg">
    <source media="(prefers-color-scheme: light)" srcset="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/main/output/github-snake.svg">
    <img alt="github contribution snake" src="https://raw.githubusercontent.com/${GH_USERNAME}/${GH_USERNAME}/main/output/github-snake.svg">
  </picture>
</div>

## 🏙️ GitHub Skyline

<div align="center">
  <a href="https://skyline.github.com/${GH_USERNAME}/${CURRENT_YEAR}">
    <img src="https://skyline.github.com/${GH_USERNAME}/${CURRENT_YEAR}.svg" alt="GitHub Skyline ${CURRENT_YEAR}" width="80%"/>
  </a>
  <p>My ${CURRENT_YEAR} contribution graph in 3D</p>
</div>

<hr/>

## 🌐 Connect with Me

<div align="center">
  <a href="${LINKEDIN_URL}" target="_blank">
    <img src="https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn"/>
  </a>
  <a href="https://twitter.com/${TWITTER_HANDLE}" target="_blank">
    <img src="https://img.shields.io/badge/Twitter-1DA1F2?style=for-the-badge&logo=twitter&logoColor=white" alt="Twitter"/>
  </a>
  <a href="mailto:${EMAIL_ADDRESS}">
    <img src="https://img.shields.io/badge/Email-D14836?style=for-the-badge&logo=gmail&logoColor=white" alt="Email"/>
  </a>
</div>

<hr/>

<div align="center">
  <p><em>README automatically updated on: ${CURRENT_DATE} UTC</em></p>
</div>
EOF
# --- END OF FILE GENERATION ---

echo "✅ README.md successfully generated with dynamic API content."
