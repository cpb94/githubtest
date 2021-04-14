$PBExportHeader$wtc_consulta_coste_aplicaciones_similares_pruebas.srw
forward
global type wtc_consulta_coste_aplicaciones_similares_pruebas from wt_padre_vacio
end type
type em_pieza from editmask within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type em_prueba from editmask within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type dw_aplicaciones from u_dw within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type cb_1 from commandbutton within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type dw_articulos from u_dw within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type pb_anyade_aplicacion from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type pb_borra_aplicacion from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type pb_intercala_aplicacion from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type em_fecha from editmask within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type barra from hprogressbar within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type pb_imprimir from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type st_1 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type st_3 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type uo_formato from u_em_campo_2 within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type st_2 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type st_4 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type ddlb_base from dropdownlistbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type uo_cliente from u_em_campo_2 within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type gb_1 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type gb_2 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type gb_3 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type gb_4 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type gb_5 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
type gb_6 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
end type
end forward

global type wtc_consulta_coste_aplicaciones_similares_pruebas from wt_padre_vacio
integer width = 5774
integer height = 3780
string title = "Consulta Coste Artículos con Aplicaciones Similares"
em_pieza em_pieza
em_prueba em_prueba
dw_aplicaciones dw_aplicaciones
cb_1 cb_1
dw_articulos dw_articulos
pb_anyade_aplicacion pb_anyade_aplicacion
pb_borra_aplicacion pb_borra_aplicacion
pb_intercala_aplicacion pb_intercala_aplicacion
em_fecha em_fecha
barra barra
pb_imprimir pb_imprimir
st_1 st_1
st_3 st_3
uo_formato uo_formato
st_2 st_2
st_4 st_4
ddlb_base ddlb_base
uo_cliente uo_cliente
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
gb_5 gb_5
gb_6 gb_6
end type
global wtc_consulta_coste_aplicaciones_similares_pruebas wtc_consulta_coste_aplicaciones_similares_pruebas

type variables
Dec formatos_ancho, formatos_largo
end variables

forward prototypes
public function boolean f_mismas_aplicaciones (string articulo)
public subroutine f_aplicar_reglas ()
public subroutine f_insertar_encajado ()
end prototypes

public function boolean f_mismas_aplicaciones (string articulo);Long i, j, n
integer indice = 1, seleccionado
Dec factor
String sel, articulo_escandallo, operacion, aplicacion, operacion_dw, aplicacion_dw, base, g2, uso_base
Boolean resultado = true, saltar_aplicaciones
str_escandallo escandallo[300]
Datastore aplicaciones

f_escandallo_factores (escandallo, articulo, indice, 1, 0)
if indice < 0 then
	return false
end if
////DEBUG
if articulo = "2" then //articulo = "48340" or articulo = "44229" then
	articulo = "2"
end if

