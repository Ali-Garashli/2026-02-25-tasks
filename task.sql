USE fullstack;

CREATE TABLE Categories (
    category_id INT IDENTITY PRIMARY KEY,
    category_name NVARCHAR(20) NOT NULL UNIQUE,
)

CREATE TABLE Products (
    product_id INT IDENTITY PRIMARY KEY,
    product_name NVARCHAR(30) NOT NULL,
    price DECIMAL(5, 2) CHECK (price > 0),
    stock INT DEFAULT 0,
    category_id INT,
    CONSTRAINT fk_category
    FOREIGN KEY (category_id)
    REFERENCES Categories(category_id)
)

CREATE TABLE Customers (
    customer_id INT IDENTITY PRIMARY KEY,
    email NVARCHAR(30) NOT NULL UNIQUE, 
    join_date DATE DEFAULT GETDATE()
)

--Cədvəllərə bir neçə məlumat əlavə et:
INSERT INTO Categories (category_name)
VALUES ('Electronics'),
       ('Clothing'),
       ('Books'),
       ('Home'),
       ('Sports');

INSERT INTO Products (product_name, price, stock, category_id)
VALUES ('Laptop', 899.99, 15, 1),
       ('Smartphone', 599.50, 25, 1),
       ('T-Shirt', 19.99, 100, 2),
       ('Jeans', 49.99, 60, 2),
       ('Novel', 14.99, 40, 3),
       ('Cookbook', 24.50, 30, 3),
       ('Blender', 79.99, 20, 4),
       ('Desk Lamp', 34.99, 45, 4),
       ('Football', 29.99, 50, 5),
       ('Tennis Racket', 89.99, 18, 5);

INSERT INTO Customers (email, join_date)
VALUES ('john.doe@email.com', '2024-01-15'),
       ('jane.smith@email.com', '2024-03-22'),
       ('mike.brown@email.com', '2024-06-10'),
       ('emily.white@email.com', '2024-09-05'),
       ('david.green@email.com', '2025-01-12');

INSERT INTO Customers (email)
VALUES ('noah.martinez@email.com'),
       ('james.moore@email.com'),
       ('isabella.jackson@email.com');

--Task A (Inner Join): Satışı olan məhsulların adlarını və onların kateqoriya adlarını bir yerdə gətirin. (Yalnız hər iki cədvəldə qarşılığı olanlar).

--Task B (Left Join): Bütün kateqoriyaları və onlara aid olan məhsulları siyahılayın. Əgər bir kateqoriyada məhsul yoxdursa, məhsul adı NULL görünsün.

--Task C (Right Join): Bütün müştəriləri və əgər varsa onların verdiyi sifarişləri gətirin. Heç sifariş verməyən müştərilər də siyahıda görünsün.

--Task D (Full Join): Sistemdəki bütün məhsulları və bütün sifarişləri birləşdirin. Heç satılmayan məhsullar və heç bir məhsula bağlı olmayan (ola bilsin silinmiş) sifarişlər daxil olmaqla.

--Task E (Cross Join): Mağazadakı bütün məhsulların hər bir müştəri üçün mümkün "tövsiyə" kombinasiyasını yaradın (Hər məhsul x Hər müştəri).

--Task F: Qiyməti 100-dən yuxarı olan (Check məntiqi ilə əlaqəli) və müəyyən bir kateqoriyaya aid olan məhsulları tapın.

--Task G: Foreign Key vasitəsilə bağlı olan cədvəllərdə, hələ heç bir kateqoriyası olmayan "yetim" məhsulların olub-olmadığını yoxlayan sorğu yazın.

SELECT * FROM Categories;
SELECT * FROM Products;
SELECT * FROM Customers;