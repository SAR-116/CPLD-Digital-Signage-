# 📟 CPLD Digital Signage  
### **Development of an LED Display Billboard Using an CPLD Board**

A compact and low-cost **digital signage system** built using an **LP-2900 CPLD development board**, **Verilog HDL**, and an **8×8 LED dot-matrix display**. The system supports **scrolling text**, **static messages**, directional **arrow animations**, and a **walking-person animation**, all controlled by simple switches.

---

## 🎥 Demo Video 
Google Drive:  
https://drive.google.com/drive/folders/1DNTFCHYRaVswgt7Q_mbn5U4-l31f4bF7

---

## ⭐ Project Features

- ✔ Static messages  
  - **OPEN**, **ENTRY**, **EXIT**, **STOP**  
- ✔ Text scrolling  
  - Left / Right / Up / Down  
- ✔ Animated walking person (Frame-based)  
- ✔ Smooth multiplexed LED display  
- ✔ Switch-based user interface  
- ✔ Clock-divided animation & scrolling engine  
- ✔ Fully simulated on **Quartus II**  

---

## 🧰 Hardware Used

| Component | Purpose |
|----------|---------|
| **LP-2900 CPLD Development Board** | Main programmable logic controller |
| **8×8 LED Dot-Matrix Display** | Visual output |
| **SW1–SW8** | Mode selection |
| **1 kHz clock input** | Multiplexing |

---

## 🎚️ Switch Functions (Mode Control)

| Switch | Function |
|--------|----------|
| **SW1** | Show **ENTRY** |
| **SW2** | Show **EXIT** |
| **SW3** | Scroll Left |
| **SW4** | Scroll Right |
| **SW5** | Scroll Up |
| **SW6** | Scroll Down |
| **SW7** | Show **STOP** |
| **SW8** | Walking Person Animation |

---

## ▶️ How to Run the Project

### **1. Open Quartus II**
- Import `open.v`
- Assign pins to match LP-2900 board layout
- Compile the project  
- Generate the `.pof` file

### **2. Program the CPLD**
Use JTAG or onboard programmer to upload the `.pof`.

### **3. Operate Using Switches**
Toggle SW1–SW8 to change modes:
- ENTRY / EXIT / STOP  
- Scrolling (any direction)  
- Walking animation  

---

## 🧪 Simulation Details

Simulation was performed using **Quartus Waveform Editor**.

Validated:
- Column scanning logic  
- Row/column multiplexing  
- Scroll counter behavior  
- Frame animation timing  
- Mode switching  
- Reset response  

Simulation screenshots are included in the `/simulation` folder.

---

## 🔧 Technical Highlights

### **1. LED Multiplexing**
Only one column is enabled at a time → rapid switching creates stable visual output.

### **2. Scroll Engine**
Smooth horizontal/vertical scrolling handled via counter wrapping.

### **3. Animation Engine**
Frames stored in memory:

| Animation | Memory Index |
|-----------|--------------|
| Frame 1 | 126–133 |
| Frame 2 | 134–141 |
| Frame 3 | 142–149 |
| Frame 4 | 150–157 |

### **4. Clock Division**
Three internal clocks:
- Column refresh clock  
- Scroll-speed clock  
- Animation frame clock  

---

## 📈 Performance Summary

- Smooth, flicker-free display  
- Fast response to input  
- Low resource utilization on CPLD  
- Stable operation over long durations  
- Flexible, modular Verilog architecture  

---

## 🚀 Future Enhancements
 
- Expand to 16×16 or 32×8 LED matrix    
- Brightness control (PWM)  
- Sync multiple boards for multi-panel signage  

---

## 👨‍🏫 Academic Info

Developed for:  
**EEE 304 – Digital Electronics Laboratory (July 2024)**  
**Bangladesh University of Engineering and Technology (BUET)**  

Group Members:
- Md. Kaidul Islam  
- Sadaf Shafin Chowdhury  
- Shohan Ahmed Rifat  
- Fabliha Labiba  

---

## 📄 License
**MIT License**
---



