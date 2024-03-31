CREATE DATABASE Actividad2;
Use Actividad2;

CREATE TABLE Clientes (
    ClienteID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(50),
    Email VARCHAR(50),
    Telefono VARCHAR(15),
    Apellido VARCHAR(15)
);

CREATE TABLE Productos (
    ProductoID INT PRIMARY KEY AUTO_INCREMENT,
    Nombre VARCHAR(100),
    Precio DECIMAL(10, 2),
    Stock INT
);

CREATE TABLE Transacciones (
    TransaccionID INT PRIMARY KEY AUTO_INCREMENT,
    ClienteID INT,
    Fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ClienteID) REFERENCES Clientes(ClienteID)
);

CREATE TABLE Detalles_Transaccion (
    DetalleID INT PRIMARY KEY AUTO_INCREMENT,
    TransaccionID INT,
    ProductoID INT,
    Cantidad INT,
    PrecioUnitario DECIMAL(10, 2),
    FOREIGN KEY (TransaccionID) REFERENCES Transacciones(TransaccionID),
    FOREIGN KEY (ProductoID) REFERENCES Productos(ProductoID)
);


# Procedimientos almacenado para cliente

CREATE PROCEDURE InsertarCliente(
    IN p_Nombre VARCHAR(50),
    IN p_Email VARCHAR(50),
    IN p_Telefono VARCHAR(15)
)
BEGIN
    INSERT INTO Clientes (Nombre, Email, Telefono) VALUES (p_Nombre, p_Email, p_Telefono);
END;

CREATE PROCEDURE ActualizarCliente(
    IN p_ClienteID INT,
    IN p_Nombre VARCHAR(50),
    IN p_Email VARCHAR(50),
    IN p_Telefono VARCHAR(15)
)
BEGIN
    UPDATE Clientes SET Nombre = p_Nombre, Email = p_Email, Telefono = p_Telefono WHERE ClienteID = p_ClienteID;
END;

CREATE PROCEDURE EliminarCliente(IN p_ClienteID INT)
BEGIN
    DELETE FROM Clientes WHERE ClienteID = p_ClienteID;
END;

CREATE PROCEDURE ObtenerClientePorID(IN p_ClienteID INT)
BEGIN
    SELECT * FROM Clientes WHERE ClienteID = p_ClienteID;
END;

CREATE PROCEDURE ObtenerClientes()
BEGIN
    SELECT * FROM Clientes;
END;

# Insertamos datos para Cliente

CALL InsertarCliente('Raul Arango','rarango@gmail.com', '5509-8566');
CALL InsertarCliente('Andrea Godinez','agodinez@gmail.com', '3317-9824');
CALL InsertarCliente('Manuela Perez','aperez@gmail.com', '3312-5698');
CALL InsertarCliente('Alejandra Salomon','asalomon@gmail.com', '2567-9456');
CALL InsertarCliente('Josue Pereira','jpereira@gmail.com', '5534-7854');

# Actualizamos datos para cliente

CALL ActualizarCliente(2,'Raul Arango 1','rarango@gmail.com', '5509-8566');
CALL ActualizarCliente(3,'Andrea Godinez 1','agodinez@gmail.com', '3317-9824');
CALL ActualizarCliente(4,'Manuela Perez 1','aperez@gmail.com', '3312-5698');
CALL ActualizarCliente(5,'Alejandra Salomon 1','asalomon@gmail.com', '2567-9456');

# Eliminamos un cliente
CALL EliminarCliente(6);

# Obtenemos un cliente por ID
CALL ObtenerClientePorID(1);

# Obtener todos los clientes
CALL ObtenerClientes();

# Procedimientos almacenados para productos

CREATE PROCEDURE InsertarProducto(
    IN p_Nombre VARCHAR(100),
    IN p_Precio DECIMAL(10, 2),
    IN p_Stock INT
)
BEGIN
    INSERT INTO Productos (Nombre, Precio, Stock) VALUES (p_Nombre, p_Precio, p_Stock);
END;

CREATE PROCEDURE ActualizarProducto(
    IN p_ProductoID INT,
    IN p_Nombre VARCHAR(100),
    IN p_Precio DECIMAL(10, 2),
    IN p_Stock INT
)
BEGIN
    UPDATE Productos SET Nombre = p_Nombre, Precio = p_Precio, Stock = p_Stock WHERE ProductoID = p_ProductoID;
