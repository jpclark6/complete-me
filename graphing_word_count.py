filename = "./word_count.txt"
file = open(filename, "r")

letters = []
numbers = []

for line in file:
    letter, number = line.split("\t")
    letters.append(letter)
    numbers.append(int(number))

import numpy as np
import matplotlib.pyplot as plt

fig, ax = plt.subplots(facecolor='#fdfdfe')
ax.set_facecolor('powderblue')

i = 0
colo = []
for number in numbers:
    colo.append([number / max(numbers), .5, .5])

barlist=ax.bar(letters, numbers, color=colo)
ax.set_xlabel('Letter', fontsize=14)
ax.set_ylabel('Words in Dictionary Starting with Letter', fontsize=14)
ax.set_title("Word Count Per Letter in Dictionary", fontsize=18, fontweight='bold')
plt.show()
