---
layout: post
title:  "Invisible WORDs"
date:   2025-05-02 23:55:00 -0400
categories: PICO-challenge forensics hard 
tags: pico CTF writeup bmp zip
---

### CHALLENGE DESCRIPTION
![](assets/img/pico/Invisible-WORDs/1.png)

### SOLUTION 
After trying some `zsteg, exiftool, binwalk, steghide, strings,...` and have nothing useful.

Let see its content in hex by `hexeditor` or `cyberchef`
![](assets/img/pico/Invisible-WORDs/2.png)

We can see `PK`, it reminds me of `ZIP` file. Let search it, and we can see `magic number` of it is `50 4B 03 04`. Let write a script to loop through 4 bytes and copy 2 bytes of it.
```python
def extract_2_bytes_every_4(input_file_path, output_file_path):
    with open(input_file_path, 'rb') as infile, open(output_file_path, 'wb') as outfile:
        while True:
            chunk = infile.read(4)
            if len(chunk) < 4:
                break  # End of file or incomplete 4-byte block
            outfile.write(chunk[:2])  # Write only the first 2 bytes of every 4

extract_2_bytes_every_4('output.bmp', 'x')
```

After running the code, we have the output, `binwalk -e [file]` we can see the file hidden in it. Open the file and search for the flag.
![](assets/img/pico/Invisible-WORDs/3.png)
