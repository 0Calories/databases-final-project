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

-- H
SELECT Rest.Name, RL.firstOpenDate AS date
FROM Rating Rat
LEFT JOIN Restaurant Rest ON Rat.RestaurantID=Rest.RestaurantID
LEFT JOIN Location RL ON RL.RestaurantID=Rat.RestaurantID
WHERE Rat.UserID = '$userIDSelect'
      AND ((Rat.Price>( SELECT AVG(Rat.Staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.RestaurantID=Rest.RestaurantID))
      OR (Rat.Mood>( SELECT AVG(Rat.Staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.RestaurantID=Rest.RestaurantID))
      OR (Rat.Food>( SELECT AVG(Rat.Staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.RestaurantID=Rest.RestaurantID))
      OR (Rat.Staff>( SELECT AVG(Rat.Staff)
        FROM Rating Rat, Restaurant Rest
        WHERE Rat.RestaurantID=Rest.RestaurantID)))
GROUP BY RL.firstOpenDate, Rest.name

-- I Replace 'Indian' with restaurant type
SELECT Rater.name
FROM Rater
INNER JOIN
  (SELECT Rating.food, Rating.user_id
  FROM Rating, Restaurant
  WHERE Restaurant.type = 'Indian' AND Rating.restaurant_id = Restaurant.restaurant_id AND Rating.food IN
  	(SELECT MAX(Rating.food) FROM Rating, Restaurant
  	 WHERE Restaurant.type = 'Indian' AND Rating.restaurant_id = Restaurant.restaurant_id)
  GROUP BY Rating.user_id, Rating.food) MaxRating ON MaxRating.user_id = Rater.user_id

-- J Replace 'Indian' with restaurant type
SELECT T.restaurant_id, T.name , T.total_rating
FROM
	(SELECT AVG(Rating.price + Rating.Food + Rating.mood + Rating.staff) as total_rating, Restaurant.restaurant_id, Restaurant.name
	FROM Rater, Rating, Restaurant
	WHERE Rater.user_id = Rating.user_id AND Restaurant.restaurant_id = Rating.restaurant_id
	GROUP BY Restaurant.restaurant_id) AS T

WHERE T.total_rating <
	(SELECT AVG(Rating.price + Rating.Food + Rating.mood + Rating.staff) as total_rating
	FROM Rater
	INNER JOIN Rating ON Rater.user_id = Rating.user_id
	INNER JOIN Restaurant ON Restaurant.restaurant_id = Rating.restaurant_id AND Restaurant.type = 'Indian'
	GROUP BY Restaurant.restaurant_id)