i = indice - 1
j = dw_aplicaciones.rowcount()
do while i >0 
	articulo_escandallo = escandallo[i].articulo
	SELECT uso INTO :uso_base FROM articulos WHERE codigo = :articulo_escandallo;
	if uso_base = "1" then
		base = articulo_escandallo
		i = -1 //FIN EN BASE
	else
		sel =  "SELECT art_ver_operaciones.tipo_operacion, art_ver_op_aplicaciones.tipoaplicacion "+&
			"FROM art_ver_op_aplicaciones "+&
			"INNER JOIN art_ver_operaciones ON art_ver_op_aplicaciones.empresa = art_ver_operaciones.empresa AND art_ver_op_aplicaciones.articulo = art_ver_operaciones.articulo AND art_ver_op_aplicaciones.version = art_ver_operaciones.version AND art_ver_op_aplicaciones.operacion = art_ver_operaciones.operacion "+&
			"WHERE art_ver_op_aplicaciones.empresa = '"+codigo_empresa+"' AND art_ver_op_aplicaciones.articulo = '"+articulo_escandallo+"' "+&
			"ORDER BY art_ver_op_aplicaciones.orden DESC"
	
		f_cargar_cursor_nuevo (sel, aplicaciones)
		
		n = 1
		saltar_aplicaciones = false
		do while i >= 0 and n <= aplicaciones.RowCount()
			operacion =  aplicaciones.object.art_ver_operaciones_tipo_operacion[n]
			aplicacion = aplicaciones.object.art_ver_op_aplicaciones_tipoaplicacion[n]
			//operacion =  aplicaciones.getItemString(n, 1)
			//aplicacion = aplicaciones.getItemString(n, 2)
			
			if j > 0 then
				operacion_dw = dw_aplicaciones.object.modelo_aplicacion_operacion[j]
				aplicacion_dw = dw_aplicaciones.object.modelo_aplicacion_aplicacion[j]
				seleccionado =  dw_aplicaciones.object.seleccionado[j]//Omitir aplicaciones si seleccionado
				if operacion = operacion_dw or (operacion = "30" and operacion_dw = "39") or (operacion = "39" and operacion_dw = "30") or (operacion = "35" and operacion_dw = "40") or (operacion = "40" and operacion_dw = "35") then	//CMYK - NEW-CMYK y INK2C - NEW INK2C
					if seleccionado = 0 then //No seleccionado, las aplicaciones deben coincidir
						if aplicacion <> aplicacion_dw then
							resultado = false
							i = -1
						end if
					else 	//No seleccionado, saltamos las aplicaciones de la prueba y el artículo
						n = aplicaciones.RowCount() //Para salir del bucle de las aplicaciones del artículo
						saltar_aplicaciones = true
					end if
				else
					resultado = false
					i = -1
				end if
			else
				i = -1
			end if		
			j --
			n++
		loop
		do while saltar_aplicaciones and j >0
			//Buscar líneas de pruebas con la misma operación, ya que hay que saltarselas
			if operacion_dw = dw_aplicaciones.object.modelo_aplicacion_operacion[j] then
				j --
			else
				saltar_aplicaciones = false
			end if
		loop
		i = i - 1
	end if
loop

//Comparación Bases
/*
COD ESTADÍSTICO
G2 = B //TENCER
G2 = N //BASE Cliente
//base = escandallo[1].articulo
*/
SELECT G2 INTO :g2 
FROM art_codestadistico 
WHERE empresa = :codigo_empresa AND codigo = :base;

CHOOSE CASE ddlb_base.text
	CASE "Base Cliente"
		if g2 <> "N" then
			resultado = false
		end if
	CASE "Base Propia"
		if g2 <> "B" then
			resultado = false
		end if
	CASE "Indiferente" 
		//No se comprueba
END CHOOSE

destroy aplicaciones

return resultado
end function

public subroutine f_aplicar_reglas ();Long i
Int accion 
String operacion_anterior, operacion

operacion_anterior = ""
For i = 1 To dw_aplicaciones.rowcount()
	operacion = dw_aplicaciones.object.modelo_aplicacion_operacion[i]
	
	if operacion_anterior <> operacion then
		//Operaciones que no tienen en cuenta las aplicaciones por defecto (Se marcarán)
		if operacion = "3" or operacion = "2"  or operacion = "15"  or operacion = "24" or operacion = "12"  then //HORNO - 3FUE - 4FUE - 5FUE - PVID    ---- OJO ITEM CHANGED DE OPERACION 
			accion = 1
		else
			accion = 0
		end if
	end if
	
	dw_aplicaciones.object.seleccionado[i] = accion
	
	operacion_anterior = operacion
Next
end subroutine

public subroutine f_insertar_encajado ();Long ultima_fila

if dw_aplicaciones.rowcount() > 0 then
	pb_anyade_aplicacion.triggerevent(clicked!)
	
	ultima_fila = dw_aplicaciones.rowcount()
	
	//ENCAJADO EN CALIENTE OP 9 - APLI 19
	dw_aplicaciones.object.modelo_aplicacion_operacion[ultima_fila] = "9"
	dw_aplicaciones.EVENT itemchanged(ultima_fila, dw_aplicaciones.object.modelo_aplicacion_operacion, "9")
	dw_aplicaciones.object.modelo_aplicacion_aplicacion[dw_aplicaciones.rowcount()] = "19"
	dw_aplicaciones.EVENT itemchanged(ultima_fila, dw_aplicaciones.object.modelo_aplicacion_aplicacion, "19")
end if
end subroutine

