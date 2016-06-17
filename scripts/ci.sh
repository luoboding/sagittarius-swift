#!/usr/bin/env bash
set -e
xctool -workspace sagittarius-swift.xcworkspace -scheme sagittarius-swift test
