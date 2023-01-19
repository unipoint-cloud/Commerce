-- DROP TABLE PERSON CASCADE CONSTRAINTS PURGE;
-- DROP TABLE ADDRESS CASCADE CONSTRAINTS PURGE;
-- DROP TABLE PHONE CASCADE CONSTRAINTS PURGE;
-- DROP TABLE PARTYADDRESS CASCADE CONSTRAINTS PURGE;
-- DROP TABLE PARTYPHONE CASCADE CONSTRAINTS PURGE;
-- DROP TABLE CATEGORY CASCADE CONSTRAINTS PURGE;
-- DROP TABLE PRODUCT CASCADE CONSTRAINTS PURGE;
-- DROP TABLE INVENTORY CASCADE CONSTRAINTS PURGE;
-- DROP TABLE ORDERSHEET CASCADE CONSTRAINTS PURGE;
-- DROP TABLE PARTYPRODUCT CASCADE CONSTRAINTS PURGE;
-- DROP TABLE PURCHASE CASCADE CONSTRAINTS PURGE;

-- PERSON TABLE
CREATE TABLE PERSON (
    personid            NUMBER(38,0),
    personname          VARCHAR2(100),
    gender              VARCHAR2(10),
    password            VARCHAR2(100),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk100 PRIMARY KEY (personid)
);

-- ADDRESS TABLE
CREATE TABLE ADDRESS (
    addressid           NUMBER(38,0),
    addressdetail       VARCHAR2(100),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk101 PRIMARY KEY (addressid)
);

-- PHONE TABLE
CREATE TABLE PHONE (
    phoneid             NUMBER(38,0),
    phonenumber         VARCHAR2(100),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk102 PRIMARY KEY (phoneid)
);

-- PARTY ADDRESS TABLE
CREATE TABLE PARTYADDRESS (
    personid            NUMBER(38,0),
    addressid           NUMBER(38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk103 PRIMARY KEY (personid, addressid),
    CONSTRAINT fk100 FOREIGN KEY (personid) REFERENCES PERSON (personid),
    CONSTRAINT fk101 FOREIGN KEY (addressid) REFERENCES ADDRESS (addressid)
);

-- PARTY PHONE TABLE
CREATE TABLE PARTYPHONE (
    personid            NUMBER(38,0),
    phoneid             NUMBER(38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk104 PRIMARY KEY (personid, phoneid),
    CONSTRAINT fk102 FOREIGN KEY (personid) REFERENCES PERSON (personid),
    CONSTRAINT fk103 FOREIGN KEY (phoneid) REFERENCES PHONE (phoneid)
);

-- CATEGORY TABLE
CREATE TABLE CATEGORY (
    categoryid          NUMBER(38,0),
    categoryname        VARCHAR2(100),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk105 PRIMARY KEY (categoryid)
);

-- PRODUCT TABLE
CREATE TABLE PRODUCT (
    productid           NUMBER(38,0),
    categoryid          NUMBER(38,0),
    productname         VARCHAR2(100),
    price               NUMBER(38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk106 PRIMARY KEY (productid),
    CONSTRAINT fk104 FOREIGN KEY (categoryid) REFERENCES CATEGORY (categoryid)
);

-- INVENTORY TABLE
CREATE TABLE INVENTORY (
    productid           NUMBER(38,0),
    quantity            NUMBER(38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk107 PRIMARY KEY (productid),
    CONSTRAINT fk105 FOREIGN KEY (productid) REFERENCES PRODUCT (productid)
);

-- ORDERSHEET TABLE
CREATE TABLE ORDERSHEET (
    orderid             NUMBER(38,0),
    personid            NUMBER(38,0),
    addressid           NUMBER(38,0),
    phoneid             NUMBER(38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk109 PRIMARY KEY (orderid),
    CONSTRAINT fk108 FOREIGN KEY (personid) REFERENCES PERSON (personid),
    CONSTRAINT fk109 FOREIGN KEY (addressid) REFERENCES ADDRESS (addressid),
    CONSTRAINT fk110 FOREIGN KEY (phoneid) REFERENCES PHONE (phoneid)
);

-- PARTYPRODUCT TABLE
CREATE TABLE PARTYPRODUCT (
    personid            NUMBER(38,0),
    productid           NUMBER(38,0),
    quantity            NUMBER(38,0),
    orderid             NUMBER (38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk108 PRIMARY KEY (personid, createdate),
    CONSTRAINT fk106 FOREIGN KEY (personid) REFERENCES PERSON (personid),
    CONSTRAINT fk107 FOREIGN KEY (productid) REFERENCES PRODUCT (productid),
    CONSTRAINT fk112 FOREIGN KEY (orderid) REFERENCES ORDERSHEET (orderid) ON DELETE SET NULL
);

-- PURCHASE TABLE
CREATE TABLE PURCHASE (
    orderid             NUMBER(38,0),
    createdate          DATE,
    updatedate          DATE,
    CONSTRAINT pk110 PRIMARY KEY (orderid),
    CONSTRAINT fk111 FOREIGN KEY (orderid) REFERENCES ORDERSHEET (orderid)
);

commit;