on wtc_consulta_coste_aplicaciones_similares_pruebas.create
int iCurrent
call super::create
this.em_pieza=create em_pieza
this.em_prueba=create em_prueba
this.dw_aplicaciones=create dw_aplicaciones
this.cb_1=create cb_1
this.dw_articulos=create dw_articulos
this.pb_anyade_aplicacion=create pb_anyade_aplicacion
this.pb_borra_aplicacion=create pb_borra_aplicacion
this.pb_intercala_aplicacion=create pb_intercala_aplicacion
this.em_fecha=create em_fecha
this.barra=create barra
this.pb_imprimir=create pb_imprimir
this.st_1=create st_1
this.st_3=create st_3
this.uo_formato=create uo_formato
this.st_2=create st_2
this.st_4=create st_4
this.ddlb_base=create ddlb_base
this.uo_cliente=create uo_cliente
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_6=create gb_6
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_pieza
this.Control[iCurrent+2]=this.em_prueba
this.Control[iCurrent+3]=this.dw_aplicaciones
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_articulos
this.Control[iCurrent+6]=this.pb_anyade_aplicacion
this.Control[iCurrent+7]=this.pb_borra_aplicacion
this.Control[iCurrent+8]=this.pb_intercala_aplicacion
this.Control[iCurrent+9]=this.em_fecha
this.Control[iCurrent+10]=this.barra
this.Control[iCurrent+11]=this.pb_imprimir
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_3
this.Control[iCurrent+14]=this.uo_formato
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.ddlb_base
this.Control[iCurrent+18]=this.uo_cliente
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.gb_2
this.Control[iCurrent+21]=this.gb_3
this.Control[iCurrent+22]=this.gb_4
this.Control[iCurrent+23]=this.gb_5
this.Control[iCurrent+24]=this.gb_6
end on

on wtc_consulta_coste_aplicaciones_similares_pruebas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_pieza)
destroy(this.em_prueba)
destroy(this.dw_aplicaciones)
destroy(this.cb_1)
destroy(this.dw_articulos)
destroy(this.pb_anyade_aplicacion)
destroy(this.pb_borra_aplicacion)
destroy(this.pb_intercala_aplicacion)
destroy(this.em_fecha)
destroy(this.barra)
destroy(this.pb_imprimir)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.uo_formato)
destroy(this.st_2)
destroy(this.st_4)
destroy(this.ddlb_base)
destroy(this.uo_cliente)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_6)
end on

event open;call super::open;String texto_fecha = String(day(today()), "00") + "-"+ String(month(today()), "00") + "-"+ String(year(today()) -2 , "0000")

dw_aplicaciones.SetTransObject(SQLCA)
dw_articulos.SetTransObject(SQLCA)

formatos_ancho = 0
formatos_largo = 0

em_fecha.text = texto_fecha
ddlb_base.text = "Indiferente"
end event

type pb_salir from wt_padre_vacio`pb_salir within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 5563
integer y = 152
integer taborder = 0
end type

type st_titulo from wt_padre_vacio`st_titulo within wtc_consulta_coste_aplicaciones_similares_pruebas
integer width = 1851
end type

