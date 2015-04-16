#encoding: utf-8
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
administrador = Funcionario.create!(login:'intt_super_admin',
                                    password: '12345678',
                                    nombre: 'Jimi',
                                    apellido: 'Hendrix',
                                    nacionalidad: 'E',
                                    cedula: 10,
                                    direccion: 'Por estas calles',
                                    email: 'super_admin@intt.gob.ve')
puts '### ADMINISTRADOR CREADO ###'

Rol.create!([{nombre:'Analista ET', funcion_sistemas: FuncionSistema.where(nombre: 'manage', clase_controlador: 'InteresadoCet')},
             {nombre: 'Funcionario ET'},
             {nombre: 'Gerente Servicios Conexos'},
             {nombre:'Inspector ET'},
             {nombre: 'Verificador ET'}])

puts '### ROLES CREADOS ###'

Rol.create!(nombre: 'Administrador Conex-ET',
            funcionarios: Funcionario.where(id: administrador),
            funcion_sistemas: FuncionSistema.where(nombre: 'manage'))

puts '### ROL DE ADMINISTRADOR CREADO Y FUNCIONES ASIGNADAS ###'

puts '### SEEDEANDO TIPOS DE ESCUELA'
TipoEscuela.create!([{nombre: 'Clase A (Licencia de 2do, 3er y 4to grado)'},
                     {nombre: 'Clase B (Licencia de 2do, 3er, 4to y 5to grado)'},
                     {nombre: 'Clase C (Licencia de 4to, 5to y Título Profesional)'}])

puts '### SEEDEANDO ESTADOS ###'
amazonas = Estado.create!(nombre: 'Amazonas', codificacion: 'AS')
anzoategui = Estado.create!(nombre: 'Anzoátegui', codificacion: 'AT')
apure = Estado.create!(nombre: 'Apure', codificacion: 'AP')
aragua = Estado.create!(nombre: 'Aragua', codificacion: 'AG')
barinas = Estado.create!(nombre: 'Barinas', codificacion: 'BS')
bolivar = Estado.create!(nombre: 'Bolívar', codificacion: 'BR')
carabobo = Estado.create!(nombre: 'Carabobo', codificacion: 'CB')
cojedes = Estado.create!(nombre: 'Cojedes', codificacion: 'CS')
delta_amacuro = Estado.create!(nombre: 'Delta Amacuro', codificacion: 'DA')
falcon = Estado.create!(nombre: 'Falcón', codificacion: 'FN')
guarico = Estado.create!(nombre: 'Guárico', codificacion: 'GC')
lara = Estado.create!(nombre: 'Lara', codificacion: 'LR')
merida = Estado.create!(nombre: 'Mérida', codificacion: 'MD')
miranda = Estado.create!(nombre: 'Miranda', codificacion: 'MI')
monagas = Estado.create!(nombre: 'Monagas', codificacion: 'MG')
nueva_esparta = Estado.create!(nombre: 'Nueva Esparta', codificacion: 'NE') #estado margarita x'D
portuguesa = Estado.create!(nombre: 'Portuguesa', codificacion: 'PS')
sucre = Estado.create!(nombre: 'Sucre', codificacion: 'SR')
tachira = Estado.create!(nombre: 'Tachira', codificacion: 'TR')
trujillo = Estado.create!(nombre: 'Trujillo', codificacion: 'TL') #tierra santa 0:D
vargas = Estado.create!(nombre: 'Vargas', codificacion: 'VA')
yaracuy = Estado.create!(nombre: 'Yaracuy', codificacion: 'YY')
zulia = Estado.create!(nombre: 'Zulia', codificacion: 'ZL')
distrito_capital = Estado.create!(nombre: 'Distrito Capital', codificacion: 'DC')
dependencias_federales = Estado.create!(nombre: 'Dependencias Federales', codificacion: nil)

puts '### SEEDEANDO CIUDADES ###'

