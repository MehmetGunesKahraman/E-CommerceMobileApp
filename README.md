
# FluttApp

A Flutter shopping UI that loads a product catalog from a remote API and falls back to bundled JSON assets. The app supports search, sorting, favorites, cart flow, and product details.

## Features

- Home catalog grid with banners
- Search input and price sorting
- Favorites screen and cart screen
- Product detail view
- Network fetch with local JSON fallback

## Tech Stack

- Flutter (Dart SDK ^3.10.8)
- HTTP client for API calls
- Local JSON assets for offline fallback

## Project Structure

- `lib/main.dart`: App entry point
- `lib/views/`: Screens and flows
- `lib/components/`: Reusable UI components
- `lib/models/`: Data models
- `lib/services/`: API and data loading
- `assets/`: Product data and images

## Data Sources

- Primary API: `https://www.wantapi.com/products.php`
- Fallback: `assets/products.json`

## Assets

Make sure these are available and listed in `pubspec.yaml`:

- `assets/products.json`
- `assets/images/`

## Notes

- If the API is unavailable, the app automatically loads local products.


