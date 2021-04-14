$PBExportHeader$w_int_inventario_compras.srw
forward
global type w_int_inventario_compras from w_int_con_empresa
end type
type st_2 from statictext within w_int_inventario_compras
end type
type em_periodo from u_em_campo within w_int_inventario_compras
end type
type dw_1 from datawindow within w_int_inventario_compras
end type
type dw_proceso from datawindow within w_int_inventario_compras
end type
type cb_salir from u_boton within w_int_inventario_compras
end type
type cb_grabar from u_boton within w_int_inventario_compras
end type
type dw_zonas from datawindow within w_int_inventario_compras
end type
type pb_1 from upb_salir within w_int_inventario_compras
end type
type cb_insertar from u_boton within w_int_inventario_compras
end type
type cb_1 from u_boton within w_int_inventario_compras
end type
type dw_insertar from datawindow within w_int_inventario_compras
end type
type dw_inv from datawindow within w_int_inventario_compras
end type
end forward

global type w_int_inventario_compras from w_int_con_empresa
integer width = 2917
integer height = 1640
st_2 st_2
em_periodo em_periodo
dw_1 dw_1
dw_proceso dw_proceso
cb_salir cb_salir
cb_grabar cb_grabar
dw_zonas dw_zonas
pb_1 pb_1
cb_insertar cb_insertar
cb_1 cb_1
dw_insertar dw_insertar
dw_inv dw_inv
end type
global w_int_inventario_compras w_int_inventario_compras

type variables
String modo_insercion,grabado,bloqueado
end variables

forward prototypes
public subroutine f_control_insercion ()
end prototypes

public subroutine f_control_insercion ();datetime var_fecha_inventario,var_fecha_actualizado
string   var_almacen,var_zona,var_mp,var_familia,var_calidad,var_ubicacion
string   var_tipo_unidad,var_observaciones,var_envase_toma,var_actualizado
long     var_fila,var_altura,var_linea,var_orden,var_anyo_toma
dec      var_existencias_toma,var_precio,var_existencias_reales
string   mensaje,campo,nombre_mp
long     maxima_linea,maxima_orden,donde,indice
boolean  v_error = false
//Controles de insercion
var_almacen            = dw_inv.object.almacen[dw_inv.getrow()]
var_zona               = dw_inv.object.zona[dw_inv.getrow()]
var_fila               = dw_insertar.object.fila[1]
var_altura             = dw_insertar.object.altura[1]
var_mp                 = dw_insertar.object.mp[1]
var_existencias_reales = dw_insertar.object.existencias_reales[1]

//Ubicacion valida
if isnull(var_fila) then var_fila     = 0
if isnull(var_altura) then var_altura = 0
IF Not(f_ubi_exist_compras(codigo_empresa,var_almacen,var_zona,var_fila,var_altura)) THEN
	mensaje   = "La ubicación no esta contemplada en el mapa de ubicaciones"
	v_error     = true 
	campo     = "fila"
END IF
//Materia prima valida
nombre_mp = Trim(f_nombre_mprima(codigo_empresa,var_mp))
if isnull(nombre_mp) then nombre_mp = ""
if trim(nombre_mp) = "" and not(v_error) then
	mensaje   = "Materia prima no valida."
	v_error   = true 
	campo     = "mp"	
end if
//Cantidad valida
if isnull(var_existencias_reales) then var_existencias_reales = 0
if var_existencias_reales = 0 and not(v_error) then
	mensaje   = "Debe introducir las existencias."
	v_error   = true 
	campo     = "existencias_reales"	
end if

if v_error then
	MessageBox("Control de inserción",mensaje,Exclamation!,OK!,1)
	dw_insertar.SetColumn(campo)
	dw_insertar.setRow(1)
	dw_insertar.setfocus()
