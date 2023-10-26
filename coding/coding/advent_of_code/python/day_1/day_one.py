"""Find the top three elves carrying the most calories. How many calories are they carrying?"""


def split_ownership(data):
    elf = []
    for idx, meal in enumerate(data):
        if meal == '':
            elves[idx] = sum(elf)
            elf = []
            continue
        elf.append(int(meal))
    return elves


def clean_data(data):
    for idx, item in enumerate(data):
        data[idx] = item.strip('\n')
    return data


def load_data():
    with open('./input.txt') as f:
        data = f.readlines()
        return data


elves = {}
data = load_data()
cleaned_data = clean_data(data)
elf_dict = split_ownership(cleaned_data)

vals = [*elf_dict.values()]
vals.sort(reverse=True)

cals = vals[0] + vals[1] + vals[2]

print(f"Top three elves are carrying {cals} calories.")




