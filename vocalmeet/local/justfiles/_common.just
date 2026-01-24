# =============================================================================
# Common Variables & Settings
# =============================================================================
# Shared configuration for all justfiles
# =============================================================================

set shell := ["bash", "-cu"]

# Docker compose file for assessment
compose := "docker compose -f ./docker-compose-assessment.yaml"

# Source code path (relative to this directory)
source_path := "../../../vocalmeet/assessment/wordpress"

# URLs
wordpress_url := "https://vocalmeet.local"
phpmyadmin_url := "http://vocalmeet.local:8081"
