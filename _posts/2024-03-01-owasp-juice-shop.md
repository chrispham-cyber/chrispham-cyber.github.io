---
layout: post
title:  "OWASP - Juice Shop"
date:   2024-03-01 18:30:00 -0400
categories: OWASP
tags: OWASP web 
image:
  path: /assets/img/owasp/banner.jpg
---

### Overview
This project is a great resource for who looking to gain hands-on experience with web application security concepts and tools, covering a wide range of vulnerabilities such as SQL injection, Cross-Site Scripting (XSS), Cross-Site Request Forgery (CSRF), and more. It offers challenges of varying difficulty levels, making it suitable for beginners as well as more experienced security professionals.

### Catagory of vulnerabilities
![](./assets/img/owasp/OWASP-categories.png)

## Link: [OWASP Juice Shop](https://juice-shop-production-fbc0.up.railway.app/#/score-board)

### Tasks

| Status | Name                          | Description                                                                                       | Solution                |
|----------|-------------------------------|---------------------------------------------------------------------------------------------------|-----------------------------------------|
| ✓       | API-only XSS                  | Perform a persisted XSS attack with <iframe src="javascript:alert(xss)"> without using the frontend application at all. | 
| ✓       | Access Log                    | Gain access to any access log file of the server.                                               |  |
| ✓       | Admin Registration             | Register as a user with administrator privileges.                                               |  |
| ✗       | Admin Section                 | Access the administration section of the store.                                                 | just like `Score Board` |
| ✓       | Allowlist Bypass              | Enforce a redirect to a page you are not supposed to redirect to.                               |  |
| ✓       | Arbitrary File Write          | Overwrite the Legal Information file.                                                            |  |
| ✓       | Bjoern’s Favorite Pet         | Reset the password of Bjoern’s OWASP account via the Forgot Password mechanism with the truthful answer to his security question. |  
| ✓       | Blockchain Hype               | Learn about the Token Sale before its official announcement.                                     |  
| ✓       | Blocked RCE DoS               | Perform a Remote Code Execution that would keep a less hardened application busy forever.        |  
| ✗       | Bonus Payload                 | Use the bonus payload <iframe width="100%" height="166" scrolling="no" frameborder="no" allow="autoplay" src="https://w.soundcloud.com/player/?url=https%3A//api.soundcloud.com/tracks/771984076&color=%23ff5500&auto_play=true&hide_related=false&show_comments=true&show_user=true&show_reposts=false&show_teaser=true"></iframe> in the DOM XSS challenge. | Copy and paste the code into search bar       |
| ✗       | Bully Chatbot                 | Receive a coupon code from the support chatbot.                                                 | Just spam the chat until it tells you the coupon code :laughing: |
| ✓       | CAPTCHA Bypass                | Submit 10 or more customer feedbacks within 10 seconds.                                         |  
| ✓       | Change Bender’s Password      | Change Bender’s password into slurmCl4ssic without using SQL Injection or Forgot Password.      |  
| ✓       | Christmas Special             | Order the Christmas special offer of 2014.                                                      |  
| ✓       | CSP Bypass                   | Bypass the Content Security Policy and perform an XSS attack with <script>alert(xss)</script> on a legacy page within the application. |  
| ✓       | Client-side XSS Protection    | Perform a persisted XSS attack with <iframe src="javascript:alert(xss)"> bypassing a client-side security mechanism. |  
| ✗       | Confidential Document         | Access a confidential document.                                                                    |  Visit `About Us` page and we will see a link to `/ftp` |
| ✓       | Cross-Site Imaging            | Stick cute cross-domain kittens all over our delivery boxes.                                      |  
| ✓       | CSRF                          | Change the name of a user by performing Cross-Site Request Forgery from another origin.           | 
| ✗       | DOM XSS                      | Perform a DOM XSS attack with <iframe src="javascript:alert(xss)">.                             | Copy and paste the code into search bar |
| ✓       | Database Schema               | Exfiltrate the entire DB schema definition via SQL Injection.                                     |  
| ✓       | Deluxe Fraud                  | Obtain a Deluxe Membership without paying for it.                                               |  
| ✓       | Deprecated Interface          | Use a deprecated B2B interface that was not properly shut down.                                   |
| ✓       | Easter Egg                   | Find the hidden easter egg.                                                                        |
| ✓       | Email Leak                   | Perform an unwanted information disclosure by accessing data cross-domain.                        |
| ✗       | Empty User Registration       | Register a user with an empty email and password.                                                | Just like `DRY` |
| ✓       | Ephemeral Accountant          | Log in with the (non-existing) accountant acc0unt4nt@juice-sh.op without ever registering that user. |
| ✗       | Error Handling                | Provoke an error that is neither very gracefully nor consistently handled.                        | In the login page, input some special characters like `* -- #`|
| ✓       | Expired Coupon                | Successfully redeem an expired campaign coupon code.                                              |
| ✗       | Exposed Metrics               | Find the endpoint that serves usage data to be scraped by a popular monitoring system. [popular monitoring system](https://github.com/prometheus/prometheus)            | Visit the document page in description and we will see the example link `/metrics`
| ✓       | Extra Language                | Retrieve the language file that never made it into production.                                    |
| ✗       | Five-Star Feedback            | Get rid of all 5-star customer feedback.                                                          | Visit `administrator` page and remove 5 stars comment |
| ✓       | Forged Coupon                 | Forge a coupon code that gives you a discount of at least 80%.                                   |
| ✓       | Forged Feedback               | Post some feedback in another user’s name.                                                       |
| ✓       | Forged Review                 | Post a product review as another user or edit any user’s existing review.                        |
| ✓       | Forged Signed JWT             | Forge an almost properly RSA-signed JWT token that impersonates the (non-existing) user rsa_lord@juice-sh.op. |
| ✓       | Forgotten Developer Backup     | Access a developer’s forgotten backup file.                                                      |
| ✓       | Forgotten Sales Backup        | Access a salesman’s forgotten backup file.                                                        |
| ✓       | Frontend Typosquatting       | Inform the shop about a typosquatting imposter that dug itself deep into the frontend. (Mention the exact name of the culprit) |
| ✓       | GDPR Data Erasure             | Log in with Chris' erased user account.                                                           |
| ✓       | GDPR Data Theft               | Steal someone else’s personal data without using Injection.                                       |
| ✓       | HTTP-Header XSS              | Perform a persisted XSS attack with <iframe src="javascript:alert(xss)"> through an HTTP header. |
| ✓       | Imaginary Challenge           | Solve challenge #999. Unfortunately, this challenge does not exist.                              |
| ✓       | Kill Chatbot                  | Permanently disable the support chatbot so that it can no longer answer customer queries.        |
| ✓       | Leaked Access Logs            | Dumpster dive the Internet for a leaked password and log in to the original user account it belongs to. (Creating a new account with the same password does not qualify as a solution.) |
| ✓       | Leaked Unsafe Product         | Identify an unsafe product that was removed from the shop and inform the shop which ingredients are dangerous. |
| ✓       | Legacy Typosquatting          | Inform the shop about a typosquatting trick it has been a victim of at least in v6.2.0-SNAPSHOT. (Mention the exact name of the culprit) |
| ✓       | Local File Read               | Gain read access to an arbitrary local file on the web server.                                   |
| ✗       | Login Admin                   | Log in with the administrator’s user account.                                                    | `' OR '1'='1'-- `|
| ✗       | Login Amy                     | Log in with Amy’s original user credentials. (This could take 93.83 billion trillion trillion centuries to brute force, but luckily she did not read the "One Important Final Note") | After reading [Hint](https://pwning.owasp-juice.shop/companion-guide/latest/part2/sensitive-data-exposure.html#_log_in_with_amys_original_user_credentials), we know that her husband's name is `Kif` and search `One Important Final Note` we will see `Password Pading`. Copy the dot with her husband's name, and replace vowel with 1 |
| ✗       | Login Bender                  | Log in with Bender’s user account.                                                                | `email'--` |
| ✓       | Login Bjoern                  | Log in with Bjoern’s Gmail account without previously changing his password, applying SQL Injection, or hacking his Google account. |
| ✗       | Login Jim                     | Log in with Jim’s user account.                                                                    | `email'--` |
| ✗       | Login MC SafeSearch           | Log in with MC SafeSearch’s original user credentials without applying SQL Injection or any other bypass. | After listening to his song, we know that his password is `Mr. Noodles` and change some o to 0 |
| ✓       | Login Support Team            | Log in with the support team’s original user credentials without applying SQL Injection or any other bypass. |
| ✓       | Manipulate Basket             | Put an additional product into another user’s shopping basket.                                    |
| ✗       | Mass Dispel                   | Close multiple "Challenge solved"-notifications in one go.                                        | Press `Shift` and click `X` button |
| ✗       | Meta Geo Stalking             | Determine the answer to John’s security question by looking at an upload of him to the Photo Wall and use it to reset his password via the Forgot Password mechanism. | Download the `Hiking` image and use `Exiftool` to get `GPS Position` |
| ✓       | Mint the Honey Pot            | Mint the Honey Pot NFT by gathering BEEs from the bee haven.                                     |
| ✓       | Misplaced Signature File      | Access a misplaced SIEM signature file.                                                           |
| ✗       | Missing Encoding              | Retrieve the photo of Bjoern’s cat in "melee combat-mode".                                       | Using `Cyber chef` we will see the URL encoding of the img link or just replace `#` with `#23`
| ✓       | Multiple Likes                | Like any review at least three times as the same user.                                           |
| ✓       | Nested Easter Egg             | Apply some advanced cryptanalysis to find the real easter egg.                                    |
| ✗       | NFT Takeover                  | Take over the wallet containing our official Soul Bound Token (NFT).                              | Visit `About Us` and scroll down `Comment` section, we will notice 1 user with comment `NFT`, visit [Bip39](https://iancoleman.io/bip39/) to get your private key |
| ✓       | NoSQL DoS                     | Let the server sleep for some time. (It has done more than enough hard work for you)              |
| ✓       | NoSQL Exfiltration            | All your orders are belong to us! Even the ones which don’t!                                     |
| ✓       | NoSQL Manipulation            | Update multiple product reviews at the same time.                                                |
| ✓       | Outdated Allowlist            | Let us redirect you to one of our crypto currency addresses which are not promoted any longer.    |
| ✗       | Password Strength             | Log in with the administrator’s user credentials without previously changing them or applying SQL Injection. | Using `FUZZ` to brufe force with `default-passwords.txt` wordlist |
| ✓       | Payback Time                  | Place an order that makes you rich.                                                                |
| ✓       | Poison Null Byte              | Bypass a security control with a Poison Null Byte to access a file not meant for your eyes.      |
| ✓       | Premium Paywall               | Unlock Premium Challenge to access exclusive content.                                             |
| ✗       | Privacy Policy                | Read our privacy policy.                                                                           | After login as `Admin` using basic SQL Injection, use can browse to `Privacy Policy` to complete the task|
| ✓       | Privacy Policy Inspection      | Prove that you actually read our privacy policy.                                                  |
| ✓       | Product Tampering             | Change the href of the link within the OWASP SSL Advanced Forensic Tool (O-Saft) product description into https://owasp.slack.com. |
| ✗       | Reflected XSS                 | Perform a reflected XSS attack with <iframe src="javascript:alert(`xss)">.                       | Visit `Order History` and `Tracking`, replace id value with malicious string | 
| ✗       | Repetitive Registration        | Follow the DRY principle while registering a user.                                               | Using `Burp Suite` to inspect and change `PasswordRepeat` to empty |
| ✓       | Reset Bender’s Password       | Reset Bender’s password via the Forgot Password mechanism with the truthful answer to his security question. |
| ✓       | Reset Bjoern’s Password       | Reset the password of Bjoern’s internal account via the Forgot Password mechanism with the truthful answer to his security question. |
| ✓       | Reset Jim’s Password          | Reset Jim’s password via the Forgot Password mechanism with the truthful answer to his security question. |
| ✓       | Reset Morty’s Password        | Reset Morty’s password via the Forgot Password mechanism with his obfuscated answer to his security question. |
| ✓       | Reset Uvogin’s Password       | Reset Uvogin’s password via the Forgot Password mechanism with the original answer to his security question. |
| ✓       | Retrieve Blueprint            | Deprive the shop of earnings by downloading the blueprint for one of its products.                |
| ✓       | SSRF                          | Request a hidden resource on server through server.                                              |
| ✓       | SSTi                          | Infect the server with juicy malware by abusing arbitrary command execution.                       |
| ✗       | Score Board                   | Find the carefully hidden 'Score Board' page.                                                    | `F12` to inspect the web, on `Sources` group click on `main.js` file and search for `Score Board`|
| ✓       | Security Policy               | Behave like any "white hat" should before getting into the action.                               |
| ✓       | Server-side XSS Protection    | Perform a persisted XSS attack with <iframe src="javascript:alert(xss)"> bypassing a server-side security mechanism. |
| ✓       | Steganography                 | Rat out a notorious character hiding in plain sight in the shop. (Mention the exact name of the character) |
| ✓       | Successful RCE DoS            | Perform a Remote Code Execution that occupies the server for a while without using infinite loops. |
| ✓       | Supply Chain Attack           | Inform the development team about a danger to some of their credentials. (Send them the URL of the original report or an assigned CVE or another identifier of this vulnerability) |
| ✓       | Two Factor Authentication      | Solve the 2FA challenge for user "wurstbrot". (Disabling, bypassing or overwriting his 2FA settings does not count as a solution) |
| ✓       | Unsigned JWT                  | Forge an essentially unsigned JWT token that impersonates the (non-existing) user jwtn3d@juice-sh.op. |
| ✓       | Upload Size                   | Upload a file larger than 100 kB.                                                                 |
| ✓       | Upload Type                   | Upload a file that has no .pdf or .zip extension.                                                |
| ✓       | User Credentials              | Retrieve a list of all user credentials via SQL Injection.                                       |
| ✓       | Video XSS                     | Embed an XSS payload </script><script>alert(xss)</script> into our promo video.                |
| ✗       | View Basket                   | View another user’s shopping basket.                                                               | Using `Burp Suite` to inspect and change `Basket` value |
| ✓       | Visual Geo Stalking           | Determine the answer to Emma’s security question by looking at an upload of her to the Photo Wall and use it to reset her password via the Forgot Password mechanism. |
| ✓       | Vulnerable Library            | Inform the shop about a vulnerable library it is using. (Mention the exact library name and version in your comment) |
| ✓       | Wallet Depletion              | Withdraw more ETH from the new wallet than you deposited.                                        |
| ✗       | Web3 Sandbox                  | Find an accidentally deployed code sandbox for writing smart contracts on the fly.                | Just like `Score Board` |
| ✓       | Weird Crypto                  | Inform the shop about an algorithm or library it should definitely not use the way it does.       |
| ✓       | XXE Data Access               | Retrieve the content of C:\Windows\system.ini or /etc/passwd from the server.                    |
| ✓       | XXE DoS                       | Give the server something to chew on for quite a while.                                          |
| ✗      | Zero Stars                    | Give a devastating zero-star feedback to the store.                                              | Using `Burp Suite` to inspect and change `Rating` to `0` |

