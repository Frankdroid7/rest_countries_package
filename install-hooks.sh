#!/bin/sh

# Script to install git hooks

echo "Installing git hooks..."

# Copy pre-commit hook
cp hooks/pre-commit .git/hooks/pre-commit

# Make it executable
chmod +x .git/hooks/pre-commit

echo " Git hooks installed successfully!"
echo "The pre-commit hook will now:"
echo "  - Format all Dart files automatically"
echo "  - Run dart analyze to check for issues"
echo "  - Prevent commits if there are analysis errors"
