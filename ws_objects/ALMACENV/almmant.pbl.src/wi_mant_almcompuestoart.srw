$PBExportHeader$wi_mant_almcompuestoart.srw
forward
global type wi_mant_almcompuestoart from w_int_con_empresa
end type
type uo_articulo from u_em_campo_2 within wi_mant_almcompuestoart
end type
type st_1 from statictext within wi_mant_almcompuestoart
end type
type dw_1 from u_datawindow within wi_mant_almcompuestoart
end type
type cb_aceptar from u_boton within wi_mant_almcompuestoart
end type
type cb_cancelar from u_boton within wi_mant_almcompuestoart
end type
type pb_1 from upb_salir within wi_mant_almcompuestoart
end type
type dw_listado from datawindow within wi_mant_almcompuestoart
end type
type pb_2 from upb_imprimir within wi_mant_almcompuestoart
end type
type dw_costes from datawindow within wi_mant_almcompuestoart
end type
type st_unidad from statictext within wi_mant_almcompuestoart
end type
end forward

global type wi_mant_almcompuestoart from w_int_con_empresa
integer width = 2734
integer height = 1588
uo_articulo uo_articulo
st_1 st_1
dw_1 dw_1
cb_aceptar cb_aceptar
cb_cancelar cb_cancelar
pb_1 pb_1
dw_listado dw_listado
pb_2 pb_2
dw_costes dw_costes
st_unidad st_unidad
end type
global wi_mant_almcompuestoart wi_mant_almcompuestoart

type variables
boolean bloqueado = false
string codigo
end variables

forward prototypes
public function boolean f_comprueba_clave ()
end prototypes

public function boolean f_comprueba_clave ();long indice,total,donde
string producto_terminado,producto,busqueda,nombre_producto
boolean duplicados = false									 
total  = dw_1.rowcount()
indice = 1
if indice > 1 then
	do
		producto_terminado = dw_1.object.producto_terminado[indice]
		producto           = dw_1.object.producto[indice]
		if producto_terminado = "S" then
			nombre_producto = f_nombre_articulo( codigo_empresa , producto )
		else
			nombre_producto = f_nombre_mprima( codigo_empresa , producto )
		end if
		busqueda = "producto_terminado = '"+producto_terminado+"' and producto = '"+producto+"'"
		donde = dw_1.find(busqueda,indice +1,dw_1.RowCount())
		if donde > 0 then
			messagebox("Atención","Se ha duplicado el producto "+nombre_producto+&
										 " en la composición del articulo."+&
										 "~nPor favor elimine el duplicado.")
										 
			duplicados = true									 
		end if
		indice ++
	loop while indice < total and not(duplicados)
end if
if duplicados then
	return false
else
	return true
end if
end function

on wi_mant_almcompuestoart.create
int iCurrent
call super::create
this.uo_articulo=create uo_articulo
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_aceptar=create cb_aceptar
this.cb_cancelar=create cb_cancelar
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.pb_2=create pb_2
this.dw_costes=create dw_costes
this.st_unidad=create st_unidad
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_articulo
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_aceptar
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.pb_1
this.Control[iCurrent+7]=this.dw_listado
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.dw_costes
this.Control[iCurrent+10]=this.st_unidad
end on

on wi_mant_almcompuestoart.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_articulo)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_aceptar)
destroy(this.cb_cancelar)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.pb_2)
destroy(this.dw_costes)
destroy(this.st_unidad)
end on

event open;call super::open;this.title = "Mantenimiento Detalle Artículos"

dw_1.SetTransObject (sqlca)
dw_listado.SetTransObject (sqlca)
//dw_aplicaciones.sharedata(dw_costes)
dw_costes.SetTransObject (sqlca)

IF istr_parametros.i_nargumentos>1 THEN
	uo_articulo.em_codigo.text = istr_parametros.s_argumentos[2]	
	uo_articulo.TriggerEvent("modificado")
END IF

f_activar_campo (uo_articulo.em_campo)
end event

event activate;call super::activate;wi_mant_almcompuestoart = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_almcompuestoart
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_almcompuestoart
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_almcompuestoart
end type

type uo_articulo from u_em_campo_2 within wi_mant_almcompuestoart
integer x = 283
integer y = 160
integer width = 1312
integer height = 76
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo      = "AYUDA SELECCION DE ARTICULOS"
ue_datawindow  = "dw_ayuda_articulos"
ue_filtro     = ""

end event

event modificado;uo_articulo.em_campo.text = f_nombre_articulo (codigo_empresa, uo_articulo.em_codigo.text)

if IsNull(uo_articulo.em_campo.text) or Trim(uo_articulo.em_campo.text) = "" then
	uo_articulo.em_campo.text = ""
	uo_articulo.em_codigo.text = ""
	st_unidad.text = ""
	f_activar_campo(uo_articulo.em_campo)
else
	dw_1.retrieve(codigo_empresa, uo_articulo.em_codigo.text)
	st_unidad.text = "Unidad : "+F_nombre_unidad(f_unidad_articulo(codigo_empresa,uo_articulo.em_codigo.text))
end if
	


end event

