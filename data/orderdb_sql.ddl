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

INSERT INTO category(categoryName) VALUES ('Beverages');
INSERT INTO category(categoryName) VALUES ('Condiments');
INSERT INTO category(categoryName) VALUES ('Dairy Products');
INSERT INTO category(categoryName) VALUES ('Produce');
INSERT INTO category(categoryName) VALUES ('Meat/Poultry');
INSERT INTO category(categoryName) VALUES ('Seafood');
INSERT INTO category(categoryName) VALUES ('Confections');
INSERT INTO category(categoryName) VALUES ('Grains/Cereals');

INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chai', 1, '10 boxes x 20 bags',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chang',1,'24 - 12 oz bottles',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Aniseed Syrup',2,'12 - 550 ml bottles',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chef Anton''s Cajun Seasoning',2,'48 - 6 oz jars',22.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Chef Anton''s Gumbo Mix',2,'36 boxes',21.35);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Grandma''s Boysenberry Spread',2,'12 - 8 oz jars',25.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Uncle Bob''s Organic Dried Pears',4,'12 - 1 lb pkgs.',30.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Northwoods Cranberry Sauce',2,'12 - 12 oz jars',40.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Mishi Kobe Niku',5,'18 - 500 g pkgs.',97.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Ikura',6,'12 - 200 ml jars',31.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Queso Cabrales',3,'1 kg pkg.',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Queso Manchego La Pastora',3,'10 - 500 g pkgs.',38.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Tofu',4,'40 - 100 g pkgs.',23.25);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Genen Shouyu',2,'24 - 250 ml bottles',15.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Pavlova',7,'32 - 500 g boxes',17.45);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Alice Mutton',5,'20 - 1 kg tins',39.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Carnarvon Tigers',6,'16 kg pkg.',62.50);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Teatime Chocolate Biscuits',7,'10 boxes x 12 pieces',9.20);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sir Rodney''s Marmalade',7,'30 gift boxes',81.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sir Rodney''s Scones',7,'24 pkgs. x 4 pieces',10.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Gustaf''s Knackebread',8,'24 - 500 g pkgs.',21.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Sasquatch Ale',1,'24 - 12 oz bottles',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Steeleye Stout',1,'24 - 12 oz bottles',18.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Inlagd Sill',6,'24 - 250 g  jars',19.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Boston Crab Meat',6,'24 - 4 oz tins',18.40);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Jack''s New England Clam Chowder',6,'12 - 12 oz cans',9.65);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Singaporean Hokkien Fried Mee',8,'32 - 1 kg pkgs.',14.00);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Louisiana Fiery Hot Pepper Sauce',2,'32 - 8 oz bottles',21.05);
INSERT product(productName, categoryId, productDesc, productPrice) VALUES ('Laughing Lumberjack Lager',1,'24 - 12 oz bottles',14.00);

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

-- Loads image data for product 1
UPDATE Product SET productImage = c2b736c54abf99c218df26927f8c2e777ac831159f56a3ea5432e7b8b9c799e1cbec89abb6d638479d5cf24cc722de51351b4a064f4dc8b3cd421ca4694c44c1e921de49006194912072ce5c249304e80114251142424312d1d81b6ce16af6a4d27daa0e1c1e0711ee166a6a8d9084077fb676607815a890e04036c9c34239ac117543a33d257614f57525d449b8ccb2756f2e23f47afc6ecc65768ad41c0ef09b64efb158b53a5cfd513a5a3d6e3e89ff66096916220f050d7a1370a6a8d2d3bae0411c734d75cecb4cebf68cca94d40e6ad77d20e55df852af85a532acce014d48299d8609851566f457e32c510ac0a838aaada6a56b154d96244a5e9a50c24a24852993ca36529cd1bb01b4168953b445867a22a34cb8eeb1b27969e3c174db3363b28b4d6ace0204971c87829d554ed7c74557ea214c79efe00d85b20301ad5886c02493935a3392b95e946dfff0015500648a2cb53194f179e67d879a3e95749ce23f674c16d106c357c7e27f2e03cf3cb070d497729aa354708f3975d2ba5b99728b2c93e9f0461180a44085a8823737828820091aa4de510288d44c0983d3a86524019ad4d09a53ef2ce5a306a49a524c424e534262818884c13c2509606435e8cdd49b1b6e56c23e699969ef30f74f3e479fcd48d0abe270d370a5197a626bda3d0f676d9c1e386ebbb157e13670fca750a3c6ec1ab4eecedb7967e9af92f2ea8d2d3c1741b1ba6d89a10d27ad670767e4efbcaaedd242ce4be8d6d9570baf8374d8c1041e762942d1c1f4c7038800566f56efde16f277f55a4dd8986aa37a8d617e0e047bfdd73a7a0b23f9793a95fe2754bf370736ea72a334174553a3158775ed3e208f94aaefd83881f85a7c0fdc2a5d1747d3342d4d12fdc8c5148a7eacad4ff0027c4fc03fe4113361e24e8d1e27ec12f15bf0c7e7a57ee5fd993d514ba91a95bf4ba3154f79e07809f9ab3fe9fc3d3bd57cc67bce81e8202b63a5b65f62a9eba88fbc9ccd312618d2e3c009fecb6301d1eab52efec8e033f3390f752627a5581a02298eb08d182deb92e6b6b74d3115a5ac22933837bde6efb42d956812e6473eefc4e4f882c1d863369e1302dddb39ff036e678b8e9e2570db6f6f56c53a6a1868eeb07747dcf359209cf3474db2ba318460b08e5ca729bcb0a9b64abcca7082953853649390241351a109c94861212d94e9c20012147aa9f750bda98885cd3c524e4a48033ca4853aa0b441c9d0b4a2940049cb50846d4003098b511174481834c2321201109480af570a1cb3abe01c320b6daa7a4d09ef710da99c9ba991984546a39865ae734f16923e4bb96ecba7500040e03fb8c954da1d136c9eadd039dc5f9d8fcd0b550ce1f00e89768c7c2f49b194fbb5dde707e62569d2e9ee35b9b98ef169fa159f8be8e576680e963f78bdc2a55304f6e6d23c95f19c65d32a7192ed1d2b7ff00d0317c29fa1fba8eaf4f31a7234c7f09fbae70523c0a3144f04f08469623a558d7e759c393401f459955ef7997b9ce3fbc49f9a91b48a91b4502206b548da4ad52a0a765208dc3c15a9502add3a402209017516f234891396a008c35218402445d0ca70810e4a26041bc89bc9300c14ce4e4a1940025a9d21e09200c9482492a0b062914c9260185204924c05aa67a74900208986e924931929faa918924a0c9234305de6f88f9aea317de3fad124961d4768d3574455402c74df337e30b9ada406f1f3f9a4929697b15fd18ef49c12497511898d4c5d4ff0064e92188433fd7346c4c924026e6892490046dd3f5a2b0c4924000754c7f5e89249811d336533734924c448d409248181299249007ffd9 WHERE ProductId = 1;