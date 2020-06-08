#!/bin/bash

#############################
#
# Made by: Daniel Torma
# Latest update: 07 06 2020
# Version: 0.3
#
# To do list:
#   - Could make the expiration_date variables used in the main block to actually be an array by itself so I don't need to check for that each cycle - more memory use but speed it up! (maybe then just split the default array into the variable name array and an expiration date array)
#   - N/A
#   - N/A
#   - N/A
#
#############################

#--------#> Variables set so I can colour the bash output to a desired colour for emphasis
ncl=$(tput sgr0); # no colour
xcl="" # yes colour
rcl="\e[48;5;009m" # red yclcolour
ocl="\e[48;5;178m" # orange colour 
gcl="\e[48;5;040m" # green colour
bcl="\e[48;5;027m" # blue colour

#--------#> Date needed to calculate how much it needs for the items to spoil
todays_date=$(date --date="yesterday" "+%s")

#--------#> Define array for the lines within the file
item_array=()

#--------#> Defne the array which will contain all the "from" and "to" dates by default
spoil_range=( 3 7 14 )

#--------#> "f" as in "full" is an additional argument that can be added to the script to print out more info about it, or rather, the "full range" of it (although, it will not print out anything that will expire in 366 days or later)
if [[ "$1" == "f" ]]
then
	spoil_range+=( 30 365 )
fi

#--------#> This `while` block simply reads all the lines from the items_list.txt file (currently still an absolute path for testing purposes) and adds it to the item_array array defined above
while IFS= read -r each
	do item_array+=( "$each" )
done < /home/torma/Scripts/expiration_date_script/items_list.txt

#--------#> Sets the start date at 0 for the "from to" range in the next block's if statement, so that we can have "from 0 days to 3 days" and "from 3 days to 7 days spoil items", instead of "from 0 to 3 days" and "from 0 days to 7 days" 
previous_date=0

#--------#> Setting variable for colouring by importance (iterate through the colour schemes as the `jindex` varaible increses) 
jindex=0

expire_flag=true;

#--------#> The main heart of the script, which iterates through the days listed in the "spoil_range" array, and simply checks all the items from the item_array if they are between the designated spoil range (with the if statement)
for day in ${spoil_range[@]}
do 
	#--------#> Change the colour of the xcl variable based on the iteration jindex (the higher the jindex iteration/number, it's a milder colour); the earlier it spoils, the more "important" the colour
	case $jindex in
		"0")
			xcl=$rcl
			;;
		"1")
			xcl=$ocl
			;;
		"2")
			xcl=$gcl
			;;	
		*)
			xcl=$bcl
			;;
	esac
	
	#--------#> Check if the expire_flag bool variable is true or false - if true, run this expired block which iterates through the whole list and checks of there are any items that are expired (today's date - expiry date is below 0), otherwise don't (since we only want to run this once).
	if $expire_flag
	then
		#--------#> For a clear explanation of the block, looks further down.
		printf "\no ${xcl} EXPIRED ${ncl} items \n"
		index=0
		for each in "${item_array[@]}"
			do
			expiration_date=$(date -d "$(echo $each | awk '{print $1}')" '+%s')
			time_diff=$(( ( $expiration_date - $todays_date )/(60*60*24) ))
			if [[ "$time_diff" -lt 1 ]]
				then printf " !!! [%s] ${xcl} %s ${ncl} Days Overdue: %s %s %s %s %s %s \n" $(echo $each | awk '{print $1}' | tr '-' ' ' | awk '{print $3"/"$2}') $(echo $time_diff | tr -d '-') $(echo $each | awk '{first = $1; $1 = ""; print $0}') 
			fi
			index=$((index + 1))
		done | sort -hrk4
		
		#--------#> Set the expire_flag boolean to false so this doesn't trigger on the next for loop
		expire_flag=false;
	fi
	
	
	
	#--------#> Main print in which it shows what the following block's range is
	printf "\no Items that will spoil in the next [${xcl} $(( $previous_date + 1 )) - $day ${ncl}] days.\n"
	
	#--------#> `index` back to 0 so we can iterate through the array of items again
	index=0
	
	#--------#> Go through the whole item array
	for each in "${item_array[@]}"
		do
		
		#--------#> Check for each items expiration date and save it as a variable
		expiration_date=$(date -d "$(echo $each | awk '{print $1}')" '+%s')
		
		#--------#> Calculate the time difference for the item's expiration date and current date, this will allow us to know how long the item has until it expires
		time_diff=$(( ( $expiration_date - $todays_date )/(60*60*24) ))
		
		#--------#> Check if the item's `time_diff` is between the suggested time differences that were defined with the `spoil_range` and `previous_date` - and if it is, print out that line.
		if [[ "$time_diff" -lt "$(( $day + 1 ))" ]] && [[ "$time_diff" -gt "$previous_date" ]]
			then printf " > [%s] ${xcl} %s ${ncl} Days: %s %s %s %s %s %s \n" $(echo $each | awk '{print $1}' | tr '-' ' ' | awk '{print $3"/"$2}') $time_diff $(echo $each | awk '{first = $1; $1 = ""; print $0}') 
		fi
		
		#--------#> Increase index because, well, we want to move forward through the array, lol.
		index=$((index + 1))
		
	#--------#> Don't forget to sort the output by date! Otherwise it would look ugly.
	done | sort -hk4
	
	#--------#> Set the previous date to be date that was the max for the last iteration, so we can have 1-3 and then 4-7
	previous_date=$day
	
	#--------#> `jindex` is here so we know the importance of the dates' in colours. Red > Orange > Green > Blue (yellow looks weird so I'm skipping that)
	jindex=$((jindex + 1))
done
echo