DROP TABLE review;
DROP TABLE shipment;
DROP TABLE productinventory;
DROP TABLE warehouse;
DROP TABLE orderproduct;
DROP TABLE incart;
DROP TABLE product;
DROP TABLE category;
DROP TABLE ordersummary;
DROP TABLE paymentmethod;
DROP TABLE customer;


CREATE TABLE customer (
    customerId          INT IDENTITY,
    firstName           VARCHAR(40),
    lastName            VARCHAR(40),
    email               VARCHAR(50),
    phonenum            VARCHAR(20),
    address             VARCHAR(50),
    city                VARCHAR(40),
    state               VARCHAR(20),
    postalCode          VARCHAR(20),
    country             VARCHAR(40),
    userid              VARCHAR(20),
    password            VARCHAR(30),
    PRIMARY KEY (customerId)
);

CREATE TABLE paymentmethod (
    paymentMethodId     INT IDENTITY,
    paymentType         VARCHAR(20),
    paymentNumber       VARCHAR(30),
    paymentExpiryDate   DATE,
    customerId          INT,
    PRIMARY KEY (paymentMethodId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE ordersummary (
    orderId             INT IDENTITY,
    orderDate           DATETIME,
    totalAmount         DECIMAL(10,2),
    shiptoAddress       VARCHAR(50),
    shiptoCity          VARCHAR(40),
    shiptoState         VARCHAR(20),
    shiptoPostalCode    VARCHAR(20),
    shiptoCountry       VARCHAR(40),
    customerId          INT,
    PRIMARY KEY (orderId),
    FOREIGN KEY (customerId) REFERENCES customer(customerid)
        ON UPDATE CASCADE ON DELETE CASCADE 
);

CREATE TABLE category (
    categoryId          INT IDENTITY,
    categoryName        VARCHAR(50),    
    PRIMARY KEY (categoryId)
);

CREATE TABLE product (
    productId           INT IDENTITY,
    productName         VARCHAR(40),
    productPrice        DECIMAL(10,2),
    productImageURL     VARCHAR(100),
    productImage        VARBINARY(MAX),
    productDesc         VARCHAR(1000),
    categoryId          INT,
    PRIMARY KEY (productId),
    FOREIGN KEY (categoryId) REFERENCES category(categoryId)
);

CREATE TABLE orderproduct (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE incart (
    orderId             INT,
    productId           INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (orderId, productId),
    FOREIGN KEY (orderId) REFERENCES ordersummary(orderId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE warehouse (
    warehouseId         INT IDENTITY,
    warehouseName       VARCHAR(30),    
    PRIMARY KEY (warehouseId)
);

CREATE TABLE shipment (
    shipmentId          INT IDENTITY,
    shipmentDate        DATETIME,   
    shipmentDesc        VARCHAR(100),   
    warehouseId         INT, 
    PRIMARY KEY (shipmentId),
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE productinventory ( 
    productId           INT,
    warehouseId         INT,
    quantity            INT,
    price               DECIMAL(10,2),  
    PRIMARY KEY (productId, warehouseId),   
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE NO ACTION,
    FOREIGN KEY (warehouseId) REFERENCES warehouse(warehouseId)
        ON UPDATE CASCADE ON DELETE NO ACTION
);

CREATE TABLE review (
    reviewId            INT IDENTITY,
    reviewRating        INT,
    reviewDate          DATETIME,   
    customerId          INT,
    productId           INT,
    reviewComment       VARCHAR(1000),          
    PRIMARY KEY (reviewId),
    FOREIGN KEY (customerId) REFERENCES customer(customerId)
        ON UPDATE CASCADE ON DELETE CASCADE,
    FOREIGN KEY (productId) REFERENCES product(productId)
        ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO category(categoryName) VALUES ('Explosives');
INSERT INTO category(categoryName) VALUES ('Clothing');
INSERT INTO category(categoryName) VALUES ('Weapons');
INSERT INTO category(categoryName) VALUES ('Consumables');
INSERT INTO category(categoryName) VALUES ('Tools & Equipment');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grenade',1,'Classic trusty grenade!',$19.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('C-4',1,'Small but powerful! Small quantities only!',$36.49);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Black Friday/Biohazard Suit',2,'Full protective suit, corrosive resistant. (Sort of) protects from the sweaty Black Friday hordes. L,M sizes available', 129.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gas Mask',2,'Advanced Gas Filter, one size fits all (adults)',63.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Combat Boots',2,'Comes in Black, Grey, and Camoflauge. Sizes come in L,M and S', 39.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Backpack',2,'Large backpack, stab proof and water repelling. Deep Storage.',74.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gloves',2,'Tactical, non-slip gloves. All Weather Durable.',25.89);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('P-90',3,'Compact Sub-machine gun. Comes with 1 round',$118.29);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Desert Eagle',3,'Comes with Silencer attachment. Great Mid or Short Range. Comes with 2 clips.',229.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Carving Knife',3,'8 inch blade, Serrated Steel.',72.29);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Semi-Automatic Pistol',3,'Basic Short-Range pistol with semi-auto trigger. Comes with 2 Clips.',110.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('M4 Carbine',3,'Optional Silencer and Grip Attachments. Comes with 2 Clips, Very Reliable',329.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Shotgun',3,'Classic Pump-Action Shotgun. Short-Range Use and Double Barrel.',269.89);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Assorted Ammunition',3,'Medium Box of Ammo. Choose 2 Ammo types. ',63.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Canned Beans',4,'6-pack of hearty beans. Jerrys Bean Farm Brand', $2.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Compass',4,'Dont get lost! Basic magnetic compass',$5.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Binoculars',4,'Advanced Lenses, 1km Vision Radius',75.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Water Filtration System',4,'Fully-equipped, compact, water filter system. 3 filters, reverse osmosis removes most impurities',329.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Vitamin Supplements',4,'Health is important. 12-pack of Assorted essential vitamins.',29.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Adrenaline Pack',4,'3 filled syringes. For an emergency or other needs.',89.99);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Nutrient Bars',4,'6-pack of super protein bars, packed with important nutrients.',22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Dried Meat',4,'1kg Assorted Wild Meats, added preservatives for longevity',56.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Packaged Seeds',4,'Assorted Seeds. Options include trees or crops.',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Food Pack',4,'Assorted Canned Food and Water',26.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('First Aid Kit',5,'Full Aid supply Kit. Includes bandage, gauze and sterilization solution',48.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Fire starter',5,'Flint and Steel or Matchbox Options Available', 32.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Radio',5,'Long range signal. AM/FM,UHF,VHF. Helpful for finding survivors.',25.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Hatchet',5,'Compact Axe, 14 inches. Reinforced Blade.',40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Kerosene',5,'Flammable gas, 1L Can', $20.99);

INSERT INTO warehouse(warehouseName) VALUES ('Main warehouse');
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (1, 1, 5, 18);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (2, 1, 10, 19);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (3, 1, 3, 10);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (4, 1, 2, 22);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (5, 1, 6, 21.35);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (6, 1, 3, 25);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (7, 1, 1, 30);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (8, 1, 0, 40);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (9, 1, 2, 97);
INSERT INTO productInventory(productId, warehouseId, quantity, price) VALUES (10, 1, 3, 31);

INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Arnold', 'Anderson', 'a.anderson@gmail.com', '204-111-2222', '103 AnyWhere Street', 'Winnipeg', 'MB', 'R3X 45T', 'Canada', 'arnold' , 'test');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Bobby', 'Brown', 'bobby.brown@hotmail.ca', '572-342-8911', '222 Bush Avenue', 'Boston', 'MA', '22222', 'United States', 'bobby' , 'bobby');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Candace', 'Cole', 'cole@charity.org', '333-444-5555', '333 Central Crescent', 'Chicago', 'IL', '33333', 'United States', 'candace' , 'password');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Darren', 'Doe', 'oe@doe.com', '250-807-2222', '444 Dover Lane', 'Kelowna', 'BC', 'V1V 2X9', 'Canada', 'darren' , 'pw');
INSERT INTO customer (firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password) VALUES ('Elizabeth', 'Elliott', 'engel@uiowa.edu', '555-666-7777', '555 Everwood Street', 'Iowa City', 'IA', '52241', 'United States', 'beth' , 'test');

-- Order 1 can be shipped as have enough inventory
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (1, '2019-10-15 10:25:55', 91.70)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 1, 1, 18)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 2, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 10, 1, 31);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-16 18:00:00', 106.75)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 5, 21.35);

