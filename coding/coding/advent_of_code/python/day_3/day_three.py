"""One elf loaded all the rucksacks for Jungle Journey. He screwed up. He didn't follow packing
instructions, things need to be rearranged.

Each rucksack has two large compartments.
All items of a given type are meant to go into exactly one of the two compartments.

Elves made a list of items currently in each rucksack (puzzle input).

Item types identified by a single lowercases or uppercase letter 
(`A` and `a` are different items)

One line = One rucksack contents
First half of line  = compartment 1
Second half of line = compartment 2

Item priority: 
    a-z = 1-26
    A-Z = 27-52

Find the item type that appears in both compartments of each rucksack.
What is the sum of the priorities of those item types?

"""
import string


priority = {c: n for c, n in zip(string.ascii_letters, range(1, 53))}


def split_bag(bag):
    compartment_1, compartment_2 = (
        bag[: int(len(bag) / 2)],
        bag[int(len(bag) / 2) : len(bag)],
    )
    return compartment_1, compartment_2


def find_common_items(c1, c2, common_items):
    for char in set(c1):
        if char in c2:
            common_items.append(char)
    # return shared_items


def get_priority(char):
    return string.ascii_letters.index(char) + 1


def load_data():
    with open("./input.txt") as f:
        data = f.readlines()
        for i, l in enumerate(data):
            data[i] = l.strip("\n")
    return data


def main():
    common_items = []
    bags = load_data()
    print(f"Number of rucksacks: {len(bags)}")
    for bag in bags:
        c1, c2 = split_bag(bag)
        find_common_items(c1, c2, common_items)

    # Priority determined by get_priority()
    priorities = [get_priority(c) for c in common_items]
    print(f"Sum of item priority of common items: {sum(priorities)}")

    # Priority determined with `priority` dict
    p = sum([priority[item] for item in common_items])
    print(f"Priority determined with dict: {p}")


# incorrect: 10433
# incorrect:   948
# Correct: 7785 - They wanted only the unique items

if __name__ == "__main__":
    main()