END;

CREATE PROCEDURE EliminarProducto(IN p_ProductoID INT)
BEGIN
    DELETE FROM Productos WHERE ProductoID = p_ProductoID;
END;

CREATE PROCEDURE ObtenerProductos()
BEGIN
    SELECT * FROM Productos;
END;

CREATE PROCEDURE ObtenerProductoPorID(IN p_ProductoID INT)
BEGIN
    SELECT * FROM Productos WHERE ProductoID = p_ProductoID;
END;

# Insertamos datos para producto

CALL InsertarProducto('Leche', 2.99, 100);
CALL InsertarProducto('Pan', 1.49, 200);
CALL InsertarProducto('Huevos', 3.99, 50);
CALL InsertarProducto('Arroz', 5.49, 150);
CALL InsertarProducto('Pollo', 7.99, 80);
CALL InsertarProducto('Harina', 12.99, 6);

# Actualizamos datos para producto

CALL ActualizarProducto(1,'Leche 1', 2.99, 100);
CALL ActualizarProducto(2,'Pan 1', 1.49, 200);
CALL ActualizarProducto(3,'Huevos 1', 3.99, 50);
CALL ActualizarProducto(4,'Arroz 1', 5.49, 150);
CALL ActualizarProducto(5,'Pollo 1', 7.99, 80);
CALL ActualizarProducto(6,'Harina 1', 12.99, 6);

# Eliminamos un producto
CALL EliminarProducto(6);

# Obtenemos un producto por ID
CALL ObtenerProductoPorID(1);

# Obtener todos los productos
CALL ObtenerProductos();


# Procedimientos almacenados para Transacciones

CREATE PROCEDURE InsertarTransaccion(IN p_ClienteID INT)
BEGIN
    INSERT INTO Transacciones (ClienteID) VALUES (p_ClienteID);
END;

CREATE PROCEDURE InsertarDetalleTransaccion(
    IN p_TransaccionID INT,
    IN p_ProductoID INT,
    IN p_Cantidad INT,
    IN p_PrecioUnitario DECIMAL(10, 2)
)
BEGIN
    INSERT INTO Detalles_Transaccion (TransaccionID, ProductoID, Cantidad, PrecioUnitario)
    VALUES (p_TransaccionID, p_ProductoID, p_Cantidad, p_PrecioUnitario);
END;

CREATE PROCEDURE ObtenerTransacciones()
BEGIN
    SELECT * FROM Transacciones;
END;

CREATE PROCEDURE ObtenerDetallesTransaccionPorID(IN p_TransaccionID INT)
BEGIN
    SELECT * FROM Detalles_Transaccion WHERE TransaccionID = p_TransaccionID;
END;


# Insertar transaccion

CALL InsertarTransaccion(1);
CALL InsertarTransaccion(2);

# Insertar detalle de transaccion

CALL InsertarDetalleTransaccion(1, 1, 2, 5.99);
CALL InsertarDetalleTransaccion(1, 2, 3, 1.99);
CALL InsertarDetalleTransaccion(2, 3, 1, 3.49);
CALL InsertarDetalleTransaccion(2, 4, 2, 4.99);
CALL InsertarDetalleTransaccion(2, 5, 1, 7.99);

# Obtener todas las transacciones
CALL ObtenerTransacciones();

# Obtener detalles de una transacción por ID
CALL ObtenerDetallesTransaccionPorID(1);


# Vista productos

CREATE VIEW VistaDetallesProductos AS
SELECT
    DT.DetalleID,
    DT.TransaccionID,
    DT.ProductoID,
    DT.Cantidad,
    DT.PrecioUnitario,
    P.Nombre AS NombreProducto,
    P.Precio AS PrecioProducto
FROM Detalles_Transaccion DT
INNER JOIN Productos P ON DT.ProductoID = P.ProductoID;

SELECT * FROM VistaDetallesProductos;

# Vista transacciones

CREATE VIEW VistaTransaccionesDetalles AS
SELECT
    T.TransaccionID,
    T.ClienteID,
    T.Fecha,
    DT.ProductoID,
    DT.Cantidad,
    DT.PrecioUnitario
FROM Transacciones T
INNER JOIN Detalles_Transaccion DT ON T.TransaccionID = DT.TransaccionID;

SELECT * FROM VistaTransaccionesDetalles;