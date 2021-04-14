$PBExportHeader$w_ventana_ubicacion.srw
forward
global type w_ventana_ubicacion from window
end type
type st_envase from statictext within w_ventana_ubicacion
end type
type em_envase from u_em_campo within w_ventana_ubicacion
end type
type st_7 from statictext within w_ventana_ubicacion
end type
type st_cantidad from statictext within w_ventana_ubicacion
end type
type st_materia from statictext within w_ventana_ubicacion
end type
type st_6 from statictext within w_ventana_ubicacion
end type
type cb_insertar from commandbutton within w_ventana_ubicacion
end type
type cb_borrar from commandbutton within w_ventana_ubicacion
end type
type cb_salir from commandbutton within w_ventana_ubicacion
end type
type cb_procesar from commandbutton within w_ventana_ubicacion
end type
type st_1 from statictext within w_ventana_ubicacion
end type
type st_2 from statictext within w_ventana_ubicacion
end type
type st_3 from statictext within w_ventana_ubicacion
end type
type st_4 from statictext within w_ventana_ubicacion
end type
type st_5 from statictext within w_ventana_ubicacion
end type
type st_unidad from statictext within w_ventana_ubicacion
end type
type em_almacen from u_em_campo within w_ventana_ubicacion
end type
type em_zona from u_em_campo within w_ventana_ubicacion
end type
type em_fila from u_em_campo within w_ventana_ubicacion
end type
type em_altura from u_em_campo within w_ventana_ubicacion
end type
type em_cantidad from u_em_campo within w_ventana_ubicacion
end type
type em_lote from u_em_campo within w_ventana_ubicacion
end type
type st_almacen from statictext within w_ventana_ubicacion
end type
type dw_1 from u_datawindow within w_ventana_ubicacion
end type
type ole_cont_pro from u_barra_contador within w_ventana_ubicacion
end type
type sle_opcion_orden from singlelineedit within w_ventana_ubicacion
end type
type st_empresa from statictext within w_ventana_ubicacion
end type
type gb_1 from groupbox within w_ventana_ubicacion
end type
type gb_2 from groupbox within w_ventana_ubicacion
end type
type gb_3 from groupbox within w_ventana_ubicacion
end type
type gb_4 from groupbox within w_ventana_ubicacion
end type
end forward

global type w_ventana_ubicacion from window
integer x = 521
integer y = 600
integer width = 2286
integer height = 1016
boolean titlebar = true
string title = "Ubicación de la linea en el Almacén"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 12632256
boolean center = true
event ue_recuperar pbm_custom01
event ue_listar pbm_custom02
event ue_f1 pbm_custom03
event ue_f2 pbm_custom04
event ue_f3 pbm_custom05
event ue_f4 pbm_custom06
event ue_f5 pbm_custom07
event ue_f6 pbm_custom08
event ue_esc pbm_custom09
event ue_f7 pbm_custom10
event ue_pagina_arriba pbm_custom11
event ue_pagina_abajo pbm_custom12
event ue_cursor_arriba pbm_custom13
event ue_cursor_abajo pbm_custom14
st_envase st_envase
em_envase em_envase
st_7 st_7
st_cantidad st_cantidad
st_materia st_materia
st_6 st_6
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_salir cb_salir
cb_procesar cb_procesar
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_unidad st_unidad
em_almacen em_almacen
em_zona em_zona
em_fila em_fila
em_altura em_altura
em_cantidad em_cantidad
em_lote em_lote
st_almacen st_almacen
dw_1 dw_1
ole_cont_pro ole_cont_pro
sle_opcion_orden sle_opcion_orden
st_empresa st_empresa
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_ventana_ubicacion w_ventana_ubicacion

type variables
str_parametros istr_parametros

// Datos que vienen por parámetros
String          is_mprima
String          is_anyo
Decimal      id_cantidad,cantidad_restante
DateTime   if_fecha
String          is_albaran,is_provee,is_linea,is_unidad

// Estructura de la tablas a procesar
str_almlinubicahis  ubihis
str_almlinubica      ubi
str_almmovhis       mov
end variables

forward prototypes
public subroutine f_inicializa_linea ()
public function boolean f_datos_comunes ()
end prototypes

