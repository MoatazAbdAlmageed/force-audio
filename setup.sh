# Ensure ForceAudio directory exists
mkdir -p ForceAudio

# Move project files if they exist
mv *.csproj ForceAudio/ 2>/dev/null || true
mv Program.cs ForceAudio/ 2>/dev/null || true

# Verify if files were moved
if [ ! -f "ForceAudio/ForceAudio.csproj" ] || [ ! -f "ForceAudio/Program.cs" ]; then
  echo "Error: Required project files not found in ForceAudio!"
  exit 1
fi

echo "Project files moved to ForceAudio/"