Ciudad.create!([{nombre: 'Maroa', estado_id:amazonas.id},
                {nombre: 'Puerto Ayacucho', estado_id:amazonas.id},
                {nombre: 'San Fernando de Atabapo', estado_id: amazonas.id},
                {nombre: 'Anaco', estado_id: anzoategui.id},
                {nombre: 'Aragua de Barcelona', estado_id: anzoategui.id},
                {nombre: 'Barcelona', estado_id: anzoategui.id},
                {nombre: 'Boca de Uchire', estado_id: anzoategui.id},
                {nombre: 'Cantaura', estado_id: anzoategui.id},
                {nombre: 'Clarines', estado_id: anzoategui.id},
                {nombre: 'El Chaparro', estado_id: anzoategui.id},
                {nombre: 'El Pao Anzoátegui', estado_id: anzoategui.id},
                {nombre: 'El Tigre', estado_id: anzoategui.id},
                {nombre: 'El Tigrito', estado_id: anzoategui.id},
                {nombre: 'Guanape', estado_id: anzoategui.id},
                {nombre: 'Guanta', estado_id: anzoategui.id},
                {nombre: 'Lechería', estado_id: anzoategui.id},
                {nombre: 'Onoto', estado_id: anzoategui.id},
                {nombre: 'Pariaguán', estado_id: anzoategui.id},
                {nombre: 'Píritu', estado_id: anzoategui.id},
                {nombre: 'Puerto La Cruz', estado_id: anzoategui.id},
                {nombre: 'Puerto Píritu', estado_id: anzoategui.id},
                {nombre: 'Sabana de Uchire', estado_id: anzoategui.id},
                {nombre: 'San Mateo Anzoátegui', estado_id: anzoategui.id},
                {nombre: 'San Pablo Anzoátegui', estado_id: anzoategui.id},
                {nombre: 'San Tomé', estado_id: anzoategui.id},
                {nombre: 'Santa Ana de Anzoátegui', estado_id: anzoategui.id},
                {nombre: 'Santa Fe Anzoátegui', estado_id: anzoategui.id},
                {nombre: 'Santa Rosa', estado_id: anzoategui.id},
                {nombre: 'Soledad', estado_id: anzoategui.id},
                {nombre: 'Urica', estado_id: anzoategui.id},
                {nombre: 'Valle de Guanape', estado_id: anzoategui.id},
                {nombre: 'Achaguas', estado_id: apure.id},
                {nombre: 'Biruaca', estado_id: apure.id},
                {nombre: 'Bruzual', estado_id: apure.id},
                {nombre: 'El Amparo', estado_id: apure.id},
                {nombre: 'El Nula', estado_id: apure.id},
                {nombre: 'Elorza', estado_id: apure.id},
                {nombre: 'Guasdualito', estado_id: apure.id},
                {nombre: 'Mantecal', estado_id: apure.id},
                {nombre: 'Puerto Páez', estado_id: apure.id},
                {nombre: 'San Fernando de Apure', estado_id: apure.id},
                {nombre: 'San Juan de Payara', estado_id: apure.id},
                {nombre: 'Barbacoas', estado_id: aragua.id},
                {nombre: 'Cagua', estado_id: aragua.id},
                {nombre: 'Camatagua', estado_id: aragua.id},
                {nombre: 'Choroní', estado_id: aragua.id},
                {nombre: 'Colonia Tovar', estado_id: aragua.id},
                {nombre: 'El Consejo', estado_id: aragua.id},
                {nombre: 'La Victoria', estado_id: aragua.id},
                {nombre: 'Las Tejerías', estado_id: aragua.id},
                {nombre: 'Magdaleno', estado_id: aragua.id},
                {nombre: 'Maracay', estado_id: aragua.id},
                {nombre: 'Ocumare de La Costa', estado_id: aragua.id},
                {nombre: 'Palo Negro', estado_id: aragua.id},
                {nombre: 'San Casimiro', estado_id: aragua.id},
                {nombre: 'San Mateo', estado_id: aragua.id},
                {nombre: 'San Sebastián', estado_id: aragua.id},
                {nombre: 'Santa Cruz de Aragua', estado_id: aragua.id},
                {nombre: 'Tocorón', estado_id: aragua.id},
                {nombre: 'Turmero', estado_id: aragua.id},
                {nombre: 'Villa de Cura', estado_id: aragua.id},
                {nombre: 'Zuata', estado_id: aragua.id},
                {nombre: 'Barinas', estado_id: barinas.id},
                {nombre: 'Barinitas', estado_id: barinas.id},
                {nombre: 'Barrancas', estado_id: barinas.id},
                {nombre: 'Calderas', estado_id: barinas.id},
                {nombre: 'Capitanejo', estado_id: barinas.id},
                {nombre: 'Ciudad Bolivia', estado_id: barinas.id},
                {nombre: 'El Cantón', estado_id: barinas.id},
                {nombre: 'Las Veguitas', estado_id: barinas.id},
                {nombre: 'Libertad de Barinas', estado_id: barinas.id},
                {nombre: 'Sabaneta', estado_id: barinas.id},
                {nombre: 'Santa Bárbara de Barinas', estado_id: barinas.id},
                {nombre: 'Socopó', estado_id: barinas.id},
                {nombre: 'Caicara del Orinoco', estado_id: bolivar.id},
                {nombre: 'Canaima', estado_id: bolivar.id},
                {nombre: 'Ciudad Bolívar', estado_id: bolivar.id},
                {nombre: 'Ciudad Piar', estado_id: bolivar.id},
                {nombre: 'El Callao', estado_id: bolivar.id},
                {nombre: 'El Dorado', estado_id: bolivar.id},
                {nombre: 'El Manteco', estado_id: bolivar.id},
                {nombre: 'El Palmar', estado_id: bolivar.id},
                {nombre: 'El Pao', estado_id: bolivar.id},
                {nombre: 'Guasipati', estado_id: bolivar.id},
                {nombre: 'Guri', estado_id: bolivar.id},
                {nombre: 'La Paragua', estado_id: bolivar.id},
                {nombre: 'Matanzas', estado_id: bolivar.id},
                {nombre: 'Puerto Ordaz', estado_id: bolivar.id},
                {nombre: 'San Félix', estado_id: bolivar.id},
                {nombre: 'Santa Elena de Uairén', estado_id: bolivar.id},
                {nombre: 'Tumeremo', estado_id: bolivar.id},
                {nombre: 'Unare', estado_id: bolivar.id},
                {nombre: 'Upata', estado_id: bolivar.id},
                {nombre: 'Bejuma', estado_id: carabobo.id},
                {nombre: 'Belén', estado_id: carabobo.id},
                {nombre: 'Campo de Carabobo', estado_id: carabobo.id},
                {nombre: 'Canoabo', estado_id: carabobo.id},
                {nombre: 'Central Tacarigua', estado_id: carabobo.id},
                {nombre: 'Chirgua', estado_id: carabobo.id},
                {nombre: 'Ciudad Alianza', estado_id: carabobo.id},
                {nombre: 'El Palito', estado_id: carabobo.id},
                {nombre: 'Guacara', estado_id: carabobo.id},
                {nombre: 'Guigue', estado_id: carabobo.id},
                {nombre: 'Las Trincheras', estado_id: carabobo.id},
                {nombre: 'Los Guayos', estado_id: carabobo.id},
                {nombre: 'Mariara', estado_id: carabobo.id},
                {nombre: 'Miranda', estado_id: carabobo.id},
                {nombre: 'Montalbán', estado_id: carabobo.id},
                {nombre: 'Morón', estado_id: carabobo.id},
                {nombre: 'Naguanagua', estado_id: carabobo.id},
                {nombre: 'Puerto Cabello', estado_id: carabobo.id},
                {nombre: 'San Joaquín', estado_id: carabobo.id},
                {nombre: 'Tocuyito', estado_id: carabobo.id},
                {nombre: 'Urama', estado_id: carabobo.id},
                {nombre: 'Valencia', estado_id: carabobo.id},
                {nombre: 'Vigirimita', estado_id: carabobo.id},
                {nombre: 'Aguirre', estado_id: cojedes.id},
                {nombre: 'Apartaderos Cojedes', estado_id: cojedes.id},
                {nombre: 'Arismendi', estado_id: cojedes.id},
                {nombre: 'Camuriquito', estado_id: cojedes.id},
                {nombre: 'El Baúl', estado_id: cojedes.id},
                {nombre: 'El Limón', estado_id: cojedes.id},
                {nombre: 'El Pao Cojedes', estado_id: cojedes.id},
                {nombre: 'El Socorro', estado_id: cojedes.id},
                {nombre: 'La Aguadita', estado_id: cojedes.id},
                {nombre: 'Las Vegas', estado_id: cojedes.id},
                {nombre: 'Libertad de Cojedes', estado_id: cojedes.id},
                {nombre: 'Mapuey', estado_id: cojedes.id},
                {nombre: 'Piñedo', estado_id: cojedes.id},
                {nombre: 'Samancito', estado_id: cojedes.id},
                {nombre: 'San Carlos', estado_id: cojedes.id},
                {nombre: 'Sucre', estado_id: cojedes.id},
                {nombre: 'Tinaco', estado_id: cojedes.id},
                {nombre: 'Tinaquillo', estado_id: cojedes.id},
                {nombre: 'Vallecito', estado_id: cojedes.id},
                {nombre: 'Tucupita', estado_id: delta_amacuro.id},
                {nombre: 'Tucaní', estado_id: merida.id},
                {nombre: 'El Junquito', estado_id: distrito_capital.id},
                {nombre: 'Adícora', estado_id: falcon.id},
                {nombre: 'Boca de Aroa', estado_id: falcon.id},
                {nombre: 'Cabure', estado_id: falcon.id},
                {nombre: 'Capadare', estado_id: falcon.id},
                {nombre: 'Capatárida', estado_id: falcon.id},
                {nombre: 'Chichiriviche', estado_id: falcon.id},
                {nombre: 'Churuguara', estado_id: falcon.id},
                {nombre: 'Coro', estado_id: falcon.id},
                {nombre: 'Cumarebo', estado_id: falcon.id},
                {nombre: 'Dabajuro', estado_id: falcon.id},
                {nombre: 'Judibana', estado_id: falcon.id},
                {nombre: 'La Cruz de Taratara', estado_id: falcon.id},
                {nombre: 'La Vela de Coro', estado_id: falcon.id},
                {nombre: 'Los Taques', estado_id: falcon.id},
                {nombre: 'Maparari', estado_id: falcon.id},
                {nombre: 'Mene de Mauroa', estado_id: falcon.id},
                {nombre: 'Mirimire', estado_id: falcon.id},
                {nombre: 'Pedregal', estado_id: falcon.id},
                {nombre: 'Píritu Falcón', estado_id: falcon.id},
                {nombre: 'Pueblo Nuevo Falcón', estado_id: falcon.id},
                {nombre: 'Puerto Cumarebo', estado_id: falcon.id},
                {nombre: 'Punta Cardón', estado_id: falcon.id},
                {nombre: 'Punto Fijo', estado_id: falcon.id},
                {nombre: 'San Juan de Los Cayos', estado_id: falcon.id},
                {nombre: 'San Luis', estado_id: falcon.id},
                {nombre: 'Santa Ana Falcón', estado_id: falcon.id},
                {nombre: 'Santa Cruz De Bucaral', estado_id: falcon.id},
                {nombre: 'Tocopero', estado_id: falcon.id},
                {nombre: 'Tocuyo de La Costa', estado_id: falcon.id},
                {nombre: 'Tucacas', estado_id: falcon.id},
                {nombre: 'Yaracal', estado_id: falcon.id},
                {nombre: 'Altagracia de Orituco', estado_id: guarico.id},
                {nombre: 'Cabruta', estado_id: guarico.id},
                {nombre: 'Calabozo', estado_id: guarico.id},
                {nombre: 'Camaguán', estado_id: guarico.id},
                {nombre: 'Chaguaramas Guárico', estado_id: guarico.id},
                {nombre: 'El Socorro', estado_id: guarico.id},
                {nombre: 'El Sombrero', estado_id: guarico.id},
                {nombre: 'Las Mercedes de Los Llanos', estado_id: guarico.id},
                {nombre: 'Lezama', estado_id: guarico.id},
                {nombre: 'Onoto', estado_id: guarico.id},
                {nombre: 'Ortíz', estado_id: guarico.id},
                {nombre: 'San José de Guaribe', estado_id: guarico.id},
                {nombre: 'San Juan de Los Morros', estado_id: guarico.id},
                {nombre: 'San Rafael de Laya', estado_id: guarico.id},
                {nombre: 'Santa María de Ipire', estado_id: guarico.id},
                {nombre: 'Tucupido', estado_id: guarico.id},
                {nombre: 'Valle de La Pascua', estado_id: guarico.id},
                {nombre: 'Zaraza', estado_id: guarico.id},
                {nombre: 'Aguada Grande', estado_id: lara.id},
                {nombre: 'Atarigua', estado_id: lara.id},
                {nombre: 'Barquisimeto', estado_id: lara.id},
                {nombre: 'Bobare', estado_id: lara.id},
                {nombre: 'Cabudare', estado_id: lara.id},
                {nombre: 'Carora', estado_id: lara.id},
                {nombre: 'Cubiro', estado_id: lara.id},
                {nombre: 'Cují', estado_id: lara.id},
                {nombre: 'Duaca', estado_id: lara.id},
                {nombre: 'El Manzano', estado_id: lara.id},
                {nombre: 'El Tocuyo', estado_id: lara.id},
                {nombre: 'Guaríco', estado_id: lara.id},
                {nombre: 'Humocaro Alto', estado_id: lara.id},
                {nombre: 'Humocaro Bajo', estado_id: lara.id},
                {nombre: 'La Miel', estado_id: lara.id},
                {nombre: 'Moroturo', estado_id: lara.id},
                {nombre: 'Quíbor', estado_id: lara.id},
                {nombre: 'Río Claro', estado_id: lara.id},
                {nombre: 'Sanare', estado_id: lara.id},
                {nombre: 'Santa Inés', estado_id: lara.id},
                {nombre: 'Sarare', estado_id: lara.id},
                {nombre: 'Siquisique', estado_id: lara.id},
                {nombre: 'Tintorero', estado_id: lara.id},
                {nombre: 'Apartaderos Mérida', estado_id: merida.id},
                {nombre: 'Arapuey', estado_id: merida.id},
                {nombre: 'Bailadores', estado_id: merida.id},
                {nombre: 'Caja Seca', estado_id: merida.id},
                {nombre: 'Canaguá', estado_id: merida.id},
                {nombre: 'Chachopo', estado_id: merida.id},
                {nombre: 'Chiguara', estado_id: merida.id},
                {nombre: 'Ejido', estado_id: merida.id},
                {nombre: 'El Vigía', estado_id: merida.id},
                {nombre: 'La Azulita', estado_id: merida.id},
                {nombre: 'La Playa', estado_id: merida.id},
                {nombre: 'Lagunillas Mérida', estado_id: merida.id},
                {nombre: 'Mérida', estado_id: merida.id},
                {nombre: 'Mesa de Bolívar', estado_id: merida.id},
                {nombre: 'Mucuchíes', estado_id: merida.id},
                {nombre: 'Mucujepe', estado_id: merida.id},
                {nombre: 'Mucuruba', estado_id: merida.id},
                {nombre: 'Nueva Bolivia', estado_id: merida.id},
                {nombre: 'Palmarito', estado_id: merida.id},
                {nombre: 'Pueblo Llano', estado_id: merida.id},
                {nombre: 'Santa Cruz de Mora', estado_id: merida.id},
                {nombre: 'Santa Elena de Arenales', estado_id: merida.id},
                {nombre: 'Santo Domingo', estado_id: merida.id},
                {nombre: 'Tabáy', estado_id: merida.id},
                {nombre: 'Timotes', estado_id: merida.id},
                {nombre: 'Torondoy', estado_id: merida.id},
                {nombre: 'Tovar', estado_id: merida.id},
                {nombre: 'Tucani', estado_id: merida.id},
                {nombre: 'Zea', estado_id: merida.id},
                {nombre: 'Araguita', estado_id: miranda.id},
                {nombre: 'Carrizal', estado_id: miranda.id},
                {nombre: 'Caucagua', estado_id: miranda.id},
                {nombre: 'Chaguaramas Miranda', estado_id: miranda.id},
                {nombre: 'Charallave', estado_id: miranda.id},
                {nombre: 'Chirimena', estado_id: miranda.id},
                {nombre: 'Chuspa', estado_id: miranda.id},
                {nombre: 'Cúa', estado_id: miranda.id},
                {nombre: 'Cupira', estado_id: miranda.id},
                {nombre: 'Curiepe', estado_id: miranda.id},
                {nombre: 'El Guapo', estado_id: miranda.id},
                {nombre: 'El Jarillo', estado_id: miranda.id},
                {nombre: 'Filas de Mariche', estado_id: miranda.id},
                {nombre: 'Guarenas', estado_id: miranda.id},
                {nombre: 'Guatire', estado_id: miranda.id},
                {nombre: 'Higuerote', estado_id: miranda.id},
                {nombre: 'Los Anaucos', estado_id: miranda.id},
                {nombre: 'Los Teques', estado_id: miranda.id},
                {nombre: 'Ocumare del Tuy', estado_id: miranda.id},
                {nombre: 'Panaquire', estado_id: miranda.id},
                {nombre: 'Paracotos', estado_id: miranda.id},
                {nombre: 'Río Chico', estado_id: miranda.id},
                {nombre: 'San Antonio de Los Altos', estado_id: miranda.id},
                {nombre: 'San Diego de Los Altos', estado_id: miranda.id},
                {nombre: 'San Fernando del Guapo', estado_id: miranda.id},
                {nombre: 'San Francisco de Yare', estado_id: miranda.id},
                {nombre: 'San José de Los Altos', estado_id: miranda.id},
                {nombre: 'San José de Río Chico', estado_id: miranda.id},
                {nombre: 'San Pedro de Los Altos', estado_id: miranda.id},
                {nombre: 'Santa Lucía', estado_id: miranda.id},
                {nombre: 'Santa Teresa', estado_id: miranda.id},
                {nombre: 'Tacarigua de La Laguna', estado_id: miranda.id},
                {nombre: 'Tacarigua de Mamporal', estado_id: miranda.id},
                {nombre: 'Tácata', estado_id: miranda.id},
                {nombre: 'Turumo', estado_id: miranda.id},
                {nombre: 'Aguasay', estado_id: monagas.id},
                {nombre: 'Aragua de Maturín', estado_id: monagas.id},
                {nombre: 'Barrancas del Orinoco', estado_id: monagas.id},
                {nombre: 'Caicara de Maturín', estado_id: monagas.id},
                {nombre: 'Caripe', estado_id: monagas.id},
                {nombre: 'Caripito', estado_id: monagas.id},
                {nombre: 'Chaguaramal', estado_id: monagas.id},
                {nombre: 'Chaguaramas Monagas', estado_id: monagas.id},
                {nombre: 'El Furrial', estado_id: monagas.id},
                {nombre: 'El Tejero', estado_id: monagas.id},
                {nombre: 'Jusepín', estado_id: monagas.id},
                {nombre: 'La Toscana', estado_id: monagas.id},
                {nombre: 'Maturín', estado_id: monagas.id},
                {nombre: 'Miraflores', estado_id: monagas.id},
                {nombre: 'Punta de Mata', estado_id: monagas.id},
                {nombre: 'Quiriquire', estado_id: monagas.id},
                {nombre: 'San Antonio de Maturín', estado_id: monagas.id},
                {nombre: 'San Vicente Monagas', estado_id: monagas.id},
                {nombre: 'Santa Bárbara', estado_id: monagas.id},
                {nombre: 'Temblador', estado_id: monagas.id},
                {nombre: 'Teresen', estado_id: monagas.id},
                {nombre: 'Uracoa', estado_id: monagas.id},
                {nombre: 'Altagracia', estado_id: nueva_esparta.id},
                {nombre: 'Boca de Pozo', estado_id: nueva_esparta.id},
                {nombre: 'Boca de Río', estado_id: nueva_esparta.id},
                {nombre: 'El Espinal', estado_id: nueva_esparta.id},
                {nombre: 'El Valle del Espíritu Santo', estado_id: nueva_esparta.id},
                {nombre: 'El Yaque', estado_id: nueva_esparta.id},
                {nombre: 'Juangriego', estado_id: nueva_esparta.id},
                {nombre: 'La Asunción', estado_id: nueva_esparta.id},
                {nombre: 'La Guardia', estado_id: nueva_esparta.id},
                {nombre: 'Pampatar', estado_id: nueva_esparta.id},
                {nombre: 'Porlamar', estado_id: nueva_esparta.id},
                {nombre: 'Puerto Fermín', estado_id: nueva_esparta.id},
                {nombre: 'Punta de Piedras', estado_id: nueva_esparta.id},
                {nombre: 'San Francisco de Macanao', estado_id: nueva_esparta.id},
                {nombre: 'San Juan Bautista', estado_id: nueva_esparta.id},
                {nombre: 'San Pedro de Coche', estado_id: nueva_esparta.id},
                {nombre: 'Santa Ana de Nueva Esparta', estado_id: nueva_esparta.id},
                {nombre: 'Villa Rosa', estado_id: nueva_esparta.id},
                {nombre: 'Acarigua', estado_id: portuguesa.id},
                {nombre: 'Agua Blanca', estado_id: portuguesa.id},
                {nombre: 'Araure', estado_id: portuguesa.id},
                {nombre: 'Biscucuy', estado_id: portuguesa.id},
                {nombre: 'Boconoito', estado_id: portuguesa.id},
                {nombre: 'Campo Elías', estado_id: portuguesa.id},
                {nombre: 'Chabasquén', estado_id: portuguesa.id},
                {nombre: 'Guanare', estado_id: portuguesa.id},
                {nombre: 'Guanarito', estado_id: portuguesa.id},
                {nombre: 'La Aparición', estado_id: portuguesa.id},
                {nombre: 'La Misión', estado_id: portuguesa.id},
                {nombre: 'Mesa de Cavacas', estado_id: portuguesa.id},
                {nombre: 'Ospino', estado_id: portuguesa.id},
                {nombre: 'Papelón', estado_id: portuguesa.id},
                {nombre: 'Payara', estado_id: portuguesa.id},
                {nombre: 'Pimpinela', estado_id: portuguesa.id},
                {nombre: 'Píritu de Portuguesa', estado_id: portuguesa.id},
                {nombre: 'San Rafael de Onoto', estado_id: portuguesa.id},
                {nombre: 'Santa Rosalía', estado_id: portuguesa.id},
                {nombre: 'Turén', estado_id: portuguesa.id},
                {nombre: 'Altos de Sucre', estado_id: sucre.id},
                {nombre: 'Araya', estado_id: sucre.id},
                {nombre: 'Cariaco', estado_id: sucre.id},
                {nombre: 'Carúpano', estado_id: sucre.id},
                {nombre: 'Casanay', estado_id: sucre.id},
                {nombre: 'Cumaná', estado_id: sucre.id},
                {nombre: 'Cumanacoa', estado_id: sucre.id},
                {nombre: 'El Morro Puerto Santo', estado_id: sucre.id},
                {nombre: 'El Pilar', estado_id: sucre.id},
                {nombre: 'El Poblado', estado_id: sucre.id},
                {nombre: 'Guaca', estado_id: sucre.id},
                {nombre: 'Guiria', estado_id: sucre.id},
                {nombre: 'Irapa', estado_id: sucre.id},
                {nombre: 'Manicuare', estado_id: sucre.id},
                {nombre: 'Mariguitar', estado_id: sucre.id},
                {nombre: 'Río Caribe', estado_id: sucre.id},
                {nombre: 'San Antonio del Golfo', estado_id: sucre.id},
                {nombre: 'San José de Aerocuar', estado_id: sucre.id},
                {nombre: 'San Vicente de Sucre', estado_id: sucre.id},
                {nombre: 'Santa Fe de Sucre', estado_id: sucre.id},
                {nombre: 'Tunapuy', estado_id: sucre.id},
                {nombre: 'Yaguaraparo', estado_id: sucre.id},
                {nombre: 'Yoco', estado_id: sucre.id},
                {nombre: 'Abejales', estado_id: tachira.id},
                {nombre: 'Borota', estado_id: tachira.id},
                {nombre: 'Bramon', estado_id: tachira.id},
                {nombre: 'Capacho', estado_id: tachira.id},
                {nombre: 'Colón', estado_id: tachira.id},
                {nombre: 'Coloncito', estado_id: tachira.id},
                {nombre: 'Cordero', estado_id: tachira.id},
                {nombre: 'El Cobre', estado_id: tachira.id},
                {nombre: 'El Pinal', estado_id: tachira.id},
                {nombre: 'Independencia', estado_id: tachira.id},
                {nombre: 'La Fría', estado_id: tachira.id},
                {nombre: 'La Grita', estado_id: tachira.id},
                {nombre: 'La Pedrera', estado_id: tachira.id},
                {nombre: 'La Tendida', estado_id: tachira.id},
                {nombre: 'Las Delicias', estado_id: tachira.id},
                {nombre: 'Las Hernández', estado_id: tachira.id},
                {nombre: 'Lobatera', estado_id: tachira.id},
                {nombre: 'Michelena', estado_id: tachira.id},
                {nombre: 'Palmira', estado_id: tachira.id},
                {nombre: 'Pregonero', estado_id: tachira.id},
                {nombre: 'Queniquea', estado_id: tachira.id},
                {nombre: 'Rubio', estado_id: tachira.id},
                {nombre: 'San Antonio del Tachira', estado_id: tachira.id},
                {nombre: 'San Cristobal', estado_id: tachira.id},
                {nombre: 'San José de Bolívar', estado_id: tachira.id},
                {nombre: 'San Josecito', estado_id: tachira.id},
                {nombre: 'San Pedro del Río', estado_id: tachira.id},
                {nombre: 'Santa Ana Táchira', estado_id: tachira.id},
                {nombre: 'Seboruco', estado_id: tachira.id},
                {nombre: 'Táriba', estado_id: tachira.id},
                {nombre: 'Umuquena', estado_id: tachira.id},
                {nombre: 'Ureña', estado_id: tachira.id},
                {nombre: 'Batatal', estado_id: trujillo.id},
                {nombre: 'Betijoque', estado_id: trujillo.id},
                {nombre: 'Boconó', estado_id: trujillo.id},
                {nombre: 'Carache', estado_id: trujillo.id},
                {nombre: 'Chejende', estado_id: trujillo.id},
                {nombre: 'Cuicas', estado_id: trujillo.id},
                {nombre: 'El Dividive', estado_id: trujillo.id},
                {nombre: 'El Jaguito', estado_id: trujillo.id},
                {nombre: 'Escuque', estado_id: trujillo.id},
                {nombre: 'Isnotú', estado_id: trujillo.id},
                {nombre: 'Jajó', estado_id: trujillo.id},
                {nombre: 'La Ceiba', estado_id: trujillo.id},
                {nombre: 'La Concepción de Trujllo', estado_id: trujillo.id},
                {nombre: 'La Mesa de Esnujaque', estado_id: trujillo.id},
                {nombre: 'La Puerta', estado_id: trujillo.id},
                {nombre: 'La Quebrada', estado_id: trujillo.id},
                {nombre: 'Mendoza Fría', estado_id: trujillo.id},
                {nombre: 'Meseta de Chimpire', estado_id: trujillo.id},
                {nombre: 'Monay', estado_id: trujillo.id},
                {nombre: 'Motatán', estado_id: trujillo.id},
                {nombre: 'Pampán', estado_id: trujillo.id},
                {nombre: 'Pampanito', estado_id: trujillo.id},
                {nombre: 'Sabana de Mendoza', estado_id: trujillo.id},
                {nombre: 'San Lázaro', estado_id: trujillo.id},
                {nombre: 'Santa Ana de Trujillo', estado_id: trujillo.id},
                {nombre: 'Tostós', estado_id: trujillo.id},
                {nombre: 'Trujillo', estado_id: trujillo.id},
                {nombre: 'Valera', estado_id: trujillo.id},
                {nombre: 'Carayaca', estado_id: vargas.id},
                {nombre: 'Litoral', estado_id: vargas.id},
                {nombre: 'Archipiélago Los Roques', estado_id: dependencias_federales.id},
                {nombre: 'Aroa', estado_id: yaracuy.id},
                {nombre: 'Boraure', estado_id: yaracuy.id},
                {nombre: 'Campo Elías de Yaracuy', estado_id: yaracuy.id},
                {nombre: 'Chivacoa', estado_id: yaracuy.id},
                {nombre: 'Cocorote', estado_id: yaracuy.id},
                {nombre: 'Farriar', estado_id: yaracuy.id},
                {nombre: 'Guama', estado_id: yaracuy.id},
                {nombre: 'Marín', estado_id: yaracuy.id},
                {nombre: 'Nirgua', estado_id: yaracuy.id},
                {nombre: 'Sabana de Parra', estado_id: yaracuy.id},
                {nombre: 'Salom', estado_id: yaracuy.id},
                {nombre: 'San Felipe', estado_id: yaracuy.id},
                {nombre: 'San Pablo de Yaracuy', estado_id: yaracuy.id},
                {nombre: 'Urachiche', estado_id: yaracuy.id},
                {nombre: 'Yaritagua', estado_id: yaracuy.id},
                {nombre: 'Yumare', estado_id: yaracuy.id},
                {nombre: 'Bachaquero', estado_id: zulia.id},
                {nombre: 'Bobures', estado_id: zulia.id},
                {nombre: 'Cabimas', estado_id: zulia.id},
                {nombre: 'Campo Concepción', estado_id: zulia.id},
                {nombre: 'Campo Mara', estado_id: zulia.id},
                {nombre: 'Campo Rojo', estado_id: zulia.id},
                {nombre: 'Carrasquero', estado_id: zulia.id},
                {nombre: 'Casigua', estado_id: zulia.id},
                {nombre: 'Chiquinquirá', estado_id: zulia.id},
                {nombre: 'Ciudad Ojeda', estado_id: zulia.id},
                {nombre: 'El Batey', estado_id: zulia.id},
                {nombre: 'El Carmelo', estado_id: zulia.id},
                {nombre: 'El Chivo', estado_id: zulia.id},
                {nombre: 'El Guayabo', estado_id: zulia.id},
                {nombre: 'El Mene', estado_id: zulia.id},
                {nombre: 'El Venado', estado_id: zulia.id},
                {nombre: 'Encontrados', estado_id: zulia.id},
                {nombre: 'Gibraltar', estado_id: zulia.id},
                {nombre: 'Isla de Toas', estado_id: zulia.id},
                {nombre: 'La Concepción del Zulia', estado_id: zulia.id},
                {nombre: 'La Paz', estado_id: zulia.id},
                {nombre: 'La Sierrita', estado_id: zulia.id},
                {nombre: 'Lagunillas del Zulia', estado_id: zulia.id},
                {nombre: 'Las Piedras de Perijá', estado_id: zulia.id},
                {nombre: 'Los Cortijos', estado_id: zulia.id},
                {nombre: 'Machiques', estado_id: zulia.id},
                {nombre: 'Maracaibo', estado_id: zulia.id},
                {nombre: 'Mene Grande', estado_id: zulia.id},
                {nombre: 'Palmarejo', estado_id: zulia.id},
                {nombre: 'Paraguaipoa', estado_id: zulia.id},
                {nombre: 'Potrerito', estado_id: zulia.id},
                {nombre: 'Pueblo Nuevo del Zulia', estado_id: zulia.id},
                {nombre: 'Puertos de Altagracia', estado_id: zulia.id},
                {nombre: 'Punta Gorda', estado_id: zulia.id},
                {nombre: 'Sabaneta de Palma', estado_id: zulia.id},
                {nombre: 'San Francisco', estado_id: zulia.id},
                {nombre: 'San José de Perijá', estado_id: zulia.id},
                {nombre: 'San Rafael del Moján', estado_id: zulia.id},
                {nombre: 'San Timoteo', estado_id: zulia.id},
                {nombre: 'Santa Bárbara Del Zulia', estado_id: zulia.id},
                {nombre: 'Santa Cruz de Mara', estado_id: zulia.id},
                {nombre: 'Santa Cruz del Zulia', estado_id: zulia.id},
                {nombre: 'Santa Rita', estado_id: zulia.id},
                {nombre: 'Sinamaica', estado_id: zulia.id},
                {nombre: 'Tamare', estado_id: zulia.id},
                {nombre: 'Tía Juana', estado_id: zulia.id},
                {nombre: 'Villa del Rosario', estado_id: zulia.id},
                {nombre: 'La Guaira', estado_id: vargas.id},
                {nombre: 'Catia La Mar', estado_id: vargas.id},
                {nombre: 'Macuto', estado_id: vargas.id},
                {nombre: 'Naiguatá', estado_id: vargas.id},
                {nombre: 'Archipiélago Los Monjes', estado_id: dependencias_federales.id},
                {nombre: 'Isla La Tortuga y Cayos adyacentes', estado_id: dependencias_federales.id},
                {nombre: 'Isla La Sola', estado_id: dependencias_federales.id},
                {nombre: 'Islas Los Testigos', estado_id: dependencias_federales.id},
                {nombre: 'Islas Los Frailes', estado_id: dependencias_federales.id},
                {nombre: 'Isla La Orchila', estado_id: dependencias_federales.id},
                {nombre: 'Archipiélago Las Aves', estado_id: dependencias_federales.id},
                {nombre: 'Isla de Aves', estado_id: dependencias_federales.id},
                {nombre: 'Isla La Blanquilla', estado_id: dependencias_federales.id},
                {nombre: 'Isla de Patos', estado_id: dependencias_federales.id},
                {nombre: 'Caracas', estado_id: distrito_capital.id }])




puts '### SEEDEANDO MUNICIPIOS ###'

