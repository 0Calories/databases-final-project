CREATE TABLE Restaurant (
  restaurant_id INTEGER PRIMARY KEY,
  name VARCHAR(32),
  type VARCHAR(32),
  url VARCHAR(255)
);

CREATE TABLE Rater (
  user_id INTEGER PRIMARY KEY,
  email VARCHAR(32),
  name VARCHAR(32),
  join_date DATE,
  type VARCHAR(32),
  reputation INTEGER CHECK (reputation >= 1 AND reputation <= 5) DEFAULT 1
);


CREATE TABLE MenuItem (
  item_id INTEGER PRIMARY KEY,
  name VARCHAR(32),
  type VARCHAR(32),
  category VARCHAR(32),
  description VARCHAR(255),
  price DECIMAL(3,2) CHECK (price >= 0),
  restaurant_id INTEGER REFERENCES Restaurant(restaurant_id)
);

CREATE TABLE Rating (
  user_id INTEGER REFERENCES Rater(user_id),
  rating_date DATE,
  PRIMARY KEY (user_id, rating_date),
  price INTEGER CHECK (price >= 1 AND price <= 5) DEFAULT 1,
  food INTEGER CHECK (food >= 1 AND food <= 5) DEFAULT 1,
  mood INTEGER CHECK (mood >= 1 AND mood <= 5) DEFAULT 1,
  staff INTEGER CHECK (staff >= 1 AND staff <= 5) DEFAULT 1,
  rating INTEGER CHECK (rating >= 1 AND rating <= 5) DEFAULT 1,
  comments VARCHAR(255),
  restaurant_id INTEGER REFERENCES Restaurant(restaurant_id)
);

CREATE TABLE RatingItem (
  item_id INTEGER REFERENCES MenuItem(item_id),
  rating_item_date DATE,
  user_id INTEGER REFERENCES Rater(user_id),
  PRIMARY KEY (item_id, rating_item_date, user_id),
  rating INTEGER CHECK (rating >= 1 AND rating <= 5) DEFAULT 1,
  comment VARCHAR(255)
);

CREATE TABLE Location (
  location_id INTEGER PRIMARY KEY,
  first_open_date DATE,
  manager_name VARCHAR(32),
  phone_number VARCHAR(10),
  street_address VARCHAR(32),
  hour_open TIME,
  hour_close TIME,
  restaurant_id INTEGER REFERENCES Restaurant(restaurant_id)
);

