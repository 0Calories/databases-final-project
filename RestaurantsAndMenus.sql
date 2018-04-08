--a)
"SELECT *
FROM Restuarant rest
LEFT JOIN Location loc ON rest.restaurant_id=loc.restaurant_id
WHERE rest.restaurant_id='" + restaurantID + "';"

--b)
"SELECT *
FROM MenuItem
WHERE restaurant_id='" + restaurantID + "'
ORDER BY category;"

--c)
"SELECT loc.manager_name, loc.first_open_date
FROM Location loc
LEFT JOIN Restaurant rest ON loc.restaurant_id=rest.restaurant_id
WHERE 	loc.restaurant_id='" + restaurantID + "'
		OR rest.type='Korean';"

--d)
"SELECT menu.name, menu.price, loc.manager_name, loc.hour_open, rest.url
FROM MenuItem menu
LEFT JOIN Restaurant rest ON menu.restaurant_id=rest.restaurant_id
LEFT JOIN Location loc ON menu.restaurant_id=loc.restaurant_id
WHERE 	menu.restaurant_id = '" + restaurantID "'
		AND price = (SELECT max(price) FROM MenuItem WHERE restaurant_id='" + R646F6F4 + "');"

--e)
"SELECT avg(menu.price), rest.type, menu.category
FROM Restaurant rest
LEFT JOIN MenuItem menu ON rest.restaurant_id=menu.restaurant_id
GROUP BY rest.type, menu.category
ORDER BY rest.type;"
