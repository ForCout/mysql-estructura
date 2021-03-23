cnx = new Mongo("localhost");
db = cnx.getDB('pizzeria');
db.dropDatabase();

db.cliente.insert(
    {
        'id_cliente': 1,
        'nombre': 'Pepe',
        'apellidos': 'Garcia',
        'direccion': {
            'calle':'av.meridiana' ,
            'numero': '34',
            'piso': '3',
            'puerta': '2',
            'ciudad': 'Barcelona',
            'localidad': 'Barcelona',
            'provincia':'Barcelona',
            'cp': '08016',
            'pais': 'España'
        
        }
    }
)

db.provincias.insert(
    {
        'id_provincia': 1,
        'nombre': 'Barcelona',
        'localidades': [{ 'id_localidad': 1, 'nombre': 'Barcelona' }, { 'id_localidad': 2, 'nombre': 'Badalona' }],
        
            
    }
)

db.pedidos.insert(
    {
        'id_pedido': 1,
        'fecha/hora': ISODate("2014-10-19T18:56:20.197Z"),
        'tipo': 'domicilio',
        'cantidades': [{ 'id_producto': 1, 'cantidad': 2 }, { 'id_producto': 2, 'cantidad': 2 }],
        'precio_total': 19.34,
        'id_cliente': 1,
        'id_tienda': 1,
        'entregas': { 'id_empleado':1,'fecha/hora':ISODate("2014-10-19T18:56:20.197Z")}

        
    }
)

db.tiendas.insert(
    {
        'id_tienda': 1,
        'direccion': {
            'calle':'av.meridiana' ,
            'numero': '34',
            'piso': '3',
            'puerta': '2',
            'ciudad': 'Barcelona',
            'localidad': 'Barcelona',
            'provincia':'Barcelona',
            'cp': '08016',
            
        
        },
        'empleados': [{ 'id_empleado': 1, 'nombre': 'luis', 'apellidos': 'garcia', 'nif': '435261222h', 'cargo': 'repartidor' }, { 'id_empleado': 2, 'nombre': 'pedro', 'apellidos': 'garcia', 'nif': '435261222h', 'cargo': 'cocinero' }]
        
    }
)
db.productos.insert(
    {
        'id_producto': 1,
        'nombre': 'pizza 4 quesos',
        'descripción': 'Pizza formada por variedades de quesos',
        'imagen': '',
        'categoria': 'pizzas',
        'precio':9.90
    }
)
db.categorias_pizza.insert(
    {
        'id_categoria': 1,
        'nombre': 'masa gruesa',
        'productos': [{ 'id_producto': 1 },{ 'id_producto': 2 },{ 'id_producto': 3 }]
    }
)
