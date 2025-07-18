# Copilot Instructions

## General Guidelines

- Follow PSR-12 coding standards for PHP code
- Use meaningful variable and function names
- Write clean, self-documenting code with appropriate comments
- Prioritize security best practices in all implementations
- Use proper error handling and validation
- Follow the principle of least privilege for permissions and access

## WordPress Development

### Code Structure
- Use WordPress coding standards (WPCS)
- Follow the WordPress Plugin/Theme directory structure
- Use proper WordPress hooks and filters instead of direct modifications
- Implement proper sanitization and validation for all user inputs
- Use WordPress nonces for form security

### Best Practices
- Use `wp_enqueue_script()` and `wp_enqueue_style()` for assets
- Implement proper database queries using `$wpdb` or `WP_Query`
- Use WordPress caching mechanisms when appropriate
- Follow WordPress security guidelines (sanitize, escape, validate)
- Use WordPress coding conventions for function naming (`prefix_function_name`)

### Common Patterns
- Use `add_action()` and `add_filter()` for hooking into WordPress
- Implement proper activation/deactivation hooks for plugins
- Use `wp_localize_script()` for passing data to JavaScript
- Implement proper AJAX handling with WordPress nonces
- Use custom post types and meta fields appropriately

### Security
- Always sanitize user input with appropriate WordPress functions
- Use `wp_nonce_field()` and `wp_verify_nonce()` for form security
- Escape output using `esc_html()`, `esc_attr()`, `esc_url()`
- Use prepared statements for database queries
- Validate and sanitize all $_GET, $_POST, and $_REQUEST data

## Laravel Development

### Code Structure
- Follow Laravel's MVC architecture strictly
- Use Eloquent ORM for database interactions
- Implement proper service providers and dependency injection
- Use Laravel's built-in authentication and authorization
- Follow RESTful API conventions

### Best Practices
- Use Laravel's validation rules and form requests
- Implement proper error handling with try-catch blocks
- Use Laravel's caching mechanisms (Redis, Memcached)
- Follow Laravel naming conventions for models, controllers, and routes
- Use Laravel's built-in testing framework

### Common Patterns
- Use middleware for authentication and authorization
- Implement proper database migrations and seeders
- Use Laravel's queue system for background jobs
- Implement proper API resource transformations
- Use Laravel's event and listener system

### Security
- Use Laravel's CSRF protection for forms
- Implement proper input validation using Form Requests
- Use Laravel's authentication guards and policies
- Sanitize and validate all user inputs
- Use Laravel's built-in rate limiting

### Performance
- Use eager loading to avoid N+1 queries
- Implement proper database indexing
- Use Laravel's caching for expensive operations
- Optimize database queries with proper relationships
- Use Laravel's pagination for large datasets

## Cloudflare Worker Development

### Code Structure
- Use modern JavaScript (ES6+) or TypeScript
- Implement proper error handling for edge cases
- Use Cloudflare's APIs and services appropriately
- Follow serverless best practices
- Keep code lightweight and efficient

### Best Practices
- Use Cloudflare's KV storage for persistent data
- Implement proper caching strategies
- Use Cloudflare's Durable Objects for stateful applications
- Follow Cloudflare's security guidelines
- Use environment variables for configuration

### Common Patterns
- Use `fetch()` API for external requests
- Implement proper request/response handling
- Use Cloudflare's HTMLRewriter for HTML manipulation
- Implement proper routing for different endpoints
- Use Cloudflare's scheduled events for cron jobs

### Security
- Validate all incoming requests
- Use proper CORS headers
- Implement rate limiting and DDoS protection
- Use Cloudflare's security features (WAF, Bot Management)
- Sanitize all user inputs and outputs

### Performance
- Keep bundle sizes small and efficient
- Use streaming responses for large data
- Implement proper caching headers
- Use Cloudflare's edge caching effectively
- Optimize for cold start performance

## Cross-Platform Considerations

### API Development
- Use consistent HTTP status codes
- Implement proper API versioning
- Use JSON for data exchange
- Implement proper pagination
- Use appropriate HTTP methods (GET, POST, PUT, DELETE)

### Database
- Use proper database normalization
- Implement database indexing for performance
- Use migrations for schema changes
- Implement proper backup and recovery procedures
- Use connection pooling when appropriate

### Testing
- Write unit tests for all business logic
- Implement integration tests for API endpoints
- Use proper mocking for external dependencies
- Follow test-driven development (TDD) when possible
- Maintain good test coverage

### Documentation
- Document all API endpoints with proper examples
- Use PHPDoc for PHP functions and classes
- Document complex business logic
- Maintain up-to-date README files
- Use version control effectively with meaningful commit messages

## Environment-Specific Notes

### Development
- Use local development environments (Local, XAMPP, Laravel Sail)
- Implement proper debugging tools and logging
- Use version control with meaningful commit messages
- Use environment-specific configuration files

### Production
- Use proper production configurations
- Implement monitoring and logging
- Use HTTPS everywhere
- Implement proper backup strategies
- Use CDN for static assets when appropriate
