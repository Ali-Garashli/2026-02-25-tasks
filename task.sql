USE fullstack;

CREATE TABLE Categories (
    category_id INT IDENTITY PRIMARY KEY,
    category_name NVARCHAR(20) NOT NULL UNIQUE,
);

CREATE TABLE Products (
    product_id INT IDENTITY PRIMARY KEY,
    product_name NVARCHAR(30) NOT NULL,
    price DECIMAL(5, 2) CHECK (price > 0),
    stock INT DEFAULT 0,
    category_id INT,

    CONSTRAINT fk_category
    FOREIGN KEY (category_id)
    REFERENCES Categories(category_id)
);

CREATE TABLE Customers (
    customer_id INT IDENTITY PRIMARY KEY,
    email NVARCHAR(30) NOT NULL UNIQUE, 
    join_date DATE DEFAULT GETDATE()
);

CREATE TABLE Orders (
    order_id INT IDENTITY PRIMARY KEY,
    product_id INT,
    customer_id INT,

    CONSTRAINT fk_product
    FOREIGN KEY (product_id)
    REFERENCES Products(product_id),

    CONSTRAINT fk_customer
    FOREIGN KEY (customer_id)
    REFERENCES Customers(customer_id)
);

--Cədvəllərə bir neçə məlumat əlavə et:
INSERT INTO Categories
VALUES ('Electronics'),
       ('Clothing'),
       ('Books'),
       ('Furniture'),
       ('Toys');

INSERT INTO Products
VALUES ('Laptop', 999.99, 10, 1),
       ('Smartphone', 699.99, 15, 1),
       ('T-Shirt', 19.99, 50, 2),
       ('Jeans', 49.99, 30, 2),
       ('Novel', 14.99, 40, 3),
       ('Desk', 199.99, 5, 4),
       ('Chair', 89.99, 12, 4),
       ('Mystery Box', 29.99, 20, NULL);

INSERT INTO Customers(email)
VALUES ('alice@email.com'),
       ('bob@email.com'),
       ('charlie@email.com'),
       ('diana@email.com');

INSERT INTO Orders(customer_id, product_id)
VALUES (1, 1),
       (1, 3),
       (2, 2),
       (2, 8),
       (3, 5),
       (3, 1),
       (3, 6);

--Task A (Inner Join): Satışı olan məhsulların adlarını və onların kateqoriya adlarını bir yerdə gətirin. (Yalnız hər iki cədvəldə qarşılığı olanlar).
SELECT p.product_name AS Product,
       c.category_name AS Category
FROM Products p
INNER JOIN Categories c
ON p.category_id = c.category_id;

--Task B (Left Join): Bütün kateqoriyaları və onlara aid olan məhsulları siyahılayın. Əgər bir kateqoriyada məhsul yoxdursa, məhsul adı NULL görünsün.
SELECT c.category_name AS Category,
       p.product_name AS Product
FROM Categories c
LEFT JOIN Products p
ON p.category_id = c.category_id;

--Task C (Right Join): Bütün müştəriləri və əgər varsa onların verdiyi sifarişləri gətirin. Heç sifariş verməyən müştərilər də siyahıda görünsün.
SELECT c.*, p.* FROM Orders o
RIGHT JOIN Customers c
ON c.customer_id = o.customer_id
LEFT JOIN Products p
ON p.product_id = o.product_id;

--Task D (Full Join): Sistemdəki bütün məhsulları və bütün sifarişləri birləşdirin. Heç satılmayan məhsullar və heç bir məhsula bağlı olmayan
--(ola bilsin silinmiş) sifarişlər daxil olmaqla.
SELECT * FROM Products p
FULL JOIN Orders o
ON p.product_id = o.product_id;

--Task E (Cross Join): Mağazadakı bütün məhsulların hər bir müştəri üçün mümkün "tövsiyə" kombinasiyasını yaradın (Hər məhsul x Hər müştəri).
SELECT * FROM Customers c
CROSS JOIN Products p;

--Task F: Qiyməti 100-dən yuxarı olan (Check məntiqi ilə əlaqəli) və müəyyən bir kateqoriyaya aid olan məhsulları tapın.
SELECT * FROM Products
WHERE price > 100 AND
      category_id IS NOT NULL;

--Task G: Foreign Key vasitəsilə bağlı olan cədvəllərdə, hələ heç bir kateqoriyası olmayan "yetim" məhsulların olub-olmadığını yoxlayan sorğu yazın.
SELECT * FROM Products
WHERE category_id IS NULL;


SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;
SELECT * FROM Orders;

DROP TABLE Categories;
DROP TABLE Products;
DROP TABLE Customers;
DROP TABLE Orders;