-- Order 3 cannot be shipped as do not have enough inventory for item 7
DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (3, '2019-10-15 3:30:22', 140)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 6, 2, 25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 7, 3, 30);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (2, '2019-10-17 05:45:11', 327.85)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 3, 4, 10)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 8, 3, 40)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 13, 3, 23.25)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 28, 2, 21.05)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 29, 4, 14);

DECLARE @orderId int
INSERT INTO ordersummary (customerId, orderDate, totalAmount) VALUES (5, '2019-10-15 10:25:55', 277.40)
SELECT @orderId = @@IDENTITY
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 5, 4, 21.35)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 19, 2, 81)
INSERT INTO orderproduct (orderId, productId, quantity, price) VALUES (@orderId, 20, 3, 10);

-- New SQL DDL for lab 8
UPDATE Product SET productImageURL = 'img/1.jpg' WHERE ProductId = 1;
UPDATE Product SET productImageURL = 'img/2.jpg' WHERE ProductId = 2;
UPDATE Product SET productImageURL = 'img/3.jpg' WHERE ProductId = 3;
UPDATE Product SET productImageURL = 'img/4.jpg' WHERE ProductId = 4;
UPDATE Product SET productImageURL = 'img/5.jpg' WHERE ProductId = 5;
UPDATE Product SET productImageURL = 'img/6.jpg' WHERE ProductId = 6;
UPDATE Product SET productImageURL = 'img/7.jpg' WHERE ProductId = 7;
UPDATE Product SET productImageURL = 'img/8.jpg' WHERE ProductId = 8;
UPDATE Product SET productImageURL = 'img/9.jpg' WHERE ProductId = 9;
UPDATE Product SET productImageURL = 'img/10.jpg' WHERE ProductId = 10;
UPDATE Product SET productImageURL = 'img/11.jpg' WHERE ProductId = 11;
UPDATE Product SET productImageURL = 'img/12.jpg' WHERE ProductId = 12;
UPDATE Product SET productImageURL = 'img/13.jpg' WHERE ProductId = 13;