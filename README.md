# pegasus-radar-full

PegasusRF is a powerful tool for penetration testing Radar Full and various cybersecurity tasks.

# Author

Muhammad Sobri Maulana

## Tutorial: Getting Started with HackRF for Penetration Testing

### Prerequisites
- **HackRF Device:** Ensure you have a HackRF One device.
- **Computer:** A computer with a compatible operating system (Windows, macOS, Linux).
- **Software:** Install GNU Radio and HackRF tools.

### Step 1: Install GNU Radio and HackRF Tools

#### For Linux:
bash sudo apt-get update sudo apt-get install gnuradio gr-osmosdr hackrf


#### For macOS:
You might need to use Homebrew:
bash brew install gnuradio brew install gr-osmosdr brew install hackrf

#### For Windows:
Download and install the necessary software from the official GNU Radio and HackRF websites.

### Step 2: Verify Installation
Open a terminal and type:
bash hackrf_info


You should see information about your HackRF device if everything is set up correctly.

### Step 3: Set Up a Simple Receiver
1. **Create a new GNU Radio flowgraph:**
   - Open GNU Radio Companion (GRC).
   - Create a new flowgraph.
   - Add the necessary blocks:
     - **HackRF Source:** Right-click in the workspace and add a HackRF Source.
     - **QT GUI Time Sink:** Right-click and add a QT GUI Time Sink.
     - **FFT:** Add an FFT block.
     - **Throttle:** Add a Throttle block.
     - **Low Pass Filter:** Add a Low Pass Filter block.
   - Connect the blocks:
     - Connect the HackRF Source to the Low Pass Filter.
     - Connect the Low Pass Filter to the FFT.
     - Connect the FFT to the QT GUI Time Sink.
     - Connect the Throttle block between the HackRF Source and the Low Pass Filter to control the data rate.
   - Configure the blocks:
     - Double-click on the HackRF Source and set the Sample Rate to 20e6.
     - Double-click on the Low Pass Filter and set the Cutoff Frequency to 2e6.
     - Double-click on the Throttle block and set the Sample Rate to 2e6.
   - Run the flowgraph:
     - Click the Execute button to run the flowgraph.
     - You should see the spectrum in the QT GUI Time Sink.

### Step 4: Capture and Analyze Signals
1. **Capture Signals:**
   - Use the QT GUI Time Sink to capture signals of interest.
   - You can save the captured data to a file for later analysis.
2. **Analyze Signals:**
   - Use tools like GNU Radio's QT GUI Frequency Sink to analyze the frequency spectrum.
   - Use QT GUI Waterfall Sink to visualize the signal over time.

### Step 5: Transmit Signals
1. **Create a new flowgraph for transmission:**
   - Open a new flowgraph in GRC.
   - Add the necessary blocks:
     - **WX GUI Scope:** Right-click and add a WX GUI Scope.
     - **Throttle:** Add a Throttle block.
     - **Signal Source:** Add a Signal Source.
     - **HackRF Sink:** Add a HackRF Sink.
   - Connect the blocks:
     - Connect the Signal Source to the Throttle.
     - Connect the Throttle to the HackRF Sink.
     - Connect the HackRF Sink to the WX GUI Scope.
   - Configure the blocks:
     - Double-click on the Signal Source and set the Sample Rate to 20e6 and the Frequency to 1e6 (1 MHz).
     - Double-click on the Throttle block and set the Sample Rate to 2e6.
     - Double-click on the HackRF Sink and set the Sample Rate to 20e6.
   - Run the flowgraph:
     - Click the Execute button to run the flowgraph.
     - You should see the signal being transmitted in the WX GUI Scope.

### Step 6: Advanced Techniques
1. **Replay Attacks:**
   - Capture a signal using the receiver flowgraph.
   - Save the captured signal to a file.
   - Use the File Source block in a new flowgraph to replay the captured signal through the HackRF Sink.
2. **Signal Modulation/Demodulation:**
   - Use GNU Radio's modulation blocks (e.g., GFSK Mod, QPSK Mod) to modulate signals.
   - Use demodulation blocks (e.g., GFSK Demod, QPSK Demod) to demodulate signals.
3. **Packet Injection:**
   - Use tools like scapy or GNU Radio to create custom packets.
   - Transmit the packets using the HackRF Sink.
