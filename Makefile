.PHONY: help setup check-flutter install run clean test

# Define required Flutter version
REQUIRED_FLUTTER_VERSION := 3.29.0

help: ## Show help
	@echo "🚀 Face Check-in Flutter Project"
	@echo ""
	@echo "Available commands:"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-15s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

check-flutter: ## Check Flutter version
	@echo "🔍 Checking Flutter version..."
	@if ! command -v fvm &> /dev/null; then \
		echo "❌ FVM (Flutter Version Management) is not installed."; \
		echo "📦 Please install FVM: dart pub global activate fvm"; \
		exit 1; \
	fi
	@if [ ! -f .fvmrc ]; then \
		echo "❌ .fvmrc file not found. This project requires Flutter $(REQUIRED_FLUTTER_VERSION)"; \
		exit 1; \
	fi
	@echo "✅ FVM configuration found (.fvmrc)"
	@echo "🎯 Required Flutter version: $(REQUIRED_FLUTTER_VERSION)"

install: check-flutter ## Install Flutter version and dependencies
	@echo "📦 Installing Flutter $(REQUIRED_FLUTTER_VERSION)..."
	@fvm install $(REQUIRED_FLUTTER_VERSION)
	@echo "🎯 Using Flutter $(REQUIRED_FLUTTER_VERSION) for this project..."
	@fvm use $(REQUIRED_FLUTTER_VERSION)
	@echo "📋 Getting dependencies..."
	@fvm flutter pub get
	@echo "✅ Setup completed!"

setup: install ## Setup project (alias for install)

run: check-flutter ## Run app
	@echo "🚀 Running app with Flutter $(REQUIRED_FLUTTER_VERSION)..."
	@fvm flutter run

build: check-flutter ## Build APK
	@echo "🔨 Building APK with Flutter $(REQUIRED_FLUTTER_VERSION)..."
	@fvm flutter build apk

test: check-flutter ## Run tests
	@echo "🧪 Running tests with Flutter $(REQUIRED_FLUTTER_VERSION)..."
	@fvm flutter test

clean: ## Clean project
	@echo "🧹 Cleaning project..."
	@fvm flutter clean
	@fvm flutter pub get

doctor: check-flutter ## Run Flutter doctor
	@echo "🏥 Running Flutter doctor..."
	@fvm flutter doctor 