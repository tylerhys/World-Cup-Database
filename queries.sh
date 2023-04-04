#! /bin/bash

PSQL="psql --username=freecodecamp --dbname=worldcup --no-align --tuples-only -c"

# Do not change code above this line. Use the PSQL variable above to query your database.

echo -e "\nTotal number of goals in all games from winning teams:"
echo "$($PSQL "SELECT SUM(winner_goals) FROM games")"

echo -e "\nTotal number of goals in all games from both teams combined:"
echo "$($PSQL "SELECT SUM(winner_goals+opponent_goals) from games")"

echo -e "\nAverage number of goals in all games from the winning teams:"
echo "$($PSQL "SELECT AVG(winner_goals) FROM games")"

echo -e "\nAverage number of goals in all games from the winning teams rounded to two decimal places:"
echo "$($PSQL "SELECT ROUND(AVG(winner_goals),2) FROM games")"

echo -e "\nAverage number of goals in all games from both teams:"
echo "$($PSQL "SELECT AVG(winner_goals+opponent_goals) from games")"

echo -e "\nMost goals scored in a single game by one team:"
echo "$($PSQL "SELECT winner_goals from games order by winner_goals desc limit 1")"

echo -e "\nNumber of games where the winning team scored more than two goals:"
echo "$($PSQL "select count(*) from games where winner_goals > 2")"

echo -e "\nWinner of the 2018 tournament team name:"
echo "$($PSQL "select b.name from games a left join teams b on a.winner_id = b.team_id where a.round = 'Final' and a.year = 2018")"

echo -e "\nList of teams who played in the 2014 'Eighth-Final' round:"
echo "$($PSQL "select b.name from games a left join teams b on a.winner_id = b.team_id or a.opponent_id = b.team_id where a.round = 'Eighth-Final' and a.year = 2014 order by name;")"

echo -e "\nList of unique winning team names in the whole data set:"
echo "$($PSQL "select distinct b.name from games a left join teams b on a.winner_id = b.team_id order by b.name;")"

echo -e "\nYear and team name of all the champions:"
echo "$($PSQL "select a.year,b.name from games a left join teams b on a.winner_id = b.team_id where round = 'Final' order by a.year;")"

echo -e "\nList of teams that start with 'Co':"
echo "$($PSQL "select name from teams where name like 'Co%'")"
