import 'dart:io';

// these are the only moves used in the game
const List<String> vMoves = ['rock', 'paper', 'scissors'];
/// Print the title banner before the game start
void titleBanner() {
  print('===== ROCK, PAPER, SCISSORS  GAME=====');
}
/// print the 30 blank line to hide the move of player1
void clearSascreen() {
  for (int i = 0; i < 30; i++) {
    print('');
  }
}
/// this method asked the player name ang give default name if player didnt put the name
String getPName(int PNumber) {
  stdout.write('Enter Player $PNumber name: ');

  String? input = stdin.readLineSync();
  String? name = input?.trim();

  if (name == null || name.isEmpty) {
    print('(No name entered. Using "Player $PNumber".)');
    return 'Player $PNumber';
  }

  return name;
}
/// this method check if the move valid and return it to lowercase
String? VMove(String? input) {
  if (input == null) {
    return null;
  }

  String move = input.trim().toLowerCase();

  if (vMoves.contains(move)) {
    return move;
  }

  return null;
}
/// this method asked the player, till he/she give the valid move
String getMove(String pName) {
  String? move;

  while (move == null) {
    stdout.write('$pName, enter your move (rock/paper/scissors): ');

    String? input = stdin.readLineSync();
    move = VMove(input);

    if (move == null) {
      print('Invalid move. Please type rock, paper, or scissors.');
    }
  }

  return move;
}

///this part decide who wins or draw in round
String? decideWinner(
  String playerOneName,
  String playerOneMove,
  String playerTwoName,
  String playerTwoMove,
) {
  if (playerOneMove == playerTwoMove) {
    return null;
  }

  if (playerOneMove == 'rock' && playerTwoMove == 'scissors') {
    return playerOneName;
  } else if (playerOneMove == 'rock' && playerTwoMove == 'paper') {
    return playerTwoName;
  } else if (playerOneMove == 'paper' && playerTwoMove == 'rock') {
    return playerOneName;
  } else if (playerOneMove == 'paper' && playerTwoMove == 'scissors') {
    return playerTwoName;
  } else if (playerOneMove == 'scissors' && playerTwoMove == 'paper') {
    return playerOneName;
  } else {
    return playerTwoName;
  }
}

void main() {
  titleBanner();

  String playerOneName = getPName(1);
  String playerTwoName = getPName(2);

  int playerOneScore = 0;
  int playerTwoScore = 0;
  int roundNumber = 1;
  String? playAgain;

  do {
    print('--- Round $roundNumber ---');
    String playerOneMove = getMove(playerOneName);
    // this part vclear the screen so player2 cant see player 1 move
    clearSascreen();

    String playerTwoMove = getMove(playerTwoName);

    print(
      '$playerOneName chose $playerOneMove. '
      '$playerTwoName chose $playerTwoMove.',
    );

    String? winner = decideWinner(
      playerOneName,
      playerOneMove,
      playerTwoName,
      playerTwoMove,
    );
    if (winner == playerOneName) {
      playerOneScore++;
    } else if (winner == playerTwoName) {
      playerTwoScore++;
    }

    String result = winner ?? "It's a draw!";

    if (winner != null) {
      result = '$winner wins the round!';
    }

    print('Result: $result');

    print(
      'Score -> $playerOneName: $playerOneScore | '
      '$playerTwoName: $playerTwoScore',
    );

    stdout.write('Play again? (y/n): ');
    playAgain = stdin.readLineSync()?.trim().toLowerCase();
    roundNumber++;
  } while (playAgain != 'n');

  print('===== FINAL SCORE =====');
  print(
    '$playerOneName: $playerOneScore | '
    '$playerTwoName: $playerTwoScore',
  );

  if (playerOneScore > playerTwoScore) {
    print('Overall winner: $playerOneName');
  } else if (playerTwoScore > playerOneScore) {
    print('Overall winner: $playerTwoName');
  } else {
    print("Overall winner: It's a tie!");
  }
}
