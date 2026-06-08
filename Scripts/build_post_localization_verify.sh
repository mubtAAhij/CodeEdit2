#!/usr/bin/env bash

set -euo pipefail

# Usage:
#   build_post_localization_verify.sh <build_path> <scheme> [configuration]
# where build_path is either .xcworkspace or .xcodeproj

BUILD_PATH="${1:-}"
SCHEME="${2:-}"
CONFIGURATION="${3:-Debug}"

if [ -z "$BUILD_PATH" ] || [ -z "$SCHEME" ]; then
    echo "Usage: build_post_localization_verify.sh <build_path> <scheme> [configuration]"
    exit 1
fi

BUILD_TYPE="project"
if [[ "$BUILD_PATH" == *.xcworkspace ]]; then
    BUILD_TYPE="workspace"
fi

xcodebuild_cmd() {
    local cmd_args=()
    if [ "$BUILD_TYPE" = "workspace" ]; then
        cmd_args+=(-workspace "$BUILD_PATH")
    else
        cmd_args+=(-project "$BUILD_PATH")
    fi
    cmd_args+=(-scheme "$SCHEME")
    cmd_args+=("$@")
    xcodebuild "${cmd_args[@]}"
}

AVAILABLE_DESTINATIONS=$(xcodebuild_cmd -showdestinations 2>/dev/null || true)
DESTINATION=""
if echo "$AVAILABLE_DESTINATIONS" | grep -q "platform:macOS"; then
    DESTINATION="generic/platform=macOS"
elif echo "$AVAILABLE_DESTINATIONS" | grep -q "platform:iOS Simulator"; then
    DESTINATION="generic/platform=iOS Simulator"
elif echo "$AVAILABLE_DESTINATIONS" | grep -q "platform:iOS"; then
    DESTINATION="generic/platform=iOS"
else
    DESTINATION="generic/platform=macOS"
fi

echo "Using build path: $BUILD_PATH"
echo "Using scheme: $SCHEME"
echo "Using destination: $DESTINATION"

# This workflow is a compile/type safety gate for post-localization changes.
# Disable SwiftLint plugin enforcement so style violations don't mask true build regressions.
export SWIFTLINT_DISABLE=YES
export SWIFTLINT_SKIP_BUILD_PHASE=YES
export DISABLE_SWIFTLINT=YES
export SWIFTLINT_DISABLE=1

if [ "$BUILD_TYPE" = "workspace" ]; then
    xcodebuild -workspace "$BUILD_PATH" -resolvePackageDependencies || true
else
    xcodebuild -project "$BUILD_PATH" -resolvePackageDependencies || true
fi

xcodebuild_cmd \
    -configuration "$CONFIGURATION" \
    -destination "$DESTINATION" \
    CODE_SIGNING_ALLOWED=NO \
    -skipPackagePluginValidation \
    build 2>&1 | tee build_output_post_localization.log
