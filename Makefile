# Makefile for deploying Flutter web to GitHub Pages

GITHUB_USER = blackoaz
GITHUB_REPO_NAME = flutter_challenge
GITHUB_REPO = https://$(GITHUB_USER):$(GITHUB_TOKEN)@github.com/$(GITHUB_USER)/$(GITHUB_REPO_NAME).git
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

deploy:
ifndef GITHUB_TOKEN
	$(error GITHUB_TOKEN is not set. Usage: make deploy GITHUB_TOKEN=your_token_here)
endif

	@echo "Cleaning project..."
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Building for web..."
	flutter build web --base-href /$(GITHUB_REPO_NAME)/ --release

	@echo "Deploying to gh-pages branch..."
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M gh-pages && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin gh-pages

	@echo "Finished deploying!"
	@echo "Visit app at: https://$(GITHUB_USER).github.io/$(GITHUB_REPO_NAME)/"

.PHONY: deploy