else	
	var_fecha_inventario = dw_inv.object.fecha_inventario[dw_inv.getrow()]
	var_calidad          = "1"
	var_existencias_toma = 0
	var_precio           = dw_insertar.object.precio[1]
	if isnull(var_precio) then var_precio = 0
	var_ubicacion	      = f_componer_ubicacion(var_almacen,var_zona,var_fila,var_altura)
	//Seleccionamos el maximo numero de linea de la datawindow
	maxima_linea = 0
	for indice = 1 to dw_inv.rowcount()
		if var_ubicacion = dw_inv.object.ubicacion[indice] then
			if maxima_linea < dw_inv.object.linea[indice] then
				maxima_linea = dw_inv.object.linea[indice]
			end if
		end if
	next	
	var_linea            = maxima_linea + 1
	
	var_observaciones	   = "Linea introducida por "+nombre_usuario
	var_actualizado      = "N"
	setnull(var_fecha_actualizado)
	//Seleccionamos el maximo numero de orden de la datawindow
	maxima_orden = 0
	for indice = 1 to dw_inv.rowcount()
		if maxima_orden < dw_inv.object.orden[indice] then
			maxima_orden = dw_inv.object.orden[indice]
		end if
	next	
	var_orden            = maxima_orden + 1
	var_anyo_toma        = year(date(var_fecha_inventario))
	
	SELECT familia,tipo_unidad,envase
	INTO   :var_familia,:var_tipo_unidad,:var_envase_toma
	FROM   venmprima
	WHERE  empresa = :codigo_empresa
	AND    codigo  = :var_mp ;
	
	IF SQLCA.SQLCode = 0 THEN
		donde = dw_inv.insertrow(dw_inv.rowcount() +1) 
		dw_inv.object.empresa[donde]            = codigo_empresa
		dw_inv.object.fecha_inventario[donde]   = var_fecha_inventario
		dw_inv.object.almacen[donde]            = var_almacen
		dw_inv.object.zona[donde]               = var_zona
		dw_inv.object.fila[donde]               = var_fila
		dw_inv.object.altura[donde]             = var_altura
		dw_inv.object.linea[donde]              = var_linea
		dw_inv.object.mp[donde]                 = var_mp
		dw_inv.object.nombre_mp[donde]          = nombre_mp
		dw_inv.object.familia[donde]            = var_familia
		dw_inv.object.calidad[donde]            = var_calidad
		dw_inv.object.existencias_toma[donde]   = var_existencias_toma
		dw_inv.object.ubicacion[donde]          = var_ubicacion
		dw_inv.object.tipo_unidad[donde]        = var_tipo_unidad
		dw_inv.object.observaciones[donde]      = var_observaciones
		dw_inv.object.envase_toma[donde]        = var_envase_toma
		dw_inv.object.precio[donde]             = var_precio
		dw_inv.object.existencias_reales[donde] = var_existencias_reales
		dw_inv.object.actualizado[donde]        = var_actualizado
		dw_inv.object.fecha_actualizado[donde]  = var_fecha_actualizado
		dw_inv.object.orden[donde]              = var_orden
		dw_inv.object.anyo_toma[donde]          = var_anyo_toma
		
		dw_insertar.DeleteRow(1)
		dw_inv.enabled      = FALSE
		dw_insertar.visible = TRUE
		modo_insercion      = "S"
		dw_insertar.InsertRow(1)
		dw_insertar.SetItem(1,"empresa",codigo_empresa)
		dw_insertar.SetItem(1,"fila",1)
		dw_insertar.SetItem(1,"altura",0)
		dw_insertar.SetRow(1)
		dw_insertar.SetColumn("mp")
		dw_insertar.SetFocus()		
	else
		messagebox("Atención","Se ha producido un error al seleccionar las especificaciones de la materia prima.")
	end if
end if
end subroutine

on close;call w_int_con_empresa::close;IF bloqueado="S" THEN 
 f_desbloquear(tabla,seleccion,titulo)
 COMMIT using sqlca;
END IF
end on