public subroutine f_inicializa_linea ();//em_almacen.text  = ""
st_almacen.text  = ""
em_zona.text     = ""
em_fila.text     = ""
em_altura.text   = ""
em_cantidad.text = Trim(String(cantidad_restante))
em_lote.text     = ""
f_activar_campo(em_zona)

end subroutine

public function boolean f_datos_comunes ();/* ----------------------------------------------------------- */
/* Datos invariables para el histórico de ubicaciones          */
/* ----------------------------------------------------------- */
ubihis.usuario    = nombre_usuario
ubihis.empresa    = codigo_empresa
ubihis.anyo       = Year(Date(if_fecha))
ubihis.articulo   = is_mprima
ubihis.referencia = is_mprima
ubihis.fecha      = if_fecha
ubihis.f_alta     = DateTime(Today(),Now())
ubihis.tipo_unidad= is_unidad
ubihis.observaciones = ""

// Datos de la materia
SELECT venmprima.familia //, venmprima.tipo_materia
	INTO :ubihis.familia //,:ubihis.tipo_materia
	FROM venmprima  
	WHERE (venmprima.empresa= :ubihis.empresa ) AND  
			(venmprima.codigo = :ubihis.articulo )   
	USING SQLCA ;
	
IF SQLCA.SQLCode<>0 THEN 
	f_mensaje("Error","No se encontró el artículo en la tabla VENMPRIMA.")
	Return FALSE
END IF

/* ----------------------------------------------------------- */
/* Datos invariables para la tabla de ubicaciones     			*/
/* ----------------------------------------------------------- */
ubi.empresa    =  ubihis.empresa
ubi.articulo   =  ubihis.articulo
ubi.familia    =  ubihis.familia
SetNull(ubi.anyo)
SetNull(ubi.pedido) 
SetNull(ubi.linped)
SetNull(ubi.cliente)
ubi.tipo_unidad  = ubihis.tipo_unidad
//ubi.tipo_materia = ubihis.tipo_materia
ubi.referencia   = ubihis.referencia
ubi.f_alta       = ubihis.f_alta

Return TRUE
end function

event open;
istr_parametros.s_titulo_ventana="Pedir Ubicación"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)

istr_parametros = message.powerobjectparm

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	is_anyo         = istr_parametros.s_argumentos[3]
	is_albaran      = istr_parametros.s_argumentos[4]
	is_linea        = istr_parametros.s_argumentos[5]
	is_mprima       = istr_parametros.s_argumentos[6]
	is_provee       = istr_parametros.s_argumentos[7]
	if_fecha        = DateTime(Date(istr_parametros.s_argumentos[8]))
	id_cantidad     = Dec(Trim(istr_parametros.s_argumentos[9]))
	is_unidad       = istr_parametros.s_argumentos[10]
	
	st_materia.text = f_nombre_mprima(codigo_empresa,is_mprima)
	st_cantidad.text= String(id_cantidad)
	dw_1.SetItem(1,"cantidad",id_cantidad)
	em_envase.text = f_envase_mprima(codigo_empresa,is_mprima)
	st_envase.text = f_nombre_envase_abr(Trim(em_envase.text))
	cantidad_restante = id_cantidad
	f_activar_campo(em_almacen)
END IF
end event

on w_ventana_ubicacion.create
this.st_envase=create st_envase
this.em_envase=create em_envase
this.st_7=create st_7
this.st_cantidad=create st_cantidad
this.st_materia=create st_materia
this.st_6=create st_6
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.cb_salir=create cb_salir
this.cb_procesar=create cb_procesar
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_unidad=create st_unidad
this.em_almacen=create em_almacen
this.em_zona=create em_zona
this.em_fila=create em_fila
this.em_altura=create em_altura
this.em_cantidad=create em_cantidad
this.em_lote=create em_lote
this.st_almacen=create st_almacen
this.dw_1=create dw_1
this.ole_cont_pro=create ole_cont_pro
this.sle_opcion_orden=create sle_opcion_orden
this.st_empresa=create st_empresa
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
this.Control[]={this.st_envase,&
this.em_envase,&
this.st_7,&
this.st_cantidad,&
this.st_materia,&
this.st_6,&
this.cb_insertar,&
this.cb_borrar,&
this.cb_salir,&
this.cb_procesar,&
this.st_1,&
this.st_2,&
this.st_3,&
this.st_4,&
this.st_5,&
this.st_unidad,&
this.em_almacen,&
this.em_zona,&
this.em_fila,&
this.em_altura,&
this.em_cantidad,&
this.em_lote,&
this.st_almacen,&
this.dw_1,&
this.ole_cont_pro,&
this.sle_opcion_orden,&
this.st_empresa,&
this.gb_1,&
this.gb_2,&
this.gb_3,&
this.gb_4}
end on

