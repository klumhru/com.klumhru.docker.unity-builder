#!/bin/sh

# Test that we have the environment variables we need
if [ -z "$UNITY_USERNAME" ]; then
    echo "UNITY_USERNAME environment variable not set"
    exit 1
fi

if [ -z "$UNITY_PASSWORD" ]; then
    echo "UNITY_PASSWORD environment variable not set"
    exit 1
fi

if [ -z "$UNITY_SERIAL" ]; then
    echo "UNITY_SERIAL environment variable not set"
    exit 1
fi

# Activate unity
echo "Activating Unity"
/opt/unity/Editor/Unity -batchmode -username "${UNITY_USERNAME}" -serial "${UNITY_SERIAL}" -password "${UNITY_PASSWORD}" -quit

# Run unity build

# Deactivate unity
echo "Deactivating Unity"
/opt/unity/Editor/Unity -batchmode -returnlicense -username "${UNITY_USERNAME}" -password "${UNITY_PASSWORD}" -quit
