# ForceAudio 🎵🔒 (Windows Volume Lock)

🚨 **Why did I make this?** 🚨

Meet **Belal**, my 4-year-old sound engineer-in-the-making 🎧. He loves watching YouTube on **his PC** while I sit on **my laptop** at our large table. The problem? He **ALWAYS** cranks the volume up to the max! 😵‍💫🔥

I needed a way to **lock the volume at 50%** to save my ears (and my sanity). So, **ForceAudio** was born! 🚀

## Features
✅ Runs silently in the background 🕵️‍♂️
✅ Forces volume to 50% 🔊➡️🔇
✅ Uses **NAudio** for audio control 🎼
✅ GitHub Actions workflow to auto-build Windows `.exe`

---

## 📌 Folder Structure
```
/force-audio
  ├── ForceAudio/
  │   ├── ForceAudio.csproj  <-- Project file
  │   ├── Program.cs         <-- Main code file
  ├── .github/
  │   ├── workflows/
  │       ├── build.yml  <-- GitHub Actions workflow
  ├── README.md
  ├── setup.sh  <-- Bash script to set up the project
```

---

## 📌 Installation

### **1. Clone the repository and run setup script**
```sh
git clone https://github.com/your-username/force-audio.git
cd force-audio
chmod +x setup.sh
./setup.sh
```

### **2. Build the project**
```sh
dotnet publish -c Release -r win-x64 --self-contained true
```

### **3. Run the app**
```sh
cd bin/Release/net6.0/win-x64/publish/
./ForceAudio.exe
```

---

## 📌 GitHub Actions (Automatic Build)
When you push to GitHub, it will automatically build the Windows `.exe`. You can download the build from GitHub Actions.

---

## 📌 setup.sh (Bash Script to Set Up Project)
```sh
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
```

---

## 📌 Source Code

### **ForceAudio/Program.cs**
```csharp
using System;
using System.Threading;
using NAudio.CoreAudioApi;

class Program
{
    static void Main()
    {
        Console.WriteLine("Audio Lock: Forcing volume to 50%...");

        var deviceEnumerator = new MMDeviceEnumerator();
        var device = deviceEnumerator.GetDefaultAudioEndpoint(DataFlow.Render, Role.Multimedia);

        while (true)
        {
            float currentVolume = device.AudioEndpointVolume.MasterVolumeLevelScalar;
            if (currentVolume > 0.5f)
            {
                device.AudioEndpointVolume.MasterVolumeLevelScalar = 0.5f;
                Console.WriteLine("Volume reset to 50%.");
            }
            Thread.Sleep(1000); // Check every second
        }
    }
}
```

---

## 📌 GitHub Actions Workflow

`.github/workflows/build.yml`
```yaml
name: Build Windows EXE

on: [push, pull_request]

jobs:
  build:
    runs-on: windows-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Setup .NET
        uses: actions/setup-dotnet@v3
        with:
          dotnet-version: 6.0.x

      - name: Run Setup Script
        run: |
          chmod +x setup.sh
          ./setup.sh

      - name: Build
        run: dotnet publish -c Release -r win-x64 --self-contained true

      - name: Upload EXE
        uses: actions/upload-artifact@v4
        with:
          name: Windows-App
          path: ForceAudio/bin/Release/net6.0/win-x64/publish/
```

---

## 📌 Notes
- This app is designed for **Windows** only.
- If you need it to **autostart on boot**, create a shortcut in `shell:startup`.
- If you want a **silent version**, I can modify it to run as a Windows Service.

---

🎉 Thanks to **Belal** for inspiring this project (and for keeping my ears safe)! 🚀😂