on w_ventana_ubicacion.destroy
destroy(this.st_envase)
destroy(this.em_envase)
destroy(this.st_7)
destroy(this.st_cantidad)
destroy(this.st_materia)
destroy(this.st_6)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.cb_salir)
destroy(this.cb_procesar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_unidad)
destroy(this.em_almacen)
destroy(this.em_zona)
destroy(this.em_fila)
destroy(this.em_altura)
destroy(this.em_cantidad)
destroy(this.em_lote)
destroy(this.st_almacen)
destroy(this.dw_1)
destroy(this.ole_cont_pro)
destroy(this.sle_opcion_orden)
destroy(this.st_empresa)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

type st_envase from statictext within w_ventana_ubicacion
integer x = 1696
integer y = 824
integer width = 238
integer height = 64
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_envase from u_em_campo within w_ventana_ubicacion
integer x = 1595
integer y = 824
integer width = 101
integer height = 68
integer taborder = 70
integer textsize = -7
long backcolor = 16777215
alignment alignment = right!
end type

type st_7 from statictext within w_ventana_ubicacion
integer x = 1600
integer y = 760
integer width = 334
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Envase"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_cantidad from statictext within w_ventana_ubicacion
integer x = 1554
integer y = 148
integer width = 416
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
alignment alignment = center!
boolean border = true
long bordercolor = 8421376
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_materia from statictext within w_ventana_ubicacion
integer x = 512
integer y = 148
integer width = 1006
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean border = true
long bordercolor = 8421376
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_ventana_ubicacion
integer x = 37
integer y = 148
integer width = 471
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8421376
boolean enabled = false
string text = "Línea a Ubicar:"
boolean border = true
long bordercolor = 8421376
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_insertar from commandbutton within w_ventana_ubicacion
integer x = 1975
integer y = 780
integer width = 238
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\BMP\Mano.cur"
string text = "Insertar"
end type

event clicked;Boolean lb_error
Dec{2}  total_cantidad
String  mensaje, nombre, campo
Long    contador

lb_error = FALSE
contador  = dw_1.Rowcount()
dw_1.Accepttext()

/********************************************************************/
/*              COMPROBACIÓN DE QUE LOS DATOS SON CORRECTOS         */
/********************************************************************/

IF contador<>0 THEN
	
	// Control del almacén
	IF (Trim(em_almacen.text)="" or IsNull(em_almacen.text)) AND NOT lb_error THEN
		lb_error   = TRUE
		campo   = "almacen"
		mensaje = "Introduzca el almacén " 
	END IF
	
	// Control de la zona
	IF (Trim(em_zona.text)="" or IsNull(em_zona.text)) AND NOT lb_error THEN
		lb_error  = TRUE
		campo  = "zona"
		mensaje= "Introduzca la zona "
	END IF
	
	// Control de la fila
	IF (Trim(String(em_fila.text))=""  or IsNull(em_fila.text)) AND NOT lb_error THEN
		lb_error   = TRUE
		campo   = "fila"
		mensaje = "Introduzca la fila de la ubicación"
	END IF
	
	// Control de la altura
	IF (Trim(String(em_altura.text))=""  or IsNull(em_altura.text)) AND NOT lb_error THEN
		lb_error   = TRUE
		campo   = "altura"
		mensaje = "Introduzca la altura de la ubicación"
	END IF
	
	// Control de la ubicación completa
	IF (Not(f_ubi_exist(codigo_empresa,Trim(em_almacen.text),Trim(em_zona.text),Integer(Trim(em_fila.text)),Integer(Trim(em_altura.text))))) AND NOT lb_error THEN
		lb_error   = TRUE
		campo   = "almacen"
		mensaje = "La ubicación no está contemplada en el mapa de ubicaciones"
	END IF

	// Control del nº de lote
	IF (Trim(em_lote.text)="" or IsNull(em_lote.text)) AND NOT lb_error THEN
		lb_error   = TRUE
		campo   = "lote"
		mensaje = " Introduzca el nº de lote "
	END IF
	
