CREATE TABLE Restaurant (
  restaurant_id VARCHAR(32) PRIMARY KEY,
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
  item_id VARCHAR(32) PRIMARY KEY,
  name VARCHAR(32),
  type VARCHAR(32),
  category VARCHAR(32),
  description VARCHAR(255),
  price DECIMAL(15,2) CHECK (price >= 0),
  restaurant_id VARCHAR(32) REFERENCES Restaurant(restaurant_id) ON DELETE CASCADE
);

CREATE TABLE Rating (
  user_id INTEGER REFERENCES Rater(user_id) ON DELETE CASCADE,
  rating_date DATE,
  PRIMARY KEY (user_id, rating_date),
  price INTEGER CHECK (price >= 1 AND price <= 5) DEFAULT 1,
  food INTEGER CHECK (food >= 1 AND food <= 5) DEFAULT 1,
  mood INTEGER CHECK (mood >= 1 AND mood <= 5) DEFAULT 1,
  staff INTEGER CHECK (staff >= 1 AND staff <= 5) DEFAULT 1,
  comments VARCHAR(255),
  restaurant_id VARCHAR(32) REFERENCES Restaurant(restaurant_id) ON DELETE CASCADE
);

CREATE TABLE RatingItem (
  item_id VARCHAR(32) REFERENCES MenuItem(item_id) ON DELETE CASCADE,
  rating_item_date DATE,
  user_id INTEGER REFERENCES Rater(user_id) ON DELETE CASCADE,
  PRIMARY KEY (item_id, rating_item_date, user_id),
  rating INTEGER CHECK (rating >= 1 AND rating <= 5) DEFAULT 1,
  comment VARCHAR(255)
);

CREATE TABLE Location (
  location_id VARCHAR(32) PRIMARY KEY,
  first_open_date DATE,
  manager_name VARCHAR(32),
  phone_number VARCHAR(10),
  street_address VARCHAR(255),
  hour_open TIME,
  hour_close TIME,
  restaurant_id VARCHAR(32) REFERENCES Restaurant(restaurant_id) ON DELETE CASCADE
);
