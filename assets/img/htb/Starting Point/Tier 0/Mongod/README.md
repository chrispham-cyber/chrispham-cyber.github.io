# Task 1: How many TCP ports are open on the machine?
2

# Task 2: Which service is running on port 27017 of the remote host?
MongoDB 3.6.8

# Task 3: What type of database is MongoDB? (Choose: SQL or NoSQL)
NoSQL

# Task 4: What is the command name for the Mongo shell that is installed with the mongodb-clients package?
Mongosh

# Task 5: What is the command used for listing all the databases present on the MongoDB server? (No need to include a trailing ;)
show dbs

# Task 6: What is the command used for listing out the collections in a database? (No need to include a trailing ;)
show collections

# Task 7: What is the command used for dumping the content of all the documents within the collection named flag in a format that is easy to read?
db.flag.find().pretty()

# Task 8: Flag
`./mongosh "mongodb://10.129.120.237:27017"` connect to MongoDB
`show dbs` list all databases
`use {data}` select database
`show collections` list all collections
`db.{data}.find()` get content
