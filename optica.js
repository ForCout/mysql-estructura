cnx = new Mongo("localhost");
db = cnx.getDB('optica');
db.dropDatabase();
db.proveedor.insert(
    {
        'id_producto':1,
        'nombre': 'optilux',
        'direccion': {
            'calle': 'av.meridiana',
            'numero': '34',
            'piso': '3',
            'puerta': '2',
            'ciudad': 'Barcelona',
            'cp': '08016',
            'pais':'España'
            
        },
        'telefono': '933456574',
        'fax': '9334456574',
        'nif': '453672835h',
        'marcas':['oakley','Ray-ban']
        
    }
)

db.producto.insert(
    {
        'id_producto':1,
        'marca': 'oakley',
        'graduación': [1.2, 1],
        'tipo_montura': 'pasta',
        'color_montura': 'verde',
        'color_vidrio': ['transparente', 'transparente'],
        'precio':123.56
    }
)

db.cliente.insert(
    {
        'id_cliente': 1,
        'nombre': 'Juan Garcia',
        'dirección': {
            'calle': 'av.diagonal',
            'numero': '0',
            'piso': '3',
            'puerta': '2',
            'ciudad': 'Barcelona',
            'cp': '08036',
        },
        'telefono': '933456574',
        'email': 'juan@gmail.com',
        'fecha_registro': ISODate("2014-10-21"),
        'recomendados': [{ 'id_cliente': 2 }, { 'id_cliente': 3 }],
        'facturas': 
            [
                { 'id_factura': 1 },
                { 'detalles': { 'detalle_1': [{ 'id_producto': 1 }, { 'cantidad': 1 }, { 'precio_total': 123.56 }] } },
                { 'vendedor': { 'id_empleado':1} },
                { 'Total_factura': 123.56 }
            ]
        
        
    }
)
db.empleado.insert(
    {
        'id_empleado':1,
        'nombre':'Carlos'
    }

)


