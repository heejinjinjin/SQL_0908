-- ���տ�����: ������(UNION), ������(MINUS), ������(INTERSECT)
-- ������ ������ ���
-- ������ �ֹ����� ���� ���� �̸��� ���ÿ�
select name from customer
minus
select name from customer
where custid in(select distinct custid from orders);

--���� ������ ������� ���� ���
select name from customer
where custid not in(select distinct custid from orders);

-- EXISTS: ���������� ����� �����ϴ� ��쿡 true
-- �ֹ��� �ִ� ���� �̸��� �ּҸ� ����Ͻÿ�
select distinct name, address from customer, orders
where customer.custid = orders.custid;

select name, address from customer
where custid in(select distinct custid from orders);

-- Exists ����� ���
select name, address from customer c
where exists(select * from orders o
                        where c.custid = o.custid);
                        
-- �������� ������ ������ ���ǻ� ��
select count (distinct publisher) as "���ǻ� ��" from book b , orders o, customer c
where b.bookid = o.bookid and c.custid = 1;

-- �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
select distinct bookname, price, price-saleprice as "���� ��" 
from book b , orders o, customer c
where b.bookid = o.bookid 
and o.custid = c.custid
and name = "������";

-- �������� �������� ���� ������ �̸�
select bookname from book b , orders o, customer c
minus
select bookname from book b , orders o, customer c
where b.bookid = o.bookid and o.custid = c.custid and name = "������";

-- �ֹ����� ���� ���� �̸�(�μ����� ���)
select name from customer
where custid not in (select custid from orders);

-- �ֹ� �ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
select sum(saleprice) as "�Ѿ�", sum(saleprice)/count(orderid) as "���" 
from orders;

-- ���� �̸��� ���� ���ž�
select name, sum(saleprice) as "���ž�" from customer, orders
where customer.custid = orders.custid
group by name;

-- ���� �̸��� ���� ������ ���� ���
select name, bookname from customer, orders, book
where orders.custid = customer.custid and book.bookid = orders.bookid;

-- ������ ����(book���̺�)�� �ǸŰ���(Orders ���̺�)�� ���̰� ���� ���� �ֹ�
SELECT *
FROM Book, Orders
WHERE Book.bookid=Orders.bookid AND price-saleprice=(SELECT MAX(price-saleprice) FROM Book, Orders WHERE Book.bookid=Orders.bookid);

--������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
SELECT name
FROM Customer, Orders
WHERE Customer.custid=Orders.custid GROUP BY name HAVING AVG(saleprice) > (SELECT AVG(saleprice) FROM Orders);

-- DDL: ������ ���Ǿ�
-- create table/alter table/drop table
-- ���̺� ���� ����1
create table newbook1(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- ���̺� ���� ����2
-- primary key ���� ��� 1
create table newbook2(
    bookid number,
    bookname varchar2(20),
    publisher varchar2(20),
    price number,
    primary key (bookid)
);

-- primary key ���� ��� 2
create table newbook3(
    bookid number primary key,
    bookname varchar2(20),
    publisher varchar2(20),
    price number
);

-- bookname �÷� : null X
-- publisher �÷� : ���� �� X
-- price �÷� : ������ �ԷµǾ� ���� ������ �⺻ ���� 10000���� �ϰ� �Էµɶ��� �ּ� 1000
-- bookname , publisher �÷��� ����Ű�� ����
create table newbook4(
        bookname varchar2(20) not null,
        publisher varchar2(20) unique,
        price number default 10000 check (price > 1000),
        primary key(bookname, publisher)
);