event open;call super::open;bloqueado = "N"
istr_parametros.s_titulo_ventana="Introduccion inventarios Compras"
This.title=istr_parametros.s_titulo_ventana
dw_1.settransobject(SQLCA)
dw_zonas.settransobject(SQLCA)
dw_inv.settransobject(SQLCA)
dw_proceso.settransobject(SQLCA)
dw_1.SetRowFocusIndicator(Hand!)		// Use hand for focus indicator
em_periodo.text=String(year(today()))
dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
//dw_inv.SetRowFocusIndicator(Hand!)	
dw_zonas.SetRowFocusIndicator(Hand!)	
grabado = "N"
dw_inv.visible= FALSE


end event

on w_int_inventario_compras.create
int iCurrent
call super::create
this.st_2=create st_2
this.em_periodo=create em_periodo
this.dw_1=create dw_1
this.dw_proceso=create dw_proceso
this.cb_salir=create cb_salir
this.cb_grabar=create cb_grabar
this.dw_zonas=create dw_zonas
this.pb_1=create pb_1
this.cb_insertar=create cb_insertar
this.cb_1=create cb_1
this.dw_insertar=create dw_insertar
this.dw_inv=create dw_inv
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.em_periodo
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.cb_salir
this.Control[iCurrent+6]=this.cb_grabar
this.Control[iCurrent+7]=this.dw_zonas
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.cb_insertar
this.Control[iCurrent+10]=this.cb_1
this.Control[iCurrent+11]=this.dw_insertar
this.Control[iCurrent+12]=this.dw_inv
end on

on w_int_inventario_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.em_periodo)
destroy(this.dw_1)
destroy(this.dw_proceso)
destroy(this.cb_salir)
destroy(this.cb_grabar)
destroy(this.dw_zonas)
destroy(this.pb_1)
destroy(this.cb_insertar)
destroy(this.cb_1)
destroy(this.dw_insertar)
destroy(this.dw_inv)
end on

event activate;call super::activate;w_int_inventario_compras = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_inventario_compras
integer taborder = 30
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_inventario_compras
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_inventario_compras
integer y = 12
integer width = 2661
end type

type st_2 from statictext within w_int_inventario_compras
integer x = 14
integer y = 180
integer width = 274
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Periodo"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_periodo from u_em_campo within w_int_inventario_compras
integer x = 306
integer y = 172
integer taborder = 40
maskdatatype maskdatatype = numericmask!
string mask = "####"
end type

on modified;call u_em_campo::modified;dw_1.Retrieve(codigo_empresa,Integer(em_periodo.text))
end on

type dw_1 from datawindow within w_int_inventario_compras
integer x = 585
integer y = 160
integer width = 1582
integer height = 984
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_int_inventario_compras1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

event rowfocuschanged;
if dw_1.rowcount() > 0 then
	dw_zonas.Retrieve(codigo_empresa,&
							dw_1.GetItemDatetime(dw_1.GetRow(),"fecha_inventario"),&
							dw_1.GetItemString(dw_1.GetRow(),"almacen"))
end if
end event

type dw_proceso from datawindow within w_int_inventario_compras
boolean visible = false
integer x = 9
integer width = 494
integer height = 176
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_proceso_inventario"
boolean livescroll = true
end type

type cb_salir from u_boton within w_int_inventario_compras
boolean visible = false
integer x = 823
integer y = 1352
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

event clicked;IF modo_insercion = "N" THEN
	IF grabado="N" Then
		Integer opcion
		opcion=MessageBox("Al salir sin grabar no se actualizan los cambios",&
						  "¿Desea Salir?",question!, YesNo!,2)
		If opcion=2 Then 
			dw_inv.SetFocus()
			Return
		End If
	END IF
	
	dw_1.enabled        = TRUE
	dw_zonas.enabled    = TRUE
	em_periodo.enabled  = TRUE
	cb_1.enabled        = TRUE
	dw_inv.enabled      = FALSE
	dw_inv.reset()
	cb_grabar.visible   = FALSE
	cb_salir.visible    = FALSE
	cb_insertar.visible = FALSE
	dw_inv.visible      = FALSE
	f_desbloquear(tabla,seleccion,titulo)
	COMMIT using sqlca;
	bloqueado = "N"
	f_activar_campo(em_periodo)
