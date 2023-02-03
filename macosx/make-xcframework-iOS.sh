#!/bin/sh

# The script to create LAME.xcframework
# Copyright © 2021 BB9z.
# https://github.com/BB9z/LAME-xcframework

# The MIT License
# https://opensource.org/licenses/MIT

set -euo pipefail
echo "$PWD"

if [ -d "LAME.xcframework" ]; then
    echo "Remove previous result."
    rm -r "LAME.xcframework"
else
    echo "No previous build, go on."
fi

xcodebuild archive \
    -scheme LAME-iOS \
    -destination "generic/platform=iOS" \
    -archivePath "build/iOS" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -scheme LAME-iOS \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "build/iOS-Simulator" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES

xcodebuild archive \
    -scheme LAME-iOS \
    -destination "generic/platform=macOS,variant=Mac Catalyst" \
    -archivePath "build/Catalyst" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES


xcodebuild -create-xcframework \
    -framework "build/iOS.xcarchive/Products/Library/Frameworks/LAME.framework" \
    -framework "build/iOS-Simulator.xcarchive/Products/Library/Frameworks/LAME.framework" \
    -framework "build/Catalyst.xcarchive/Products/Library/Frameworks/LAME.framework" \
    -output "LAME.xcframework"