municipio_1 = Municipio.create!(estado_id: amazonas.id, nombre: 'Alto Orinoco')
municipio_2 = Municipio.create!(estado_id: amazonas.id, nombre: 'Atabapo')
municipio_3 = Municipio.create!(estado_id: amazonas.id, nombre: 'Atures')
municipio_4 = Municipio.create!(estado_id: amazonas.id, nombre: 'Autana')
municipio_5 = Municipio.create!(estado_id: amazonas.id, nombre: 'Manapiare')
municipio_6 = Municipio.create!(estado_id: amazonas.id, nombre: 'Maroa')
municipio_7 = Municipio.create!(estado_id: amazonas.id, nombre: 'Río Negro')
municipio_8 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Anaco')
municipio_9 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Aragua')
municipio_10 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Manuel Ezequiel Bruzual')
municipio_11 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Diego Bautista Urbaneja')
municipio_12 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Fernando Peñalver')
municipio_13 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Francisco Del Carmen Carvajal')
municipio_14 = Municipio.create!(estado_id: anzoategui.id, nombre: 'General Sir Arthur McGregor')
municipio_15 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Guanta')
municipio_16 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Independencia')
municipio_17 = Municipio.create!(estado_id: anzoategui.id, nombre: 'José Gregorio Monagas')
municipio_18 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Juan Antonio Sotillo')
municipio_19 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Juan Manuel Cajigal')
municipio_20 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Libertad')
municipio_21 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Francisco de Miranda')
municipio_22 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Pedro María Freites')
municipio_23 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Píritu')
municipio_24 = Municipio.create!(estado_id: anzoategui.id, nombre: 'San José de Guanipa')
municipio_25 = Municipio.create!(estado_id: anzoategui.id, nombre: 'San Juan de Capistrano')
municipio_26 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Santa Ana')
municipio_27 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Simón Bolívar')
municipio_28 = Municipio.create!(estado_id: anzoategui.id, nombre: 'Simón Rodríguez')
municipio_29 = Municipio.create!(estado_id: apure.id, nombre: 'Achaguas')
municipio_30 = Municipio.create!(estado_id: apure.id, nombre: 'Biruaca')
municipio_31 = Municipio.create!(estado_id: apure.id, nombre: 'Muñóz')
municipio_32 = Municipio.create!(estado_id: apure.id, nombre: 'Páez')
municipio_33 = Municipio.create!(estado_id: apure.id, nombre: 'Pedro Camejo')
municipio_34 = Municipio.create!(estado_id: apure.id, nombre: 'Rómulo Gallegos')
municipio_35 = Municipio.create!(estado_id: apure.id, nombre: 'San Fernando')
municipio_36 = Municipio.create!(estado_id: aragua.id, nombre: 'Atanasio Girardot')
municipio_37 = Municipio.create!(estado_id: aragua.id, nombre: 'Bolívar')
municipio_38 = Municipio.create!(estado_id: aragua.id, nombre: 'Camatagua')
municipio_39 = Municipio.create!(estado_id: aragua.id, nombre: 'Francisco Linares Alcántara')
municipio_40 = Municipio.create!(estado_id: aragua.id, nombre: 'José Ángel Lamas')
municipio_41 = Municipio.create!(estado_id: aragua.id, nombre: 'José Félix Ribas')
municipio_42 = Municipio.create!(estado_id: aragua.id, nombre: 'José Rafael Revenga')
municipio_43 = Municipio.create!(estado_id: aragua.id, nombre: 'Libertador')
municipio_44 = Municipio.create!(estado_id: aragua.id, nombre: 'Mario Briceño Iragorry')
municipio_45 = Municipio.create!(estado_id: aragua.id, nombre: 'Ocumare de la Costa de Oro')
municipio_46 = Municipio.create!(estado_id: aragua.id, nombre: 'San Casimiro')
municipio_47 = Municipio.create!(estado_id: aragua.id, nombre: 'San Sebastián')
municipio_48 = Municipio.create!(estado_id: aragua.id, nombre: 'Santiago Mariño')
municipio_49 = Municipio.create!(estado_id: aragua.id, nombre: 'Santos Michelena')
municipio_50 = Municipio.create!(estado_id: aragua.id, nombre: 'Sucre')
municipio_51 = Municipio.create!(estado_id: aragua.id, nombre: 'Tovar')
municipio_52 = Municipio.create!(estado_id: aragua.id, nombre: 'Urdaneta')
municipio_53 = Municipio.create!(estado_id: aragua.id, nombre: 'Zamora')
municipio_54 = Municipio.create!(estado_id: barinas.id, nombre: 'Alberto Arvelo Torrealba')
municipio_55 = Municipio.create!(estado_id: barinas.id, nombre: 'Andrés Eloy Blanco')
municipio_56 = Municipio.create!(estado_id: barinas.id, nombre: 'Antonio José de Sucre')
municipio_57 = Municipio.create!(estado_id: barinas.id, nombre: 'Arismendi')
municipio_58 = Municipio.create!(estado_id: barinas.id, nombre: 'Barinas')
municipio_59 = Municipio.create!(estado_id: barinas.id, nombre: 'Bolívar')
municipio_60 = Municipio.create!(estado_id: barinas.id, nombre: 'Cruz Paredes')
municipio_61 = Municipio.create!(estado_id: barinas.id, nombre: 'Ezequiel Zamora')
municipio_62 = Municipio.create!(estado_id: barinas.id, nombre: 'Obispos')
municipio_63 = Municipio.create!(estado_id: barinas.id, nombre: 'Pedraza')
municipio_64 = Municipio.create!(estado_id: barinas.id, nombre: 'Rojas')
municipio_65 = Municipio.create!(estado_id: barinas.id, nombre: 'Sosa')
municipio_67 = Municipio.create!(estado_id: bolivar.id, nombre: 'Caroní')
municipio_68 = Municipio.create!(estado_id: bolivar.id, nombre: 'Cedeño')
municipio_69 = Municipio.create!(estado_id: bolivar.id, nombre: 'El Callao')
municipio_70 = Municipio.create!(estado_id: bolivar.id, nombre: 'Gran Sabana')
municipio_71 = Municipio.create!(estado_id: bolivar.id, nombre: 'Heres')
municipio_72 = Municipio.create!(estado_id: bolivar.id, nombre: 'Piar')
municipio_73 = Municipio.create!(estado_id: bolivar.id, nombre: 'Angostura (Raúl Leoni)')
municipio_74 = Municipio.create!(estado_id: bolivar.id, nombre: 'Roscio')
municipio_75 = Municipio.create!(estado_id: bolivar.id, nombre: 'Sifontes')
municipio_76 = Municipio.create!(estado_id: bolivar.id, nombre: 'Sucre')
municipio_77 = Municipio.create!(estado_id: bolivar.id, nombre: 'Padre Pedro Chien')
municipio_78 = Municipio.create!(estado_id: carabobo.id, nombre: 'Bejuma')
municipio_79 = Municipio.create!(estado_id: carabobo.id, nombre: 'Carlos Arvelo')
municipio_80 = Municipio.create!(estado_id: carabobo.id, nombre: 'Diego Ibarra')
municipio_81 = Municipio.create!(estado_id: carabobo.id, nombre: 'Guacara')
municipio_82 = Municipio.create!(estado_id: carabobo.id, nombre: 'Juan José Mora')
municipio_83 = Municipio.create!(estado_id: carabobo.id, nombre: 'Libertador')
municipio_84 = Municipio.create!(estado_id: carabobo.id, nombre: 'Los Guayos')
municipio_85 = Municipio.create!(estado_id: carabobo.id, nombre: 'Miranda')
municipio_86 = Municipio.create!(estado_id: carabobo.id, nombre: 'Montalbán')
municipio_87 = Municipio.create!(estado_id: carabobo.id, nombre: 'Naguanagua')
municipio_88 = Municipio.create!(estado_id: carabobo.id, nombre: 'Puerto Cabello')
municipio_89 = Municipio.create!(estado_id: carabobo.id, nombre: 'San Diego')
municipio_90 = Municipio.create!(estado_id: carabobo.id, nombre: 'San Joaquín')
municipio_91 = Municipio.create!(estado_id: carabobo.id, nombre: 'Valencia')
municipio_92 = Municipio.create!(estado_id: cojedes.id, nombre: 'Anzoátegui')
municipio_93 = Municipio.create!(estado_id: cojedes.id, nombre: 'Tinaquillo')
municipio_94 = Municipio.create!(estado_id: cojedes.id, nombre: 'Girardot')
municipio_95 = Municipio.create!(estado_id: cojedes.id, nombre: 'Lima Blanco')
municipio_96 = Municipio.create!(estado_id: cojedes.id, nombre: 'Pao de San Juan Bautista')
municipio_97 = Municipio.create!(estado_id: cojedes.id, nombre: 'Ricaurte')
municipio_98 = Municipio.create!(estado_id: cojedes.id, nombre: 'Rómulo Gallegos')
municipio_99 = Municipio.create!(estado_id: cojedes.id, nombre: 'San Carlos')
municipio_100 = Municipio.create!(estado_id: cojedes.id, nombre: 'Tinaco')
municipio_101 = Municipio.create!(estado_id: delta_amacuro.id, nombre: 'Antonio Díaz')
municipio_102 = Municipio.create!(estado_id: delta_amacuro.id, nombre: 'Casacoima')
municipio_103 = Municipio.create!(estado_id: delta_amacuro.id, nombre: 'Pedernales')
municipio_104 = Municipio.create!(estado_id: delta_amacuro.id, nombre: 'Tucupita')
municipio_105 = Municipio.create!(estado_id: falcon.id, nombre: 'Acosta')
municipio_106 = Municipio.create!(estado_id: falcon.id, nombre: 'Bolívar')
municipio_107 = Municipio.create!(estado_id: falcon.id, nombre: 'Buchivacoa')
municipio_108 = Municipio.create!(estado_id: falcon.id, nombre: 'Cacique Manaure')
municipio_109 = Municipio.create!(estado_id: falcon.id, nombre: 'Carirubana')
municipio_110 = Municipio.create!(estado_id: falcon.id, nombre: 'Colina')
municipio_111 = Municipio.create!(estado_id: falcon.id, nombre: 'Dabajuro')
municipio_112 = Municipio.create!(estado_id: falcon.id, nombre: 'Democracia')
municipio_113 = Municipio.create!(estado_id: falcon.id, nombre: 'Falcón')
municipio_114 = Municipio.create!(estado_id: falcon.id, nombre: 'Federación')
municipio_115 = Municipio.create!(estado_id: falcon.id, nombre: 'Jacura')
municipio_116 = Municipio.create!(estado_id: falcon.id, nombre: 'José Laurencio Silva')
municipio_117 = Municipio.create!(estado_id: falcon.id, nombre: 'Los Taques')
municipio_118 = Municipio.create!(estado_id: falcon.id, nombre: 'Mauroa')
municipio_119 = Municipio.create!(estado_id: falcon.id, nombre: 'Miranda')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Monseñor Iturriza')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Palmasola')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Petit')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Píritu')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'San Francisco')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Tocópero')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Unión')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Urumaco')
municipio_ = Municipio.create!(estado_id: falcon.id, nombre: 'Zamora')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Camaguán')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Chaguaramas')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'El Socorro')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'José Félix Ribas')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'José Tadeo Monagas')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Juan Germán Roscio')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Julián Mellado')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Las Mercedes')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Leonardo Infante')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Pedro Zaraza')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Ortíz')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'San Gerónimo de Guayabal')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'San José de Guaribe')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Santa María de Ipire')
municipio_ = Municipio.create!(estado_id: guarico.id, nombre: 'Sebastián Francisco de Miranda')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Andrés Eloy Blanco')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Crespo')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Iribarren')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Jiménez')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Morán')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Palavecino')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Simón Planas')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Torres')
municipio_ = Municipio.create!(estado_id: lara.id, nombre: 'Urdaneta')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Alberto Adriani')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Andrés Bello')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Antonio Pinto Salinas')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Aricagua')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Arzobispo Chacón')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Campo Elías')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Caracciolo Parra Olmedo')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Cardenal Quintero')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Guaraque')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Julio César Salas')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Justo Briceño')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Libertador')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Miranda')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Obispo Ramos de Lora')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Padre Noguera')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Pueblo Llano')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Rangel')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Rivas Dávila')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Santos Marquina')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Tovar')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Tulio Febres Cordero')
municipio_ = Municipio.create!(estado_id: merida.id, nombre: 'Zea')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Acevedo')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Andrés Bello')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Baruta')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Brión')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Buroz')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Carrizal')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Chacao')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Cristóbal Rojas')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'El Hatillo')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Guaicaipuro')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Independencia')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Lander')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Los Salias')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Páez')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Paz Castillo')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Pedro Gual')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Plaza')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Simón Bolívar')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Urdaneta')
municipio_ = Municipio.create!(estado_id: miranda.id, nombre: 'Zamora')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Acosta')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Aguasay')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Bolívar')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Caripe')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Cedeño')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Ezequiel Zamora')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Libertador')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Maturín')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Piar')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Punceres')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Santa Bárbara')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Sotillo')
municipio_ = Municipio.create!(estado_id: monagas.id, nombre: 'Uracoa')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Antolín del Campo')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Arismendi')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'García')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Gómez')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Maneiro')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Marcano')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Mariño')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Península de Macanao')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Tubores')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Villalba')
municipio_ = Municipio.create!(estado_id: nueva_esparta.id, nombre: 'Díaz')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Agua Blanca')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Araure')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Esteller')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Guanare')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Guanarito')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Monseñor José Vicente de Unda')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Ospino')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Páez')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Papelón')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'San Genaro de Boconoíto')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'San Rafael de Onoto')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Santa Rosalía')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: portuguesa.id, nombre: 'Turén')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Andrés Eloy Blanco')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Andrés Mata')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Arismendi')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Benítez')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Bermúdez')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Bolívar')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Cajigal')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Cruz Salmerón Acosta')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Libertador')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Mariño')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Mejía')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Montes')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Ribero')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: sucre.id, nombre: 'Valdéz')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Andrés Bello')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Antonio Rómulo Costa')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Ayacucho')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Bolívar')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Cárdenas')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Córdoba')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Fernández Feo')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Francisco de Miranda')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'García de Hevia')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Guásimos')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Independencia')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Jáuregui')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'José María Vargas')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Junín')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Libertad')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Libertador')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Lobatera')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Michelena')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Panamericano')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Pedro María Ureña')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Rafael Urdaneta')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Samuel Darío Maldonado')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'San Cristóbal')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Seboruco')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Simón Rodríguez')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Torbes')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'Uribante')
municipio_ = Municipio.create!(estado_id: tachira.id, nombre: 'San Judas Tadeo')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Andrés Bello')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Boconó')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Bolívar')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Candelaria')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Carache')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Escuque')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'José Felipe Márquez Cañizalez')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Juan Vicente Campos Elías')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'La Ceiba')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Miranda')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Monte Carmelo')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Motatán')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Pampán')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Pampanito')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Rafael Rangel')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'San Rafael de Carvajal')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Trujillo')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Urdaneta')
municipio_ = Municipio.create!(estado_id: trujillo.id, nombre: 'Valera')
municipio_ = Municipio.create!(estado_id: vargas.id, nombre: 'Vargas')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Arístides Bastidas')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Bolívar')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Bruzual')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Cocorote')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Independencia')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'José Antonio Páez')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'La Trinidad')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Manuel Monge')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Nirgua')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Peña')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'San Felipe')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'Urachiche')
municipio_ = Municipio.create!(estado_id: yaracuy.id, nombre: 'José Joaquín Veroes')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Almirante Padilla')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Baralt')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Cabimas')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Catatumbo')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Colón')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Francisco Javier Pulgar')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Páez')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Jesús Enrique Losada')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Jesús María Semprún')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'La Cañada de Urdaneta')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Lagunillas')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Machiques de Perijá')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Mara')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Maracaibo')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Miranda')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Rosario de Perijá')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'San Francisco')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Santa Rita')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Simón Bolívar')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Sucre')
municipio_ = Municipio.create!(estado_id: zulia.id, nombre: 'Valmore Rodríguez')
municipio_ = Municipio.create!(estado_id: distrito_capital.id, nombre: 'Libertador')

