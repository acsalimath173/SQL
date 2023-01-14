
  -- MANDOTORY PROJECT --
  # Using 'ig_clone' database
  # Ig_clone database is basically related to social media for uploading photos,likes,tqss,comments etc 
  
# Q.1) Create an ER diagram or draw a schema for the given database.
-- There are some steps to draw ER-Diagrams for given Dataset 
# select Database -> Reverse Engineer -> Set parameters for connecting DBMS -> Next -> Select required Database -> Next -> Execute > Next -> Finish

# Q.2) We want to reward the user who has been around the longest, Find the 5 oldest users.
SELECT id,username AS oldest_users,created_at FROM  users  
ORDER BY created_at ASC                          		 # Orderwise from lower to higher  
LIMIT 5;                                        		 # Only top 5 records


# Q.3) To understand when to run the ad campaign, figure out the day of the week most users register on? 
  SELECT DATE_FORMAT(created_at,'%W')AS day_of_the_week,COUNT(created_at) AS total_registration FROM users     
  GROUP BY day_of_the_week                  			 # For Grouped data used Group by 
  ORDER BY total_registration DESC ;        			 # Orderwise from higher to lower
  

# Q.4) To target inactive users in an email ad campaign, find the users who have never posted a photo.
SELECT * FROM users 
JOIN photos ON users.id = photos.id     				 # Joined Two tables 
WHERE photos.id IS NULL; 
# Correct Answer               				
SELECT * FROM users 
LEFT JOIN photos ON users.id = photos.user_id     				 # Joined Two tables 
WHERE photos.image_url IS NULL; 

# Q.5) Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
SELECT u.username,p.id,p.image_url,COUNT(*) AS most_likes  FROM photos AS p 
JOIN likes AS l ON p.id = l.photo_id                   
JOIN users AS u ON u.id = p.user_id             		 # Joined three tables 
GROUP BY p.id                                    		 # Grouped data 
ORDER BY  most_likes DESC                        		 # Only Descending order
LIMIT 1;                                         		 # Top 1 record only 


#Q.6) The investors want to know how many times does the average user post.
SELECT  u.username ,COUNT(*) AS total_counts  FROM users AS u 
JOIN photos AS p ON u.id = p.user_id             		 # Joined two tables 
GROUP BY user_id                                 		 # Grouped data 
ORDER BY total_counts DESC;                      		 # Only Descending order


# Q.7) A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
SELECT  COUNT(tag_name) AS total_tags,tag_name AS hashtags FROM tags AS t
JOIN photo_tags AS pt ON t.id = pt.tag_id       		 # Joined three tables 
GROUP BY tag_id                                 		 # Grouped data 
ORDER BY total_tags DESC                        		 # Only Descending order
LIMIT 5;                                        		 # Top 5 records only


# Q.8) To find out if there are bots, find users who have liked every single photo on the site.
SELECT user_id,username, COUNT(id) AS total_likes_by_user
FROM users JOIN likes ON users.id=likes.user_id
GROUP BY id                                                  # used Grouped data so we cant use 'WHERE' clause here so
HAVING total_likes_by_user=(SELECT COUNT(*) FROM photos);    # used 'HAVING' clause 


#Q.9) To know who the celebrities are, find users who have never commented on a photo.
SELECT u.username,c.comment_text FROM users AS u
JOIN comments AS c ON u.id = c.id 
GROUP BY user_id                       						# used Grouped data so we cant use 'WHERE' clause here so
HAVING comment_text IS NULL;           						# used 'HAVING' clause

# Q.10) Now it's time to find both of them together, find the users who have never commented on any photo or have commented on every phot
SELECT u.username,c.comment_text FROM users AS u
JOIN comments AS c ON u.id = c.user_id 
GROUP BY user_id 
HAVING comment_text IS NULL                                 # Check NULL/Missing values  
UNION                                                       # Used UNION to get all records of two tables 
SELECT u.username,c.comment_text FROM users AS u
JOIN comments AS c ON u.id = c.user_id 
GROUP BY user_id 
HAVING comment_text IS NOT NULL;                            # Check NOT NULL/Missing values

				
								# THANK YOU




















































-- fINDING EVEN AND ODD NUMBERS OF BETWEEN 0-10;
DELIMITER //
CREATE PROCEDURE while_loop()
   BEGIN
   DECLARE num INT default 1;
   DECLARE res Varchar(50);
   SET res = CAST(num AS CHAR);
   WHILE num < 11 DO
              SET num = num + 2;
      SET res = CONCAT(res,',' , num);
   END While;
   SELECT res;
   END //
call while_loop();


# Q.5  
select u.username,l.user_id,count(*) 
from users u join likes l on l.user_id = u.id
join photos p on p.id = u.id 
group by l.photo_id
order by count(*) desc;




