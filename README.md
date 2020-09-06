# lightlogs Docker files for development

1. git clone `lightlogs` into `src/`
2. cd src/ && cp .env.example .env
3. cd .. && docker-compose up -d --build

## Database:
- DB_CONNECTION=pgsql
- DB_HOST=timescale
- DB_PORT=5432
- DB_DATABASE=lightlogs
- DB_USERNAME=default
- DB_PASSWORD=secret

## Composer:
```bash
docker-compose run --rm composer i
```

## Migration:
```bash
docker-compose run --rm app php artisan migrate:fresh --seed
```

## Services:
  - nginx: http://localhost:8080
  - pgsql: timescale:5432
  - grafana: http://localhost:3000