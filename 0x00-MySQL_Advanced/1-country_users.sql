-- creates a table users
-- with id, email, name and country

CREATE TABLE IF NOT EXISTS users (
        id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
        email VARCHAR (255) NOT NULL UNIQUE,
        name VARCHAR (255),
        country ENUM('US', 'CO', 'TN') NOT NULL DEFAULT 'US',
);
