CREATE SCHEMA amazon;
USE amazon;
CREATE TABLE User (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    address VARCHAR(255),
    phone_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO User (name, email, password, address, phone_number)
VALUES
    ('Santosh kumar', 'sk@example.com', 'password123', '292c Noida UP', '+1234567890'),
    ('Uma soni', 'uma@example.com', 'securepwd456', '264 Noida UP', '+1987654321'),
    ('Michael Brown', 'michael.brown@example.com', 'mypass789', '789 Elm Rd, Villagetown', '+1654321876'),
    ('Sarah Johnson', 'sarah.johnson@example.com', 'sarahpass', '567 Pine Blvd, Hamlet City', '+1765432198'),
    ('Kevin Lee', 'kevin.lee@example.com', 'kevinpass123', '890 Maple Ln, Hillside Village', '+1543219876'),
    ('Emily Davis', 'emily.davis@example.com', 'emilypass456', '234 Cedar Dr, Riverside', '+1876543210'),
    ('David Wilson', 'david.wilson@example.com', 'davidpass789', '901 Willow Ave, Lakeside', '+1987456321');


CREATE TABLE Product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10 , 2 ) NOT NULL,
    category VARCHAR(100),
    stock_quantity INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

INSERT INTO Product (name, description, price, category, stock_quantity)
VALUES
    ('Laptop', 'High-performance laptop with 16GB RAM and SSD storage', 1299.99, 'Electronics', 50),
    ('Smartphone', 'Latest smartphone with dual cameras and OLED display', 899.99, 'Electronics', 100),
    ('Running Shoes', 'Lightweight running shoes for all-terrain use', 99.99, 'Sports', 200),
    ('Coffee Maker', 'Automatic coffee maker with programmable settings', 149.50, 'Home & Kitchen', 75),
    ('Wireless Earbuds', 'Bluetooth wireless earbuds with noise cancellation', 129.00, 'Electronics', 150),
    ('Yoga Mat', 'Eco-friendly yoga mat with non-slip surface', 49.95, 'Sports', 300),
    ('Backpack', 'Waterproof backpack with multiple compartments', 79.99, 'Travel', 120);

CREATE TABLE `Order` (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50) NOT NULL,
    total_amount DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (user_id)
        REFERENCES User (user_id)
);

INSERT INTO `Order` (user_id, status, total_amount)
VALUES
    (1, 'Pending', 1299.99),
    (2, 'Shipped', 899.99),
    (3, 'Delivered', 99.99),
    (1, 'Pending', 149.50),
    (4, 'Shipped', 129.00),
    (2, 'Delivered', 49.95),
    (3, 'Pending', 79.99);

CREATE TABLE OrderItem (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10 , 2 ) NOT NULL,
    FOREIGN KEY (order_id)
        REFERENCES `Order` (order_id),
    FOREIGN KEY (product_id)
        REFERENCES Product (product_id)
);

INSERT INTO OrderItem (order_id, product_id, quantity, price)
VALUES
    (1, 1, 1, 1299.99),
    (2, 2, 1, 899.99),
    (3, 3, 2, 199.98),
    (1, 4, 2, 299.00),
    (2, 5, 1, 129.00),
    (3, 6, 3, 149.85),
    (1, 7, 1, 79.99);


CREATE TABLE Review (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    rating DECIMAL(2 , 1 ) NOT NULL,
    comment TEXT,
    review_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES User (user_id),
    FOREIGN KEY (product_id)
        REFERENCES Product (product_id)
);

INSERT INTO Review (user_id, product_id, rating, comment)
VALUES
    (1, 1, 4.5, 'Great laptop, fast delivery.'),
    (2, 2, 4.2, 'Nice smartphone, good camera quality.'),
    (3, 3, 3.8, 'Comfortable shoes but took a while to arrive.'),
    (1, 4, 4.0, 'Makes great coffee, easy to use.'),
    (4, 5, 4.5, 'Excellent sound quality, good battery life.'),
    (2, 6, 3.5, 'Good mat, durable material.'),
    (3, 7, 4.0, 'Spacious backpack, good for travel.');