// Control del envase
	IF (Trim(em_envase.text)="" or IsNull(em_envase.text)) AND NOT lb_error THEN
		lb_error   = TRUE
		campo   = "envase"
		mensaje = " Introduzca el envase "
	END IF

	// Control de la cantidad
	IF (Trim(String(em_cantidad.text))=""  or IsNull(em_cantidad.text) or Dec(Trim(em_cantidad.text))=0) and NOT lb_error THEN
		lb_error   = TRUE
		campo   = "cantidad"
		mensaje = "Introduzca la cantidad"
	END IF
	
	total_cantidad  = dw_1.GetItemNumber(1,"total_cantidad")
	total_cantidad  = total_cantidad + Dec(Trim(em_cantidad.text))
	IF id_cantidad < total_cantidad THEN
		lb_error   = TRUE
		campo   = "cantidad"
		mensaje = "Con la cantidad introducida, la cantidad total superará la del albarán."
	END IF

	// Mensaje de lb_error
	IF lb_error THEN
		MessageBox("Campo obligatorio",mensaje,Exclamation!, OK!,1)
		dw_1.SetColumn(campo)
		dw_1.SetRow(contador)
		dw_1.SetFocus()
		Return
	END IF

END IF

/********************************************************************/
/*              			INSERCIÓN DE LA LÍNEA							  */
/********************************************************************/

contador = contador + 1
dw_1.InsertRow(contador)
dw_1.SetItem(contador,"empresa",codigo_empresa)
dw_1.SetItem(contador,"almacen",Trim(em_almacen.text))
dw_1.SetItem(contador,"desc_almacen",st_almacen.text)
dw_1.SetItem(contador,"zona",Trim(em_zona.text))
dw_1.SetItem(contador,"fila",Integer(Trim(em_fila.text)))
dw_1.SetItem(contador,"altura",Integer(Trim(em_altura.text)))
dw_1.SetItem(contador,"cantidad",Dec(Trim(em_cantidad.text)))
dw_1.SetItem(contador,"lote",Trim(em_lote.text))
dw_1.SetItem(contador,"envase",Trim(em_envase.text))
dw_1.SetItem(contador,"desc_unidad",st_unidad.text)
dw_1.SetItem(contador,"desc_envase",st_envase.text)

cantidad_restante = cantidad_restante - Dec(Trim(em_cantidad.text))

f_inicializa_linea()

end event

type cb_borrar from commandbutton within w_ventana_ubicacion
integer x = 1888
integer y = 264
integer width = 311
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\BMP\Mano.cur"
string text = "Borrar"
end type

event clicked;Integer li_fila, li_resp

li_fila = dw_1.GetRow()

IF li_fila<>0 THEN
 	dw_1.SetRow(li_fila)
 	dw_1.SetFocus()
	li_resp = MessageBox("Borrado","¿Desea Borrar la Línea seleccionada?", Question!, YesNo!, 2)
	IF li_resp = 1 THEN 
   	cantidad_restante = cantidad_restante + dw_1.GetItemNumber(li_fila,"cantidad")
	 	dw_1.DeleteRow(dw_1.GetRow())
//	ELSE
//		f_inicializa_linea()
	END IF
	f_inicializa_linea()
END IF
end event

type cb_salir from commandbutton within w_ventana_ubicacion
integer x = 1893
integer y = 412
integer width = 311
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\BMP\Mano.cur"
string text = "Salir"
end type

event clicked;closewithreturn(parent,"N")
end event

type cb_procesar from commandbutton within w_ventana_ubicacion
integer x = 1893
integer y = 564
integer width = 311
integer height = 88
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string pointer = "\BMP\Mano.cur"
string text = "Procesar"
end type

