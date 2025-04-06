# Task 1: Which TCP port is open on the machine?
`nmap -pn -sV 10.129.159.121`

# Task 2: Which service is running on the port that is open on the machine?
redis

# Task 3: What type of database is Redis? Choose from the following options: (i) In-memory Database, (ii) Traditional Database
In-memory Database

# Task 4: Which command-line utility is used to interact with the Redis server? Enter the program name you would enter into the terminal without any arguments.
redis-cli

# Task 5: Which flag is used with the Redis command-line utility to specify the hostname?
-h

# Task 6: Once connected to a Redis server, which command is used to obtain the information and statistics about the Redis server?
info

# Task 7: What is the version of the Redis server being used on the target machine?
5.0.7

# Task 8: Which command is used to select the desired database in Redis?
select

# Task 9: How many keys are present inside the database with index 0?
`select 0` and `keys *`

# Task 10: Which command is used to obtain all the keys in a database?
keys *

# Task 11: Flag
After listing all keys, use `get flag` to get  the flag.
