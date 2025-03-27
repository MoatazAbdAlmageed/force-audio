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