puts '### SEEDEANDO PARROQUIAS ###'
Parroquia.create!([
                      {nombre: 'Alto Orinoco', municipio_id: 1},
                      {nombre: 'Huachamacare AcanaÃ±a', municipio_id: 1},
                      {nombre: 'Marawaka Toky ShamanaÃ±a', municipio_id: 1},
                      {nombre: 'Mavaka Mavaka', municipio_id: 1},
                      {nombre: 'Sierra Parima ParimabÃ©', municipio_id: 1},
                      {nombre: 'Ucata Laja Lisa', municipio_id: 2},
                      {nombre: 'Yapacana Macuruco', municipio_id: 2},
                      {nombre: 'Caname Guarinuma', municipio_id: 2},
                      {nombre: 'Fernando GirÃ³n Tovar', municipio_id: 3},
                      {nombre: 'Luis Alberto GÃ³mez', municipio_id: 3},
                      {nombre: 'PahueÃ±a LimÃ³n de ParhueÃ±a', municipio_id: 3},
                      {nombre: 'Platanillal Platanillal', municipio_id: 3},
                      {nombre: 'Samariapo', municipio_id: 4},
                      {nombre: 'Sipapo', municipio_id: 4},
                      {nombre: 'Munduapo', municipio_id: 4},
                      {nombre: 'Guayapo', municipio_id: 4},
                      {nombre: 'Alto Ventuari', municipio_id: 5},
                      {nombre: 'Medio Ventuari', municipio_id: 5},
                      {nombre: 'Bajo Ventuari', municipio_id: 5},
                      {nombre: 'Victorino', municipio_id: 6},
                      {nombre: 'Comunidad', municipio_id: 6},
                      {nombre: 'Casiquiare', municipio_id: 7},
                      {nombre: 'Cocuy', municipio_id: 7},
                      {nombre: 'San Carlos de RÃ­o Negro', municipio_id: 7},
                      {nombre: 'Solano', municipio_id: 7},
                      {nombre: 'Anaco', municipio_id: 8},
                      {nombre: 'San JoaquÃ­n', municipio_id: 8},
                      {nombre: 'Cachipo', municipio_id: 9},
                      {nombre: 'Aragua de Barcelona', municipio_id: 9},
                      {nombre: 'LecherÃ­a', municipio_id: 11},
                      {nombre: 'El Morro', municipio_id: 11},
                      {nombre: 'Puerto PÃ­ritu', municipio_id: 12},
                      {nombre: 'San Miguel', municipio_id: 12},
                      {nombre: 'Sucre', municipio_id: 12},
                      {nombre: 'Valle de Guanape', municipio_id: 13},
                      {nombre: 'Santa BÃ¡rbara', municipio_id: 13},
                      {nombre: 'El Chaparro', municipio_id: 14},
                      {nombre: 'TomÃ¡s Alfaro', municipio_id: 14},
                      {nombre: 'Calatrava', municipio_id: 14},
                      {nombre: 'Guanta', municipio_id: 15},
                      {nombre: 'ChorrerÃ³n', municipio_id: 15},
                      {nombre: 'Mamo', municipio_id: 16},
                      {nombre: 'Soledad', municipio_id: 16},
                      {nombre: 'Mapire', municipio_id: 17},
                      {nombre: 'Piar', municipio_id: 17},
                      {nombre: 'Santa Clara', municipio_id: 17},
                      {nombre: 'San Diego de Cabrutica', municipio_id: 17},
                      {nombre: 'Uverito', municipio_id: 17},
                      {nombre: 'Zuata', municipio_id: 17},
                      {nombre: 'Puerto La Cruz', municipio_id: 18},
                      {nombre: 'Pozuelos', municipio_id: 18},
                      {nombre: 'Onoto', municipio_id: 19},
                      {nombre: 'San Pablo', municipio_id: 19},
                      {nombre: 'San Mateo', municipio_id: 20},
                      {nombre: 'El Carito', municipio_id: 20},
                      {nombre: 'Santa InÃ©s', municipio_id: 20},
                      {nombre: 'La RomereÃ±a', municipio_id: 20},
                      {nombre: 'Atapirire', municipio_id: 21},
                      {nombre: 'Boca del Pao', municipio_id: 21},
                      {nombre: 'El Pao', municipio_id: 21},
                      {nombre: 'PariaguÃ¡n', municipio_id: 21},
                      {nombre: 'Cantaura', municipio_id: 22},
                      {nombre: 'Libertador', municipio_id: 22},
                      {nombre: 'Santa Rosa', municipio_id: 22},
                      {nombre: 'Urica', municipio_id: 22},
                      {nombre: 'PÃ­ritu', municipio_id: 23},
                      {nombre: 'San Francisco', municipio_id: 23},
                      {nombre: 'San JosÃ© de Guanipa', municipio_id: 24},
                      {nombre: 'Boca de Uchire', municipio_id: 25},
                      {nombre: 'Boca de ChÃ¡vez', municipio_id: 25},
                      {nombre: 'Pueblo Nuevo', municipio_id: 26},
                      {nombre: 'Santa Ana', municipio_id: 26},
                      {nombre: 'BergatÃ­n', municipio_id: 27},
                      {nombre: 'Caigua', municipio_id: 27},
                      {nombre: 'El Carmen', municipio_id: 27},
                      {nombre: 'El Pilar', municipio_id: 27},
                      {nombre: 'Naricual', municipio_id: 27},
                      {nombre: 'San CrsitÃ³bal', municipio_id: 27},
                      {nombre: 'Edmundo Barrios', municipio_id: 28},
                      {nombre: 'Miguel Otero Silva', municipio_id: 28},
                      {nombre: 'Achaguas', municipio_id: 29},
                      {nombre: 'Apurito', municipio_id: 29},
                      {nombre: 'El Yagual', municipio_id: 29},
                      {nombre: 'Guachara', municipio_id: 29},
                      {nombre: 'Mucuritas', municipio_id: 29},
                      {nombre: 'Queseras del medio', municipio_id: 29},
                      {nombre: 'Biruaca', municipio_id: 30},
                      {nombre: 'Bruzual', municipio_id: 31},
                      {nombre: 'Mantecal', municipio_id: 31},
                      {nombre: 'Quintero', municipio_id: 31},
                      {nombre: 'RincÃ³n Hondo', municipio_id: 31},
                      {nombre: 'San Vicente', municipio_id: 31},
                      {nombre: 'Guasdualito', municipio_id: 32},
                      {nombre: 'Aramendi', municipio_id: 32},
                      {nombre: 'El Amparo', municipio_id: 32},
                      {nombre: 'San Camilo', municipio_id: 32},
                      {nombre: 'Urdaneta', municipio_id: 32},
                      {nombre: 'San Juan de Payara', municipio_id: 33},
                      {nombre: 'Codazzi', municipio_id: 33},
                      {nombre: 'Cunaviche', municipio_id: 33},
                      {nombre: 'Elorza', municipio_id: 34},
                      {nombre: 'La Trinidad', municipio_id: 34},
                      {nombre: 'San Fernando', municipio_id: 35},
                      {nombre: 'El Recreo', municipio_id: 35},
                      {nombre: 'PeÃ±alver', municipio_id: 35},
                      {nombre: 'San Rafael de Atamaica', municipio_id: 35},
                      {nombre: 'Pedro JosÃ© Ovalles', municipio_id: 36},
                      {nombre: 'JoaquÃ­n Crespo', municipio_id: 36},
                      {nombre: 'JosÃ© Casanova Godoy', municipio_id: 36},
                      {nombre: 'Madre MarÃ­a de San JosÃ©', municipio_id: 36},
                      {nombre: 'AndrÃ©s Eloy Blanco', municipio_id: 36},
                      {nombre: 'Los Tacarigua', municipio_id: 36},
                      {nombre: 'Las Delicias', municipio_id: 36},
                      {nombre: 'ChoronÃ­', municipio_id: 36},
                      {nombre: 'BolÃ­var', municipio_id: 37},
                      {nombre: 'Camatagua', municipio_id: 38},
                      {nombre: 'Carmen de Cura', municipio_id: 38},
                      {nombre: 'Santa Rita', municipio_id: 39},
                      {nombre: 'Francisco de Miranda', municipio_id: 39},
                      {nombre: 'MoseÃ±or Feliciano GonzÃ¡lez', municipio_id: 39},
                      {nombre: 'Santa Cruz', municipio_id: 40},
                      {nombre: 'JosÃ© FÃ©lix Ribas', municipio_id: 41},
                      {nombre: 'Castor Nieves RÃ­os', municipio_id: 41},
                      {nombre: 'Las Guacamayas', municipio_id: 41},
                      {nombre: 'Pao de ZÃ¡rate', municipio_id: 41},
                      {nombre: 'Zuata', municipio_id: 41},
                      {nombre: 'JosÃ© Rafael Revenga', municipio_id: 42},
                      {nombre: 'Palo Negro', municipio_id: 43},
                      {nombre: 'San MartÃ­n de Porres', municipio_id: 43},
                      {nombre: 'El LimÃ³n', municipio_id: 44},
                      {nombre: 'CaÃ±a de AzÃºcar', municipio_id: 44},
                      {nombre: 'Ocumare de la Costa', municipio_id: 45},
                      {nombre: 'San Casimiro', municipio_id: 46},
                      {nombre: 'GÃ¼iripa', municipio_id: 46},
                      {nombre: 'Ollas de Caramacate', municipio_id: 46},
                      {nombre: 'Valle MorÃ­n', municipio_id: 46},
                      {nombre: 'San SebastÃ­an', municipio_id: 47},
                      {nombre: 'Turmero', municipio_id: 48},
                      {nombre: 'Arevalo Aponte', municipio_id: 48},
                      {nombre: 'Chuao', municipio_id: 48},
                      {nombre: 'SamÃ¡n de GÃ¼ere', municipio_id: 48},
                      {nombre: 'Alfredo Pacheco Miranda', municipio_id: 48},
                      {nombre: 'Santos Michelena', municipio_id: 49},
                      {nombre: 'Tiara', municipio_id: 49},
                      {nombre: 'Cagua', municipio_id: 50},
                      {nombre: 'Bella Vista', municipio_id: 50},
                      {nombre: 'Tovar', municipio_id: 51},
                      {nombre: 'Urdaneta', municipio_id: 52},
                      {nombre: 'Las PeÃ±itas', municipio_id: 52},
                      {nombre: 'San Francisco de Cara', municipio_id: 52},
                      {nombre: 'Taguay', municipio_id: 52},
                      {nombre: 'Zamora', municipio_id: 53},
                      {nombre: 'Magdaleno', municipio_id: 53},
                      {nombre: 'San Francisco de AsÃ­s', municipio_id: 53},
                      {nombre: 'Valles de Tucutunemo', municipio_id: 53},
                      {nombre: 'Augusto Mijares', municipio_id: 53},
                      {nombre: 'Sabaneta', municipio_id: 54},
                      {nombre: 'Juan Antonio RodrÃ­guez DomÃ­nguez', municipio_id: 54},
                      {nombre: 'El CantÃ³n', municipio_id: 55},
                      {nombre: 'Santa Cruz de Guacas', municipio_id: 55},
                      {nombre: 'Puerto Vivas', municipio_id: 55},
                      {nombre: 'Ticoporo', municipio_id: 56},
                      {nombre: 'NicolÃ¡s Pulido', municipio_id: 56},
                      {nombre: 'AndrÃ©s Bello', municipio_id: 56},
                      {nombre: 'Arismendi', municipio_id: 57},
                      {nombre: 'Guadarrama', municipio_id: 57},
                      {nombre: 'La UniÃ³n', municipio_id: 57},
                      {nombre: 'San Antonio', municipio_id: 57},
                      {nombre: 'Barinas', municipio_id: 58},
                      {nombre: 'Alberto Arvelo Larriva', municipio_id: 58},
                      {nombre: 'San Silvestre', municipio_id: 58},
                      {nombre: 'Santa InÃ©s', municipio_id: 58},
                      {nombre: 'Santa LucÃ­a', municipio_id: 58},
                      {nombre: 'Torumos', municipio_id: 58},
                      {nombre: 'El Carmen', municipio_id: 58},
                      {nombre: 'RÃ³mulo Betancourt', municipio_id: 58},
                      {nombre: 'CorazÃ³n de JesÃºs', municipio_id: 58},
                      {nombre: 'RamÃ³n Ignacio MÃ©ndez', municipio_id: 58},
                      {nombre: 'Alto Barinas', municipio_id: 58},
                      {nombre: 'Manuel Palacio Fajardo', municipio_id: 58},
                      {nombre: 'Juan Antonio RodrÃ­guez DomÃ­nguez', municipio_id: 58},
                      {nombre: 'Dominga Ortiz de PÃ¡ez', municipio_id: 58},
                      {nombre: 'Barinitas', municipio_id: 59},
                      {nombre: 'Altamira de CÃ¡ceres', municipio_id: 59},
                      {nombre: 'Calderas', municipio_id: 59},
                      {nombre: 'Barrancas', municipio_id: 60},
                      {nombre: 'El Socorro', municipio_id: 60},
                      {nombre: 'Mazparrito', municipio_id: 60},
                      {nombre: 'Santa BÃ¡rbara', municipio_id: 61},
                      {nombre: 'Pedro BriceÃ±o MÃ©ndez', municipio_id: 61},
                      {nombre: 'RamÃ³n Ignacio MÃ©ndez', municipio_id: 61},
                      {nombre: 'JosÃ© Ignacio del Pumar', municipio_id: 61},
                      {nombre: 'Obispos', municipio_id: 62},
                      {nombre: 'Guasimitos', municipio_id: 62},
                      {nombre: 'El Real', municipio_id: 62},
                      {nombre: 'La Luz', municipio_id: 62},
                      {nombre: 'Ciudad BolÃ­via', municipio_id: 63},
                      {nombre: 'JosÃ© Ignacio BriceÃ±o', municipio_id: 63},
                      {nombre: 'JosÃ© FÃ©lix Ribas', municipio_id: 63},
                      {nombre: 'PÃ¡ez', municipio_id: 63},
                      {nombre: 'Libertad', municipio_id: 64},
                      {nombre: 'Dolores', municipio_id: 64},
                      {nombre: 'Santa Rosa', municipio_id: 64},
                      {nombre: 'Palacio Fajardo', municipio_id: 64},
                      {nombre: 'Ciudad de Nutrias', municipio_id: 65},
                      {nombre: 'El Regalo', municipio_id: 65},
                      {nombre: 'Puerto Nutrias', municipio_id: 65},
                      {nombre: 'Santa Catalina', municipio_id: 65},
                      {nombre: 'Cachamay', municipio_id: 66},
                      {nombre: 'Chirica', municipio_id: 66},
                      {nombre: 'Dalla Costa', municipio_id: 66},
                      {nombre: 'Once de Abril', municipio_id: 66},
                      {nombre: 'SimÃ³n BolÃ­var', municipio_id: 66},
                      {nombre: 'Unare', municipio_id: 66},
                      {nombre: 'Universidad', municipio_id: 66},
                      {nombre: 'Vista al Sol', municipio_id: 66},
                      {nombre: 'Pozo Verde', municipio_id: 66},
                      {nombre: 'Yocoima', municipio_id: 66},
                      {nombre: '5 de Julio', municipio_id: 66},
                      {nombre: 'CedeÃ±o', municipio_id: 67},
                      {nombre: 'Altagracia', municipio_id: 67},
                      {nombre: 'AscensiÃ³n Farreras', municipio_id: 67},
                      {nombre: 'Guaniamo', municipio_id: 67},
                      {nombre: 'La Urbana', municipio_id: 67},
                      {nombre: 'Pijiguaos', municipio_id: 67},
                      {nombre: 'El Callao', municipio_id: 68},
                      {nombre: 'Gran Sabana', municipio_id: 69},
                      {nombre: 'IkabarÃº', municipio_id: 69},
                      {nombre: 'Catedral', municipio_id: 70},
                      {nombre: 'Zea', municipio_id: 70},
                      {nombre: 'Orinoco', municipio_id: 70},
                      {nombre: 'JosÃ© Antonio PÃ¡ez', municipio_id: 70},
                      {nombre: 'Marhuanta', municipio_id: 70},
                      {nombre: 'Agua Salada', municipio_id: 70},
                      {nombre: 'Vista Hermosa', municipio_id: 70},
                      {nombre: 'La Sabanita', municipio_id: 70},
                      {nombre: 'Panapana', municipio_id: 70},
                      {nombre: 'AndrÃ©s Eloy Blanco', municipio_id: 71},
                      {nombre: 'Pedro Cova', municipio_id: 71},
                      {nombre: 'RaÃºl Leoni', municipio_id: 72},
                      {nombre: 'Barceloneta', municipio_id: 72},
                      {nombre: 'Santa BÃ¡rbara', municipio_id: 72},
                      {nombre: 'San Francisco', municipio_id: 72},
                      {nombre: 'Roscio', municipio_id: 73},
                      {nombre: 'SalÃ³m', municipio_id: 73},
                      {nombre: 'Sifontes', municipio_id: 74},
                      {nombre: 'Dalla Costa', municipio_id: 74},
                      {nombre: 'San Isidro', municipio_id: 74},
                      {nombre: 'Sucre', municipio_id: 75},
                      {nombre: 'Aripao', municipio_id: 75},
                      {nombre: 'Guarataro', municipio_id: 75},
                      {nombre: 'Las Majadas', municipio_id: 75},
                      {nombre: 'Moitaco', municipio_id: 75},
                      {nombre: 'Padre Pedro Chien', municipio_id: 76},
                      {nombre: 'RÃ­o Grande', municipio_id: 76},
                      {nombre: 'Bejuma', municipio_id: 77},
                      {nombre: 'Canoabo', municipio_id: 77},
                      {nombre: 'SimÃ³n BolÃ­var', municipio_id: 77},
                      {nombre: 'GÃ¼igÃ¼e', municipio_id: 78},
                      {nombre: 'Carabobo', municipio_id: 78},
                      {nombre: 'Tacarigua', municipio_id: 78},
                      {nombre: 'Mariara', municipio_id: 79},
                      {nombre: 'Aguas Calientes', municipio_id: 79},
                      {nombre: 'Ciudad Alianza', municipio_id: 80},
                      {nombre: 'Guacara', municipio_id: 80},
                      {nombre: 'Yagua', municipio_id: 80},
                      {nombre: 'MorÃ³n', municipio_id: 81},
                      {nombre: 'Yagua', municipio_id: 81},
                      {nombre: 'Tocuyito', municipio_id: 82},
                      {nombre: 'Independencia', municipio_id: 82},
                      {nombre: 'Los Guayos', municipio_id: 83},
                      {nombre: 'Miranda', municipio_id: 84},
                      {nombre: 'MontalbÃ¡n', municipio_id: 85},
                      {nombre: 'Naguanagua', municipio_id: 86},
                      {nombre: 'BartolomÃ© SalÃ³m', municipio_id: 87},
                      {nombre: 'Democracia', municipio_id: 87},
                      {nombre: 'Fraternidad', municipio_id: 87},
                      {nombre: 'Goaigoaza', municipio_id: 87},
                      {nombre: 'Juan JosÃ© Flores', municipio_id: 87},
                      {nombre: 'UniÃ³n', municipio_id: 87},
                      {nombre: 'Borburata', municipio_id: 87},
                      {nombre: 'Patanemo', municipio_id: 87},
                      {nombre: 'San Diego', municipio_id: 88},
                      {nombre: 'San JoaquÃ­n', municipio_id: 89},
                      {nombre: 'Candelaria', municipio_id: 90},
                      {nombre: 'Catedral', municipio_id: 90},
                      {nombre: 'El Socorro', municipio_id: 90},
                      {nombre: 'Miguel PeÃ±a', municipio_id: 90},
                      {nombre: 'Rafael Urdaneta', municipio_id: 90},
                      {nombre: 'San Blas', municipio_id: 90},
                      {nombre: 'San JosÃ©', municipio_id: 90},
                      {nombre: 'Santa Rosa', municipio_id: 90},
                      {nombre: 'Negro Primero', municipio_id: 90},
                      {nombre: 'Cojedes', municipio_id: 91},
                      {nombre: 'Juan de Mata SuÃ¡rez', municipio_id: 91},
                      {nombre: 'Tinaquillo', municipio_id: 92},
                      {nombre: 'El BaÃºl', municipio_id: 93},
                      {nombre: 'Sucre', municipio_id: 93},
                      {nombre: 'La Aguadita', municipio_id: 94},
                      {nombre: 'Macapo', municipio_id: 94},
                      {nombre: 'El Pao', municipio_id: 95},
                      {nombre: 'El Amparo', municipio_id: 96},
                      {nombre: 'Libertad de Cojedes', municipio_id: 96},
                      {nombre: 'RÃ³mulo Gallegos', municipio_id: 97},
                      {nombre: 'San Carlos de Austria', municipio_id: 98},
                      {nombre: 'Juan Ã\u0081ngel Bravo', municipio_id: 98},
                      {nombre: 'Manuel Manrique', municipio_id: 98},
                      {nombre: 'General en Jefe JosÃ© Laurencio Silva', municipio_id: 99},
                      {nombre: 'Curiapo', municipio_id: 100},
                      {nombre: 'Almirante Luis BriÃ³n', municipio_id: 100},
                      {nombre: 'Francisco Aniceto Lugo', municipio_id: 100},
                      {nombre: 'Manuel Renaud', municipio_id: 100},
                      {nombre: 'Padre Barral', municipio_id: 100},
                      {nombre: 'Santos de Abelgas', municipio_id: 100},
                      {nombre: 'Imataca', municipio_id: 101},
                      {nombre: 'Cinco de Julio', municipio_id: 101},
                      {nombre: 'Juan Bautista Arismendi', municipio_id: 101},
                      {nombre: 'Manuel Piar', municipio_id: 101},
                      {nombre: 'RÃ³mulo Gallegos', municipio_id: 101},
                      {nombre: 'Pedernales', municipio_id: 102},
                      {nombre: 'Luis BeltrÃ¡n Prieto Figueroa', municipio_id: 102},
                      {nombre: 'San JosÃ© (Delta Amacuro)', municipio_id: 103},
                      {nombre: 'JosÃ© Vidal Marcano', municipio_id: 103},
                      {nombre: 'Juan MillÃ¡n', municipio_id: 103},
                      {nombre: 'Leonardo RuÃ­z Pineda', municipio_id: 103},
                      {nombre: 'Mariscal Antonio JosÃ© de Sucre', municipio_id: 103},
                      {nombre: 'MonseÃ±or Argimiro GarcÃ­a', municipio_id: 103},
                      {nombre: 'San Rafael (Delta Amacuro)', municipio_id: 103},
                      {nombre: 'Virgen del Valle', municipio_id: 103},
                      {nombre: 'Clarines', municipio_id: 10},
                      {nombre: 'Guanape', municipio_id: 10},
                      {nombre: 'Sabana de Uchire', municipio_id: 10},
                      {nombre: 'Capadare', municipio_id: 104},
                      {nombre: 'La Pastora', municipio_id: 104},
                      {nombre: 'Libertador', municipio_id: 104},
                      {nombre: 'San Juan de los Cayos', municipio_id: 104},
                      {nombre: 'Aracua', municipio_id: 105},
                      {nombre: 'La PeÃ±a', municipio_id: 105},
                      {nombre: 'San Luis', municipio_id: 105},
                      {nombre: 'Bariro', municipio_id: 106},
                      {nombre: 'BorojÃ³', municipio_id: 106},
                      {nombre: 'CapatÃ¡rida', municipio_id: 106},
                      {nombre: 'Guajiro', municipio_id: 106},
                      {nombre: 'Seque', municipio_id: 106},
                      {nombre: 'ZazÃ¡rida', municipio_id: 106},
                      {nombre: 'Valle de Eroa', municipio_id: 106},
                      {nombre: 'Cacique Manaure', municipio_id: 107},
                      {nombre: 'Norte', municipio_id: 108},
                      {nombre: 'Carirubana', municipio_id: 108},
                      {nombre: 'Santa Ana', municipio_id: 108},
                      {nombre: 'Urbana Punta CardÃ³n', municipio_id: 108},
                      {nombre: 'La Vela de Coro', municipio_id: 109},
                      {nombre: 'Acurigua', municipio_id: 109},
                      {nombre: 'Guaibacoa', municipio_id: 109},
                      {nombre: 'Las Calderas', municipio_id: 109},
                      {nombre: 'Macoruca', municipio_id: 109},
                      {nombre: 'Dabajuro', municipio_id: 110},
                      {nombre: 'Agua Clara', municipio_id: 111},
                      {nombre: 'Avaria', municipio_id: 111},
                      {nombre: 'Pedregal', municipio_id: 111},
                      {nombre: 'Piedra Grande', municipio_id: 111},
                      {nombre: 'Purureche', municipio_id: 111},
                      {nombre: 'Adaure', municipio_id: 112},
                      {nombre: 'AdÃ­cora', municipio_id: 112},
                      {nombre: 'Baraived', municipio_id: 112},
                      {nombre: 'Buena Vista', municipio_id: 112},
                      {nombre: 'Jadacaquiva', municipio_id: 112},
                      {nombre: 'El VÃ­nculo', municipio_id: 112},
                      {nombre: 'El Hato', municipio_id: 112},
                      {nombre: 'Moruy', municipio_id: 112},
                      {nombre: 'Pueblo Nuevo', municipio_id: 112},
                      {nombre: 'Agua Larga', municipio_id: 113},
                      {nombre: 'El PaujÃ­', municipio_id: 113},
                      {nombre: 'Independencia', municipio_id: 113},
                      {nombre: 'MapararÃ­', municipio_id: 113},
                      {nombre: 'Agua Linda', municipio_id: 114},
                      {nombre: 'Araurima', municipio_id: 114},
                      {nombre: 'Jacura', municipio_id: 114},
                      {nombre: 'Tucacas', municipio_id: 115},
                      {nombre: 'Boca de Aroa', municipio_id: 115},
                      {nombre: 'Los Taques', municipio_id: 116},
                      {nombre: 'Judibana', municipio_id: 116},
                      {nombre: 'Mene de Mauroa', municipio_id: 117},
                      {nombre: 'San FÃ©lix', municipio_id: 117},
                      {nombre: 'Casigua', municipio_id: 117},
                      {nombre: 'GuzmÃ¡n Guillermo', municipio_id: 118},
                      {nombre: 'Mitare', municipio_id: 118},
                      {nombre: 'RÃ­o Seco', municipio_id: 118},
                      {nombre: 'Sabaneta', municipio_id: 118},
                      {nombre: 'San Antonio', municipio_id: 118},
                      {nombre: 'San Gabriel', municipio_id: 118},
                      {nombre: 'Santa Ana', municipio_id: 118},
                      {nombre: 'Boca del Tocuyo', municipio_id: 119},
                      {nombre: 'Chichiriviche', municipio_id: 119},
                      {nombre: 'Tocuyo de la Costa', municipio_id: 119},
                      {nombre: 'Palmasola', municipio_id: 120},
                      {nombre: 'Cabure', municipio_id: 121},
                      {nombre: 'Colina', municipio_id: 121},
                      {nombre: 'Curimagua', municipio_id: 121},
                      {nombre: 'San JosÃ© de la Costa', municipio_id: 122},
                      {nombre: 'PÃ­ritu', municipio_id: 122},
                      {nombre: 'San Francisco', municipio_id: 123},
                      {nombre: 'Sucre', municipio_id: 124},
                      {nombre: 'Pecaya', municipio_id: 124},
                      {nombre: 'TocÃ³pero', municipio_id: 125},
                      {nombre: 'El Charal', municipio_id: 126},
                      {nombre: 'Las Vegas del Tuy', municipio_id: 126},
                      {nombre: 'Santa Cruz de Bucaral', municipio_id: 126},
                      {nombre: 'Bruzual', municipio_id: 127},
                      {nombre: 'Urumaco', municipio_id: 127},
                      {nombre: 'Puerto Cumarebo', municipio_id: 128},
                      {nombre: 'La CiÃ©naga', municipio_id: 128},
                      {nombre: 'La Soledad', municipio_id: 128},
                      {nombre: 'Pueblo Cumarebo', municipio_id: 128},
                      {nombre: 'ZazÃ¡rida', municipio_id: 128},
                      {nombre: 'Churuguara', municipio_id: 113},
                      {nombre: 'CamaguÃ¡n', municipio_id: 129},
                      {nombre: 'Puerto Miranda', municipio_id: 129},
                      {nombre: 'Uverito', municipio_id: 129},
                      {nombre: 'Chaguaramas', municipio_id: 130},
                      {nombre: 'El Socorro', municipio_id: 131},
                      {nombre: 'Tucupido', municipio_id: 132},
                      {nombre: 'San Rafael de Laya', municipio_id: 132},
                      {nombre: 'Altagracia de Orituco', municipio_id: 133},
                      {nombre: 'San Rafael de Orituco', municipio_id: 133},
                      {nombre: 'San Francisco Javier de Lezama', municipio_id: 133},
                      {nombre: 'Paso Real de Macaira', municipio_id: 133},
                      {nombre: 'Carlos Soublette', municipio_id: 133},
                      {nombre: 'San Francisco de Macaira', municipio_id: 133},
                      {nombre: 'Libertad de Orituco', municipio_id: 133},
                      {nombre: 'Cantaclaro', municipio_id: 134},
                      {nombre: 'San Juan de los Morros', municipio_id: 134},
                      {nombre: 'Parapara', municipio_id: 134},
                      {nombre: 'El Sombrero', municipio_id: 135},
                      {nombre: 'Sosa', municipio_id: 135},
                      {nombre: 'Las Mercedes', municipio_id: 136},
                      {nombre: 'Cabruta', municipio_id: 136},
                      {nombre: 'Santa Rita de Manapire', municipio_id: 136},
                      {nombre: 'Valle de la Pascua', municipio_id: 137},
                      {nombre: 'Espino', municipio_id: 137},
                      {nombre: 'San JosÃ© de Unare', municipio_id: 138},
                      {nombre: 'Zaraza', municipio_id: 138},
                      {nombre: 'San JosÃ© de Tiznados', municipio_id: 139},
                      {nombre: 'San Francisco de Tiznados', municipio_id: 139},
                      {nombre: 'San Lorenzo de Tiznados', municipio_id: 139},
                      {nombre: 'Ortiz', municipio_id: 139},
                      {nombre: 'Guayabal', municipio_id: 140},
                      {nombre: 'Cazorla', municipio_id: 140},
                      {nombre: 'San JosÃ© de Guaribe', municipio_id: 141},
                      {nombre: 'Uveral', municipio_id: 141},
                      {nombre: 'Santa MarÃ­a de Ipire', municipio_id: 142},
                      {nombre: 'Altamira', municipio_id: 142},
                      {nombre: 'El Calvario', municipio_id: 143},
                      {nombre: 'El Rastro', municipio_id: 143},
                      {nombre: 'Guardatinajas', municipio_id: 143},
                      {nombre: 'Capital Urbana Calabozo', municipio_id: 143},
                      {nombre: 'Quebrada Honda de Guache', municipio_id: 144},
                      {nombre: 'PÃ­o Tamayo', municipio_id: 144},
                      {nombre: 'YacambÃº', municipio_id: 144},
                      {nombre: 'FrÃ©itez', municipio_id: 145},
                      {nombre: 'JosÃ© MarÃ­a Blanco', municipio_id: 145},
                      {nombre: 'Catedral', municipio_id: 146},
                      {nombre: 'ConcepciÃ³n', municipio_id: 146},
                      {nombre: 'El CujÃ­', municipio_id: 146},
                      {nombre: 'Juan de Villegas', municipio_id: 146},
                      {nombre: 'Santa Rosa', municipio_id: 146},
                      {nombre: 'Tamaca', municipio_id: 146},
                      {nombre: 'UniÃ³n', municipio_id: 146},
                      {nombre: 'Aguedo Felipe Alvarado', municipio_id: 146},
                      {nombre: 'Buena Vista', municipio_id: 146},
                      {nombre: 'JuÃ¡rez', municipio_id: 146},
                      {nombre: 'Juan Bautista RodrÃ­guez', municipio_id: 147},
                      {nombre: 'Cuara', municipio_id: 147},
                      {nombre: 'Diego de Lozada', municipio_id: 147},
                      {nombre: 'ParaÃ­so de San JosÃ©', municipio_id: 147},
                      {nombre: 'San Miguel', municipio_id: 147},
                      {nombre: 'Tintorero', municipio_id: 147},
                      {nombre: 'JosÃ© Bernardo Dorante', municipio_id: 147},
                      {nombre: 'Coronel Mariano Peraza ', municipio_id: 147},
                      {nombre: 'BolÃ­var', municipio_id: 148},
                      {nombre: 'AnzoÃ¡tegui', municipio_id: 148},
                      {nombre: 'Guarico', municipio_id: 148},
                      {nombre: 'Hilario Luna y Luna', municipio_id: 148},
                      {nombre: 'Humocaro Alto', municipio_id: 148},
                      {nombre: 'Humocaro Bajo', municipio_id: 148},
                      {nombre: 'La Candelaria', municipio_id: 148},
                      {nombre: 'MorÃ¡n', municipio_id: 148},
                      {nombre: 'Cabudare', municipio_id: 149},
                      {nombre: 'JosÃ© Gregorio Bastidas', municipio_id: 149},
                      {nombre: 'Agua Viva', municipio_id: 149},
                      {nombre: 'Sarare', municipio_id: 150},
                      {nombre: 'BurÃ­a', municipio_id: 150},
                      {nombre: 'Gustavo Vegas LeÃ³n', municipio_id: 150},
                      {nombre: 'Trinidad Samuel', municipio_id: 151},
                      {nombre: 'Antonio DÃ­az', municipio_id: 151},
                      {nombre: 'Camacaro', municipio_id: 151},
                      {nombre: 'CastaÃ±eda', municipio_id: 151},
                      {nombre: 'Cecilio Zubillaga', municipio_id: 151},
                      {nombre: 'ChiquinquirÃ¡', municipio_id: 151},
                      {nombre: 'El Blanco', municipio_id: 151},
                      {nombre: 'Espinoza de los Monteros', municipio_id: 151},
                      {nombre: 'Lara', municipio_id: 151},
                      {nombre: 'Las Mercedes', municipio_id: 151},
                      {nombre: 'Manuel Morillo', municipio_id: 151},
                      {nombre: 'MontaÃ±a Verde', municipio_id: 151},
                      {nombre: 'Montes de Oca', municipio_id: 151},
                      {nombre: 'Torres', municipio_id: 151},
                      {nombre: 'Heriberto Arroyo', municipio_id: 151},
                      {nombre: 'Reyes Vargas', municipio_id: 151},
                      {nombre: 'Altagracia', municipio_id: 151},
                      {nombre: 'Siquisique', municipio_id: 152},
                      {nombre: 'Moroturo', municipio_id: 152},
                      {nombre: 'San Miguel', municipio_id: 152},
                      {nombre: 'Xaguas', municipio_id: 152},
                      {nombre: 'Presidente Betancourt', municipio_id: 179},
                      {nombre: 'Presidente PÃ¡ez', municipio_id: 179},
                      {nombre: 'Presidente RÃ³mulo Gallegos', municipio_id: 179},
                      {nombre: 'Gabriel PicÃ³n GonzÃ¡lez', municipio_id: 179},
                      {nombre: 'HÃ©ctor Amable Mora', municipio_id: 179},
                      {nombre: 'JosÃ© Nucete Sardi', municipio_id: 179},
                      {nombre: 'Pulido MÃ©ndez', municipio_id: 179},
                      {nombre: 'La Azulita', municipio_id: 180},
                      {nombre: 'Santa Cruz de Mora', municipio_id: 181},
                      {nombre: 'Mesa BolÃ­var', municipio_id: 181},
                      {nombre: 'Mesa de Las Palmas', municipio_id: 181},
                      {nombre: 'Aricagua', municipio_id: 182},
                      {nombre: 'San Antonio', municipio_id: 182},
                      {nombre: 'Canagua', municipio_id: 183},
                      {nombre: 'CapurÃ­', municipio_id: 183},
                      {nombre: 'ChacantÃ¡', municipio_id: 183},
                      {nombre: 'El Molino', municipio_id: 183},
                      {nombre: 'Guaimaral', municipio_id: 183},
                      {nombre: 'Mucutuy', municipio_id: 183},
                      {nombre: 'MucuchachÃ­', municipio_id: 183},
                      {nombre: 'FernÃ¡ndez PeÃ±a', municipio_id: 184},
                      {nombre: 'Matriz', municipio_id: 184},
                      {nombre: 'MontalbÃ¡n', municipio_id: 184},
                      {nombre: 'Acequias', municipio_id: 184},
                      {nombre: 'JajÃ­', municipio_id: 184},
                      {nombre: 'La Mesa', municipio_id: 184},
                      {nombre: 'San JosÃ© del Sur', municipio_id: 184},
                      {nombre: 'TucanÃ­', municipio_id: 185},
                      {nombre: 'Florencio RamÃ­rez', municipio_id: 185},
                      {nombre: 'Santo Domingo', municipio_id: 186},
                      {nombre: 'Las Piedras', municipio_id: 186},
                      {nombre: 'Guaraque', municipio_id: 187},
                      {nombre: 'Mesa de Quintero', municipio_id: 187},
                      {nombre: 'RÃ­o Negro', municipio_id: 187},
                      {nombre: 'Arapuey', municipio_id: 188},
                      {nombre: 'Palmira', municipio_id: 188},
                      {nombre: 'San CristÃ³bal de Torondoy', municipio_id: 189},
                      {nombre: 'Torondoy', municipio_id: 189},
                      {nombre: 'Antonio Spinetti Dini', municipio_id: 190},
                      {nombre: 'Arias', municipio_id: 190},
                      {nombre: 'Caracciolo Parra PÃ©rez', municipio_id: 190},
                      {nombre: 'Domingo PeÃ±a', municipio_id: 190},
                      {nombre: 'El Llano', municipio_id: 190},
                      {nombre: 'Gonzalo PicÃ³n Febres', municipio_id: 190},
                      {nombre: 'Jacinto Plaza', municipio_id: 190},
                      {nombre: 'Juan RodrÃ­guez SuÃ¡rez', municipio_id: 190},
                      {nombre: 'Lasso de la Vega', municipio_id: 190},
                      {nombre: 'Mariano PicÃ³n Salas', municipio_id: 190},
                      {nombre: 'Milla', municipio_id: 190},
                      {nombre: 'Osuna RodrÃ­guez', municipio_id: 190},
                      {nombre: 'Sagrario', municipio_id: 190},
                      {nombre: 'El Morro', municipio_id: 190},
                      {nombre: 'Los Nevados', municipio_id: 190},
                      {nombre: 'AndrÃ©s Eloy Blanco', municipio_id: 191},
                      {nombre: 'La Venta', municipio_id: 191},
                      {nombre: 'PiÃ±ango', municipio_id: 191},
                      {nombre: 'Timotes', municipio_id: 191},
                      {nombre: 'Eloy Paredes', municipio_id: 192},
                      {nombre: 'San Rafael de AlcÃ¡zar', municipio_id: 192},
                      {nombre: 'Santa Elena de Arenales', municipio_id: 192},
                      {nombre: 'Santa MarÃ­a de Caparo', municipio_id: 193},
                      {nombre: 'Pueblo Llano', municipio_id: 194},
                      {nombre: 'Cacute', municipio_id: 195},
                      {nombre: 'La Toma', municipio_id: 195},
                      {nombre: 'MucuchÃ­es', municipio_id: 195},
                      {nombre: 'MucurubÃ¡', municipio_id: 195},
                      {nombre: 'San Rafael', municipio_id: 195},
                      {nombre: 'GerÃ³nimo Maldonado', municipio_id: 196},
                      {nombre: 'Bailadores', municipio_id: 196},
                      {nombre: 'Tabay', municipio_id: 197},
                      {nombre: 'ChiguarÃ¡', municipio_id: 198},
                      {nombre: 'EstÃ¡nquez', municipio_id: 198},
                      {nombre: 'Lagunillas', municipio_id: 198},
                      {nombre: 'La Trampa', municipio_id: 198},
                      {nombre: 'Pueblo Nuevo del Sur', municipio_id: 198},
                      {nombre: 'San Juan', municipio_id: 198},
                      {nombre: 'El Amparo', municipio_id: 199},
                      {nombre: 'El Llano', municipio_id: 199},
                      {nombre: 'San Francisco', municipio_id: 199},
                      {nombre: 'Tovar', municipio_id: 199},
                      {nombre: 'Independencia', municipio_id: 200},
                      {nombre: 'MarÃ­a de la ConcepciÃ³n Palacios Blanco', municipio_id: 200},
                      {nombre: 'Nueva Bolivia', municipio_id: 200},
                      {nombre: 'Santa Apolonia', municipio_id: 200},
                      {nombre: 'CaÃ±o El Tigre', municipio_id: 201},
                      {nombre: 'Zea', municipio_id: 201},
                      {nombre: 'AragÃ¼ita', municipio_id: 223},
                      {nombre: 'ArÃ©valo GonzÃ¡lez', municipio_id: 223},
                      {nombre: 'Capaya', municipio_id: 223},
                      {nombre: 'Caucagua', municipio_id: 223},
                      {nombre: 'Panaquire', municipio_id: 223},
                      {nombre: 'Ribas', municipio_id: 223},
                      {nombre: 'El CafÃ©', municipio_id: 223},
                      {nombre: 'Marizapa', municipio_id: 223},
                      {nombre: 'Cumbo', municipio_id: 224},
                      {nombre: 'San JosÃ© de Barlovento', municipio_id: 224},
                      {nombre: 'El Cafetal', municipio_id: 225},
                      {nombre: 'Las Minas', municipio_id: 225},
                      {nombre: 'Nuestra SeÃ±ora del Rosario', municipio_id: 225},
                      {nombre: 'Higuerote', municipio_id: 226},
                      {nombre: 'Curiepe', municipio_id: 226},
                      {nombre: 'Tacarigua de BriÃ³n', municipio_id: 226},
                      {nombre: 'Mamporal', municipio_id: 227},
                      {nombre: 'Carrizal', municipio_id: 228},
                      {nombre: 'Chacao', municipio_id: 229},
                      {nombre: 'Charallave', municipio_id: 230},
                      {nombre: 'Las Brisas', municipio_id: 230},
                      {nombre: 'El Hatillo', municipio_id: 231},
                      {nombre: 'Altagracia de la MontaÃ±a', municipio_id: 232},
                      {nombre: 'Cecilio Acosta', municipio_id: 232},
                      {nombre: 'Los Teques', municipio_id: 232},
                      {nombre: 'El Jarillo', municipio_id: 232},
                      {nombre: 'San Pedro', municipio_id: 232},
                      {nombre: 'TÃ¡cata', municipio_id: 232},
                      {nombre: 'Paracotos', municipio_id: 232},
                      {nombre: 'Cartanal', municipio_id: 233},
                      {nombre: 'Santa Teresa del Tuy', municipio_id: 233},
                      {nombre: 'La Democracia', municipio_id: 234},
                      {nombre: 'Ocumare del Tuy', municipio_id: 234},
                      {nombre: 'Santa BÃ¡rbara', municipio_id: 234},
                      {nombre: 'San Antonio de los Altos', municipio_id: 235},
                      {nombre: 'RÃ­o Chico', municipio_id: 236},
                      {nombre: 'El Guapo', municipio_id: 236},
                      {nombre: 'Tacarigua de la Laguna', municipio_id: 236},
                      {nombre: 'Paparo', municipio_id: 236},
                      {nombre: 'San Fernando del Guapo', municipio_id: 236},
                      {nombre: 'Santa LucÃ­a del Tuy', municipio_id: 237},
                      {nombre: 'CÃºpira', municipio_id: 238},
                      {nombre: 'Machurucuto', municipio_id: 238},
                      {nombre: 'Guarenas', municipio_id: 239},
                      {nombre: 'San Antonio de Yare', municipio_id: 240},
                      {nombre: 'San Francisco de Yare', municipio_id: 240},
                      {nombre: 'Leoncio MartÃ­nez', municipio_id: 241},
                      {nombre: 'Petare', municipio_id: 241},
                      {nombre: 'CaucagÃ¼ita', municipio_id: 241},
                      {nombre: 'Filas de Mariche', municipio_id: 241},
                      {nombre: 'La Dolorita', municipio_id: 241},
                      {nombre: 'CÃºa', municipio_id: 242},
                      {nombre: 'Nueva CÃºa', municipio_id: 242},
                      {nombre: 'Guatire', municipio_id: 243},
                      {nombre: 'BolÃ­var', municipio_id: 243},
                      {nombre: 'San Antonio de MaturÃ­n', municipio_id: 258},
                      {nombre: 'San Francisco de MaturÃ­n', municipio_id: 258},
                      {nombre: 'Aguasay', municipio_id: 259},
                      {nombre: 'Caripito', municipio_id: 260},
                      {nombre: 'El GuÃ¡charo', municipio_id: 261},
                      {nombre: 'La Guanota', municipio_id: 261},
                      {nombre: 'Sabana de Piedra', municipio_id: 261},
                      {nombre: 'San AgustÃ­n', municipio_id: 261},
                      {nombre: 'Teresen', municipio_id: 261},
                      {nombre: 'Caripe', municipio_id: 261},
                      {nombre: 'Areo', municipio_id: 262},
                      {nombre: 'Capital CedeÃ±o', municipio_id: 262},
                      {nombre: 'San FÃ©lix de Cantalicio', municipio_id: 262},
                      {nombre: 'Viento Fresco', municipio_id: 262},
                      {nombre: 'El Tejero', municipio_id: 263},
                      {nombre: 'Punta de Mata', municipio_id: 263},
                      {nombre: 'Chaguaramas', municipio_id: 264},
                      {nombre: 'Las Alhuacas', municipio_id: 264},
                      {nombre: 'Tabasca', municipio_id: 264},
                      {nombre: 'Temblador', municipio_id: 264},
                      {nombre: 'Alto de los Godos', municipio_id: 265},
                      {nombre: 'BoquerÃ³n', municipio_id: 265},
                      {nombre: 'Las Cocuizas', municipio_id: 265},
                      {nombre: 'La Cruz', municipio_id: 265},
                      {nombre: 'San SimÃ³n', municipio_id: 265},
                      {nombre: 'El Corozo', municipio_id: 265},
                      {nombre: 'El Furrial', municipio_id: 265},
                      {nombre: 'JusepÃ­n', municipio_id: 265},
                      {nombre: 'La Pica', municipio_id: 265},
                      {nombre: 'San Vicente', municipio_id: 265},
                      {nombre: 'Aparicio', municipio_id: 266},
                      {nombre: 'Aragua de MaturÃ­n', municipio_id: 266},
                      {nombre: 'Chaguamal', municipio_id: 266},
                      {nombre: 'El Pinto', municipio_id: 266},
                      {nombre: 'Guanaguana', municipio_id: 266},
                      {nombre: 'La Toscana', municipio_id: 266},
                      {nombre: 'Taguaya', municipio_id: 266},
                      {nombre: 'Cachipo', municipio_id: 267},
                      {nombre: 'Quiriquire', municipio_id: 267},
                      {nombre: 'Santa BÃ¡rbara', municipio_id: 268},
                      {nombre: 'Barrancas', municipio_id: 269},
                      {nombre: 'Los Barrancos de Fajardo', municipio_id: 269},
                      {nombre: 'Uracoa', municipio_id: 270},
                      {nombre: 'AntolÃ­n del Campo', municipio_id: 271},
                      {nombre: 'Arismendi', municipio_id: 272},
                      {nombre: 'GarcÃ­a', municipio_id: 273},
                      {nombre: 'Francisco Fajardo', municipio_id: 273},
                      {nombre: 'BolÃ­var', municipio_id: 274},
                      {nombre: 'Guevara', municipio_id: 274},
                      {nombre: 'Matasiete', municipio_id: 274},
                      {nombre: 'Santa Ana', municipio_id: 274},
                      {nombre: 'Sucre', municipio_id: 274},
                      {nombre: 'Aguirre', municipio_id: 275},
                      {nombre: 'Maneiro', municipio_id: 275},
                      {nombre: 'AdriÃ¡n', municipio_id: 276},
                      {nombre: 'Juan Griego', municipio_id: 276},
                      {nombre: 'Yaguaraparo', municipio_id: 276},
                      {nombre: 'Porlamar', municipio_id: 277},
                      {nombre: 'San Francisco de Macanao', municipio_id: 278},
                      {nombre: 'Boca de RÃ­o', municipio_id: 278},
                      {nombre: 'Tubores', municipio_id: 279},
                      {nombre: 'Los Baleales', municipio_id: 279},
                      {nombre: 'Vicente Fuentes', municipio_id: 280},
                      {nombre: 'Villalba', municipio_id: 280},
                      {nombre: 'San Juan Bautista', municipio_id: 281},
                      {nombre: 'Zabala', municipio_id: 281},
                      {nombre: 'Capital Araure', municipio_id: 283},
                      {nombre: 'RÃ­o Acarigua', municipio_id: 283},
                      {nombre: 'Capital Esteller', municipio_id: 284},
                      {nombre: 'Uveral', municipio_id: 284},
                      {nombre: 'Guanare', municipio_id: 285},
                      {nombre: 'CÃ³rdoba', municipio_id: 285},
                      {nombre: 'San JosÃ© de la MontaÃ±a', municipio_id: 285},
                      {nombre: 'San Juan de Guanaguanare', municipio_id: 285},
                      {nombre: 'Virgen de la Coromoto', municipio_id: 285},
                      {nombre: 'Guanarito', municipio_id: 286},
                      {nombre: 'Trinidad de la Capilla', municipio_id: 286},
                      {nombre: 'Divina Pastora', municipio_id: 286},
                      {nombre: 'MonseÃ±or JosÃ© Vicente de Unda', municipio_id: 287},
                      {nombre: 'PeÃ±a Blanca', municipio_id: 287},
                      {nombre: 'Capital Ospino', municipio_id: 288},
                      {nombre: 'ApariciÃ³n', municipio_id: 288},
                      {nombre: 'La EstaciÃ³n', municipio_id: 288},
                      {nombre: 'PÃ¡ez', municipio_id: 289},
                      {nombre: 'Payara', municipio_id: 289},
                      {nombre: 'Pimpinela', municipio_id: 289},
                      {nombre: 'RamÃ³n Peraza', municipio_id: 289},
                      {nombre: 'PapelÃ³n', municipio_id: 290},
                      {nombre: 'CaÃ±o Delgadito', municipio_id: 290},
                      {nombre: 'San Genaro de Boconoito', municipio_id: 291},
                      {nombre: 'AntolÃ­n Tovar', municipio_id: 291},
                      {nombre: 'San Rafael de Onoto', municipio_id: 292},
                      {nombre: 'Santa Fe', municipio_id: 292},
                      {nombre: 'Thermo Morles', municipio_id: 292},
                      {nombre: 'Santa RosalÃ­a', municipio_id: 293},
                      {nombre: 'Florida', municipio_id: 293},
                      {nombre: 'Sucre', municipio_id: 294},
                      {nombre: 'ConcepciÃ³n', municipio_id: 294},
                      {nombre: 'San Rafael de Palo Alzado', municipio_id: 294},
                      {nombre: 'Uvencio Antonio VelÃ¡squez', municipio_id: 294},
                      {nombre: 'San JosÃ© de Saguaz', municipio_id: 294},
                      {nombre: 'Villa Rosa', municipio_id: 294},
                      {nombre: 'TurÃ©n', municipio_id: 295},
                      {nombre: 'Canelones', municipio_id: 295},
                      {nombre: 'Santa Cruz', municipio_id: 295},
                      {nombre: 'San Isidro Labrador', municipio_id: 295},
                      {nombre: 'MariÃ±o', municipio_id: 296},
                      {nombre: 'RÃ³mulo Gallegos', municipio_id: 296},
                      {nombre: 'San JosÃ© de Aerocuar', municipio_id: 297},
                      {nombre: 'Tavera Acosta', municipio_id: 297},
                      {nombre: 'RÃ­o Caribe', municipio_id: 298},
                      {nombre: 'Antonio JosÃ© de Sucre', municipio_id: 298},
                      {nombre: 'El Morro de Puerto Santo', municipio_id: 298},
                      {nombre: 'Puerto Santo', municipio_id: 298},
                      {nombre: 'San Juan de las Galdonas', municipio_id: 298},
                      {nombre: 'El Pilar', municipio_id: 299},
                      {nombre: 'El RincÃ³n', municipio_id: 299},
                      {nombre: 'General Francisco Antonio VÃ¡quez', municipio_id: 299},
                      {nombre: 'GuaraÃºnos', municipio_id: 299},
                      {nombre: 'Tunapuicito', municipio_id: 299},
                      {nombre: 'UniÃ³n', municipio_id: 299},
                      {nombre: 'Santa Catalina', municipio_id: 300},
                      {nombre: 'Santa Rosa', municipio_id: 300},
                      {nombre: 'Santa Teresa', municipio_id: 300},
                      {nombre: 'BolÃ­var', municipio_id: 300},
                      {nombre: 'Maracapana', municipio_id: 300},
                      {nombre: 'Libertad', municipio_id: 302},
                      {nombre: 'El Paujil', municipio_id: 302},
                      {nombre: 'Yaguaraparo', municipio_id: 302},
                      {nombre: 'Cruz SalmerÃ³n Acosta', municipio_id: 303},
                      {nombre: 'Chacopata', municipio_id: 303},
                      {nombre: 'Manicuare', municipio_id: 303},
                      {nombre: 'Tunapuy', municipio_id: 304},
                      {nombre: 'Campo ElÃ­as', municipio_id: 304},
                      {nombre: 'Irapa', municipio_id: 305},
                      {nombre: 'Campo Claro', municipio_id: 305},
                      {nombre: 'Maraval', municipio_id: 305},
                      {nombre: 'San Antonio de Irapa', municipio_id: 305},
                      {nombre: 'Soro', municipio_id: 305},
                      {nombre: 'MejÃ­a', municipio_id: 306},
                      {nombre: 'Cumanacoa', municipio_id: 307},
                      {nombre: 'Arenas', municipio_id: 307},
                      {nombre: 'Aricagua', municipio_id: 307},
                      {nombre: 'Cogollar', municipio_id: 307},
                      {nombre: 'San Fernando', municipio_id: 307},
                      {nombre: 'San Lorenzo', municipio_id: 307},
                      {nombre: 'Villa Frontado (Muelle de Cariaco)', municipio_id: 308},
                      {nombre: 'Catuaro', municipio_id: 308},
                      {nombre: 'RendÃ³n', municipio_id: 308},
                      {nombre: 'San Cruz', municipio_id: 308},
                      {nombre: 'Santa MarÃ­a', municipio_id: 308},
                      {nombre: 'Altagracia', municipio_id: 309},
                      {nombre: 'Santa InÃ©s', municipio_id: 309},
                      {nombre: 'ValentÃ­n Valiente', municipio_id: 309},
                      {nombre: 'Ayacucho', municipio_id: 309},
                      {nombre: 'San Juan', municipio_id: 309},
                      {nombre: 'RaÃºl Leoni', municipio_id: 309},
                      {nombre: 'Gran Mariscal', municipio_id: 309},
                      {nombre: 'CristÃ³bal ColÃ³n', municipio_id: 310},
                      {nombre: 'Bideau', municipio_id: 310},
                      {nombre: 'Punta de Piedras', municipio_id: 310},
                      {nombre: 'GÃ¼iria', municipio_id: 310},
                      {nombre: 'AndrÃ©s Bello', municipio_id: 341},
                      {nombre: 'Antonio RÃ³mulo Costa', municipio_id: 342},
                      {nombre: 'Ayacucho', municipio_id: 343},
                      {nombre: 'Rivas Berti', municipio_id: 343},
                      {nombre: 'El BaÃ±o', municipio_id: 381},
                      {nombre: 'San Pedro del RÃ­o', municipio_id: 343},
                      {nombre: 'BolÃ­var', municipio_id: 344},
                      {nombre: 'Palotal', municipio_id: 344},
                      {nombre: 'General Juan Vicente GÃ³mez', municipio_id: 344},
                      {nombre: 'IsaÃ­as Medina Angarita', municipio_id: 344},
                      {nombre: 'CÃ¡rdenas', municipio_id: 345},
                      {nombre: 'Amenodoro Ã\u0081ngel Lamus', municipio_id: 345},
                      {nombre: 'La Florida', municipio_id: 345},
                      {nombre: 'CÃ³rdoba', municipio_id: 346},
                      {nombre: 'FernÃ¡ndez Feo', municipio_id: 347},
                      {nombre: 'Alberto Adriani', municipio_id: 347},
                      {nombre: 'Santo Domingo', municipio_id: 347},
                      {nombre: 'Francisco de Miranda', municipio_id: 348},
                      {nombre: 'GarcÃ­a de Hevia', municipio_id: 349},
                      {nombre: 'Boca de Grita', municipio_id: 349},
                      {nombre: 'JosÃ© Antonio PÃ¡ez', municipio_id: 349},
                      {nombre: 'GuÃ¡simos', municipio_id: 350},
                      {nombre: 'Independencia', municipio_id: 351},
                      {nombre: 'Juan GermÃ¡n Roscio', municipio_id: 351},
                      {nombre: 'RomÃ¡n CÃ¡rdenas', municipio_id: 351},
                      {nombre: 'JÃ¡uregui', municipio_id: 352},
                      {nombre: 'Emilio Constantino Guerrero', municipio_id: 352},
                      {nombre: 'MonseÃ±or Miguel Antonio Salas', municipio_id: 352},
                      {nombre: 'JosÃ© MarÃ­a Vargas', municipio_id: 353},
                      {nombre: 'JunÃ­n', municipio_id: 354},
                      {nombre: 'La PetrÃ³lea', municipio_id: 354},
                      {nombre: 'QuinimarÃ­', municipio_id: 354},
                      {nombre: 'BramÃ³n', municipio_id: 354},
                      {nombre: 'Libertad', municipio_id: 355},
                      {nombre: 'Cipriano Castro', municipio_id: 355},
                      {nombre: 'Manuel Felipe Rugeles', municipio_id: 355},
                      {nombre: 'Libertador', municipio_id: 356},
                      {nombre: 'Doradas', municipio_id: 356},
                      {nombre: 'Emeterio Ochoa', municipio_id: 356},
                      {nombre: 'San JoaquÃ­n de Navay', municipio_id: 356},
                      {nombre: 'Lobatera', municipio_id: 357},
                      {nombre: 'ConstituciÃ³n', municipio_id: 357},
                      {nombre: 'Michelena', municipio_id: 358},
                      {nombre: 'Panamericano', municipio_id: 359},
                      {nombre: 'La Palmita', municipio_id: 359},
                      {nombre: 'Pedro MarÃ­a UreÃ±a', municipio_id: 360},
                      {nombre: 'Nueva Arcadia', municipio_id: 360},
                      {nombre: 'Delicias', municipio_id: 361},
                      {nombre: 'Pecaya', municipio_id: 361},
                      {nombre: 'Samuel DarÃ­o Maldonado', municipio_id: 362},
                      {nombre: 'BoconÃ³', municipio_id: 362},
                      {nombre: 'HernÃ¡ndez', municipio_id: 362},
                      {nombre: 'La Concordia', municipio_id: 363},
                      {nombre: 'San Juan Bautista', municipio_id: 363},
                      {nombre: 'Pedro MarÃ­a Morantes', municipio_id: 363},
                      {nombre: 'San SebastiÃ¡n', municipio_id: 363},
                      {nombre: 'Dr. Francisco Romero Lobo', municipio_id: 363},
                      {nombre: 'Seboruco', municipio_id: 364},
                      {nombre: 'SimÃ³n RodrÃ­guez', municipio_id: 365},
                      {nombre: 'Sucre', municipio_id: 366},
                      {nombre: 'Eleazar LÃ³pez Contreras', municipio_id: 366},
                      {nombre: 'San Pablo', municipio_id: 366},
                      {nombre: 'Torbes', municipio_id: 367},
                      {nombre: 'Uribante', municipio_id: 368},
                      {nombre: 'CÃ¡rdenas', municipio_id: 368},
                      {nombre: 'Juan Pablo PeÃ±alosa', municipio_id: 368},
                      {nombre: 'PotosÃ­', municipio_id: 368},
                      {nombre: 'San Judas Tadeo', municipio_id: 369},
                      {nombre: 'Araguaney', municipio_id: 370},
                      {nombre: 'El Jaguito', municipio_id: 370},
                      {nombre: 'La Esperanza', municipio_id: 370},
                      {nombre: 'Santa Isabel', municipio_id: 370},
                      {nombre: 'BoconÃ³', municipio_id: 371},
                      {nombre: 'El Carmen', municipio_id: 371},
                      {nombre: 'Mosquey', municipio_id: 371},
                      {nombre: 'Ayacucho', municipio_id: 371},
                      {nombre: 'Burbusay', municipio_id: 371},
                      {nombre: 'General Ribas', municipio_id: 371},
                      {nombre: 'Guaramacal', municipio_id: 371},
                      {nombre: 'Vega de Guaramacal', municipio_id: 371},
                      {nombre: 'MonseÃ±or JÃ¡uregui', municipio_id: 371},
                      {nombre: 'Rafael Rangel', municipio_id: 371},
                      {nombre: 'San Miguel', municipio_id: 371},
                      {nombre: 'San JosÃ©', municipio_id: 371},
                      {nombre: 'Sabana Grande', municipio_id: 372},
                      {nombre: 'CheregÃ¼Ã©', municipio_id: 372},
                      {nombre: 'Granados', municipio_id: 372},
                      {nombre: 'Arnoldo GabaldÃ³n', municipio_id: 373},
                      {nombre: 'Bolivia', municipio_id: 373},
                      {nombre: 'Carrillo', municipio_id: 373},
                      {nombre: 'Cegarra', municipio_id: 373},
                      {nombre: 'ChejendÃ©', municipio_id: 373},
                      {nombre: 'Manuel Salvador Ulloa', municipio_id: 373},
                      {nombre: 'San JosÃ©', municipio_id: 373},
                      {nombre: 'Carache', municipio_id: 374},
                      {nombre: 'La ConcepciÃ³n', municipio_id: 374},
                      {nombre: 'Cuicas', municipio_id: 374},
                      {nombre: 'Panamericana', municipio_id: 374},
                      {nombre: 'Santa Cruz', municipio_id: 374},
                      {nombre: 'Escuque', municipio_id: 375},
                      {nombre: 'La UniÃ³n', municipio_id: 375},
                      {nombre: 'Santa Rita', municipio_id: 375},
                      {nombre: 'Sabana Libre', municipio_id: 375},
                      {nombre: 'El Socorro', municipio_id: 376},
                      {nombre: 'Los Caprichos', municipio_id: 376},
                      {nombre: 'Antonio JosÃ© de Sucre', municipio_id: 376},
                      {nombre: 'Campo ElÃ­as', municipio_id: 377},
                      {nombre: 'Arnoldo GabaldÃ³n', municipio_id: 377},
                      {nombre: 'Santa Apolonia', municipio_id: 378},
                      {nombre: 'El Progreso', municipio_id: 378},
                      {nombre: 'La Ceiba', municipio_id: 378},
                      {nombre: 'Tres de Febrero', municipio_id: 378},
                      {nombre: 'El Dividive', municipio_id: 379},
                      {nombre: 'Agua Santa', municipio_id: 379},
                      {nombre: 'Agua Caliente', municipio_id: 379},
                      {nombre: 'El Cenizo', municipio_id: 379},
                      {nombre: 'Valerita', municipio_id: 379},
                      {nombre: 'Monte Carmelo', municipio_id: 380},
                      {nombre: 'Buena Vista', municipio_id: 380},
                      {nombre: 'Santa MarÃ­a del HorcÃ³n', municipio_id: 380},
                      {nombre: 'MotatÃ¡n', municipio_id: 381},
                      {nombre: 'Jalisco', municipio_id: 381},
                      {nombre: 'PampÃ¡n', municipio_id: 382},
                      {nombre: 'Flor de Patria', municipio_id: 382},
                      {nombre: 'La Paz', municipio_id: 382},
                      {nombre: 'Santa Ana', municipio_id: 382},
                      {nombre: 'Pampanito', municipio_id: 383},
                      {nombre: 'La ConcepciÃ³n', municipio_id: 383},
                      {nombre: 'Pampanito II', municipio_id: 383},
                      {nombre: 'Betijoque', municipio_id: 384},
                      {nombre: 'JosÃ© Gregorio HernÃ¡ndez', municipio_id: 384},
                      {nombre: 'La Pueblita', municipio_id: 384},
                      {nombre: 'Los Cedros', municipio_id: 384},
                      {nombre: 'Carvajal', municipio_id: 385},
                      {nombre: 'Campo Alegre', municipio_id: 385},
                      {nombre: 'Antonio NicolÃ¡s BriceÃ±o', municipio_id: 385},
                      {nombre: 'JosÃ© Leonardo SuÃ¡rez', municipio_id: 385},
                      {nombre: 'Sabana de Mendoza', municipio_id: 386},
                      {nombre: 'JunÃ­n', municipio_id: 386},
                      {nombre: 'Valmore RodrÃ­guez', municipio_id: 386},
                      {nombre: 'El ParaÃ­so', municipio_id: 386},
                      {nombre: 'AndrÃ©s Linares', municipio_id: 387},
                      {nombre: 'ChiquinquirÃ¡', municipio_id: 387},
                      {nombre: 'CristÃ³bal Mendoza', municipio_id: 387},
                      {nombre: 'Cruz Carrillo', municipio_id: 387},
                      {nombre: 'Matriz', municipio_id: 387},
                      {nombre: 'MonseÃ±or Carrillo', municipio_id: 387},
                      {nombre: 'Tres Esquinas', municipio_id: 387},
                      {nombre: 'CabimbÃº', municipio_id: 388},
                      {nombre: 'JajÃ³', municipio_id: 388},
                      {nombre: 'La Mesa de Esnujaque', municipio_id: 388},
                      {nombre: 'Santiago', municipio_id: 388},
                      {nombre: 'TuÃ±ame', municipio_id: 388},
                      {nombre: 'La Quebrada', municipio_id: 388},
                      {nombre: 'Juan Ignacio Montilla', municipio_id: 389},
                      {nombre: 'La Beatriz', municipio_id: 389},
                      {nombre: 'La Puerta', municipio_id: 389},
                      {nombre: 'Mendoza del Valle de Momboy', municipio_id: 389},
                      {nombre: 'Mercedes DÃ­az', municipio_id: 389},
                      {nombre: 'San Luis', municipio_id: 389},
                      {nombre: 'Caraballeda', municipio_id: 390},
                      {nombre: 'Carayaca', municipio_id: 390},
                      {nombre: 'Carlos Soublette', municipio_id: 390},
                      {nombre: 'Caruao Chuspa', municipio_id: 390},
                      {nombre: 'Catia La Mar', municipio_id: 390},
                      {nombre: 'El Junko', municipio_id: 390},
                      {nombre: 'La Guaira', municipio_id: 390},
                      {nombre: 'Macuto', municipio_id: 390},
                      {nombre: 'MaiquetÃ­a', municipio_id: 390},
                      {nombre: 'NaiguatÃ¡', municipio_id: 390},
                      {nombre: 'Urimare', municipio_id: 390},
                      {nombre: 'ArÃ­stides Bastidas', municipio_id: 391},
                      {nombre: 'BolÃ­var', municipio_id: 392},
                      {nombre: 'Chivacoa', municipio_id: 407},
                      {nombre: 'Campo ElÃ­as', municipio_id: 407},
                      {nombre: 'Cocorote', municipio_id: 408},
                      {nombre: 'Independencia', municipio_id: 409},
                      {nombre: 'JosÃ© Antonio PÃ¡ez', municipio_id: 410},
                      {nombre: 'La Trinidad', municipio_id: 411},
                      {nombre: 'Manuel Monge', municipio_id: 412},
                      {nombre: 'SalÃ³m', municipio_id: 413},
                      {nombre: 'Temerla', municipio_id: 413},
                      {nombre: 'Nirgua', municipio_id: 413},
                      {nombre: 'San AndrÃ©s', municipio_id: 414},
                      {nombre: 'Yaritagua', municipio_id: 414},
                      {nombre: 'San Javier', municipio_id: 415},
                      {nombre: 'Albarico', municipio_id: 415},
                      {nombre: 'San Felipe', municipio_id: 415},
                      {nombre: 'Sucre', municipio_id: 416},
                      {nombre: 'Urachiche', municipio_id: 417},
                      {nombre: 'El Guayabo', municipio_id: 418},
                      {nombre: 'Farriar', municipio_id: 418},
                      {nombre: 'Isla de Toas', municipio_id: 441},
                      {nombre: 'Monagas', municipio_id: 441},
                      {nombre: 'San Timoteo', municipio_id: 442},
                      {nombre: 'General Urdaneta', municipio_id: 442},
                      {nombre: 'Libertador', municipio_id: 442},
                      {nombre: 'Marcelino BriceÃ±o', municipio_id: 442},
                      {nombre: 'Pueblo Nuevo', municipio_id: 442},
                      {nombre: 'Manuel Guanipa Matos', municipio_id: 442},
                      {nombre: 'Ambrosio', municipio_id: 443},
                      {nombre: 'Carmen Herrera', municipio_id: 443},
                      {nombre: 'La Rosa', municipio_id: 443},
                      {nombre: 'GermÃ¡n RÃ­os Linares', municipio_id: 443},
                      {nombre: 'San Benito', municipio_id: 443},
                      {nombre: 'RÃ³mulo Betancourt', municipio_id: 443},
                      {nombre: 'Jorge HernÃ¡ndez', municipio_id: 443},
                      {nombre: 'Punta Gorda', municipio_id: 443},
                      {nombre: 'ArÃ­stides Calvani', municipio_id: 443},
                      {nombre: 'Encontrados', municipio_id: 444},
                      {nombre: 'UdÃ³n PÃ©rez', municipio_id: 444},
                      {nombre: 'Moralito', municipio_id: 445},
                      {nombre: 'San Carlos del Zulia', municipio_id: 445},
                      {nombre: 'Santa Cruz del Zulia', municipio_id: 445},
                      {nombre: 'Santa BÃ¡rbara', municipio_id: 445},
                      {nombre: 'UrribarrÃ­', municipio_id: 445},
                      {nombre: 'Carlos Quevedo', municipio_id: 446},
                      {nombre: 'Francisco Javier Pulgar', municipio_id: 446},
                      {nombre: 'SimÃ³n RodrÃ­guez', municipio_id: 446},
                      {nombre: 'Guamo-Gavilanes', municipio_id: 446},
                      {nombre: 'La ConcepciÃ³n', municipio_id: 448},
                      {nombre: 'San JosÃ©', municipio_id: 448},
                      {nombre: 'Mariano Parra LeÃ³n', municipio_id: 448},
                      {nombre: 'JosÃ© RamÃ³n YÃ©pez', municipio_id: 448},
                      {nombre: 'JesÃºs MarÃ­a SemprÃºn', municipio_id: 449},
                      {nombre: 'BarÃ­', municipio_id: 449},
                      {nombre: 'ConcepciÃ³n', municipio_id: 450},
                      {nombre: 'AndrÃ©s Bello', municipio_id: 450},
                      {nombre: 'ChiquinquirÃ¡', municipio_id: 450},
                      {nombre: 'El Carmelo', municipio_id: 450},
                      {nombre: 'Potreritos', municipio_id: 450},
                      {nombre: 'Libertad', municipio_id: 451},
                      {nombre: 'Alonso de Ojeda', municipio_id: 451},
                      {nombre: 'Venezuela', municipio_id: 451},
                      {nombre: 'Eleazar LÃ³pez Contreras', municipio_id: 451},
                      {nombre: 'Campo Lara', municipio_id: 451},
                      {nombre: 'BartolomÃ© de las Casas', municipio_id: 452},
                      {nombre: 'Libertad', municipio_id: 452},
                      {nombre: 'RÃ­o Negro', municipio_id: 452},
                      {nombre: 'San JosÃ© de PerijÃ¡', municipio_id: 452},
                      {nombre: 'San Rafael', municipio_id: 453},
                      {nombre: 'La Sierrita', municipio_id: 453},
                      {nombre: 'Las Parcelas', municipio_id: 453},
                      {nombre: 'Luis de Vicente', municipio_id: 453},
                      {nombre: 'MonseÃ±or Marcos Sergio Godoy', municipio_id: 453},
                      {nombre: 'Ricaurte', municipio_id: 453},
                      {nombre: 'Tamare', municipio_id: 453},
                      {nombre: 'Antonio Borjas Romero', municipio_id: 454},
                      {nombre: 'BolÃ­var', municipio_id: 454},
                      {nombre: 'Cacique Mara', municipio_id: 454},
                      {nombre: 'Carracciolo Parra PÃ©rez', municipio_id: 454},
                      {nombre: 'Cecilio Acosta', municipio_id: 454},
                      {nombre: 'Cristo de Aranza', municipio_id: 454},
                      {nombre: 'Coquivacoa', municipio_id: 454},
                      {nombre: 'ChiquinquirÃ¡', municipio_id: 454},
                      {nombre: 'Francisco Eugenio Bustamante', municipio_id: 454},
                      {nombre: 'Idelfonzo VÃ¡squez', municipio_id: 454},
                      {nombre: 'Juana de Ã\u0081vila', municipio_id: 454},
                      {nombre: 'Luis Hurtado Higuera', municipio_id: 454},
                      {nombre: 'Manuel Dagnino', municipio_id: 454},
                      {nombre: 'Olegario Villalobos', municipio_id: 454},
                      {nombre: 'RaÃºl Leoni', municipio_id: 454},
                      {nombre: 'Santa LucÃ­a', municipio_id: 454},
                      {nombre: 'Venancio Pulgar', municipio_id: 454},
                      {nombre: 'San Isidro', municipio_id: 454},
                      {nombre: 'Altagracia', municipio_id: 455},
                      {nombre: 'FarÃ­a', municipio_id: 455},
                      {nombre: 'Ana MarÃ­a Campos', municipio_id: 455},
                      {nombre: 'San Antonio', municipio_id: 455},
                      {nombre: 'San JosÃ©', municipio_id: 455},
                      {nombre: 'Donaldo GarcÃ­a', municipio_id: 456},
                      {nombre: 'El Rosario', municipio_id: 456},
                      {nombre: 'Sixto Zambrano', municipio_id: 456},
                      {nombre: 'San Francisco', municipio_id: 457},
                      {nombre: 'El Bajo', municipio_id: 457},
                      {nombre: 'Domitila Flores', municipio_id: 457},
                      {nombre: 'Francisco Ochoa', municipio_id: 457},
                      {nombre: 'Los Cortijos', municipio_id: 457},
                      {nombre: 'Marcial HernÃ¡ndez', municipio_id: 457},
                      {nombre: 'Santa Rita', municipio_id: 458},
                      {nombre: 'El Mene', municipio_id: 458},
                      {nombre: 'Pedro Lucas UrribarrÃ­', municipio_id: 458},
                      {nombre: 'JosÃ© Cenobio UrribarrÃ­', municipio_id: 458},
                      {nombre: 'Rafael Maria Baralt', municipio_id: 459},
                      {nombre: 'Manuel Manrique', municipio_id: 459},
                      {nombre: 'Rafael Urdaneta', municipio_id: 459},
                      {nombre: 'Bobures', municipio_id: 460},
                      {nombre: 'Gibraltar', municipio_id: 460},
                      {nombre: 'Heras', municipio_id: 460},
                      {nombre: 'MonseÃ±or Arturo Ã\u0081lvarez', municipio_id: 460},
                      {nombre: 'RÃ³mulo Gallegos', municipio_id: 460},
                      {nombre: 'El Batey', municipio_id: 460},
                      {nombre: 'Rafael Urdaneta', municipio_id: 461},
                      {nombre: 'La Victoria', municipio_id: 461},
                      {nombre: 'RaÃºl Cuenca', municipio_id: 461},
                      {nombre: 'Sinamaica', municipio_id: 447},
                      {nombre: 'Alta Guajira', municipio_id: 447},
                      {nombre: 'ElÃ­as SÃ¡nchez Rubio', municipio_id: 447},
                      {nombre: 'Guajira', municipio_id: 447},
                      {nombre: 'Altagracia', municipio_id: 462},
                      {nombre: 'AntÃ­mano', municipio_id: 462},
                      {nombre: 'Caricuao', municipio_id: 462},
                      {nombre: 'Catedral', municipio_id: 462},
                      {nombre: 'Coche', municipio_id: 462},
                      {nombre: 'El Junquito', municipio_id: 462},
                      {nombre: 'El ParaÃ­so', municipio_id: 462},
                      {nombre: 'El Recreo', municipio_id: 462},
                      {nombre: 'El Valle', municipio_id: 462},
                      {nombre: 'La Candelaria', municipio_id: 462},
                      {nombre: 'La Pastora', municipio_id: 462},
                      {nombre: 'La Vega', municipio_id: 462},
                      {nombre: 'Macarao', municipio_id: 462},
                      {nombre: 'San AgustÃ­n', municipio_id: 462},
                      {nombre: 'San Bernardino', municipio_id: 462},
                      {nombre: 'San JosÃ©', municipio_id: 462},
                      {nombre: 'San Juan', municipio_id: 462},
                      {nombre: 'San Pedro', municipio_id: 462},
                      {nombre: 'Santa RosalÃ­a', municipio_id: 462},
                      {nombre: 'Santa Teresa', municipio_id: 462},
                      {nombre: 'Sucre (Catia)', municipio_id: 462},
                      {nombre: '23 de enero', municipio_id: 462}
                  ])
