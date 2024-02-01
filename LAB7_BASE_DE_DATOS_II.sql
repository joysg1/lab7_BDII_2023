use ALMACEN




--- 1. Cree un procedimiento almacenado al cual se le envien dos numeros decimales y que retorne el promedio
--- Recuerde retornar el promedio como output



CREATE PROCEDURE CalculoPromedio
    @Num1 decimal(8,2),
    @Num2 decimal(8,2),
    @Promedio decimal(8,2) OUTPUT
AS
BEGIN
    
   
    SET  @Promedio = (@Num1 + @Num2) / 2;

END;


DECLARE  @result decimal(8,2);


EXEC CalculoPromedio @Num1 = 100.20, @Num2 = 50.90, @Promedio = @result OUTPUT;   --- Ejecutar estas tres lineas en bloque

Select @result as promedio;




--- 2. Crear un procedimiento almacenado que imprima los numeros impares del 1 al 10, usar ciclo while


CREATE PROCEDURE NumImpares
AS
BEGIN
    DECLARE @Num INT;
    SET @Num = 1;
    
    WHILE @Num <= 10
    BEGIN
        IF @Num % 2 <> 0
        BEGIN
            PRINT @Num; -- Imprimir número impar
        END
        
        SET @Num = @Num + 1;
    END
END;


exec NumImpares 


--- 2.1 Script numeros impares
declare @i int =0;

while @i<=10
 begin;
 if (@i%2!=0)
 print @i
 set @i = @i +1;
 end;



--- 3. Cree un procedimiento almacenado que imprima hola 15 veces usando while

CREATE PROCEDURE HOLA
AS
BEGIN
 DECLARE @contador int;
 SET @contador = 1;

 WHILE @contador <=15
 BEGIN

 print 'Hola #' + CAST(@contador as char);
 SET @contador = @contador +1;

 END

END


exec HOLA



--- 4. Realice un script usando la tabla producto que mientras el promedio de los precios sea menor a 2000 
---- permita aumentar el precio en 10% hacer esta actualizacion solo hasta que algun precio de productos supere
---- 5000.00, si pasa entonces interrumpir el ciclo. Cuando se termine de actualizar dichos valores mostrar el mensaje
---- ya no hay mas precios que actualizar

use almacen

select * from producto

--- Se actualizan los precios de los productos 

UPDATE producto
set precio = 399.99
where marca in('DELL', 'LENOVO', 'TRENDNET', 'TOSHIBA')

UPDATE producto 
set precio = 4000.00
where marca = 'HP'



while (select AVG(precio) from producto) < 1800.00
BEGIN
??update producto set precio = precio * 1.1;
??IF (SELECT MAX(precio) FROM producto) > 5000.00
??break
??else
??continue
END
PRINT 'No hay mas precios que actualizar'   


select * from producto

--- 5. Trabajaremos con la tabla libros de una libreria

create database libreria

use libreria

create table libros (
 codigo int identity,
 titulo varchar(40),
 autor varchar(30),
 editorial varchar(20),
 precio decimal (5,2),
 primary key(codigo)


);


insert into libros (titulo, autor, editorial, precio)
VALUES('UNO','Richard Bach','Planeta',15),
      ('Ilusiones', 'Richard Bach', 'Planeta', 12),
	  ('El aleph', 'Borges', 'Emece', 25),
	  ('Aprenda PHP', 'Mario Molina', 'Nuevo Siglo', 50),
	  ('Matematica estas ahi', 'Paenza', 'Nuevo Siglo',18),
	  ('Puente al infinito', 'Richard Bach','Sudamericana',14),
	  ('Antologia', 'J.L. Borges','Paidos',24),
	  ('Java en 10 minutos', 'Mario Molina', 'Siglo XXI', 45),
	  ('Antologia', 'Borges','Planeta',34)


select * from libros


--- Elimina la tabla libros al estar no vacia, tras la eliminacion usamos el codigo superior para crearla y llenarla nuevamente
if object_id('libros') is not null
drop table libros;


--- Eliminar la tabla ofertas si existe y la creamos con los mismos campos de la tabla libros


if object_id('ofertas') is not null
drop table ofertas


create table ofertas(
codigo int identity,
 titulo varchar(40),
 autor varchar(30),
 editorial varchar(20),
 precio decimal (5,2),
 primary key(codigo)

);



select * from ofertas

	 
--- Crear un procedimiento almacenado llamado sp_promo que seleccione el titulo, autor, editorial y los libros
--- precio no supere los 30 dolares

use libreria

CREATE PROCEDURE sp_promo
as
begin
 select titulo, autor, editorial, precio
 from libros
 where precio <= 30;


end;


exec sp_promo



--- Ingresar en la tabla ofertas el resultado devuelto por el procedimiento almacenado "sp_promo"

insert into ofertas exec sp_promo


--- Visualice el contenido de la tabla ofertas

select * from ofertas

  
	 
	 
































