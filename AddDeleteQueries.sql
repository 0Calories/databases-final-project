-- Restaurant Add/Delete queries

INSERT INTO Restaurant
VALUES(restaurant_id, name, type, url);

DELETE FROM Restaurant
WHERE restaurant_id = 'id_here';

-- Rater Add/Delete

INSERT INTO Rater
VALUES(user_id, email, name, join_date, type, reputation);

DELETE FROM Rater
WHERE user_id = 'id_here';

-- MenuItem Add/Delete

INSERT INTO MenuItem
VALUES(item_id, name, type, category, description, price, restaurant_id);

DELETE FROM MenuItem 
WHERE item_id = 'id_here';