type st_1 from statictext within wi_mant_almcompuestoart
integer x = 14
integer y = 164
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Artículo:"
boolean focusrectangle = false
end type

type dw_1 from u_datawindow within wi_mant_almcompuestoart
integer y = 324
integer width = 2601
integer height = 1008
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_almcompuestoart"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;long maxi,i,num,donde

if not(bloqueado) then
	codigo = codigo_empresa + uo_articulo.em_codigo.text
	if not(f_bloquear("almcompuestoart",codigo,"Mantenimiento Detalle Artículos")) then
		commit;
		bloqueado = true
		cb_aceptar.enabled = true
	else
		commit;
		this.reset()
	end if
end if


choose case f_objeto_datawindow(this) 
	case "cb_anyadir"
		donde = this.InsertRow(0)
		this.SetItem(donde,"empresa",codigo_empresa)
		this.SetItem(donde,"articulo",uo_articulo.em_codigo.text)
		if this.RowCount() = 0 then
			maxi = 0
		else
			maxi = 0
			for i = 1 to this.rowcount()
				num = this.GetItemNumber(i,"orden")
				if IsNull(num) then num = 0
				if num > maxi then maxi = num
			next
			
		end if
		maxi = maxi + 1
		this.SetItem(donde,"orden",maxi)
		this.SetRow(donde)
		this.SetColumn("producto_terminado")
	case "cb_intercalar"
		donde = this.GetRow()
		donde = this.InsertRow(donde)
		
		this.SetItem(donde,"empresa",codigo_empresa)
		this.SetItem(donde,"articulo",uo_articulo.em_codigo.text)
		for i = 1 to this.rowcount()
			this.SetItem(i,"orden",i)
		next
		this.SetRow(donde)
		this.SetColumn("producto_terminado")
	case "cb_borrar"
		if this.RowCOunt() > 0 then
			this.DeleteRow(this.GetRow())
			this.SetRow(1)
		end if
		for i = 1 to this.rowcount()
			this.SetItem(i,"orden",i)
		next

end choose

call super::clicked
end event

event key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "producto"
		if this.object.producto_terminado[this.getrow()] = "S" then
			bus_filtro =""
			bus_datawindow = "dw_ayuda_articulos"
			bus_titulo = "VENTANA SELECCION DE ARTICULOS"
		else
			bus_datawindow =  "dw_ayuda_venmprima"
			bus_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS"
			bus_filtro     =  ""	
		end if
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event rbuttondown;

bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "producto"
		if this.object.producto_terminado[this.getrow()] = "S" then
			bus_filtro =""
			bus_datawindow = "dw_ayuda_articulos"
			bus_titulo = "VENTANA SELECCION DE ARTICULOS"
		else
			bus_datawindow =  "dw_ayuda_venmprima"
			bus_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS"
			bus_filtro     =  ""	
		end if
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::rbuttondown

end event

type cb_aceptar from u_boton within wi_mant_almcompuestoart
integer x = 1778
integer y = 228
integer width = 338
integer height = 92
integer taborder = 40
boolean bringtotop = true
boolean enabled = false
string text = "&Aceptar"
end type

event clicked;dw_1.AcceptText()

if f_comprueba_clave() then
	dw_1.update()
	commit;

	f_desbloquear("almcompuestoart",codigo,"Mantenimiento Detalle Artículos")
	commit;	
	bloqueado = false
	this.enabled = false
end if
end event

type cb_cancelar from u_boton within wi_mant_almcompuestoart
integer x = 2117
integer y = 228
integer width = 338
integer height = 92
integer taborder = 90
boolean bringtotop = true
string text = "&Cancelar"
end type

event clicked;dw_1.retrieve(codigo_empresa, uo_articulo.em_codigo.text)
if bloqueado then
	f_desbloquear("almcompuestoart",codigo,"Mantenimiento Detalle Artículos")
	commit;
	bloqueado = false
end if
cb_aceptar.enabled = false
end event

type pb_1 from upb_salir within wi_mant_almcompuestoart
integer x = 2501
integer y = 88
integer width = 110
integer height = 96
integer taborder = 30
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

event clicked;if bloqueado then
	f_desbloquear("almcompuestoart",codigo,"Mantenimiento Detalle Artículos")
	commit;
	bloqueado = false
end if
call super::clicked

end event

type dw_listado from datawindow within wi_mant_almcompuestoart
boolean visible = false
integer x = 9
integer y = 80
integer width = 494
integer height = 360
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_proddetartic"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within wi_mant_almcompuestoart
boolean visible = false
integer x = 2391
integer y = 88
integer taborder = 80
boolean bringtotop = true
string picturename = "print!"
end type

event clicked;dw_listado.retrieve(codigo_empresa, uo_articulo.em_codigo.text)
f_imprimir_datawindow(dw_listado)
end event

type dw_costes from datawindow within wi_mant_almcompuestoart
boolean visible = false
integer x = 1536
integer y = 328
integer width = 987
integer height = 912
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_proddetartic_costes"
boolean border = false
boolean livescroll = true
end type

type st_unidad from statictext within wi_mant_almcompuestoart
integer x = 283
integer y = 244
integer width = 1312
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

