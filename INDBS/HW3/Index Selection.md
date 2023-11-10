# Available indexes

(a) Property(id)  
(b) Property(square_meters)  
(c) Property(price)  
(d) Property(square_meters, price)  
(e) Property(square_meters, price, id)  
(f) Property(square_meters, price, type)  
(g) No index  
  
# Queries

1. 
  ```sql
  select id, type, price
  from Property
  where square_meters > 200;
  ```
We are filtering by a range, so Property(square_meters) is best here.

2. 
  ```sql
  select square_meters
  from Property
  where price = 25,000,000;
  ```
Poperty(price)

3. 
  ```sql
  select id
  from Property
  where square_meters > (select AVG(price)/250,000 from Property);
  ```
Poperty(square_meters) We have to go through every row to calculate the average anyway.

4. 
  ```sql
  select id, type, price
  from Property;
  ```
No index.