event clicked;//// DECLARACIÓN DE VARIABLES
//Decimal{4}  total_cantidad, ld_cantidad
//Long			contador
//String		seleccion, tabla, criterio[3], titulo
//Integer		li_fila, li_altura, bien = 0, longitudes, anyo, i
//Integer     mov_entrada, mov_salida
//
//// Controlamos que se ha introducido la ubicacion de toda la cantidad
//// de no ser así se va a ejecutar lo que hay al final del script
//// este IF engloba todos los procesos de almacen. Es muy grande
//IF cantidad_restante = 0 THEN
//	// El proceso sólo se realizará si se han introducido líneas
//	contador = dw_1.RowCount()
//	IF contador=0 THEN
//		MessageBox("Proceso Cancelado","No hay lineas a procesar.",Exclamation!, OK!,1)
//		CloseWithReturn(Parent,"N")
//	END IF
//	
//	// Recogemos una serie de datos invariables durante todo el proceso
//	dw_1.Accepttext()
//	IF NOT f_datos_comunes() THEN
//		CloseWithReturn(Parent,"N")
//	END IF
//	
//	/********************************************************************/
//	/*	PROCESO 1: ENTRADA A REALIZAR POR CADA LÍNEA DE UBICACIÓN        */
//	/********************************************************************/
//	
//	FOR i=1 TO contador
//		
//		// ........ PARA EL HISTÓRICO DE UBICACIONES
//		ubihis.almacen = dw_1.GetItemString(i,"almacen")	
//		ubihis.zona    = dw_1.GetItemString(i,"zona")	
//		ubihis.fila    = dw_1.GetItemNumber(i,"fila")	
//		ubihis.altura  = dw_1.GetItemNumber(i,"altura")	
//		ubihis.lote    = dw_1.GetItemString(i,"lote")	
//		ubihis.envase  = dw_1.GetItemString(i,"envase")	
//		ubihis.cantidade = dw_1.GetItemDecimal(i,"cantidad")	
//		ubihis.cantidads = 0
//		ubihis.ubicacion = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
//								 ubihis.fila,ubihis.altura)
//		ubihis.tipomov   = '107'
//		
//		// Cálculo del número de orden
//		titulo        =  Parent.title
//		longitudes    =  Len(Trim(codigo_empresa))
//		criterio[1]   =  Trim(codigo_empresa)+ Space(20-longitudes)
//		anyo          =  Year(Date(if_fecha))
//		longitudes    =  Len(Trim(String(anyo)))
//		criterio[2]   =  Trim(String(anyo)) + Space(20-longitudes)
//		longitudes    =  Len(Trim(ubihis.almacen))
//		criterio[3]   =  Trim(ubihis.almacen) + Space(20-longitudes)
//		seleccion     =  criterio[1]+criterio[2]+criterio[3]
//		tabla         =  "almparam"
//
//		IF f_bloquear(tabla,seleccion,titulo) THEN
//			CloseWithReturn(Parent,"N")
//		END IF
//		
//		ubihis.orden  = f_almparam_numorden(codigo_empresa,ubihis.almacen,Year(Date(if_fecha)))
//		IF i = 1 THEN
//			mov_entrada = f_almparam_nummov(codigo_empresa,ubihis.almacen,Year(Date(if_fecha)))
//			ubihis.nummov = mov_entrada
//			mov.almacen   = ubihis.almacen
//			IF NOT f_actualiza_nummov(ubihis.empresa,ubihis.almacen,Year(Date(if_fecha)),mov_entrada) THEN
//				bien = 1
//			END IF
//		END IF
//		IF NOT f_insert_almlinubicahis(ubihis) THEN  
//			bien = 1
//		END IF
//		
//		IF NOT f_actualiza_numorden(ubihis.empresa,ubihis.almacen,Year(Date(if_fecha)),ubihis.nummov) THEN
//			bien = 1
//		END IF
//		
//		// ............... PARA EL DE UBICACIONES
//		ubi.almacen    = ubihis.almacen
//		ubi.zona       = ubihis.zona
//		ubi.fila       = ubihis.fila
//		ubi.altura     = ubihis.altura
//		ubi.lote       = ubihis.lote
//		ubi.envase     = ubihis.envase
//		ubi.existencias= ubihis.cantidade
//		ubi.ubicacion  = ubihis.ubicacion
//			
//		// Si ya hay existencias del artículo procesado en las ubicaciones
//		// seleccionadas, se actualiza la tabla. En caso contrario, se inserta
//			
//		ubi.linea = f_ult_linea_ubi_art(ubi.empresa,ubi.ubicacion,ubi.articulo,ubi.lote)		
//		
//		IF (ubi.linea>0) THEN
//			// Actualización
//			UPDATE almlinubica  
//				SET existencias = (existencias + :ubi.existencias)
//				WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//						( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//						( almlinubica.linea     = :ubi.linea) 
//				USING SQLCA;
//			IF SQLCA.SQLCode<>0 THEN  
//				bien = 1
//			END IF
//			
//		ELSE
//			// Inserción
//			ubi.linea = (f_ult_linea_ubi(ubi.empresa,ubi.ubicacion)) + 1
//			IF NOT f_insert_almlinubica(ubi) THEN
//				bien = 1
//			END IF
//		END IF
//		
//		// Control de errores
//		IF bien = 1 THEN
//			CloseWithReturn(Parent,"N")
//		END IF
//		f_desbloquear(tabla,seleccion,titulo)
//		
//	NEXT
//	
//	/********************************************************************/
//	/*	PROCESO 3: SALIDA DE LAS TABLAS DE UBICACIONES						  */
//	/********************************************************************/
//	ubihis.almacen = "2"
//	ubihis.zona    = "1"
//	ubihis.fila    = 1
//	ubihis.altura  = 1
//	ubihis.lote    = ""
//	ubihis.cantidade = 0
//	ubihis.cantidads = dw_1.GetItemDecimal(1,"total_cantidad")	
//	ubihis.ubicacion = f_componer_ubicacion(ubihis.almacen,ubihis.zona,&
//							 ubihis.fila,ubihis.altura)
//	ubihis.tipomov   = '108'
//		
//	// Cálculo del número de orden 
//	titulo        =  Parent.title
//	longitudes    =  Len(Trim(codigo_empresa))
//	criterio[1]   =  Trim(codigo_empresa)+ Space(20-longitudes)
//	anyo          =  Year(Date(if_fecha))
//	longitudes    =  Len(Trim(String(anyo)))
//	criterio[2]   =  Trim(String(anyo)) + Space(20-longitudes)
//	longitudes    =  Len(Trim(ubihis.almacen))
//	criterio[3]   =  Trim(ubihis.almacen) + Space(20-longitudes)
//	seleccion     =  criterio[1]+criterio[2]+criterio[3]
//	tabla         =  "almparam"
//	
//	IF f_bloquear(tabla,seleccion,titulo) THEN
//		bien = 1
//	END IF
//	
//	mov_salida    = f_almparam_nummov(codigo_empresa,ubihis.almacen,Year(Date(if_fecha)))
//	ubihis.orden  = f_almparam_numorden(codigo_empresa,ubihis.almacen,Year(Date(if_fecha)))
//	
//	ubihis.nummov = mov_salida
//	
//	IF NOT f_insert_almlinubicahis(ubihis) THEN  
//		bien = 1
//	END IF
//	
//	IF NOT f_actualiza_numorden(ubihis.empresa,ubihis.almacen,Year(Date(if_fecha)),ubihis.nummov) THEN
//		bien = 1
//	END IF
//	IF NOT f_actualiza_nummov(ubihis.empresa,ubihis.almacen,Year(Date(if_fecha)),mov_salida) THEN
//		bien = 1
//	END IF
//	
//		
//	// ............... PARA EL DE UBICACIONES
//	ubi.almacen    = ubihis.almacen
//	ubi.zona       = ubihis.zona
//	ubi.fila       = ubihis.fila
//	ubi.altura     = ubihis.altura
//	ubi.lote       = ubihis.lote
//	ubi.existencias= ubihis.cantidads
//	ubi.ubicacion  = ubihis.ubicacion
//		
//	// Si ya hay existencias del artículo procesado en las ubicaciones
//	// seleccionadas, se actualiza la tabla. En caso contrario, se inserta
//	Dec ls_exist
//	
//	// Miro si hay existencias de ese artículo
//	ubi.linea = f_ult_linea_ubi_art(ubi.empresa,ubi.ubicacion,ubi.articulo,ubi.lote)		
//		
//	IF ubi.linea > 0 THEN
//			// Actualización
////			ubi.linea = f_ult_linea_ubi(ubi.empresa,ubi.ubicacion)
//			SELECT almlinubica.existencias into :ls_exist FROM almlinubica
//				WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//						( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//						( almlinubica.linea     = :ubi.linea) 
//				USING SQLCA;
//			IF ubi.existencias < ls_exist THEN
//				UPDATE almlinubica  
//					SET existencias = (existencias - :ubi.existencias)
//					WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//							( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//							( almlinubica.linea     = :ubi.linea) 
//					USING SQLCA;
//		
//				IF SQLCA.SQLCode<>0 THEN  
//					bien = 1
//				END IF
//		ELSE
//			// borro la línea
//			DELETE FROM almlinubica  
//				WHERE ( almlinubica.empresa   = :ubi.empresa ) AND  
//						( almlinubica.ubicacion = :ubi.ubicacion ) AND  
//						( almlinubica.linea     = :ubi.linea )
//				USING SQLCA;
//			IF SQLCA.SQLCode<>0 THEN  
//				bien = 1
//			END IF
//		END IF
//	END IF
//	f_desbloquear(tabla,seleccion,titulo)
//	// Control de errores
//	IF bien = 1 THEN
//		CloseWithReturn(Parent,"N")
//	END IF
//		
//	
//	/********************************************************************/
//	/*	PROCESO 3: ENTRADA EN TABLA DE MOVIMIENTOS                		  */
//	/********************************************************************/
//	
//	// Cargar estructura de datos para la tabla de movimientos
//	mov.usuario    = nombre_usuario
//	mov.empresa    = ubihis.empresa
//	mov.anyo			= Year(Date(if_fecha))
//	mov.nummov     = mov_entrada
//	mov.articulo   = ubihis.articulo
//	mov.familia    = ubihis.familia
//	mov.tipo_unidad= ubihis.tipo_unidad
//	mov.referencia = ubihis.referencia
//	mov.f_alta     = ubihis.f_alta       
//	mov.anyo       = year(Date(String(if_fecha)))
//	mov.origen     = "3"
//	mov.fechmov    = ubihis.fecha
//	mov.tipomov    = ubihis.tipomov
//	mov.cantidade  = dw_1.GetItemDecimal(1,"total_cantidad")	
//	mov.cantidads  = 0
//	mov.precio     = 0
//	mov.tipo_materia  = ubihis.tipo_materia
//	SetNull(mov.codtercero)
//	mov.numdoc        = is_albaran
//	mov.situacion     = "N"
//	mov.antexist      = 0
//	mov.observaciones = ""
//	mov.lote          = ""
//	SetNull(mov.punteado)
//	
//	IF NOT f_insert_almmovhis(mov) Then
//		bien = 1
//	END IF
//	
//	/********************************************************************/
//	/*	PROCESO 4: SALIDA EN TABLA DE MOVIMIENTOS                		  */
//	/********************************************************************/
//	
//	mov.cantidads  =  dw_1.GetItemDecimal(1,"total_cantidad")	
//	mov.cantidade  = 0
//	mov.tipomov    = "108"
//	mov.nummov     = mov_salida
//	mov.almacen    = "2"
//	
//	IF NOT f_insert_almmovhis(mov) Then
//		MessageBox("Error en proceso","Grabando almmovhis",Exclamation!, OK!,1)
//		bien = 1
//	END IF
//	IF bien = 1 THEN
//		CloseWithReturn(Parent,"N")
//	ELSE
//		CloseWithReturn(Parent,"S")
//	END IF
//ELSE		// No han introducido toda la cantidad de la linea en ubicaciones
//	MessageBox("Asignación Ubicaciones","No se ha asignado bien, cantidad = "+ String(cantidad_restante,"###,##0"),Exclamation!)
//	f_activar_campo(em_zona)
//END IF
//
//
//
end event

