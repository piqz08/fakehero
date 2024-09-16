# Sprobe Laravel ReactJS Boilerplate

## [Unreleased]

## [2.0.0] - 2021-01-20
### Added
- Added `CHANGELOG.md` file
- Added `MergeRequestGuide.md` file.
- Added `StyleGuide` Page for development reference.
- Added new Public Static Pages for `About, Inquiry, FAQ, Terms`
- Added Static Pages for Dashboard `Widgets, Integration Card List`
- Added `Mailhog` as SMTP server for development environment.
- Added `Localization` support in Frontend for (English and Japanese).
- Added `Toast` packages for notifications.
- Added Import Auto Sort for Prettier.
- Added Common Components to be used sitewide like `Forms` & `DataTable`.
- Added Yup schema validation for `react-hook-form` package.
- Added `setup.sh` script to automatically setup the base template easily with ease.
- Added Scribe API Documentation Generator.

### Changed
- Applied Theming.
- Applied Atomic Design Structure.
- Moved Composer inside PHP Container.
- Updated Nginx Config for all environments.
- New API Base URL. Before `api.DOMAIN.com/v1`. Now API Route `DOMAIN.com/api/v1`. Removed API subdomain.
- Optional SSL Support. Can enable/disable via `.env` file `GENERATE_SELF_SIGNED_SSL=0 or 1`. Set value to `0` to disable SSL or `1` to enable SSL.

### Removed
- Removed Composer Docker Container
- Removed subdomain nginx config for Backend API.
- Removed Redux in React.

### Updates
- Updated PHPCS (Php Coding Standard) Fixer container to support PHP 8.1
- Updated Rules to adhere PSR12 and PHPCSFixer standards.
- Updated and Restructured Frontend Files and Directory.
- Updated MUI version and implementation.
- 100% Code Coverage for backend source code.
- Updated ESLint rules.
