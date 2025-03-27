#!/bin/bash

# Ensure .NET is installed
if ! command -v dotnet &> /dev/null
then
    echo "Error: .NET SDK is not installed. Please install .NET 6+ and retry."
    exit 1
fi

# Create project folder and initialize .NET project
echo "Setting up ForceAudio project..."
dotnet new console -n ForceAudio

# Move Program.cs to the correct directory if it exists in the root
if [ -f "Program.cs" ]; then
    mv Program.cs ForceAudio/
    echo "Moved Program.cs to ForceAudio directory."
fi

cd ForceAudio

echo "Installing dependencies..."
dotnet add package NAudio

echo "Setup complete! You can now build and run the project."