#########################################################
############# SOLICITUDES Y REQUISITOS ##################
#########################################################
puts '## PRIMER NUMERO DE CONTROL DE SOLICITUDES ###'
NumeroControl.create!(nombre: 'solicitud', numero: 0)

puts '### SEEDEANDO TIPOS DE SOLICITUDES ###'
preinscripcion = TipoSolicitud.create!(nombre: 'preinscripcion',
                                       descripcion: 'Solicitud de Autorización de Adecuación')


puts '### SEEDEANDO WORKFLOW POR TIPO DE SOLICITUD##'
workflowPreinscripcion = WorkFlow.create!(nombre: 'WF_Preinscripcion',
                                          TipoSolicitud_id: preinscripcion.id)
puts 'workflow preinscripción ET creado'
# Creando Estados de Workflow Preincripcion

st_creada       = EstadosWorkFlow.create!(nombre:'creada'   ,
                                          Workflow_id: workflowPreinscripcion.id)
st_preparada    = EstadosWorkFlow.create!(nombre:'preparada',
                                          Workflow_id: workflowPreinscripcion.id)
st_completa     = EstadosWorkFlow.create!(nombre:'completa' ,
                                          Workflow_id: workflowPreinscripcion.id)
# st_modificada   = EstadosWorkFlow.create!(nombre:'modificada',
#                                           Workflow_id: workflowPreinscripcion.id)
st_para_estudio = EstadosWorkFlow.create!(nombre:'para_estudio',
                                          Workflow_id: workflowPreinscripcion.id)
