#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
clear=$($PSQL "truncate games,teams")
echo -e "Tables Games and Teams have been cleared.\n"

cat games.csv | while IFS="," read year round winner opponent winner_goals opponent_goals
do
  # Insert winner into column name in table Teams
  if [[ $winner != "winner" ]]
    then
    winner_id=$($PSQL "SELECT team_id from teams where name = '$winner'")
    if [[ -z $winner_id ]]
      then
      team=$($PSQL "INSERT INTO teams(name) values('$winner')")
      if [[ $team == 'INSERT 0 1' ]]
        then
        echo $winner has been added into teams.
        winner_id=$($PSQL "SELECT team_id from teams where name = '$winner'")
      fi
    fi
  fi    

  # Insert opponent into column name in table Teams
  if [[ $opponent != "opponent" ]]
    then
    opponent_id=$($PSQL "SELECT team_id from teams where name = '$opponent'")
    if [[ -z $opponent_id ]]
      then
      team=$($PSQL "INSERT INTO teams(name) values('$opponent')")
      if [[ $team == 'INSERT 0 1' ]]
        then
        echo $opponent has been added into teams.
        opponent_id=$($PSQL "SELECT team_id from teams where name = '$opponent'")
      fi
    fi
  fi    

  if [[ $year != 'year' && $round  != 'round' ]]
  then
  entry=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals)
   values('$year','$round','$winner_id','$opponent_id','$winner_goals','$opponent_goals')")
    if [[ $entry = 'INSERT 0 1' ]]
    then
    echo $year,$round,$winner_id,$opponent_id,$winner_goals,$opponent_goals has been inserted into games.
    fi
  fi 
done

echo -e "\nJob is Completed."
