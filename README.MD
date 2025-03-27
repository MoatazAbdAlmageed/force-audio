# ForceAudio (Windows Volume Lock)

This is a simple C# console app that forces the system volume to stay at **50%**. It runs in the background and resets the volume every second if changed.

## Features
✅ Runs in the background
✅ Forces volume to 50%
✅ Uses **NAudio** for audio control
✅ GitHub Actions workflow to build Windows `.exe`

---

## 📌 Installation

### **1. Clone the repository**
```sh
git clone https://github.com/your-username/force-audio.git
cd force-audio
```

### **2. Install dependencies**
```sh
dotnet add package NAudio
```

### **3. Build the project**
```sh
dotnet publish -c Release -r win-x64 --self-contained true
```

### **4. Run the app**
```sh
cd bin/Release/net6.0/win-x64/publish/
./ForceAudio.exe
```

---

## 📌 GitHub Actions (Automatic Build)
When you push to GitHub, it will automatically build the Windows `.exe`. You can download the build from GitHub Actions.

---

## 📌 Source Code

### **Program.cs**
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

      - name: Install Dependencies
        run: dotnet add package NAudio

      - name: Build
        run: dotnet publish -c Release -r win-x64 --self-contained true

      - name: Upload EXE
        uses: actions/upload-artifact@v3
        with:
          name: Windows-App
          path: bin/Release/net6.0/win-x64/publish/
```

---

## 📌 Notes
- This app is designed for **Windows** only.
- If you need it to **autostart on boot**, create a shortcut in `shell:startup`.
- If you want a **silent version**, I can modify it to run as a Windows Service.

---

Let me know if you need changes! 🚀