st_diferida     = EstadosWorkFlow.create!(nombre:'diferida'    ,
                                          Workflow_id: workflowPreinscripcion.id)
st_caducada     = EstadosWorkFlow.create!(nombre:'caducada'    ,
                                          Workflow_id: workflowPreinscripcion.id)
st_en_espera_de_inpeccion = EstadosWorkFlow.create!(nombre:'en_espera_de_inpeccion',
                                                    Workflow_id: workflowPreinscripcion.id)
puts 'Estados de workflow preinscripción ET creado'

# creando eventos de Workflow Preincripcion

ev_preparar= EventosWorkFlow.create!(nombre:'preparar',Workflow_id: workflowPreinscripcion.id)
ev_imprimir_planilla= EventosWorkFlow.create!(nombre:'imprimir_planilla',Workflow_id: workflowPreinscripcion.id)
ev_modificar= EventosWorkFlow.create!(nombre:'modificar',Workflow_id: workflowPreinscripcion.id)
ev_hacer_inspeccion= EventosWorkFlow.create!(nombre:'hacer_inspeccion',Workflow_id: workflowPreinscripcion.id)
ev_diferir= EventosWorkFlow.create!(nombre:'diferir',Workflow_id: workflowPreinscripcion.id)
ev_hacer_estudio= EventosWorkFlow.create!(nombre:'hacer_estudio',Workflow_id: workflowPreinscripcion.id)
ev_caducar= EventosWorkFlow.create!(nombre:'caducar',Workflow_id: workflowPreinscripcion.id)

