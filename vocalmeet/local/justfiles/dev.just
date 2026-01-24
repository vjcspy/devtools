# =============================================================================
# Development Helper Commands
# =============================================================================

# Open WordPress in browser
open:
    open {{wordpress_url}}

# Open phpMyAdmin in browser
open-db:
    open {{phpmyadmin_url}}

# Watch plugin directory for changes (requires fswatch)
watch-plugins:
    @echo "👀 Watching {{source_path}}/plugins for changes..."
    fswatch -o {{source_path}}/plugins | xargs -n1 -I{} echo "📁 Plugin files changed"

# Shell into WordPress container
shell:
    {{compose}} exec wordpress bash

# Show WordPress debug log
debug-log:
    {{compose}} exec wordpress tail -f /var/www/html/wp-content/debug.log
