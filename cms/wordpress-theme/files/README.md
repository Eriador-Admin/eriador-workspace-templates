# {{PROJECT_NAME}}

A custom WordPress theme with Docker-based local development.

## Getting Started

```bash
bash init.sh    # pull Docker images
bash run.sh     # start WordPress + MySQL
bash stop.sh    # stop containers
```

Visit `http://localhost:{{DEV_PORT}}` to see WordPress. Activate the theme from Appearance > Themes.

## Project Structure

```
theme/
  style.css         # Theme metadata and styles
  functions.php     # Theme functions and hooks
  index.php         # Main template
  header.php        # Header partial
  footer.php        # Footer partial
  single.php        # Single post template
  page.php          # Page template
docker-compose.yml  # WordPress + MySQL containers
```

## Requirements

- Docker & Docker Compose