ELSE
	dw_insertar.visible = FALSE
	cb_insertar.enabled = TRUE
	modo_insercion      = "N"
	dw_inv.enabled      = TRUE
	dw_insertar.DeleteRow(1)
	dw_inv.SetFocus()
END IF
end event

type cb_grabar from u_boton within w_int_inventario_compras
boolean visible = false
integer x = 9
integer y = 1352
integer height = 76
integer taborder = 0
string text = "&Grabar"
end type

event clicked;Int r,opcion,op

IF modo_insercion="N" THEN	
	opcion = MessageBox("Al grabar se actualizan los cambios",&
					        "¿Desea Grabar?",question!, YesNo!,2)
	If opcion = 2 Then 
		dw_inv.SetFocus()
	else		
		dw_inv.AcceptText()
		op = dw_inv.Update()
		IF op = -1 THEN
			ROLLBACK using sqlca;
			MessageBox("Error en Grabacion de datos","No se graban los datos",Exclamation!, OK!,1)
		ELSE
			COMMIT using sqlca;
		END IF
		grabado = "S"
		cb_salir.TriggerEvent(Clicked!)		
	End If				
ELSE
	dw_insertar.AcceptText()
	f_control_insercion() 	
END IF
end event

type dw_zonas from datawindow within w_int_inventario_compras
integer x = 2167
integer y = 160
integer width = 457
integer height = 984
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_int_inventario_compras2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

on losefocus;This.BorderStyle=StyleRaised!
end on

on getfocus;This.BorderStyle=StyleLowered!
end on

type pb_1 from upb_salir within w_int_inventario_compras
integer x = 2711
integer width = 119
integer height = 104
integer taborder = 0
end type

type cb_insertar from u_boton within w_int_inventario_compras
boolean visible = false
integer x = 416
integer y = 1352
integer height = 76
integer taborder = 0
string text = "&Insertar"
end type

event clicked;Integer registro
IF modo_insercion = "N" Then
	dw_inv.enabled      = FALSE
	dw_insertar.visible = TRUE
	modo_insercion      = "S"
	
	dw_insertar.InsertRow(1)
	dw_insertar.SetItem(1,"empresa",codigo_empresa)
	dw_insertar.SetItem(1,"fila",1)
	dw_insertar.SetItem(1,"altura",0)  
	dw_insertar.SetColumn("mp")
	dw_insertar.SetFocus()
	This.enabled = FALSE
END IF
end event

type cb_1 from u_boton within w_int_inventario_compras
integer x = 320
integer y = 344
integer width = 224
integer height = 148
integer taborder = 50
string text = "&OK"
end type

event clicked;IF dw_1.GetRow() = 0 Then  Return
If dw_zonas.GetRow() = 0 Then Return