type st_1 from statictext within w_ventana_ubicacion
integer x = 37
integer y = 760
integer width = 690
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Almacén"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_ventana_ubicacion
integer x = 727
integer y = 760
integer width = 128
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Zon"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_3 from statictext within w_ventana_ubicacion
integer x = 859
integer y = 760
integer width = 114
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Fila"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_4 from statictext within w_ventana_ubicacion
integer x = 978
integer y = 760
integer width = 114
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Alt"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_5 from statictext within w_ventana_ubicacion
integer x = 1390
integer y = 760
integer width = 206
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
string text = "Lote"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_unidad from statictext within w_ventana_ubicacion
integer x = 1093
integer y = 760
integer width = 293
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_almacen from u_em_campo within w_ventana_ubicacion
integer x = 37
integer y = 824
integer height = 68
integer taborder = 10
integer textsize = -7
long backcolor = 16777215
alignment alignment = right!
end type

event modificado;call super::modificado;st_almacen.text = f_nombre_almacen( codigo_empresa , Trim(em_almacen.text) )
IF Trim(st_almacen.text)="" THEN
	em_almacen.text = ""
	Return
END IF
end event

type em_zona from u_em_campo within w_ventana_ubicacion
integer x = 727
integer y = 824
integer width = 128
integer height = 68
integer taborder = 20
integer textsize = -7
long backcolor = 16777215
alignment alignment = center!
end type