puts 'Eventos de workflow preinscripción ET creado'

# creando transiciones de workflow Preinscripcion
#       st_creada  --  ev_preparar  -->st_preparada
TransicionesWorkFlow.create!(estado_fuente_id:st_creada.id,estado_destino_id:st_preparada.id,EventosWorkFlow_id:ev_preparar.id)

#       st_preparadas  --  ev_modificar  -->t_creada
TransicionesWorkFlow.create!(estado_fuente_id:st_preparada.id,estado_destino_id:st_creada.id,EventosWorkFlow_id:ev_modificar.id)


#       st_preparada  --  ev_imprimir_planilla  -->st_completa
TransicionesWorkFlow.create!(estado_fuente_id:st_preparada.id,estado_destino_id:st_completa.id,EventosWorkFlow_id:ev_imprimir_planilla.id)

#       st_completa  --  ev_modificar -->st_preparada
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id:st_preparada.id,EventosWorkFlow_id:ev_modificar.id)

#       st_completa  --  ev_hacer_estudio -->st_para_estudio
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id: st_para_estudio.id,EventosWorkFlow_id: ev_hacer_estudio.id)

#       st_completa  --  ev_diferir  -->st_diferida
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id:st_diferida.id,EventosWorkFlow_id:ev_diferir.id)