CREATE TABLE Payment (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT NOT NULL,
    payment_method VARCHAR(100) NOT NULL,
    amount DECIMAL(10 , 2 ) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id)
        REFERENCES `Order` (order_id)
);
INSERT INTO Payment (order_id, payment_method, amount)
VALUES
    (1, 'Credit Card', 1299.99),
    (2, 'PayPal', 899.99),
    (3, 'Debit Card', 199.98),
    (1, 'Credit Card', 299.00),
    (2, 'Credit Card', 129.00),
    (3, 'PayPal', 149.85),
    (1, 'Debit Card', 79.99);


CREATE TABLE Recommendation (
    recommendation_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    recommended_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id)
        REFERENCES User (user_id),
    FOREIGN KEY (product_id)
        REFERENCES Product (product_id)
);

INSERT INTO Recommendation (user_id, product_id)
VALUES
    (1, 2),
    (2, 1),
    (3, 3),
    (1, 4),
    (4, 6),
    (2, 5),
    (3, 7);

----------------------------------------------------------------------------------------------------------------------------------------------
/* --------------------
   Case Study Questions
   --------------------*/
-- 1. Retrieve the total number of users registered on the platform.
select count(distinct(name)) from User;

-- 2. List all users who registered in the last month.
SELECT 
    *
FROM
    User
WHERE
    MONTH(created_at) = 7;

-- 3. Count the total number of products available in each category
SELECT 
    category, COUNT(*) AS total_products
FROM
    Product
GROUP BY category;

-- 4. Find the top 2 categories with the highest average product ratings.
SELECT 
    category, ROUND(AVG(rating), 2) AS avg_rating
FROM
    Product
        INNER JOIN
    Review ON Product.product_id = Review.product_id
GROUP BY category
ORDER BY avg_rating DESC
LIMIT 2;
-- 5.Identify category  with the highest number of reviews.
WITH cte AS (
    SELECT  p.product_id, p.category, p.name AS product_name, r.review_id, r.rating
    FROM Product p
    INNER JOIN Review r ON p.product_id = r.product_id
)
SELECT category,count(category) as no_of_review
FROM cte group by category 
order by no_of_review desc
limit 1;

 -- 7.Calculate the total revenue generated in the last quarter.
SELECT SUM(amount ) as total_reveniew
FROM payment
WHERE DATE(payment_date) >= DATE_SUB(NOW(), INTERVAL 3 MONTH)
AND payment_date < NOW();

-- 8. List the top 3 best-selling products by reveniew.
select p.`name`, o.price from product p 
inner join orderitem o on p.product_id = o.product_id order by o.price desc limit 3;

 -- 9.Calculate the average rating for each product
WITH cte AS (
    SELECT  p.product_id, p.category, p.name AS product_name, r.review_id, r.rating
    FROM Product p
    INNER JOIN Review r ON p.product_id = r.product_id
)
select product_name, avg(rating) as avg_rating from cte
group by product_name ;

-- 10.Identify users who have left the most reviews 
 select u.name,count(u.name) as total_review from user u
 inner join review r on u.user_id = r.user_id group by u.name order by total_review desc;
 
 -- 11. Count the number of orders paid using each payment method 
SELECT payment_method, COUNT(*) AS order_count
FROM payment
GROUP BY payment_method;

-- 12 Calculate the total amount processed through each payment method
select payment_method, sum(amount) from payment group by
payment_method;
 
-- 13 List products that are frequently recommended to users
SELECT product_id, COUNT(*) AS recommendation_count
FROM recommendation
GROUP BY product_id
ORDER BY recommendation_count DESC;

-- 14 Determine the average number of orders per user
SELECT 
    o.user_id, u.name, COUNT(o.order_id)
FROM
    `order` o
        INNER JOIN
    `user` u ON o.user_id = u.user_id
GROUP BY u.name;









 
 















