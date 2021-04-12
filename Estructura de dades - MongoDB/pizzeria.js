db = db.getSiblingDB("pizzeria");
db.dropDatabase();

db.cliente.insertMany([
  {
    id_cliente: 1,
    nombre: "Pepe",
    apellidos: "Garcia",
    direccion: {
      calle: "av.meridiana",
      numero: "34",
      piso: "3",
      puerta: "2",
      ciudad: "Barcelona",
      localidad: "Barcelona",
      provincia: "Barcelona",
      cp: "08016",
      pais: "España",
    },
    pedidos: {
      id_pedido: 1,
      fecha_hora: ISODate("2014-10-19T18:56:20.197Z"),
      tipo: "domicilio",
      detalle: [
        { id_producto: 1, cantidad: 2 },
        { id_producto: 2, cantidad: 2 },
      ],
      precio_total: 19.34,
      id_cliente: 1,
      id_tienda: 1,
      entregas: {
        id_empleado: 1,
        fecha_hora: ISODate("2014-10-19T18:56:20.197Z"),
      },
    },
  },
]);

db.tiendas.insertMany([
  {
    id_tienda: 1,
    direccion: {
      calle: "av.meridiana",
      numero: "34",
      piso: "3",
      puerta: "2",
      ciudad: "Barcelona",
      localidad: "Barcelona",
      provincia: "Barcelona",
      cp: "08016",
    },
    empleados: [
      {
        id_empleado: 1,
        nombre: "luis",
        apellidos: "garcia",
        nif: "435261222h",
        cargo: "repartidor",
      },
      {
        id_empleado: 2,
        nombre: "pedro",
        apellidos: "garcia",
        nif: "435261222h",
        cargo: "cocinero",
      },
    ],
  },
]);
db.productos.insertMany([
  {
    id_producto: 1,
    nombre: "pizza",
    descripción: "Pizza 4 quesos",
    imagen: "pizza.jpg",
    categoria: { nombre: "masa fina" },
    precio: 9.9,
  },
  {
    id_producto: 2,
    nombre: "Burguer",
    descripción: "Burguer americana",
    imagen: "burger.jpg",
    categoria: { nombre: null },
    precio: 9.9,
  },
  {
    id_producto: 3,
    nombre: "bebida",
    descripción: "coca_cola",
    imagen: "coca-cola.jpg",
    categoria: { nombre: null },
    precio: 9.9,
  },
]);
