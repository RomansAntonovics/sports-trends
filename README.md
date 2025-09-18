## Sports Trends

Laravel-based backend for sports trends and daily insights.

### Quick start

1. Install dependencies
   - PHP: `composer install`
   - JS: `npm install`
2. Setup environment
   - Copy `.env.example` to `.env`
   - Fill `DATABASE_URL`, `OPENAI_API_KEY` (optional), `TIMEZONE`
3. Generate key: `php artisan key:generate`
4. Migrate DB: `php artisan migrate`
5. (Optional) Seed data: `php artisan db:seed`
6. Run locally
   - API: `php artisan serve`
   - Assets: `npm run dev`

### Environment variables

- `TIMEZONE` — default app timezone (e.g. Europe/Riga)
- `DATABASE_URL` — database connection string
  - SQLite example: `sqlite:///database/database.sqlite`
  - MySQL example: `mysql://user:pass@127.0.0.1:3306/sports_trends`
  - PostgreSQL example: `pgsql://user:pass@127.0.0.1:5432/sports_trends`
- `OPENAI_API_KEY` — required only if OpenAI features are used

See `.env.example` for a documented template.

### Run locally

- Start backend: `php artisan serve`
- Start Vite: `npm run dev`
- Open `http://localhost:8000`

### Seeding

- Seed all: `php artisan db:seed`
- Specific seeder: `php artisan db:seed --class=DatabaseSeeder`

### Schedule the daily job

1. Define schedule in `app/Console/Kernel.php` (e.g., a daily command).
2. Run the Laravel scheduler every minute:
   - Linux/macOS (cron):
     ```bash
     * * * * * cd /path/to/project && php artisan schedule:run >> /dev/null 2>&1
     ```
   - Windows (Task Scheduler):
     - Program/script: `php`
     - Arguments: `artisan schedule:run`
     - Start in: `C:\Projects\sports-trends`

This ensures daily tasks execute at their configured times.

### Testing

```bash
php artisan test
```
