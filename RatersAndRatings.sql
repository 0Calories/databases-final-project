--k)

SELECT R.name, R.join_date, R.reputation, Rest.name, Rate.rating_date
FROM Rater R, Restaurant Rest, Rating Rate
WHERE
	R.user_id IN (
	SELECT R1.user_id FROM Rater R1 GROUP BY R1.user_id
	HAVING (
		SELECT AVG(Rate1.mood + Rate1.food) FROM Rating Rate1
		WHERE Rate1.user_id = R1.user_id
	)
	>= ALL(
			SELECT AVG(Rate2.mood + Rate2.food)
			FROM Rating Rate2, Rater R2
			WHERE
			Rate2.user_id = R2.user_id GROUP BY R2.user_id
		)
	)
	AND Rate.user_id = R.user_id AND Rate.restaurant_id = Rest.restaurant_id;

--l)

SELECT R.name, R.reputation, Rest.name, Rate.rating_date
FROM Rater R, Restaurant Rest, Rating Rate
WHERE R.user_id
IN (SELECT R1.user_id FROM Rater R1
	WHERE
		(SELECT AVG(mood) FROM Rating Rate1 WHERE Rate1.user_id = R1.user_id)
		>=
		ALL(SELECT AVG(mood) FROM Rating Rate1 GROUP BY Rate1.user_id)
		OR
		(SELECT AVG(food) FROM Rating Rate1 WHERE Rate1.user_id = R1.user_id)
		>=
		ALL(SELECT AVG(food) FROM Rating Rate1 GROUP BY Rate1.user_id)
	)
AND Rate.user_id = R.user_id AND Rate.restaurant_id = Rest.restaurant_id

--m)

SELECT Rater.name, Rater.reputation, comment, items.name, items.price FROM
(SELECT * FROM RatingItem LEFT JOIN MenuItem ON RatingItem.item_id = MenuItem.item_id) items
JOIN
	(SELECT user_id AS most_frequent_userid, COUNT(user_id) AS num_ratings
	FROM RatingItem LEFT JOIN MenuItem ON RatingItem.item_id = MenuItem.item_id
	WHERE restaurant_id = 'D5G8DG57'
	GROUP BY user_id
	ORDER BY num_ratings DESC
	LIMIT 1) most_frequent_rater
ON  items.user_id = most_frequent_rater.most_frequent_userid
LEFT JOIN Rater ON Rater.user_id = most_frequent_rater.most_frequent_userid

--n)
SELECT rter.name, rter.email
FROM rater rter
WHERE (SELECT AVG(price+food+mood+staff)/4 FROM rating WHERE user_id=rter.user_id) < (SELECT AVG(price+food+mood+staff)/4 FROM rating WHERE user_id='blakey'--(SELECT user_id FROM rater WHERE name='boopsmith')
													)


-- o
SELECT  R.name ,R.type , R.email, Res.name, Ra.price , Ra.food, Ra.mood, Ra.staff, Ra.comments
FROM Rater R, Rating Ra, Restaurant Res
WHERE R.user_id = Ra.user_id AND Ra.restaurant_id = Res.restaurant_id AND R.user_id = any
(SELECT jende.uid
FROM (SELECT R.user_id uid, Ra.restaurant_id, COUNT(*) AS cnt
FROM Rater R , Rating Ra
WHERE R.user_id = Ra.user_id
GROUP BY Ra.restaurant_id , Ra.user_id , R.user_id
HAVING  COUNT(*)  > 2
ORDER BY cnt DESC, Ra.restaurant_id) AS jende )
ORDER BY R.name, Res.name
;
