""" Rock Paper Scissors.
You get an encrypted strat guide (puzzle input), 
First colulmn: What your opponent is going to play. 
    A = rock
    B = paper
    C = scissors
Second column (guessed) is what should be played in response.
    X = rock
    Y = paper
    Z = scissors
Scoring:
    If you win with rock     : 1pt
    If you win with paper    : 2pt
    If you win with scissors : 3pt
Plus the score of the outcome: 
    Lose                     : 0pt
    Draw                     : 3pt
    win                      : 6pt

Total score = sum of score for each round

"""

points_hand = {
    "rock": 1,
    "paper": 2,
    "scissors": 3,
}

points_outcome = {
    "loss": 0,
    "draw": 3,
    "win": 6,
}

challenger = {
    "A": "rock",
    "B": "paper",
    "C": "scissors",
}

user = {
    "X": "rock",
    "Y": "paper",
    "Z": "scissors",
}


def evaluate_round(challenger_hand, user_hand):
    user_hand = user[user_hand]
    challenger_hand = challenger[challenger_hand]
    if user_hand == challenger_hand:
        return points_hand[user_hand] + points_outcome["draw"]
    elif user_hand == "rock" and challenger_hand == "paper":
        return points_hand[user_hand] + points_outcome['loss']
    elif user_hand == "paper" and challenger_hand == "scissors":
        return points_hand[user_hand] + points_outcome['loss']
    elif user_hand == "scissors" and challenger_hand == "rock":
        return points_hand[user_hand] + points_outcome['loss']
    else:
        return points_hand[user_hand] + points_outcome["win"]


def load_data():
    with open("./input.txt") as f:
        data = f.readlines()
        for idx, line in enumerate(data):
            data[idx] = line.strip("\n")
    return data


def main():
    data = load_data()
    total_score = 0
    for round in data:
        hands = round.split()
        total_score += evaluate_round(hands[0], hands[1])
    print(f"Total score evaluated from all hands: {total_score}")
    # Correct: 14297


if __name__ == "__main__":
    main()

