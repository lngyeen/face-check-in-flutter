# Infrastructure and Deployment Overview

## Deployment Strategy (MVP)
A "Manual Build & Distribute" process will be used. Developers will build the `.apk` (Android) and `.ipa` (iOS) files locally.

## Distribution Method (MVP)
The application installers will be distributed for testing via **Firebase App Distribution** or direct file transfer.

## CI/CD (Post-MVP)
A CI/CD pipeline (e.g., using GitHub Actions) should be set up after the MVP to automate the build and distribution process.

## Rollback Strategy
If a new version is faulty, the rollback procedure is to uninstall it and reinstall the last known stable version from its installer file. 