event modificado;call super::modificado;String  ls_nombre

ls_nombre = f_nombre_zona(codigo_empresa,Trim(em_almacen.text),Trim(em_zona.text))
IF Trim(ls_nombre)="" THEN
	em_zona.text = ""
	Return
END IF
end event

type em_fila from u_em_campo within w_ventana_ubicacion
integer x = 859
integer y = 824
integer width = 114
integer height = 68
integer taborder = 30
integer textsize = -7
long backcolor = 16777215
alignment alignment = center!
end type

type em_altura from u_em_campo within w_ventana_ubicacion
integer x = 978
integer y = 824
integer width = 114
integer height = 68
integer taborder = 40
integer textsize = -7
long backcolor = 16777215
alignment alignment = center!
end type

type em_cantidad from u_em_campo within w_ventana_ubicacion
integer x = 1093
integer y = 824
integer width = 293
integer height = 68
integer taborder = 50
integer textsize = -7
long backcolor = 16777215
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "###,###,###.00"
string displaydata = "À"
end type

type em_lote from u_em_campo within w_ventana_ubicacion
integer x = 1390
integer y = 824
integer width = 206
integer height = 68
integer taborder = 60
integer textsize = -7
long backcolor = 16777215
alignment alignment = right!
end type

type st_almacen from statictext within w_ventana_ubicacion
integer x = 288
integer y = 828
integer width = 434
integer height = 64
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within w_ventana_ubicacion
integer x = 37
integer y = 236
integer width = 1792
integer height = 516
integer taborder = 0
string dataobject = "dw_int_almlinubicacion_1"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type ole_cont_pro from u_barra_contador within w_ventana_ubicacion
boolean visible = false
integer x = 599
integer y = 616
integer taborder = 80
end type

on ole_cont_pro.destroy
call u_barra_contador::destroy
end on

type sle_opcion_orden from singlelineedit within w_ventana_ubicacion
integer width = 41
integer height = 36
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 12632256
long backcolor = 12632256
boolean border = false
boolean autohscroll = false
end type

type st_empresa from statictext within w_ventana_ubicacion
integer x = 23
integer y = 40
integer width = 2066
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
string text = "Empresa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ventana_ubicacion
integer x = 1961
integer y = 744
integer width = 265
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

type gb_2 from groupbox within w_ventana_ubicacion
integer x = 1874
integer y = 228
integer width = 338
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

type gb_3 from groupbox within w_ventana_ubicacion
integer x = 1879
integer y = 376
integer width = 338
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

type gb_4 from groupbox within w_ventana_ubicacion
integer x = 1879
integer y = 528
integer width = 338
integer height = 136
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
end type