#       st_completa  --  ev_hacer_inspeccion  -->st_en_espera_de_inpeccion
TransicionesWorkFlow.create!(estado_fuente_id:st_completa.id,estado_destino_id: st_en_espera_de_inpeccion.id,EventosWorkFlow_id: ev_hacer_inspeccion.id)

#      st_diferida --  ev_caducar  -->st_caducada
TransicionesWorkFlow.create!(estado_fuente_id:st_diferida.id,estado_destino_id:st_caducada.id,EventosWorkFlow_id:ev_caducar.id)
puts 'Transiciones de workflow preinscripción ET creado'

#cargando funcion sistemas asociadas con cambios de estados en Work flow
wf_diferir_solicitud   = FuncionSistema.find_by_nombre(:wf_diferir_solicitud)
wf_realizar_inspeccion = FuncionSistema.find_by_nombre(:wf_realizar_inspeccion)
wf_realizar_estudio    = FuncionSistema.find_by_nombre(:wf_realizar_estudio)

#creando asociaciones entre funcion sistemas y button (esta relacion es el connect de QT)
button_diferir_solicitud   = Button.create!(helper_path:'diferir_preinscripcion_escuela_path',
                                            style:'btn btn-danger',
                                            icon:'<i class="fa fa-archive"></i>',
                                            text:'Diferir Solicitud',
                                            funcion_sistema_id: wf_diferir_solicitud.id)

button_realizar_inspeccion = Button.create!(helper_path:'inspeccionar_preinscripcion_escuela_path',
                                            style:'btn btn-success',
                                            icon:'<i class="fa fa-eye"></i>',
                                            text:'Hacer Inspección',
                                            funcion_sistema_id:wf_realizar_inspeccion.id)

button_realizar_estudio    = Button.create!(helper_path:'estudiar_preinscripcion_escuela_path',
                                            style:'btn btn-success',
                                            icon:'<i class="fa fa-archive"></i>',
                                            text:'Hacer Estudio',
                                            funcion_sistema_id:wf_realizar_estudio.id)

puts 'Asociaciones entre funcion sistemas y button creadas'

#creando asociaciones entre Estados Work Flow y buttons
st_creada.buttons.push( button_diferir_solicitud,
                        button_realizar_estudio,
                        button_realizar_inspeccion)

puts 'Asociaciones entre Estados Work Flow preinscripción ET y buttons creadas'

#creando relaciones entre funcion sistemas y eventos workflow
wf_diferir_solicitud.eventos_work_flow  = ev_diferir
wf_realizar_estudio.eventos_work_flow    = ev_hacer_estudio
wf_realizar_inspeccion.eventos_work_flow = ev_hacer_inspeccion
puts 'Asociaciones entre funcion sistemas y eventos Work flow creadas'


puts '### CREANDO VISTAS ###'

vista_registro_escuela = Vista.create!(nombre: 'registro_inicial',
                                       descripcion:
                                           'Documentos requeridos al momento del registro de la escuela de transporte')

vista_informacion_general  = Vista.create!(nombre:'informacion_general',
                                           descripcion: 'Carga de Información General de la Escuela de Transporte',
                                           index: 0)

vista_planos_infraestructura    = Vista.create!(nombre: 'planos_infraestructura',
                                                descripcion: 'Planos de la Infraestructura',
                                                index: 1,  any_grupo_documentos_uno: true)

vista_rcv_flota = Vista.create!(nombre:'rcv_flota',
                                descripcion: 'Registro de Seguro RCV para Vehículos',
                                index: 2)

vista_vehiculo_ensenanza = Vista.create!(nombre:'vehiculo_pre',
                                         descripcion: 'Registro de Vehículos de Enseñanza',
                                         index: 3)

vista_arrendamiento = Vista.create!(nombre:'vehiculo_arrendamiento',
                                    descripcion: 'Datos de Arrendamiento',
                                    index: 3)

vista_registro_circuitos_manejo = Vista.create!(nombre: 'registro_circuitos_manejo',
                                                descripcion: 'Registro de Circuitos de Manejo',
                                                index: 4)


vista_trabajadores = Vista.create!(nombre: 'trabajadores',
                                   descripcion: 'Registro de los Trabajadores',
                                   index: 5)

vista_trabajadores_instructores = Vista.create!(nombre: 'trabajadores_instructores',
                                                descripcion: 'Registro de los Trabajadores Instructores',
                                                index: 5)

puts '### ASOCIANDO VISTAS A TIPOS DE SOLICITUDES###'

preinscripcion.vistas<< vista_informacion_general<<vista_planos_infraestructura<<
    vista_rcv_flota<<vista_vehiculo_ensenanza<<vista_arrendamiento<<
    vista_registro_circuitos_manejo<<vista_trabajadores<<vista_trabajadores_instructores
puts '### DOCUMENTOS DE REQUISITOS ###'

# ######## DOCUMENTOS DE REGISTRO DE ESCUELA DE TRANSPORTE ###############
vista_registro_escuela.documento_requisitos<<
    DocumentoRequisito.create!([{nombre: 'rif_imagen',
                                 descripcion: 'RIF',
                                 cardinalidad_maxima: 1,
                                 obligatorio: true},
                                {nombre: 'acta_constitutiva',
                                 descripcion: 'Acta Constitutiva',
                                 paginado: true,
                                 cardinalidad_maxima: 1,
                                 obligatorio: true}
                               ])

####### DOCUMENTOS DE INFORMACION GENERAL ################


vista_informacion_general.documento_requisitos<<
    DocumentoRequisito.create!([{nombre: 'deposito_bancario',
                                 descripcion: 'Comprobante de depósito bancario por concepto de proceso de registro:',
                                 paginado: true,
                                 cardinalidad_maxima: 1},
                                {nombre: 'ultima_acta_asamblea',
                                 descripcion: 'Actas de Asamblea con las ultimas modificaciones, en caso de Existir:',
                                 paginado: true,
                                 cardinalidad_maxima: 1},
                                {nombre: 'carta_presidente_intt',
                                 descripcion: 'Carta de solicitud dirigida al presidente del INTT con atención a la gerencia de Servicios Conexos:',
                                 cardinalidad_maxima: 1},
                                {nombre: 'patente_industria_comercio',
                                 descripcion: 'Registro de la Patente de Industria y Comercio para uso educacional:',
                                 cardinalidad_maxima: 1},
                                {nombre: 'constancia_impuestos_municipales',
                                 descripcion: 'Constancia de pago de impuestos Municipales:',
                                 cardinalidad_maxima: 1},
                                {nombre:'impacto_ambiental_vial',
                                 descripcion: 'Estudio de impacto ambiental y víal',
                                 cardinalidad_maxima: 1},
                                {nombre: 'seguro_daño_terceros',
                                 descripcion:'Póliza de seguro a todo riesgo y daños a terceros:' ,
                                 cardinalidad_maxima: 1},
                                {nombre: 'organigrama_escuela',
                                 descripcion: 'Organigrama estructural de la escuela:',
                                 cardinalidad_maxima: 1}])

####### DOCUMENTOS DE INFRAESTRUCTURA (PLANOS) ######

vista_planos_infraestructura.documento_requisitos<<
    DocumentoRequisito.create!([{nombre:'deposito_bancario_infraestructura',
                                 descripcion:
                                     'Comprobante Deposito Bancario por pago de la Certificación de la  Infraestructura:',
                                 cardinalidad_maxima:1,
                                 paginado:true,
                                 obligatorio: true
                                },
                                {nombre:'permiso_municipal_construccion',
                                 descripcion:
                                     'Permiso Municipal de construcción:',
                                 cardinalidad_maxima:1,
                                 obligatorio: true
                                },
                                {nombre:'permiso_ingenieria_municipal',
                                 descripcion:
                                     'Permiso de Ingeniería Municipal(Variables Urbanas):',
                                 cardinalidad_maxima:1,
                                 obligatorio: true
                                },
                                {nombre:'propiedad_arrendamiento_inmueble',
                                 descripcion:
                                     'Documento de propiedad del inmueble o contrato de arrendamiento que faculte su uso:',
                                 cardinalidad_maxima:1,
                                 obligatorio: true
                                }
                               ])

grupoAlmenosUnoInfraestructura =
    GrupoDocumentosUno.create!(mensaje:
                                   'Debe ingresar almenos un documento de Planos (marcados con asterisco verde) ',
                               icon_color:'verde')

doc_planos_planta =
    DocumentoRequisito.create!(nombre:'Planta',
                               descripcion: 'Planta',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)

doc_planta_corte_lateral_izquierdo=
    DocumentoRequisito.create!(nombre:'Planta_corte_lateral_izquierdo',
                               descripcion: 'Planta corte lateral izquierdo',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)

doc_planta_corte_lateral_derecho =
    DocumentoRequisito.create!(nombre:'Planta_corte_lateral_derecho',
                               descripcion: 'Planta corte lateral derecho',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)
doc_fachada=
    DocumentoRequisito.create!(nombre:'fachada',
                               descripcion: 'Fachada',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)

doc_techo =
    DocumentoRequisito.create!( nombre:'techo',
                                descripcion: 'Techo',
                                cardinalidad_maxima:1,
                                obligatorio: false,
                                almenos_uno: true)
doc_aguas_negras =
    DocumentoRequisito.create!(nombre:'aguas_negras',
                               descripcion: 'Aguas Negras',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)
doc_aguas_blancas =
    DocumentoRequisito.create!(nombre:'aguas_blancas',
                               descripcion: 'Aguas Blancas',
                               cardinalidad_maxima:1,
                               obligatorio: false,
                               almenos_uno: true)
doc_electricidad =
    DocumentoRequisito.create!( nombre:'electricidad',
                                descripcion: 'Electricidad',
                                cardinalidad_maxima:1,
                                obligatorio: false,
                                almenos_uno: true)

DocumentosRequisitosPorVista.create!([
                                         {
                                             vista: vista_planos_infraestructura,
                                             documento_requisito:  doc_planos_planta,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura

                                         },
                                         {   vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_planta_corte_lateral_izquierdo
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_planta_corte_lateral_derecho
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_fachada
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_techo
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_aguas_negras

                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_aguas_blancas
                                         },
                                         {
                                             vista: vista_planos_infraestructura,
                                             grupo_documentos_uno: grupoAlmenosUnoInfraestructura,
                                             documento_requisito:doc_electricidad
                                         }
                                     ])
# #####################################################
# ####### DATOS DEL SEGURO RCV   ######################
# #####################################################
vista_rcv_flota.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'rcv_digital',
                                    descripcion:
                                        'Póliza RCV digital:',
                                    cardinalidad_maxima:1
                                   }
                               ])
# #####################################################
# ####### DOCUMENTOS DE VEHICULOS #####################
# #####################################################
vista_vehiculo_ensenanza.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'certificado_homologacion',
                                    descripcion:
                                        'Certificado de Homologación:',
                                    cardinalidad_maxima:1,
                                    obligatorio: false
                                   },
                                   {nombre:'certificado_registro_del_vehiculo',
                                    descripcion:
                                        'Certificado de Registro del Vehículo:',
                                    cardinalidad_maxima:1
                                   },
                                   {nombre:'certificado_revision_tecnica',
                                    descripcion: 'Certificado Revisión Técnica:',
                                    cardinalidad_maxima:1,
                                    obligatorio: true
                                   },
                                   {nombre:'Comprobante_de_pago_por_certificacion',
                                    descripcion: 'Comprobante de pago por certificación:',
                                    cardinalidad_maxima:1,
                                    obligatorio: true
                                   }
                               ])

# #####################################################
# ####### DOCUMENTOS DE ARRENDAMIENTO      ############
# #####################################################
vista_arrendamiento.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'arrendamiento_notariado',
                                    descripcion:
                                        'Contrato de arrendamiento notariado:',
                                    cardinalidad_maxima:1
                                   }
                               ])
# #####################################################
# ####### DOCUMENTOS CIRCUITOS DE MANEJO ##############
# #####################################################
vista_registro_circuitos_manejo.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'pago_certificacion',
                                    descripcion:
                                        'Comprobante de pago por la Certificación:',
                                    cardinalidad_maxima:1,
                                    paginado:true
                                   },
                                   {nombre:'planos_escala',
                                    descripcion:
                                        'planos_escala 1:1000:',
                                    cardinalidad_maxima:20,
                                    paginado:true
                                   },
                                   {nombre:'permiso_circulacion ',
                                    descripcion: 'Permiso circulación en vías públicas:',
                                    cardinalidad_maxima:1,
                                    obligatorio: true
                                   }
                               ])
# #####################################################
# ####### DOCUMENTOS REGISTRO DE TRABAJADORES##########
# #####################################################
vista_trabajadores.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'cedula',
                                    descripcion:
                                        'Cédula de identidad:',
                                    cardinalidad_maxima:1}
                               ])
vista_trabajadores_instructores.documento_requisitos<<
    DocumentoRequisito.create!([
                                   {nombre:'Licencia_instructor',
                                    descripcion:
                                        'Licencia de instructor:',
                                    cardinalidad_maxima:1,
                                   },
                                   {nombre:'certificado_medico_salud_integral',
                                    descripcion:
                                        'Certificado médico de salud integral:',
                                    cardinalidad_maxima:1,
                                   },
                                   {nombre:'Certificado_psicologico_conducir',
                                    descripcion: 'Certificado psicológico para conducir:',
                                    cardinalidad_maxima:1
                                   }
                               ])
puts '### PRODUCTION SEED END ###'
################################################
##### SEEDS PARA EL ENTORNO DE DESARROLLO ######
################################################

unless Rails.env.production?
  puts '### INICIO DE SEEDS PARA DESARROLLO Y TEST###'

  #usuarios 'externos' para probar en entornos de desarrollo y test
  userbiosoft = SessionUser.create!(email: 'biosoft@correo.com',
                                    email_confirmation: 'biosoft@correo.com',
                                    password:              '12345678',
                                    password_confirmation: '12345678',
                                    confirmed_at: Date.today,
                                    usuario_sput_id: 1
  )

  RepresentanteLegal.create!(
      estado_representante: 2,
      rif: 'V1911',
      usuario_sput_id:1,
      session_user_id: userbiosoft.id,
      direccion:'Mérida',
      remote_doc_rif_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu',
      remote_doc_cedula_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu'

  )

  userbiosoft2 = SessionUser.create!(email: 'biosoft2@correo.com',
                                     email_confirmation: 'biosoft2@correo.com',
                                     password:              '12345678',
                                     password_confirmation: '12345678',
                                     confirmed_at: Date.today,
                                     usuario_sput_id: 2
  )

  RepresentanteLegal.create!(
      estado_representante: 2,
      rif: 'V1922',
      usuario_sput_id:2,
      session_user_id: userbiosoft2.id,
      direccion:'Mérida',
      remote_doc_rif_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu',
      remote_doc_cedula_url:'https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcT5iCtHFdwuPfudcGiLj9TLambZJ64UPVTTqlQvRa6mDYPbrSF68JzTocJu'
  )
  puts '### USUARIOS EXTERNOS DE PRUEBA CREADOS (TEST Y DEVELOPMENT) ###'


end