type p_logo from wt_padre_vacio`p_logo within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 5198
integer y = 28
end type

type em_pieza from editmask within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 82
integer y = 172
integer width = 283
integer height = 88
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "######"
end type

event modified;String pieza
Long total_encontrado = 0

dw_aplicaciones.reset()

pieza = this.text

SELECT COUNT(*) INTO :total_encontrado 
FROM modelo_pieza 
WHERE empresa = :codigo_empresa AND codigo_lab = :pieza;

if total_encontrado > 0 then 
	em_prueba.text = ""
	uo_formato.em_codigo.text = ""
	uo_formato.em_campo.text = "" 
	formatos_ancho = 0
	formatos_largo = 0
else
	//Error
	this.text = ""
	em_prueba.text = ""
	uo_formato.em_codigo.text = ""
	uo_formato.em_campo.text = "" 
	formatos_ancho = 0
	formatos_largo = 0
end if
end event

type em_prueba from editmask within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 448
integer y = 172
integer width = 197
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "######"
end type

event modified;String pieza, prueba, formato, codigo_formato
Long total_encontrado = 0
Dec ancho, largo

dw_aplicaciones.reset()

pieza = em_pieza.text
prueba = this.text

SELECT formatos.codigo, formatos.abreviado, formatos.largo, formatos.ancho INTO :codigo_formato, :formato, :largo, :ancho 
FROM modelo_prueba 
INNER JOIN modelo_pieza ON modelo_prueba.empresa = modelo_pieza.empresa AND modelo_prueba.modelo = modelo_pieza.modelo AND modelo_prueba.cliente = modelo_pieza.cliente AND modelo_prueba.propuesta = modelo_pieza.propuesta AND modelo_prueba.pieza = modelo_pieza.codigo  
LEFT OUTER JOIN articulos ON modelo_prueba.empresa = articulos.empresa AND modelo_prueba.base = articulos.codigo    
LEFT OUTER JOIN formatos ON articulos.empresa = formatos.empresa AND articulos.formato = formatos.codigo  
WHERE modelo_prueba.empresa = :codigo_empresa AND modelo_pieza.codigo_lab = :pieza AND modelo_prueba.codigo = :prueba;

if  SQLCA.SQLNRows > 0 then
	dw_aplicaciones.retrieve(codigo_empresa, pieza, prueba)
	uo_formato.em_codigo.text = codigo_formato
	uo_formato.em_campo.text = formato
	formatos_ancho = ancho
	formatos_largo = largo
	f_insertar_encajado()
	f_aplicar_reglas()
	
else
	//Error
	this.text = ''
	uo_formato.em_codigo.text = "" 
	uo_formato.em_campo.text = "" 
	formatos_ancho = 0
	formatos_largo = 0
end if
end event

type dw_aplicaciones from u_dw within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 32
integer y = 388
integer width = 1403
integer height = 3196
integer taborder = 50
boolean bringtotop = true
string dataobject = "dwtc_aux_aplicaciones_prueba"
end type

event itemchanged;call super::itemchanged;String resultado, operacion
Long i, accion

this.Accepttext()

CHOOSE CASE dwo.name
	CASE "modelo_aplicacion_operacion"
		select descripcion_abr
		into :resultado
		from art_ver_tipooperacion
		where empresa = :codigo_empresa
		and codigo = :data;
		
		if SQLCA.sqlcode <> 100 then
			this.object.art_ver_tipooperacion_descripcion_abr[Row] 		= resultado
			
			//Cheks de seleccionado
			operacion = data
			if operacion = "3" or operacion = "2"  or operacion = "15"  or operacion = "24" or operacion = "12" then
				accion = 1
			else
				accion = 0
			end if
			i = row
			do while i<= this.rowcount()
				if operacion = this.object.modelo_aplicacion_operacion[i] then
					this.object.seleccionado[i] = accion
				else
					i = this.rowcount()
				end if
				i++
			loop
			i = row - 1
			do while i>0
				if operacion = this.object.modelo_aplicacion_operacion[i] then
					this.object.seleccionado[i] = accion
				else
					i = 0
				end if
				i --
			loop
			
		else
			dwo.Primary[row] = ''
			this.object.art_ver_tipooperacion_descripcion_abr[Row] 		= ''
			return 2			
		end if
		
	CASE "modelo_aplicacion_aplicacion"
		select resumido
		into :resultado
		from prodaplicaciones
		where empresa = :codigo_empresa
		and codigo = :data;
		
		if SQLCA.sqlcode <> 100 then
			this.object.prodaplicaciones_resumido[Row] 	= resultado
		else
			dwo.Primary[row] = ''
			this.object.prodaplicaciones_resumido[Row] 	= ''
			return 2			
		end if
	
	CASE "seleccionado"
		operacion = this.object.modelo_aplicacion_operacion[row]
		i = row + 1
		do while i<= this.rowcount()
			if operacion = this.object.modelo_aplicacion_operacion[i] then
				this.object.seleccionado[i] = long(data)
			else
				i = this.rowcount()
			end if
			i++
		loop
		i = row - 1
		do while i>0
			if operacion = this.object.modelo_aplicacion_operacion[i] then
				this.object.seleccionado[i] = long(data)
			else
				i = 0
			end if
			i --
		loop		
END CHOOSE

this.Accepttext()
end event

event usr_dwnkey;call super::usr_dwnkey;string campo
str_wt_busquedas_salida resultado
str_wt_busquedas_entrada busqueda

control_teclas (keyflags, key)

busqueda.filtro_es_codigo = false
if key =  keyEnter! then
	campo = This.GetColumnName()
	CHOOSE CASE campo
		CASE "modelo_aplicacion_operacion"
			busqueda.titulo_ventana = "Búsqueda de Operaciones"
			busqueda.consulta  = " SELECT CODIGO, descripcion_abr "+&
										" FROM art_ver_tipooperacion "+&
										" where empresa = '"+codigo_empresa+"'"+&
										" ORDER BY descripcion_abr"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Operacion"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.modelo_aplicacion_operacion[this.GetRow()]				= resultado.valores[1]		
				this.object.art_ver_tipooperacion_descripcion_abr[this.GetRow()]	= resultado.valores[2]		
			end if
			
		CASE "modelo_aplicacion_aplicacion"
			busqueda.titulo_ventana = "Búsqueda de Tipos de Aplicaciones"
			busqueda.consulta  = " SELECT CODIGO, resumido "+&
										" FROM prodaplicaciones "+&
										" WHERE empresa = '"+codigo_empresa+"' ORDER BY resumido"
			busqueda.titulos[1] = "Código"
			busqueda.titulos[2] = "Tipo de Aplicación"
			
			OpenWithParm(wt_busquedas, busqueda)
			resultado = Message.PowerObjectParm
			if resultado.resultado > 0 then
				this.object.modelo_aplicacion_aplicacion[this.GetRow()] = resultado.valores[1]		
				this.object.prodaplicaciones_resumido[this.GetRow()]	 = resultado.valores[2]		
			end if
			
	END CHOOSE
end if	
end event

type cb_1 from commandbutton within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 3721
integer y = 152
integer width = 539
integer height = 124
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar Artículos "
end type

event clicked;String sel1
Datastore ds_articulos
Long i, fila_actual, operaciones
String articulo, descripcion, cliente, formato, operacion_anterior, cliente_filtro
Dec coste, coste_fab, coste_mp, precio
Boolean coste_merma = true

if isnull(uo_formato.em_codigo.text) or uo_formato.em_codigo.text = "" then
	MessageBox("Error", "Debe seleccionar una pieza y una prueba válida") //Válida incluye que tenga una base asociada con su correspondiente formato
	return
end if

cliente_filtro = ""
if not isnull(uo_cliente.em_codigo.text) and uo_cliente.em_codigo.text <> "" then
	cliente_filtro = " and A.cliente = '"+uo_cliente.em_codigo.text+"' "
end if


//Contamos numero de operaciones
operaciones = 0
operacion_anterior = ""
For i = 1 To dw_aplicaciones.rowcount()
	if dw_aplicaciones.object.modelo_aplicacion_operacion[i] <> operacion_anterior then
		operaciones ++
	end if
	operacion_anterior = dw_aplicaciones.object.modelo_aplicacion_operacion[i]
next

dw_articulos.reset()
sel1 =    "SELECT DISTINCT A.codigo, A.descripcion, G.razon, F.abreviado "+&
			"FROM prodpartes_ot P1 "+&
			"INNER JOIN articulos A ON  P1.empresa = A.empresa AND P1.articulo = A.codigo "+&
			"INNER JOIN formatos F ON P1.empresa = F.empresa AND P1.formato = F.codigo "+&
			"LEFT OUTER JOIN genter G ON A.empresa = G.empresa AND A.cliente = G.codigo AND G.tipoter = 'C'  "+&
			"where F.ancho >= "+String(round(formatos_ancho - 3,0))+" "+&
			"and F.ancho <=  "+String(round(formatos_ancho + 3,0))+" "+&
			"and F.largo >= "+String(round(formatos_largo - 3,0))+" "+&
			"and F.largo <= "+String(round(formatos_largo + 3, 0))+" "+&
			"and A.uso = '3' "+&  
			"and A.promocion = 'N' "+cliente_filtro+& 
			"and P1.fecha >= '"+em_fecha.text+"' "+&
			"and P1.ot_terminada = 'S' "+&
			"and P1.empresa = '"+codigo_empresa+"' "+&
			"and  "+String(operaciones)+" = ( SELECT count (*) "+&
			"            from ( SELECT DISTINCT P2.articulo, art_ver_operaciones.operacion "+&
			"                    from prodpartes_ot P2 "+&
			"                    inner join art_ver_operaciones on P2.empresa = art_ver_operaciones.empresa "+&
			"                                                and P2.articulo = art_ver_operaciones.articulo "+&
			"                                                and P2.version = art_ver_operaciones.version "+&
			"                    where P2.anyo = P1.anyo "+&
			"                    and P2.pedido = P1.pedido "+&
			"                    and P2.linped = P1.linped "+&
			"                    and P2.art_encajado = P1.articulo ) filas )   "
			
			/*
			//POR APLICACIONES - No válido
			"and  "+String(dw_aplicaciones.rowcount())+" = ( SELECT count (*) "+&
			"            from ( SELECT DISTINCT P2.articulo, art_ver_op_aplicaciones.contadoraplicacion "+&
			"                    from prodpartes_ot P2 "+&
			"                    inner join art_ver_op_aplicaciones on P2.empresa = art_ver_op_aplicaciones.empresa "+&
			"                                                and P2.articulo = art_ver_op_aplicaciones.articulo "+&
			"                                                and P2.version = art_ver_op_aplicaciones.version "+&
			"                    where P2.anyo = P1.anyo "+&
			"                    and P2.pedido = P1.pedido "+&
			"                    and P2.linped = P1.linped "+&
			"                    and P2.art_encajado = P1.articulo ) filas )   "
*/

f_cargar_cursor_nuevo (sel1, ds_articulos)
barra.position = 0
barra.Minposition = 0
barra.Maxposition = ds_articulos.rowcount() 

for i= 1 to ds_articulos.rowcount() 
	
	articulo = ds_articulos.object.articulos_codigo[i]
	descripcion = ds_articulos.object.articulos_descripcion[i]
	cliente = ds_articulos.object.genter_razon[i]
	formato = ds_articulos.object.formatos_abreviado[i]
	
	//VALIDAMOS QUE LAS OPERACIONES Y APLICACIONES SEAN LAS MISMAS
	if f_mismas_aplicaciones(articulo) then
		coste_fab = 0
		coste_mp = 0
		
		f_calculo_coste_articulo_mp_fab (codigo_empresa, articulo, coste_mp, coste_fab, coste_merma)
		coste = coste_fab + coste_mp
		
		if coste > 0 then
			
			select min(precio)
			into :precio
			from venlintarifas
			where empresa = :codigo_empresa
			and articulo = :articulo
			and tarifa <> 5;
			
			fila_actual = dw_articulos.insertrow(0)
			dw_articulos.object.codigo[fila_actual] = articulo
			dw_articulos.object.descripcion[fila_actual] = descripcion
			dw_articulos.object.formato[fila_actual] = formato
			dw_articulos.object.cliente[fila_actual] = cliente
			dw_articulos.object.coste_fab[fila_actual] = coste_fab
			dw_articulos.object.coste_mp[fila_actual] = coste_mp
			dw_articulos.object.coste[fila_actual] = coste
			dw_articulos.object.precio[fila_actual] = precio
		end if
	end if
	
	barra.StepIt ()
next

ds_articulos.GroupCalc()

if ds_articulos.RowCount() = 0 then
	messagebox("Atención","No hay datos")
else
	dw_articulos.setsort("coste D")
	dw_articulos.sort()
end if

destroy ds_articulos
end event

type dw_articulos from u_dw within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1445
integer y = 388
integer width = 4279
integer height = 3196
integer taborder = 60
boolean bringtotop = true
string dataobject = "dwtc_aux_articulos_coste_similar"
end type

event doubleclicked;call super::doubleclicked;str_parametros lstr_param
long esta_abierta

if row > 0 then
	lstr_param.i_nargumentos=2
	lstr_param.s_argumentos[1]="wtc_consulta_coste_aplicaciones_similares_pruebas"
	lstr_param.s_argumentos[2]=String(this.object.codigo[row])
	lstr_param.nombre_ventana = "wtc_consulta_coste_aplicaciones_similares_pruebas"
	lstr_param.resultado = ''
	
	esta_abierta = f_menu_ventana_esta_abierta("w_mant_altas_intermedios_nuevo")
	if esta_abierta <> -1 then
		close(w_mant_altas_intermedios_nuevo)
		OpenWithParm(w_mant_altas_intermedios_nuevo,lstr_param)
	else
		OpenWithParm(w_mant_altas_intermedios_nuevo,lstr_param)
	end if
end if
end event

event clicked;call super::clicked;if row = 0 then
	if dwo.name = "t_articulo" then
		dw_articulos.setsort("descripcion A")
	elseif dwo.name = "t_formato" then
		dw_articulos.setsort("formato A")
	elseif dwo.name = "t_cliente" then
		dw_articulos.setsort("cliente A")
	elseif dwo.name = "t_precio" then
		dw_articulos.setsort("precio D")
	elseif dwo.name = "t_coste" then
		dw_articulos.setsort("coste D")
	elseif dwo.name = "t_rentabilidad" then	
		dw_articulos.setsort("rentabilidad D")
	elseif dwo.name = "t_coste_mp" then
		dw_articulos.setsort("coste_mp D")
	elseif dwo.name = "t_coste_fab" then
		dw_articulos.setsort("coste_fab D")
	end if	
	dw_articulos.sort()
end if
end event

type pb_anyade_aplicacion from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 837
integer y = 3408
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_plus.png"
alignment htextalign = left!
string powertiptext = "Añadir Registro"
end type

event clicked;long fila_actual, fila, nuevo_codigo, orden, indice, maximo_valor_dw, maximo_valor_dw2
string modelo, cliente, propuesta, pieza, prueba


nuevo_codigo = 0

maximo_valor_dw2 = long(dw_aplicaciones.Describe("Evaluate('Max(modelo_aplicacion_orden)', 0)"))
if isnull(maximo_valor_dw2) then maximo_valor_dw2 = 0
orden = maximo_valor_dw2 +1

fila_actual = dw_aplicaciones.InsertRow(0)

if fila_actual > 0 then
	dw_aplicaciones.object.modelo_aplicacion_orden[fila_actual] = orden
	dw_aplicaciones.object.seleccionado[fila_actual] = 0
	
end if
end event

type pb_borra_aplicacion from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 987
integer y = 3408
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\navigate_minus.png"
alignment htextalign = left!
string powertiptext = "EliminarRegistro"
end type

event clicked;boolean error_borrando
long fila_actual, fila_maxima, i, total_aplicaciones

	
error_borrando = false
fila_actual = dw_aplicaciones.getrow()
fila_maxima = dw_aplicaciones.rowcount()
if isnull(fila_actual) or fila_actual = 0 then
	MessageBox("Error","Debe seleccionar una fila para borrar")
	return
end if

if dw_aplicaciones.DeleteRow(fila_actual) <> 1 then
	error_borrando = True
else
	error_borrando = False
end if

if error_borrando then
	MessageBox("Error","No ha sido posible borrar la propuesta")
else
	For i = 1 To dw_aplicaciones.rowcount()
		dw_aplicaciones.object.modelo_aplicacion_orden[i] = i
	next
end if
end event

type pb_intercala_aplicacion from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1138
integer y = 3408
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Tencer_PB12\insertar.png"
alignment htextalign = left!
string powertiptext = "Intercalar Registro"
end type

event clicked;long fila_actual, fila_destino, i, fila, nuevo_codigo, orden, indice, maximo_valor_dw, maximo_valor_dw2
string modelo, cliente, propuesta, pieza, prueba

if dw_aplicaciones.rowcount() = 0 then
	pb_anyade_aplicacion.Event clicked()
	return
end if

fila_destino = dw_aplicaciones.getrow()
if fila_destino <= 0 then
	MessageBox("Error","Debe seleccionar una posición donde intercalar la nueva aplicación.")
	return
end if

nuevo_codigo = 0

fila_actual = dw_aplicaciones.InsertRow(0)
i = fila_actual
Do While i > fila_destino 
	
	dw_aplicaciones.object.modelo_aplicacion_orden[i] = dw_aplicaciones.object.modelo_aplicacion_orden[i - 1] + 1
	
	dw_aplicaciones.object.modelo_aplicacion_operacion[i] = dw_aplicaciones.object.modelo_aplicacion_operacion[i - 1]
	dw_aplicaciones.object.art_ver_tipooperacion_descripcion_abr[i] = dw_aplicaciones.object.art_ver_tipooperacion_descripcion_abr[i - 1]
	dw_aplicaciones.object.modelo_aplicacion_aplicacion[i] = dw_aplicaciones.object.modelo_aplicacion_aplicacion[i - 1]
	dw_aplicaciones.object.prodaplicaciones_resumido[i] = dw_aplicaciones.object.prodaplicaciones_resumido[i - 1]
	dw_aplicaciones.object.seleccionado[i] = dw_aplicaciones.object.seleccionado[i - 1]

	i --
loop

dw_aplicaciones.object.modelo_aplicacion_orden[fila_destino] = dw_aplicaciones.object.modelo_aplicacion_orden[fila_destino + 1] - 1

dw_aplicaciones.object.modelo_aplicacion_operacion[fila_destino] = ""
dw_aplicaciones.object.art_ver_tipooperacion_descripcion_abr[fila_destino] = ""
dw_aplicaciones.object.modelo_aplicacion_aplicacion[fila_destino] = ""
dw_aplicaciones.object.prodaplicaciones_resumido[fila_destino] = ""
dw_aplicaciones.object.seleccionado[fila_destino] = 0


end event

type em_fecha from editmask within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1371
integer y = 176
integer width = 425
integer height = 88
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yyyy"
boolean dropdowncalendar = true
end type

type barra from hprogressbar within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 37
integer y = 308
integer width = 5687
integer height = 68
boolean bringtotop = true
unsignedinteger maxposition = 100
integer setstep = 1
end type

type pb_imprimir from picturebutton within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 5312
integer y = 148
integer width = 146
integer height = 128
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "C:\Tencer_PB12\printer-icon2_24x24.png"
end type

event clicked;if dw_articulos.rowcount() > 0 then
		f_imprimir_datawindow(dw_articulos)
end if
end event

type st_1 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1893
integer y = 56
integer width = 1966
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
string text = "* Se buscan artículos con +/-2 cm de margen respecto al formato indicado"
boolean focusrectangle = false
end type

type st_3 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 3863
integer y = 56
integer width = 1298
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
string text = "* Haga doble clic para abrir ficha del artículo"
boolean focusrectangle = false
end type

type uo_formato from u_em_campo_2 within wtc_consulta_coste_aplicaciones_similares_pruebas
event destroy ( )
integer x = 741
integer y = 172
integer width = 539
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;String codigo, descripcion

codigo = this.em_codigo.text
descripcion = f_nombre_formato_abr(codigo_empresa, codigo)
this.em_campo.text=descripcion
If Trim(descripcion)="" then
	this.em_campo.text=""
	this.em_codigo.text=""
	Return
else
	SELECT ancho, largo INTO :formatos_ancho, :formatos_largo
	FROM formatos 
	WHERE empresa = :codigo_empresa AND codigo = :codigo;
end if 


end event

event getfocus;call super::getfocus;ue_titulo = "Selección de Formato"
ue_datawindow ="dw_ayuda_formatos"
ue_filtro = ""
end event

type st_2 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 2839
integer width = 2203
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
string text = "* Las operaciones CMYK/NEW-CMYK y INK2C/NEW-INK2C se consideran equivalentes"
boolean focusrectangle = false
end type

type st_4 from statictext within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1893
integer width = 974
integer height = 64
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
string text = "* No se comparan composiciones"
boolean focusrectangle = false
end type

type ddlb_base from dropdownlistbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1865
integer y = 172
integer width = 498
integer height = 436
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string item[] = {"Base Cliente","Base Propia","Indiferente"}
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within wtc_consulta_coste_aplicaciones_similares_pruebas
event destroy ( )
integer x = 2437
integer y = 180
integer width = 1198
integer height = 92
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)

IF Trim(uo_cliente.em_campo.text)="" THEN 
 	IF Trim(uo_cliente.em_codigo.text)<>"" Then 
		uo_cliente.em_campo.SetFocus()
	END IF
 	uo_cliente.em_campo.text=""
 	uo_cliente.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Clientes"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = ""

end event

type gb_1 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1326
integer y = 112
integer width = 507
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 67108864
string text = "Fecha Partes"
end type

type gb_2 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 37
integer y = 112
integer width = 366
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 67108864
string text = "Pieza"
end type

type gb_3 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 407
integer y = 112
integer width = 283
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 67108864
string text = "Prueba"
end type

type gb_4 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 695
integer y = 112
integer width = 626
integer height = 180
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 67108864
string text = "Formato"
end type

type gb_5 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 1838
integer y = 112
integer width = 553
integer height = 180
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 67108864
string text = "Tipo de Base"
end type

type gb_6 from groupbox within wtc_consulta_coste_aplicaciones_similares_pruebas
integer x = 2395
integer y = 112
integer width = 1266
integer height = 180
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 67108864
string text = "Cliente"
end type