titulo        =  Parent.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(string(dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inventario"))))
criterio[2]   =  trim(string(dw_1.GetItemDateTime(dw_1.GetRow(),"fecha_inventario")))+space(20-longitud)
longitud      =  len(trim(dw_1.GetItemString(dw_1.GetRow(),"almacen")))
criterio[3]   =  trim(dw_1.GetItemString(dw_1.GetRow(),"almacen"))+space(20-longitud)
longitud      =  len(trim(dw_zonas.GetItemString(dw_zonas.GetRow(),"zona")))
criterio[4]   =  trim(dw_zonas.GetItemString(dw_zonas.GetRow(),"zona"))+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]
tabla         =  "com_toma_inventario"
IF NOT f_bloquear(tabla,seleccion,titulo) THEN
	COMMIT Using SQLCA; //Solucion nivel insolacion
	bloqueado="S"
	
	modo_insercion = "N"
	Integer registros
	Boolean valor
	datetime fecha
	string   almacen,zona
	fecha   = dw_1.GetItemDatetime(dw_1.Getrow(),"fecha_inventario")
	almacen = dw_1.GetItemString(dw_1.Getrow(),"almacen")
	zona    = dw_zonas.GetItemString(dw_zonas.Getrow(),"zona")
	registros  =  dw_inv.Retrieve(codigo_empresa,fecha,almacen,zona)
	dw_1.enabled        = FALSE
	dw_zonas.enabled    = FALSE
	em_periodo.enabled  = FALSE
	cb_1.enabled        = FALSE
	dw_inv.enabled      = TRUE
	cb_grabar.visible   = TRUE
	cb_salir.visible    = TRUE
	cb_insertar.visible = TRUE
	dw_inv.visible      = TRUE
	
	dw_inv.SetFocus()
	dw_inv.SetRow(1)
	dw_inv.SelectRow(0,false)
	dw_inv.SelectRow(1,True)
END IF


end event

type dw_insertar from datawindow within w_int_inventario_compras
event key pbm_dwnkey
boolean visible = false
integer x = 9
integer y = 1048
integer width = 2821
integer height = 304
boolean titlebar = true
string title = "Introducción de lineas manuales"
string dataobject = "dw_int_inventario_compras4"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;str_parametros param
String bus_campo,bus_cadena
SetNull(bus_campo)
string cadena,bus_cadena_return

IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
  
	param.b_empresa = TRUE
	This.AcceptText()
	param.s_criterio_busqueda = ""
	bus_campo = This.GetColumnName()
	CHOOSE CASE bus_campo
		CASE "almacen"
			param.s_titulo_ayuda   = "VENTANA SELECCION DE TIPO DE ALMACEN "
			param.s_nom_datawindow = "dw_ayuda_almacenes"
			param.s_filtro         = ""
		CASE "zona"
			param.s_titulo_ayuda   = "VENTANA SELECCION DE TIPO DE ZONA "
			param.s_nom_datawindow = "dw_ayuda_almubizonas"
			param.s_filtro         = "almacen='"+dw_inv.GetItemString(dw_inv.GetRow(),"almacen")+"'"
		CASE "mp"
			param.s_titulo_ayuda   = "VENTANA SELECCION DE MATERIAS PRIMAS"
			param.s_nom_datawindow = "dw_ayuda_venmprima"
			param.s_filtro         = ""
		CASE ELSE
			SetNull(bus_campo)		
	END CHOOSE
	// Ventanas de ayuda campos relacion de las datawindows
	IF Trim(bus_campo) = "" or IsNull(bus_campo) THEN  Return
	This.accepttext()
	bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
	IF IsNull(bus_cadena) or ISNumber(bus_cadena) THEN bus_cadena = ""
	IF KeyDown(KeyEnter!) OR (KeyDown(KeyTab!) and Trim(bus_cadena)<>"") THEN
		param.s_criterio_busqueda = bus_cadena
		OpenWithParm(w_busquedas,param)
		
		bus_cadena_return = Message.StringParm		// Devuelve el valor que encuentra ...
		IF Trim(bus_cadena_return)= "" or IsNull(bus_cadena_return) THEN
			bus_cadena = This.GetItemString(This.GetRow(),This.GetColumnName())
		ELSE
			bus_cadena = bus_cadena_return
		END IF
		This.SetItem(This.getrow(),This.GetColumn(),bus_cadena)
		SetColumn(This.GetColumn())
		This.SetRow(This.getrow())
		This.Setfocus()
	END IF
END IF


end event

type dw_inv from datawindow within w_int_inventario_compras
event key pbm_dwnkey
boolean visible = false
integer x = 5
integer y = 112
integer width = 2821
integer height = 1224
string dataobject = "dw_int_inventario_compras3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event rowfocuschanged;this.selectRow(0,False)
this.selectRow(currentrow,True)

end event

event retrieveend;long indice,total
total = this.rowcount()
if total > 0 then
	this.setredraw(false)
	
	for indice = 1 to total	
		this.object.nombre_mp[indice]	 = f_nombre_mprima(codigo_empresa,this.object.mp[indice])
	next
	this.sort()
	this.groupcalc()
	this.setredraw(true)
end if

end event

