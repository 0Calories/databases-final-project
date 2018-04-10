-- F
SELECT Rater.user_id, Rater.name, Rating.price + Rating.Food + Rating.mood + Rating.staff as total_rating, Restaurant.restaurant_id
FROM Rater
INNER JOIN Rating ON Rater.user_id = Rating.user_id
INNER JOIN Restaurant ON Restaurant.restaurant_id = Rating.restaurant_id;

-- G
SELECT Restaurant.name, Restaurant.type, Location.phone_number
FROM Restaurant, Location
WHERE Restaurant.restaurant_id = Location.restaurant_id AND Restaurant.restaurant_id NOT IN
    (SELECT Rating.restaurant_id
    FROM Rating
    WHERE Rating.rating_date BETWEEN'2015/01/01' AND '2015/01/31')

-- H Replace 3 with user id
SELECT Rest.Name, RL.first_open_date AS date
FROM Rating Rat
LEFT JOIN Restaurant Rest ON Rat.restaurant_id=Rest.restaurant_id
LEFT JOIN Location RL ON RL.restaurant_id=Rat.restaurant_id
WHERE Rat.user_id = 3
      AND ((Rat.price>( SELECT AVG(Rat.staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.restaurant_id=Rest.restaurant_id))
      OR (Rat.mood>( SELECT AVG(Rat.staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.restaurant_id=Rest.restaurant_id))
      OR (Rat.food>( SELECT AVG(Rat.staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.restaurant_id=Rest.restaurant_id))
      OR (Rat.staff>( SELECT AVG(Rat.staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.restaurant_id=Rest.restaurant_id)))
GROUP BY RL.first_open_date, Rest.name

-- I Replace 'Indian' with restaurant type
SELECT Rater.name, Restaurant.name
FROM Rater, Restaurant,
  (SELECT Rating.food, Rating.user_id, Restaurant.restaurant_id
  FROM Rating, Restaurant
  WHERE Restaurant.type = 'Korean' AND Rating.restaurant_id = Restaurant.restaurant_id AND Rating.food IN
  	(SELECT MAX(Rating.food) FROM Rating, Restaurant
  	WHERE Restaurant.type = 'Korean' AND Rating.restaurant_id = Restaurant.restaurant_id)
  GROUP BY Rating.user_id, Rating.food, Restaurant.restaurant_id) MaxRating
WHERE MaxRating.user_id = Rater.user_id AND Restaurant.restaurant_id = MaxRating.restaurant_id

-- J Replace 'Indian' with restaurant type
SELECT Average.type , SUM(Average.total_rating) as LowerthanType, SUM(Selected.total_rating) as AverageofType
FROM
	(SELECT AVG(Rating.price + Rating.Food + Rating.mood + Rating.staff) as total_rating, Restaurant.type
	FROM Rater, Rating, Restaurant
	WHERE Rater.user_id = Rating.user_id AND Restaurant.restaurant_id = Rating.restaurant_id AND Restaurant.type != 'Indian'
	GROUP BY Restaurant.type) AS Average,
  (SELECT AVG(Rating.price + Rating.Food + Rating.mood + Rating.staff) as total_rating
	FROM Rater
	INNER JOIN Rating ON Rater.user_id = Rating.user_id
	INNER JOIN Restaurant ON Restaurant.restaurant_id = Rating.restaurant_id AND Restaurant.type = 'Indian'
  GROUP BY Restaurant.type) as Selected

WHERE Average.total_rating < Selected.total_rating
GROUP BY (Average.type)

