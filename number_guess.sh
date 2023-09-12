#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=postgres -t --no-align"

# Define the secret number globally
R_NUMBER=$((1 + RANDOM % 1000))

# Declare USER_INFO as a global variable
USER_INFO=""
USER_INPUT=""

# Prompt to enter username
echo "Enter your username: "

# Function to retrieve user info
REQUEST_USER_INFO() {
  local GAMES_PLAYED
  local BEST_GAME
  
  while true; do
    read USER_INPUT
    local USER_INPUT_LENGTH=${#USER_INPUT}

    # Check if the username is correct length (not more than 22 char)
    if [[ "$USER_INPUT_LENGTH" -lt 23 ]]; then
      SQL_QUERY="SELECT user_id FROM usernames WHERE username = '$USER_INPUT'"
      USER_INFO=$($PSQL -c "$SQL_QUERY" 2>/dev/null)
      # Check if any rows were returned
      if [ -z "$USER_INFO" ]; then
        echo "Welcome, $USER_INPUT! It looks like this is your first time here."
        INSERT_NEW_USER=$($PSQL -c "INSERT INTO usernames(username) VALUES('$USER_INPUT')")
        break
      else
        # Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.
        GAMES_PLAYED=$($PSQL -c "SELECT COUNT(game_id) FROM usernames INNER JOIN stats USING(user_id) WHERE username = '$USER_INPUT'")
        BEST_GAME=$($PSQL -c "SELECT MIN(guesses) FROM usernames INNER JOIN stats USING(user_id) WHERE username = '$USER_INPUT'")
        
        # Use 'tr' to remove extra spaces
        GAMES_PLAYED_CLEANED=$(echo "$GAMES_PLAYED" | tr -s ' ')
        BEST_GAME_CLEANED=$(echo "$BEST_GAME" | tr -s ' ')
        
        echo "Welcome back, $USER_INPUT! You have played $GAMES_PLAYED_CLEANED games, and your best game took $BEST_GAME_CLEANED guesses."
        break
      fi
    else
      echo "The username must be less than 23 characters. Please try again."
    fi
  done
}

GAME_GUESS() {
  # Initialize the guess count
  GUESS_COUNT=0
  # Start the guessing game
  echo "Guess the secret number between 1 and 1000:"
  while true; do
      # Ask the user to guess the secret number
      read USER_GUESS

      # Check if the user's input is a valid integer
      if [[ ! $USER_GUESS =~ ^[0-9]+$ ]]; then
          echo "That is not an integer, guess again:"
          continue
      fi

      # Increment the guess count by 1
      ((GUESS_COUNT++))

      # Compare the user's guess with the global secret number
      if ((USER_GUESS < R_NUMBER)); then
          echo "It's higher than that, guess again:"
      elif ((USER_GUESS > R_NUMBER)); then
          echo "It's lower than that, guess again:"
      else
          # The user guessed the secret number correctly
          echo "You guessed it in $GUESS_COUNT tries. The secret number was $R_NUMBER. Nice job!"
          if [ -z "$USER_INFO" ]; then
            USER_ID=$($PSQL -c "SELECT user_id FROM usernames WHERE username = '$USER_INPUT'")
            INSERT_GAME_LOG=$($PSQL -c "INSERT INTO stats(user_id, guesses) VALUES($USER_ID, $GUESS_COUNT)")
            break
          else
            INSERT_GAME_LOG=$($PSQL -c "INSERT INTO stats(user_id, guesses) VALUES($USER_INFO, $GUESS_COUNT)")
            break
          fi
      fi
  done
}

# Start the program
REQUEST_USER_INFO
GAME_GUESS
