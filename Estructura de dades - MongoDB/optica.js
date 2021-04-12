db = db.getSiblingDB("optica");
db.dropDatabase();

db.proveedor.insertMany([
  {
    id_proveedor: 1,
    nombre: "optilux",
    direccion: {
      calle: "av.meridiana",
      numero: "34",
      piso: "3",
      puerta: "2",
      ciudad: "Barcelona",
      cp: "08016",
      pais: "España",
    },
    telefono: "933456574",
    fax: "9334456574",
    nif: "453672835h",
    marcas: ["oakley", "Ray-ban"],
  },
]);

db.producto.insertMany([
  {
    id_producto: 1,
    marca: "oakley",
    graduación: [{ cristal_derecho: 1 }, { crista_izquierdo: 1 }],
    tipo_montura: "pasta",
    color_montura: "verde",
    color_vidrio: "transparente",
    precio: 123.56,
  },
]);

db.cliente.insertMany([
  {
    id_cliente: 1,
    nombre: "Juan Garcia",
    dirección: {
      calle: "av.diagonal",
      numero: "0",
      piso: "3",
      puerta: "2",
      ciudad: "Barcelona",
      cp: "08036",
    },
    telefono: "933456574",
    email: "juan@gmail.com",
    fecha_registro: ISODate("2014-10-21"),
    recomendados: { id_cliente: 2, id_cliente: 3 },
    facturas: [
      {
        id_factura: 1,
        detalles: [
          { id_detalle: 1, id_producto: 1, cantidad: 1, precio: 123.56 },
        ],
        vendedor: { id_empleado: 1, nombre: "carlos" },
        Total_factura: 123.56,
      },
    ],
  },
]);
