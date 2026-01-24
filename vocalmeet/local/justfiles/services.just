# =============================================================================
# Service Management Commands
# =============================================================================

# Start all services
start:
    @echo "🚀 Starting WordPress environment..."
    {{compose}} up -d mysql nginx wordpress phpmyadmin
    @echo ""
    @echo "✅ Services started!"
    @echo "   WordPress:   {{wordpress_url}}"
    @echo "   phpMyAdmin:  {{phpmyadmin_url}}"

# Stop all services (keeps data)
stop:
    @echo "🛑 Stopping services..."
    {{compose}} stop

# Stop and remove all containers (keeps volumes/data)
down:
    @echo "🛑 Stopping and removing containers..."
    {{compose}} down

# Stop, remove containers AND delete all data
clean:
    @echo "🗑️  Removing everything including data..."
    {{compose}} down -v
    @echo "✅ All containers and volumes removed"

# Restart all services
restart: stop start

# Show status of all services
status:
    {{compose}} ps

# Initial setup: generate SSL + start services + install plugins
setup: ssl-generate
    @echo "🚀 Starting WordPress environment..."
    {{compose}} up -d mysql nginx wordpress phpmyadmin
    @echo "⏳ Waiting for WordPress to be ready..."
    @sleep 30
    @echo "📦 Installing required plugins..."
    just wp plugin install elementor --activate
    just wp plugin install woocommerce --activate
    @echo ""
    @echo "✅ Setup complete!"
    @echo "   WordPress:   {{wordpress_url}}"
    @echo "   phpMyAdmin:  {{phpmyadmin_url}}"
    @echo ""
    @echo "⚠️  Note: Accept the self-signed certificate warning in your browser"
