# Mastermind: Terminal Deduction Engine

A sophisticated, object-oriented implementation of the classic Mastermind board game. This engine features a robust two-pass logic system to handle complex duplicate color scenarios with 100% accuracy.

---

## 🚀 Engine Features

* **Two-Pass Logic Controller:** Eliminates "double-dipping" errors by prioritizing exact matches first.
* **State-Based Architecture:** Tracks every hole and row independently using Ruby Structs.
* **Auto-Priority Feedback:** Feedback dots are automatically sorted so the player never knows which specific hole triggered which hint.
* **Buffer-Style Input:** Load colors one by one by typing the name and hitting Enter.

---

## 🎨 Color Palette Reference

The engine identifies the following colors. To play, type the name of the color into the terminal and press Enter.

| Color | Input String | README Preview |
| :--- | :--- | :---: |
| **Red** | `red` | $\color{#ff0000}{\Large\bullet}$ |
| **Green** | `green` | $\color{#00ff00}{\Large\bullet}$ |
| **Blue** | `blue` | $\color{#0000ff}{\Large\bullet}$ |
| **Yellow** | `yellow` | $\color{#ffff00}{\Large\bullet}$ |
| **Purple** | `purple` | $\color{#8000ff}{\Large\bullet}$ |
| **Orange** | `orange` | $\color{#ff8700}{\Large\bullet}$ |

---

## 🧠 Feedback Legend

The engine provides hints using a specialized symbol system to help you crack the code:

| Symbol | Hint Type | Description |
| :---: | :--- | :--- |
| ● | **Match** | **White Dot:** Correct color in the **exact right position**. |
| ⦿ | **Exists** | **Dot in Hole:** Correct color, but in the **wrong position**. |
| ○ | **Empty** | **Empty Hole:** This specific guess is not in the secret code. |



---

## ⚙️ Installation & Execution

The game is designed to be run as a standalone binary from the console.

1. **Permissions:** Navigate to your project directory and grant execution permissions to the file in the `/bin` destination:
   ```bash
   chmod +x bin/mastermind
