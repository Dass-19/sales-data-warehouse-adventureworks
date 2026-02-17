/* =========================================================
   DATA WAREHOUSE SCHEMA — AdventureWorks Sales
   Author: Dass
   ========================================================= */


/* ============================
   DIMENSION: PRODUCT
   ============================ */

CREATE TABLE dimproduct
(
  PK_dimProduct BIGSERIAL,
  version INTEGER,
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  ID_Producto INTEGER,
  NombreProducto TEXT,
  "Subcategoría" TEXT,
  "Categoría" TEXT,
  Color TEXT,
  "Tamaño" TEXT,
  Modelo TEXT,
  TipoProducto TEXT
);

CREATE INDEX idx_dimproduct_lookup ON dimproduct(ID_Producto);
CREATE INDEX idx_dimproduct_tk ON dimproduct(PK_dimProduct);


/* ============================
   DIMENSION: CUSTOMER
   ============================ */

CREATE TABLE dimcliente
(
  PK_dimCliente BIGSERIAL,
  version INTEGER,
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  ID_Customer INTEGER,
  NombreCompleto TEXT,
  Genero TEXT,
  TipoCliente TEXT,
  Ciudad TEXT,
  Estado TEXT,
  Pais TEXT
);

CREATE INDEX idx_dimCliente_lookup ON dimcliente(ID_Customer);
CREATE INDEX idx_dimCliente_tk ON dimcliente(PK_dimCliente);


/* ============================
   DIMENSION: EMPLOYEE
   ============================ */

CREATE TABLE dimempleado
(
  PK_dimEmpleado BIGSERIAL,
  version INTEGER,
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  ID_Employee INTEGER,
  NombreCompleto TEXT,
  Puesto TEXT,
  Departamento TEXT,
  FechaIngreso TIMESTAMP,
  Estado BOOLEAN
);

CREATE INDEX idx_dimEmpleado_lookup ON dimempleado(ID_Employee);
CREATE INDEX idx_dimEmpleado_tk ON dimempleado(PK_dimEmpleado);


/* ============================
   DIMENSION: STORE / TERRITORY
   ============================ */

CREATE TABLE dimtienda
(
  PK_dimTienda BIGSERIAL,
  version INTEGER,
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  territoryid INTEGER,
  NombreTerritorio VARCHAR(50),
  Pais VARCHAR(50),
  Grupo TEXT
);

CREATE INDEX idx_dimtienda_lookup ON dimtienda(territoryid);
CREATE INDEX idx_dimtienda_tk ON dimtienda(PK_dimTienda);


/* ============================
   DIMENSION: TIME
   ============================ */

CREATE TABLE dimtiempo
(
  PK_dimTiempo BIGSERIAL,
  version INTEGER,
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  FechaCompleta TIMESTAMP,
  Dia DOUBLE PRECISION,
  Mes DOUBLE PRECISION,
  MesNombre VARCHAR(10),
  "Año" DOUBLE PRECISION,
  Trimestre DOUBLE PRECISION,
  DiaSemana DOUBLE PRECISION
);

CREATE INDEX idx_dimtiempo_lookup ON dimtiempo(FechaCompleta);
CREATE INDEX idx_dimtiempo_tk ON dimtiempo(PK_dimTiempo);


/* ============================
   FACT TABLE: SALES
   ============================ */

CREATE TABLE factventas (
    PK_factVentas BIGSERIAL PRIMARY KEY,
    id_dimProducto BIGINT,
    id_dimCliente BIGINT,
    id_dimEmpleado BIGINT,
    id_dimTienda BIGINT,
    id_dimTiempo BIGINT,
    CantidadVendida INT,
    PrecioUnitario DECIMAL(10,2),
    DescuentoUnitario DECIMAL(10,2),
    SubtotalVenta DECIMAL(10,2),

    FOREIGN KEY (id_dimProducto)
        REFERENCES dimproduct(PK_dimProduct),

    FOREIGN KEY (id_dimCliente)
        REFERENCES dimcliente(PK_dimCliente),

    FOREIGN KEY (id_dimEmpleado)
        REFERENCES dimempleado(PK_dimEmpleado),

    FOREIGN KEY (id_dimTienda)
        REFERENCES dimtienda(PK_dimTienda),

    FOREIGN KEY (id_dimTiempo)
        REFERENCES dimtiempo(PK_dimTiempo)
);


/* =========================================================
   DATA QUALITY CHECKS — KEY CONSISTENCY
   ========================================================= */

-- Productos sin correspondencia
SELECT id_dimproducto
FROM factventas fv
LEFT JOIN dimproduct dp
    ON fv.id_dimproducto = dp.pk_dimproduct
WHERE dp.pk_dimproduct IS NULL;

-- Clientes sin correspondencia
SELECT id_dimcliente
FROM factventas fv
LEFT JOIN dimcliente dc
    ON fv.id_dimcliente = dc.pk_dimcliente
WHERE dc.pk_dimcliente IS NULL;

-- Empleados sin correspondencia
SELECT id_dimempleado
FROM factventas fv
LEFT JOIN dimempleado de
    ON fv.id_dimempleado = de.pk_dimempleado
WHERE de.pk_dimempleado IS NULL;

-- Tiendas sin correspondencia
SELECT id_dimtienda
FROM factventas fv
LEFT JOIN dimtienda dt
    ON fv.id_dimtienda = dt.pk_dimtienda
WHERE dt.pk_dimtienda IS NULL;

-- Fechas sin correspondencia
SELECT id_dimtiempo
FROM factventas fv
LEFT JOIN dimtiempo tt
    ON fv.id_dimtiempo = tt.pk_dimtiempo
WHERE tt.pk_dimtiempo IS NULL;
