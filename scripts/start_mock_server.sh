#!/bin/bash

echo "🚀 Starting Mock WebSocket Server for Face Check-in App"
echo "============================================="

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js first."
    echo "   Download from: https://nodejs.org/"
    exit 1
fi

# Check if npm is installed
if ! command -v npm &> /dev/null; then
    echo "❌ npm is not installed. Please install npm first."
    exit 1
fi

# Navigate to scripts directory
cd "$(dirname "$0")"

echo "📦 Installing WebSocket dependencies..."
npm install

echo ""
echo "🌐 Starting WebSocket server on port 3009..."
echo "📱 Flutter app can now connect to ws://localhost:3009"
echo ""
echo "ℹ️  To test with Flutter app:"
echo "   1. Keep this server running"
echo "   2. Run 'flutter run --debug' in another terminal"
echo "   3. Check connection status in the app"
echo ""
echo "Press Ctrl+C to stop the server"
echo ""

# Start the server
npm start 