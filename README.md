# Sprobe Laravel ReactJS Boilerplate

A base template for `ReactJS (^18.2)` with backend API implementation using `Laravel (^10.0)` preconfigured `laravel/passport(^11.8)` authentication.

## Specifications / Infrastructure Information

-   Nginx
-   PHP-FPM
-   MySQL
-   Cron
-   Node/NPM
-   Redis
-   MailHog

## Prerequisites

-   [Git](https://git-scm.com/downloads)
-   [Docker Desktop](https://www.docker.com/products/docker-desktop)

# Auto Setup [Highly Recommended]
Run this script to automatically setup the base template.
```
./setup.sh
```
You will be prompted to select the Environment, set Application Name and Domain only.  
![Setup Screenshot](/setup-sample.png)  
This is what it will look like when the setup is successful and complete.  
![Setup Screenshot](/setup-complete.png)  

# Manual Setup [Less Recommended]
Do this if you don't want the automatic setup above.
  
Setup the `.env` file for Docker in the root directory

```
cp .env.example .env
```

Make sure to fillup the following variables

```
ENVIRONMENT=development                   # development/staging/production
PROJECT_NAME=YOUR_PROJECT_NAME_HERE       # Prefix for the Docker Containers to be created
MYSQL_ROOT_PASSWORD=ANY_STRONG_PASSWORD   # root password of the root mysql user
MYSQL_DATABASE=YOUR_DATABASE_NAME         # use this value in src/backend/.env
MYSQL_USER=YOUR_DATABASE_USER             # use this value in src/backend/.env
MYSQL_PASSWORD=ANY_STRONG_PASSWORD        # use this value in src/backend/.env
....
....
....
APP_DOMAIN=tcg.local                    # for local development. change accordingly per environment
```

For Local Development in windows, add the following lines to `C:\Windows\System32\drivers\etc\hosts` or `/etc/hosts` for ubuntu

```
127.0.0.1    tcg.local
```

Note: Replace `127.0.0.1` with your Docker Machine IP.

## Build the all containers

```
docker-compose build
```

To build/rebuild a specific container, run the following command, CONTAINER_NAME is from the `docker-compose.yml`

```
docker-compose build CONTAINER_NAME
```

Start the containers

```
docker-compose up -d

# Output
Starting {PROJECT_NAME}_redis    ... done
Starting {PROJECT_NAME}_mysql    ... done
Starting {PROJECT_NAME}_data     ... done
Starting {PROJECT_NAME}_node     ... done
Starting {PROJECT_NAME}_cron     ... done
Starting {PROJECT_NAME}_php      ... done
Starting {PROJECT_NAME}_nginx    ... done
```

Run the following command to login to any Docker Container

```
docker exec -it CONTAINER_NAME bash
```

---

## Setting up Laravel

1. Install the required php packages by running `composer install`
2. Create the `.env` file and run the following to generate key for Laravel
3. Update the database credentials values in `src/backend/.env` using your code text editor then clear the config via docker exec
4. Run the migration
5. If you have seeders, you can run it by using the following command
6. Run the Laravel Passport installation

```
docker exec -it {PROJECT_NAME}_php sh
/var/www/backend # composer install                                 # 1
/var/www/backend # cp .env.example .env                             # 2
/var/www/backend # php artisan key:generate                         # 3
/var/www/backend # php artisan config:clear                         # 4
/var/www/backend # php artisan migrate:fresh                        # 5
/var/www/backend # php artisan db:seed                              # 6
/var/www/backend # php artisan passport:install --force             # 7
```

Copy the generated password grant Client ID & Secret in the `src/backend/.env` file

```
API_CLIENT_ID={COPY FROM TERMINAL}
API_CLIENT_SECRET={COPY FROM TERMINAL}
API_VERSION=v1
```

After setting up all the values in the `.env` file, run the following command to make sure the environment variables are updated successfully.

```
docker exec -it {PROJECT_NAME}_php sh
/var/www/backend # php artisan config:clear
```

---

## Composer

To install additional composer packages, run the following command:

```
docker exec -it {PROJECT_NAME}_php sh
composer require owner/package
```

To remove a package:

```
docker exec -it {PROJECT_NAME}_php sh
composer remove owner/package
```

---

## PHP Coding Standards Fixer

Running the Coding Standards Fixer Container

To check the PHP Files if it follows the PHP Coding Standards without applying any fixes, run the following command:

```
docker exec -it {PROJECT_NAME}_php sh
./fixer . --dry-run
```

To fix all your PHP code to adhere the PHP Coding Standards, run:

```
docker exec -it {PROJECT_NAME}_php sh
./fixer .
```

To Apply fix only to a specific file

```
docker exec -it {PROJECT_NAME}_php sh
./fixer <<file_name>>
```

## Unit Testing

### PHPUnit

-   Running a Test Case

```
docker exec -it {PROJECT_NAME}_php sh
/var/www/backend #  ./phpunit tests/<<test_file>>
```

-   Running the whole Test Suite

```
docker exec -it {PROJECT_NAME}_php sh
/var/www/backend #  ./phpunit
```

The code coverage result will be available at  
<https://APP_DOMAIN/api/report>

The code coverage logs will be available at  
<https://APP_DOMAIN/api/report/logs>

---

## PHP Debugging

**IMPORTANT:** Make sure to disable xDebug in Staging/Production environment for faster php container.

To enable PHP xDebug in your development environment, update the **_.env_** value into:

```
...
...
ENABLE_XDEBUG=1
```

Accepted Values:

-   ENABLE_XDEBUG=0 - Disable
-   ENABLE_XDEBUG=1 - Enable

Install the VS Code extension **PHP Debug** by **Felix Becker** then restart your VS Code.

Open the PHP file you want to debug. Add your breakpoints by clicking the left side of the Line Number of the file you want to debug.

**Breakpoints** are those red dot beside the Line Number. Once you have your breakpoints, press **F5**. Trigger the function by accessing the route via postman/browser.

---

## PHP OpCache

OPcache improves PHP performance by storing precompiled script bytecode in shared memory, thereby removing the need for PHP to load and parse scripts on each request.

By default, OPcache is already enabled when the php container is built. Somehow you need to do another step in order get the best performance especially in production site.

During development, update the **.env** file value to

```
OPCACHE_VALIDATE_TIMESTAMPS=1
```

If this is set to 1, you can see the changes directly since PHP will check if you have any changes to your .php files.

To achieve a 4-5x performance/speed boost in your staging/production site, update the `.env ` file into:

```
OPCACHE_VALIDATE_TIMESTAMPS=0
```

However if you it set this to 0, the system ignores and doesn't check any changes in you PHP files. So if you edited/uploaded any .php files, you will not see it reflected on your site.

Make sure to restart/reload the PHP container after deploying any code changes in staging/production site if you set the value to:

```
OPCACHE_VALIDATE_TIMESTAMPS=0
```

---

## BACKEND

To access the backend routes, use the **APP_DOMAIN** you set in the `.env` file

```
APP_DOMAIN=tcg.local                # for local development
```

in this case: https://tcg.local/api/v1

We are using **`v1`** as base suffix for our api routes following the rest standards. All routes should be declared in the **`src/backend/routes/api.php`** file.

---

## FRONTEND

This package uses ReactJS as frontend framework. This docker setup will automatically serve the ReactJS via node container.

All the source code for frontend development is in `src/frontend` directory. Any file changes in the `src/frontend` will reflect  
automatically via Hot Reload Module.

Create the `src/frontend/.env` file with the following variable and corresponding values

```
cp src/frontend/.env.example src/frontend/.env
```

Update the values in the `.env` file

```
REACT_APP_SITE_TITLE="My Site/App Title"  // The Suffix Site Title for all Pages  e.g Page - REACT_APP_SITE_TITLE
REACT_APP_CLIENT_ID=                      // GENERATED FROM php artisan passport:install
REACT_APP_CLIENT_SECRET=                  // GENERATED FROM php artisan passport:install
REACT_APP_API_URL=                        // THE API DOMAIN SET ON DOCKER ENV FILE
```

Restart the docker-containers

```
docker-compose restart
```

---

## NPM Packages

In case you want to install additional NPM packages, you must login to the Node Container

```
docker exec -it --user=root {PROJECT_NAME}_node sh

# In case the command above fails, run this instead
winpty docker exec -it {PROJECT_NAME}_node sh
```

Then run the install command inside the Node Container

```
docker exec -it --user=root {PROJECT_NAME}_node sh
/var/www/frontend # npm install some-package-name (e.g eslint webpack)
```

---

## Frontend Coding Standards

[ESLint](https://github.com/eslint/eslint) & [Prettier](https://github.com/prettier/prettier) has been configured and enabled for the Frontend source code to enforce uniform coding standards.

If you encounter any `eslint` errors during development, just run this command to automatically fix some of the basic errors (spacing, formatting, etc).

```
docker-compose exec -it PROJECT_node sh
npm run lint
```

Some errors aside from spacing, formatting & etc. needs to be fixed manually.

**Note: Please don't disable some of the rules just to fix your errors. As much as possible, developer should fix the error and follow the coding standards.**

---

## Usage

If you have already run the laravel seeders during the setup, you can test the frontend login using the following account:

```
email: admin@tcg.sprobe.ph
password: Password2022!
```

---

## Mail Server

This Base Template has `Mailhog` container you can use to test Email Sending events.  
Make you to set the `src/backend/.env` file with these values:

```
MAIL_MAILER=smtp
MAIL_HOST=mailhog
MAIL_PORT=1025
MAIL_USERNAME=null
MAIL_PASSWORD=null
MAIL_ENCRYPTION=null
MAIL_FROM_ADDRESS=any_email_address_here@mail.com
MAIL_FROM_NAME=Any_Name_Here
```

You can preview the emails sent by opening this link in your browser: [http://localhost:8025/](http://localhost:8025/)

---

## Staging / Production Build

Make sure to update the root `.env` values accordingly

```
# For Staging
ENVIRONMENT=staging

# For Production
ENVIRONMENT=production
...
...
...
# Disable X-Debug for Better PHP container performance
ENABLE_XDEBUG=0
```

Update also the Laravel `src/backend/.env` file

```
# For Staging
APP_ENV=staging

# For Production
APP_ENV=production
..
..
# Disable Debug on Staging/Production Environments
APP_DEBUG=false
```

The just like how you setup in your local environment

1. Build All the Docker Containers
2. Run the Composer to install Laravel Packages
3. Setup Laravel by running commands inside the PHP docker container
4. Run the React Build Manually

```
docker-compose run --rm PROJECT_node npm run build
```

After successful build, start all the containers

```
docker-compose up -d
```

Check the running containers

```
docker ps
```

Make sure the following containers are up

1. Nginx
2. PHP
3. Cron
4. Mysql
5. Redis

After checking the containers are up, you can visually check the site in the browser.

For succeeding/incremental deployments for the React(Frontend), just run

```
docker-compose run --rm PROJECT_node npm run build
```
  
---
  
## Generate API Documentation

The Laravel Backend source code has included the `knuckleswtf/scribe` package to auto generate the API Documentation. This will fetch all the routes found in your `routes/api.php` and generates the API Documentation automatically.
  
To generate the API Documentation, you will need to go inside the PHP Docker container and run the following command `php artisan scribe:generate`:
```
docker exec -it PROJECTNAME_php sh
/var/www/backend # php artisan scribe:generate
```
If the command is successful, it will look like this:
![Generate API Doc Screenshot](/api-doc-generate.png)    

You can view the API Documentation page at [http://APP_DOMAIN/api/docs](http://APP_DOMAIN/api/docs)
![View API Doc Screenshot](/api-doc-sample.png)
  
There is also a `Postman` collection file generated that can be found at [http://APP_DOMAIN/api/docs/collection.json](http://APP_DOMAIN/api/docs/collection.json) that you can import in your `Postman App`.
