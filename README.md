# Mastermind: Terminal Deduction Engine

A sophisticated, object-oriented implementation of the classic Mastermind board game. This engine features a robust two-pass logic system to handle complex duplicate color scenarios with 100% accuracy.

---

## 🚀 Engine Features

* **Two-Pass Logic Controller:** Eliminates "double-dipping" errors. The engine identifies exact matches first, "consumes" those pegs, and only then calculates existence matches for the remaining slots.
* **State-Based Architecture:** Built using Ruby Structs to track the state of every hole and row independently.
* **Auto-Priority Feedback:** Feedback strings are automatically sorted so that 'Matches' always appear first, preventing the player from knowing which specific hole triggered which hint.
* **Buffer-Style Input:** A unique input system that allows players to load colors into the board one hole at a time.

---

## 🎮 How to Play

The game is played hole-by-hole within each row:

1.  **Select Color:** Type the name of the color you wish to place (e.g., `red`).
2.  **Load Hole:** Press **Enter**. The engine loads that color into the next available hole in your current guess.
3.  **Complete Guess:** Repeat until all 4 holes are filled. The engine will then calculate your feedback.

---

## 🧠 Feedback Legend

The engine provides hints using a specialized symbol system to help you crack the code:

| Symbol | Hint Type | Description |
| :--- | :--- | :--- |
| **●** | **Match** | **White Dot:** Correct color in the **exact right position**. |
| **⦿** | **Exists** | **Dot in Hole:** Correct color, but in the **wrong position**. |
| **○** | **Empty** | **Empty Hole:** This specific guess is not in the secret code. |



---

## 🎨 Color Palette & ANSI Values

The engine renders the following colors using ANSI escape codes. These are the strings recognized by the input parser:

| Color | ANSI Escape Code | Terminal Output Example |
| :--- | :--- | :--- |
| **Red** | `\e[31m` | <span style="color:red">■</span> |
| **Green** | `\e[32m` | <span style="color:green">■</span> |
| **Blue** | `\e[34m` | <span style="color:blue">■</span> |
| **Yellow** | `\e[33m` | <span style="color:yellow">■</span> |
| **Purple** | `\e[35m` | <span style="color:purple">■</span> |
| **Orange** | `\e[38;5;208m` | <span style="color:orange">■</span> |

*Note: Use `\e[0m` to reset formatting after printing.*

---

## ⚙️ Installation & Execution

The game is designed to be run as a standalone binary from the console.

1. **Permissions:** Navigate to your project directory and grant execution permissions to the file in the `/bin` destination:
   ```bash
   chmod +x bin/mastermind
