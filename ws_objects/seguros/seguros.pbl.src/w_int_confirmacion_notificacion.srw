$PBExportHeader$w_int_confirmacion_notificacion.srw
forward
global type w_int_confirmacion_notificacion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_confirmacion_notificacion
end type
type dw_listado_detalle from datawindow within w_int_confirmacion_notificacion
end type
type pb_2 from upb_imprimir within w_int_confirmacion_notificacion
end type
type dw_detalle from datawindow within w_int_confirmacion_notificacion
end type
type uo_companyia from u_em_campo_2 within w_int_confirmacion_notificacion
end type
type cb_borrar from u_boton within w_int_confirmacion_notificacion
end type
type em_anyo from u_em_campo within w_int_confirmacion_notificacion
end type
type uo_mes from u_em_campo_2 within w_int_confirmacion_notificacion
end type
type st_1 from statictext within w_int_confirmacion_notificacion
end type
type st_2 from statictext within w_int_confirmacion_notificacion
end type
type gb_4 from groupbox within w_int_confirmacion_notificacion
end type
type em_fecha_notificacion from u_em_campo within w_int_confirmacion_notificacion
end type
type gb_5 from groupbox within w_int_confirmacion_notificacion
end type
type gb_3 from groupbox within w_int_confirmacion_notificacion
end type
type dw_listado_fras_declaradas from datawindow within w_int_confirmacion_notificacion
end type
type pb_3 from upb_imprimir within w_int_confirmacion_notificacion
end type
type st_3 from statictext within w_int_confirmacion_notificacion
end type
type gb_6 from groupbox within w_int_confirmacion_notificacion
end type
type pb_4 from upb_imprimir within w_int_confirmacion_notificacion
end type
type st_4 from statictext within w_int_confirmacion_notificacion
end type
type gb_7 from groupbox within w_int_confirmacion_notificacion
end type
type dw_listado_notificacion_nacional from datawindow within w_int_confirmacion_notificacion
end type
type cb_marcar_notificadas from u_boton within w_int_confirmacion_notificacion
end type
type gb_8 from groupbox within w_int_confirmacion_notificacion
end type
type pb_5 from upb_imprimir within w_int_confirmacion_notificacion
end type
type st_5 from statictext within w_int_confirmacion_notificacion
end type
type gb_9 from groupbox within w_int_confirmacion_notificacion
end type
type dw_listado_notificacion_export from datawindow within w_int_confirmacion_notificacion
end type
end forward

global type w_int_confirmacion_notificacion from w_int_con_empresa
integer width = 2958
integer height = 1748
pb_1 pb_1
dw_listado_detalle dw_listado_detalle
pb_2 pb_2
dw_detalle dw_detalle
uo_companyia uo_companyia
cb_borrar cb_borrar
em_anyo em_anyo
uo_mes uo_mes
st_1 st_1
st_2 st_2
gb_4 gb_4
em_fecha_notificacion em_fecha_notificacion
gb_5 gb_5
gb_3 gb_3
dw_listado_fras_declaradas dw_listado_fras_declaradas
pb_3 pb_3
st_3 st_3
gb_6 gb_6
pb_4 pb_4
st_4 st_4
gb_7 gb_7
dw_listado_notificacion_nacional dw_listado_notificacion_nacional
cb_marcar_notificadas cb_marcar_notificadas
gb_8 gb_8
pb_5 pb_5
st_5 st_5
gb_9 gb_9
dw_listado_notificacion_export dw_listado_notificacion_export
end type
global w_int_confirmacion_notificacion w_int_confirmacion_notificacion

type variables



end variables

forward prototypes
public subroutine f_fecha_notificacion ()
end prototypes

public subroutine f_fecha_notificacion ();datetime fecha_desde,fecha_hasta,fecha_notificacion
string   companyia

if dec(em_anyo.text) > 0 and dec(trim(uo_mes.em_codigo.text)) > 0 and trim(uo_companyia.em_codigo.text) <> "" then
	
	fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
	if dec(uo_mes.em_codigo.text)+1 = 13 then
		fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
	else
		fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
	End if	
	fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))
	
	companyia = uo_companyia.em_codigo.text
	
	SELECT MAX(fecha_notificacion)
	INTO   :fecha_notificacion  
	FROM   seglinventas
	WHERE  (empresa   = :codigo_empresa )
	AND  	 (companyia = :companyia )
	AND	 (fecha_factura between :fecha_desde and :fecha_hasta)
	AND    (fecha_notificacion is not null);
	
	if not isnull(fecha_notificacion) and year(date(fecha_notificacion)) <> 1900 then
		em_fecha_notificacion.text = string(fecha_notificacion,"dd/mm/yy")
		em_fecha_notificacion.enabled = false
		cb_marcar_notificadas.enabled = false
	else
		em_fecha_notificacion.text = string(today(),"dd/mm/yy")
		em_fecha_notificacion.enabled = true
		cb_marcar_notificadas.enabled = true
	end if
else
	em_fecha_notificacion.text = string(today(),"dd/mm/yy")
	em_fecha_notificacion.enabled = true	
	cb_marcar_notificadas.enabled = true
end if
			 
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Confirmación de Notificaciones"

This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)
dw_listado_detalle.SetTransObject(SQLCA)
dw_listado_fras_declaradas.SetTransObject(SQLCA)
dw_listado_notificacion_nacional.SetTransObject(SQLCA)

em_anyo.text = String(year(Today()))
uo_mes.em_codigo.text = String(Month(Today()) - 1 )

IF uo_mes.em_codigo.text = "0" Then
	uo_mes.em_codigo.text = "12"
	em_anyo.text = String(Dec(em_anyo.text) - 1)
END IF

em_fecha_notificacion.text = String(Today())
uo_mes.em_campo.text       = f_nombre_mes(Dec(uo_mes.em_codigo.text))

uo_companyia.em_codigo.text = "1"
uo_companyia.triggerEvent("modificado")
f_activar_campo(uo_companyia.em_campo)


end event

on w_int_confirmacion_notificacion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado_detalle=create dw_listado_detalle
this.pb_2=create pb_2
this.dw_detalle=create dw_detalle
this.uo_companyia=create uo_companyia
this.cb_borrar=create cb_borrar
this.em_anyo=create em_anyo
this.uo_mes=create uo_mes
this.st_1=create st_1
this.st_2=create st_2
this.gb_4=create gb_4
this.em_fecha_notificacion=create em_fecha_notificacion
this.gb_5=create gb_5
this.gb_3=create gb_3
this.dw_listado_fras_declaradas=create dw_listado_fras_declaradas
this.pb_3=create pb_3
this.st_3=create st_3
this.gb_6=create gb_6
this.pb_4=create pb_4
this.st_4=create st_4
this.gb_7=create gb_7
this.dw_listado_notificacion_nacional=create dw_listado_notificacion_nacional
this.cb_marcar_notificadas=create cb_marcar_notificadas
this.gb_8=create gb_8
this.pb_5=create pb_5
this.st_5=create st_5
this.gb_9=create gb_9
this.dw_listado_notificacion_export=create dw_listado_notificacion_export
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado_detalle
this.Control[iCurrent+3]=this.pb_2
this.Control[iCurrent+4]=this.dw_detalle
this.Control[iCurrent+5]=this.uo_companyia
this.Control[iCurrent+6]=this.cb_borrar
this.Control[iCurrent+7]=this.em_anyo
this.Control[iCurrent+8]=this.uo_mes
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.em_fecha_notificacion
this.Control[iCurrent+13]=this.gb_5
this.Control[iCurrent+14]=this.gb_3
this.Control[iCurrent+15]=this.dw_listado_fras_declaradas
this.Control[iCurrent+16]=this.pb_3
this.Control[iCurrent+17]=this.st_3
this.Control[iCurrent+18]=this.gb_6
this.Control[iCurrent+19]=this.pb_4
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.gb_7
this.Control[iCurrent+22]=this.dw_listado_notificacion_nacional
this.Control[iCurrent+23]=this.cb_marcar_notificadas
this.Control[iCurrent+24]=this.gb_8
this.Control[iCurrent+25]=this.pb_5
this.Control[iCurrent+26]=this.st_5
this.Control[iCurrent+27]=this.gb_9
this.Control[iCurrent+28]=this.dw_listado_notificacion_export
end on

on w_int_confirmacion_notificacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado_detalle)
destroy(this.pb_2)
destroy(this.dw_detalle)
destroy(this.uo_companyia)
destroy(this.cb_borrar)
destroy(this.em_anyo)
destroy(this.uo_mes)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_4)
destroy(this.em_fecha_notificacion)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.dw_listado_fras_declaradas)
destroy(this.pb_3)
destroy(this.st_3)
destroy(this.gb_6)
destroy(this.pb_4)
destroy(this.st_4)
destroy(this.gb_7)
destroy(this.dw_listado_notificacion_nacional)
destroy(this.cb_marcar_notificadas)
destroy(this.gb_8)
destroy(this.pb_5)
destroy(this.st_5)
destroy(this.gb_9)
destroy(this.dw_listado_notificacion_export)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_confirmacion_notificacion
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_confirmacion_notificacion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_confirmacion_notificacion
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_confirmacion_notificacion
integer x = 2711
integer width = 137
integer height = 120
integer taborder = 0
end type

type dw_listado_detalle from datawindow within w_int_confirmacion_notificacion
boolean visible = false
integer x = 96
integer width = 562
integer height = 340
boolean bringtotop = true
string dataobject = "report_confirmacion_notificacion_nueva1"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_int_confirmacion_notificacion
integer x = 293
integer y = 272
integer width = 119
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;string   companyia,situacion,cobrado[1 to 2]
datetime fecha_desde,fecha_hasta,fecha_factura,ultimo_vto
long     indice,total,duracion_credito

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text

dw_listado_detalle.setredraw(false)
dw_listado_detalle.Retrieve(codigo_empresa,companyia,fecha_desde,fecha_hasta)	

total = dw_listado_detalle.rowcount()

for indice = 1 to total
	fecha_factura    = dw_listado_detalle.object.seglinventas_fecha_factura[indice]
	ultimo_vto       = dw_listado_detalle.object.seglinventas_ultimo_vto[indice]
	duracion_credito = DaysAfter(date(fecha_factura),date(ultimo_vto))
	
	dw_listado_detalle.object.seglinventas_duracion_credito[indice] = duracion_credito
next

dw_listado_detalle.sort()
dw_listado_detalle.groupcalc()
dw_listado_detalle.setredraw(true)
f_imprimir_datawindow(dw_listado_detalle)

end event

type dw_detalle from datawindow within w_int_confirmacion_notificacion
event retrieveend pbm_dwnretrieveend
event retrievestart pbm_dwnretrievestart
integer y = 388
integer width = 2843
integer height = 1064
string dataobject = "dw_int_confirmacion_notificacion_nueva"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF row = 0 Then  return
String marca,valor,var_empresa

Dec{0} var_anyo,var_orden

var_empresa = f_valor_columna(dw_detalle,row,"empresa")
var_anyo    = Dec(f_valor_columna(dw_detalle,row,"anyo"))
var_orden   = dec(f_valor_columna(dw_detalle,row,"seglinventas_orden"))
//var_recibo  = Dec(f_valor_columna(dw_detalle,row,"recibo"))

IF row <> 0 then 
	IF f_valor_columna(dw_detalle,row,"declarado") = "N" Then
		marca = ""
		valor = "S"
	ELSE
		marca = "X"
		valor ="N"
	END IF

	f_asignar_columna(dw_detalle,row,"declarado",valor)
	
	Update seglinventas
	Set    seglinventas.declarado  = :valor			 
	Where  seglinventas.empresa    = :var_empresa
	And    seglinventas.anyo       = :var_anyo
	And    seglinventas.orden      = :var_orden;
	COMMIT;

END IF

end event

type uo_companyia from u_em_campo_2 within w_int_confirmacion_notificacion
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1184
integer y = 160
integer width = 1079
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;uo_companyia.em_campo.text=f_nombre_segcompanyia(codigo_empresa,uo_companyia.em_codigo.text)
If Trim(uo_companyia.em_campo.text)="" then
	uo_companyia.em_campo.text=""
	uo_companyia.em_codigo.text=""
	Return
end if 
f_fecha_notificacion()

end event

event getfocus;call super::getfocus;ue_titulo = "Selección de compañias"
ue_datawindow ="dw_ayuda_segcompanyias"
ue_filtro = ""

end event

on uo_companyia.destroy
call u_em_campo_2::destroy
end on

type cb_borrar from u_boton within w_int_confirmacion_notificacion
event clicked pbm_bnclicked
integer x = 27
integer y = 272
integer width = 265
integer height = 96
integer taborder = 0
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;string   companyia,situacion,cobrado[1 to 2]
datetime fecha_desde,fecha_hasta,fecha_factura,ultimo_vto
long     indice,total,duracion_credito

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text

dw_detalle.setredraw(false)
dw_detalle.Retrieve(codigo_empresa,companyia,fecha_desde,fecha_hasta)	

total = dw_detalle.rowcount()

for indice = 1 to total
	fecha_factura    = dw_detalle.object.seglinventas_fecha_factura[indice]
	ultimo_vto       = dw_detalle.object.seglinventas_ultimo_vto[indice]
	duracion_credito = DaysAfter(date(fecha_factura),date(ultimo_vto))
	
	dw_detalle.object.seglinventas_duracion_credito[indice] = duracion_credito
next

dw_detalle.sort()
dw_detalle.groupcalc()
dw_detalle.setredraw(true)
end event

type em_anyo from u_em_campo within w_int_confirmacion_notificacion
integer x = 183
integer y = 160
integer taborder = 100
end type

event modificado;call super::modificado;f_fecha_notificacion()
end event

type uo_mes from u_em_campo_2 within w_int_confirmacion_notificacion
event getfocus pbm_custom04
event destroy ( )
integer x = 617
integer y = 160
integer width = 530
integer taborder = 110
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_mes.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_mes.em_campo.text=f_nombre_mes(Dec(uo_mes.em_codigo.text))
If Trim(uo_mes.em_campo.text)="" then
	uo_mes.em_campo.text=""
	uo_mes.em_codigo.text=""
	Return
end if 
f_fecha_notificacion()

end event

type st_1 from statictext within w_int_confirmacion_notificacion
integer x = 27
integer y = 172
integer width = 137
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Año:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_int_confirmacion_notificacion
integer x = 462
integer y = 172
integer width = 146
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Mes:"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_int_confirmacion_notificacion
integer x = 14
integer y = 112
integer width = 1157
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type em_fecha_notificacion from u_em_campo within w_int_confirmacion_notificacion
integer x = 2391
integer y = 160
integer width = 329
integer taborder = 80
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type gb_5 from groupbox within w_int_confirmacion_notificacion
integer x = 1170
integer y = 112
integer width = 1673
integer height = 148
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Compañia                                                                Fecha Notificación"
end type

type gb_3 from groupbox within w_int_confirmacion_notificacion
integer x = 14
integer y = 232
integer width = 411
integer height = 148
integer taborder = 130
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_listado_fras_declaradas from datawindow within w_int_confirmacion_notificacion
boolean visible = false
integer x = 261
integer width = 562
integer height = 340
integer taborder = 60
boolean bringtotop = true
string dataobject = "report_confirmacion_notificacion_nueva2"
boolean livescroll = true
end type

type pb_3 from upb_imprimir within w_int_confirmacion_notificacion
integer x = 955
integer y = 272
integer width = 119
integer taborder = 30
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;string   companyia
datetime fecha_desde,fecha_hasta


fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text


dw_listado_fras_declaradas.Retrieve(codigo_empresa,companyia,fecha_desde,fecha_hasta)	

f_imprimir_datawindow(dw_listado_fras_declaradas)

end event

type st_3 from statictext within w_int_confirmacion_notificacion
integer x = 439
integer y = 268
integer width = 512
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Facturas declaradas"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_6 from groupbox within w_int_confirmacion_notificacion
integer x = 425
integer y = 232
integer width = 663
integer height = 148
integer taborder = 160
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_4 from upb_imprimir within w_int_confirmacion_notificacion
integer x = 1522
integer y = 272
integer width = 119
integer taborder = 70
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;string    companyia,sel
datetime  fecha_desde,fecha_hasta,fecha_factura,ultimo_vto,fecha_notificacion
dec       importe_contado,importe_nada,importe_otros,total_no_declarado
dec       importe_declarado[1 to 13],importe,total_declarado
long      indice,total,dias_credito,indice_array
datastore fras_declaradas

fecha_notificacion = datetime(date(em_fecha_notificacion.text))

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text

select sum(importe)
into   :importe_contado
from   seglinventas
where  empresa   = :codigo_empresa
and    companyia = :companyia
and    fecha_factura between :fecha_desde and :fecha_hasta
and    declarado = "N"
and    situacion not in("No solicitado","Denegado");

if isnull(importe_contado) then importe_contado = 0

select sum(importe)
into   :importe_nada
from   seglinventas
where  empresa   = :codigo_empresa
and    companyia = :companyia
and    fecha_factura between :fecha_desde and :fecha_hasta
and    declarado = "N"
and    situacion = "Denegado";

if isnull(importe_nada) then importe_nada = 0

select sum(importe)
into   :importe_otros
from   seglinventas
where  empresa   = :codigo_empresa
and    companyia = :companyia
and    fecha_factura between :fecha_desde and :fecha_hasta
and    declarado = "N"
and    situacion = "No solicitado";

if isnull(importe_otros) then importe_otros = 0

total_no_declarado = importe_contado+importe_nada+importe_otros

sel = "select fecha_factura,ultimo_vto,importe "+&
		"from   seglinventas "+&
		"where  empresa   = '"+codigo_empresa+"' "+&
		"and    companyia = '"+companyia+"' "+&
		"and    fecha_factura between '"+string(fecha_desde,"dd/mm/yy")+"' and '"+string(fecha_hasta,"dd/mm/yy")+"' "+&
		"and    declarado = 'S' "
		
//		"and    datepart(mm,fecha_factura) = "+uo_mes.em_codigo.text+" "+&
//		"and    datepart(yy,fecha_factura) = "+string(dec(em_anyo.text),"####")+" "+&

//fras_declaradas = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, fras_declaradas)


total = fras_declaradas.rowcount()
total_declarado = 0
for indice = 1 to total
	fecha_factura = fras_declaradas.object.fecha_factura[indice]
	ultimo_vto    = fras_declaradas.object.ultimo_vto[indice]
	importe       = fras_declaradas.object.importe[indice]
	dias_credito  = DaysAfter(date(fecha_factura),date(ultimo_vto))
	
	indice_array  = truncate((dias_credito -1) / 30,0) +1
	
	if indice_array > 13 then indice_array = 13
	
	importe_declarado[indice_array] = importe_declarado[indice_array] + importe
	total_declarado                 = total_declarado + importe
next

destroy fras_declaradas

dw_listado_notificacion_nacional.Retrieve(codigo_empresa,em_anyo.text,uo_mes.em_campo.text,fecha_notificacion)	

dw_listado_notificacion_nacional.insertrow(1)

dw_listado_notificacion_nacional.object.empresa[1] = codigo_empresa

dw_listado_notificacion_nacional.object.importe_declarado1[1]      = importe_declarado[1]
dw_listado_notificacion_nacional.object.importe_declarado2[1]      = importe_declarado[2]
dw_listado_notificacion_nacional.object.importe_declarado3[1]      = importe_declarado[3]
dw_listado_notificacion_nacional.object.importe_declarado4[1]      = importe_declarado[4]
dw_listado_notificacion_nacional.object.importe_declarado5[1]      = importe_declarado[5]
dw_listado_notificacion_nacional.object.importe_declarado6[1]      = importe_declarado[6]
dw_listado_notificacion_nacional.object.importe_declarado7[1]      = importe_declarado[7]
dw_listado_notificacion_nacional.object.importe_declarado8[1]      = importe_declarado[8]
dw_listado_notificacion_nacional.object.importe_declarado9[1]      = importe_declarado[9]
dw_listado_notificacion_nacional.object.importe_declarado10[1]     = importe_declarado[10]
dw_listado_notificacion_nacional.object.importe_declarado11[1]     = importe_declarado[11]
dw_listado_notificacion_nacional.object.importe_declarado12[1]     = importe_declarado[12]
dw_listado_notificacion_nacional.object.importe_declarado13[1]     = importe_declarado[13]
dw_listado_notificacion_nacional.object.importe_declarado_total[1] = total_declarado

dw_listado_notificacion_nacional.object.importe_no_declarado_contado[1] = importe_contado
dw_listado_notificacion_nacional.object.importe_no_declarado_nada[1]    = importe_nada
dw_listado_notificacion_nacional.object.importe_no_declarado_otros[1]   = importe_otros
dw_listado_notificacion_nacional.object.importe_no_declarado_total[1]   = total_no_declarado

f_imprimir_datawindow(dw_listado_notificacion_nacional)

end event

type st_4 from statictext within w_int_confirmacion_notificacion
integer x = 1102
integer y = 268
integer width = 411
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Notificación Nac"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_7 from groupbox within w_int_confirmacion_notificacion
integer x = 1088
integer y = 232
integer width = 567
integer height = 148
integer taborder = 150
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_listado_notificacion_nacional from datawindow within w_int_confirmacion_notificacion
boolean visible = false
integer x = 453
integer width = 562
integer height = 340
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_confirmacion_notificacion_nueva3"
boolean livescroll = true
end type

type cb_marcar_notificadas from u_boton within w_int_confirmacion_notificacion
integer x = 2354
integer y = 272
integer width = 475
integer height = 96
integer taborder = 40
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "Marca Notificacion"
end type

event clicked;datetime fecha_desde,fecha_hasta,fecha_notificacion
string   companyia

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text

IF MessageBox("Confirmación","¿Desea Marcar las facturas como notificadas?",Question!,YesNo!,2) = 1 Then
	fecha_notificacion = datetime(date(em_fecha_notificacion.text))
	
	UPDATE seglinventas  
	SET    fecha_notificacion = :fecha_notificacion  
	WHERE  (empresa   = :codigo_empresa )
	AND  	 (companyia = :companyia )
	AND	 (fecha_factura between :fecha_desde and :fecha_hasta);
			 
	if sqlca.sqlcode <> 0 then
		rollback;
		messagebox("Atención","Se ha producido un error al marcar las facturas como notificadas.")
	else
		commit;
		this.enabled                  = false
		em_fecha_notificacion.enabled = false
	end if
End if

end event

type gb_8 from groupbox within w_int_confirmacion_notificacion
integer x = 2341
integer y = 232
integer width = 503
integer height = 148
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_5 from upb_imprimir within w_int_confirmacion_notificacion
integer x = 2153
integer y = 272
integer width = 119
integer taborder = 50
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;string    companyia,sel,cliente,pais,array_paises[1 to 122]
datetime  fecha_desde,fecha_hasta,fecha_factura,ultimo_vto,fecha_notificacion
dec       importe_contado,importe_nada,importe_otros,total_no_declarado
dec       importe_declarado[1 to 122],importe,total_declarado
long      indice,total,dias_credito
int       indice_array,ultimo_indice_array,indice2,posicion
int		 duracion_credito[1 to 122]
datastore fras_declaradas

messagebox("Atención","Opción no activa en su versión")
return
//Para activarla hay que crear la función f_orden_cyc_pais() y descomentar la linea : indice_array  = f_orden_cyc_pais(pais)
fecha_notificacion = datetime(date(em_fecha_notificacion.text))

fecha_desde = DateTime(MDY(Dec(uo_mes.em_codigo.text),01,Dec(em_anyo.text)))
if dec(uo_mes.em_codigo.text)+1 = 13 then
   fecha_hasta = DateTime(MDY((1),01,Dec(em_anyo.text)+1))
else
	fecha_hasta = DateTime(MDY(Dec(uo_mes.em_codigo.text)+1,01,Dec(em_anyo.text)))
End if	
fecha_hasta = DateTime(RelativeDate(Date(fecha_hasta),-1))

companyia = uo_companyia.em_codigo.text

select sum(importe)
into   :importe_contado
from   seglinventas
where  empresa   = :codigo_empresa
and    companyia = :companyia
and    fecha_factura between :fecha_desde and :fecha_hasta
and    declarado = "N"
and    situacion not in("No solicitado","Denegado");

if isnull(importe_contado) then importe_contado = 0

select sum(importe)
into   :importe_nada
from   seglinventas
where  empresa   = :codigo_empresa
and    companyia = :companyia
and    fecha_factura between :fecha_desde and :fecha_hasta
and    declarado = "N"
and    situacion = "Denegado";

if isnull(importe_nada) then importe_nada = 0

select sum(importe)
into   :importe_otros
from   seglinventas
where  empresa   = :codigo_empresa
and    companyia = :companyia
and    fecha_factura between :fecha_desde and :fecha_hasta
and    declarado = "N"
and    situacion = "No solicitado";

if isnull(importe_otros) then importe_otros = 0

total_no_declarado = importe_contado+importe_nada+importe_otros

sel = "select fecha_factura,ultimo_vto,importe,cliente "+&
		"from   seglinventas "+&
		"where  empresa   = '"+codigo_empresa+"' "+&
		"and    companyia = '"+companyia+"' "+&
		"and    fecha_factura between '"+string(fecha_desde,"dd/mm/yy")+"' and '"+string(fecha_hasta,"dd/mm/yy")+"' "+&
		"and    declarado = 'S' "

//fras_declaradas = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, fras_declaradas)

total               = fras_declaradas.rowcount()
total_declarado     = 0
ultimo_indice_array = 32
for indice = 1 to total
	fecha_factura = fras_declaradas.object.fecha_factura[indice]
	ultimo_vto    = fras_declaradas.object.ultimo_vto[indice]
	importe       = fras_declaradas.object.importe[indice]
	cliente       = fras_declaradas.object.cliente[indice]
	pais          = f_pais_genter(codigo_empresa,"C",cliente)		
	dias_credito  = DaysAfter(date(fecha_factura),date(ultimo_vto))
	
	//indice_array  = f_orden_cyc_pais(pais)
		
	if indice_array = 0 then
		for indice2 = 1 to ultimo_indice_array
			if array_paises[indice2] = pais then
				indice_array = indice2			
			end if
		next
		if indice_array = 0 then
			ultimo_indice_array ++
			array_paises[ultimo_indice_array] = pais 
			indice_array  = ultimo_indice_array
		end if
	end if
	if duracion_credito[indice_array] < dias_credito then
		duracion_credito[indice_array] = dias_credito
	end if
	
	importe_declarado[indice_array] = importe_declarado[indice_array] + importe
	total_declarado                 = total_declarado + importe
next

destroy fras_declaradas

dw_listado_notificacion_export.dataobject = "report_confirmacion_notificacion_nueva4"
dw_listado_notificacion_export.settransobject(sqlca)

dw_listado_notificacion_export.Retrieve(codigo_empresa,em_anyo.text,uo_mes.em_campo.text,fecha_notificacion)	

dw_listado_notificacion_export.insertrow(1)

dw_listado_notificacion_export.object.empresa[1] = codigo_empresa

//dw_listado_notificacion_export.object.importe_declarado1[1]      = importe_declarado[1]
//dw_listado_notificacion_export.object.importe_declarado2[1]      = importe_declarado[2]
//dw_listado_notificacion_export.object.importe_declarado3[1]      = importe_declarado[3]
//dw_listado_notificacion_export.object.importe_declarado4[1]      = importe_declarado[4]
//dw_listado_notificacion_export.object.importe_declarado5[1]      = importe_declarado[5]
//dw_listado_notificacion_export.object.importe_declarado6[1]      = importe_declarado[6]
//dw_listado_notificacion_export.object.importe_declarado7[1]      = importe_declarado[7]
//dw_listado_notificacion_export.object.importe_declarado8[1]      = importe_declarado[8]
//dw_listado_notificacion_export.object.importe_declarado9[1]      = importe_declarado[9]
//dw_listado_notificacion_export.object.importe_declarado10[1]     = importe_declarado[10]
//dw_listado_notificacion_export.object.importe_declarado11[1]     = importe_declarado[11]
//dw_listado_notificacion_export.object.importe_declarado12[1]     = importe_declarado[12]
//dw_listado_notificacion_export.object.importe_declarado13[1]     = importe_declarado[13]
//dw_listado_notificacion_export.object.importe_declarado14[1]     = importe_declarado[14]
//dw_listado_notificacion_export.object.importe_declarado15[1]     = importe_declarado[15]
//dw_listado_notificacion_export.object.importe_declarado16[1]     = importe_declarado[16]
//dw_listado_notificacion_export.object.importe_declarado17[1]     = importe_declarado[17]
//dw_listado_notificacion_export.object.importe_declarado18[1]     = importe_declarado[18]
//dw_listado_notificacion_export.object.importe_declarado19[1]     = importe_declarado[19]
//dw_listado_notificacion_export.object.importe_declarado20[1]     = importe_declarado[20]
//dw_listado_notificacion_export.object.importe_declarado21[1]     = importe_declarado[21]
//dw_listado_notificacion_export.object.importe_declarado22[1]     = importe_declarado[22]

for indice = 1 to 22
	dw_listado_notificacion_export.setitem(1,"importe_declarado"+string(indice,"##"),importe_declarado[indice])
	dw_listado_notificacion_export.setitem(1,"duracion"+string(indice,"##"),duracion_credito[indice])
next

dw_listado_notificacion_export.print(false)

dw_listado_notificacion_export.dataobject = "report_confirmacion_notificacion_nueva5"
dw_listado_notificacion_export.settransobject(sqlca)

dw_listado_notificacion_export.Retrieve(codigo_empresa,em_anyo.text,uo_mes.em_campo.text,fecha_notificacion)	

dw_listado_notificacion_export.insertrow(1)

dw_listado_notificacion_export.object.empresa[1] = codigo_empresa

for indice = 23 to 50
	dw_listado_notificacion_export.setitem(1,"importe_declarado"+string(indice -22,"##"),importe_declarado[indice])
	dw_listado_notificacion_export.setitem(1,"duracion"+string(indice -22,"##"),duracion_credito[indice])
next

for indice = 33 to 50
	dw_listado_notificacion_export.setitem(1,"pais"+string(indice -22,"##"),f_nombre_pais(array_paises[indice]))	
next

if ultimo_indice_array <= 50 then
	dw_listado_notificacion_export.object.importe_declarado_total[1] = total_declarado
	
	dw_listado_notificacion_export.object.importe_no_declarado_contado[1] = importe_contado
	dw_listado_notificacion_export.object.importe_no_declarado_nada[1]    = importe_nada
	dw_listado_notificacion_export.object.importe_no_declarado_otros[1]   = importe_otros
	dw_listado_notificacion_export.object.importe_no_declarado_total[1]   = total_no_declarado
end if
messagebox("Atención","Pulse Ok despues de volver la hoja.",StopSign!)

dw_listado_notificacion_export.print(false)

if ultimo_indice_array > 50 then
	dw_listado_notificacion_export.Retrieve(codigo_empresa,em_anyo.text,uo_mes.em_campo.text,fecha_notificacion)	

	dw_listado_notificacion_export.insertrow(1)
	
	dw_listado_notificacion_export.object.empresa[1] = codigo_empresa
	for indice = 51 to ultimo_indice_array
		posicion = indice - (22 + (18 * (Truncate ((indice - 33) / 18,0))))
		dw_listado_notificacion_export.setitem(1,"importe_declarado"+string(posicion,"##"),importe_declarado[indice])
		dw_listado_notificacion_export.setitem(1,"duracion"+string(posicion,"##"),duracion_credito[indice])
		dw_listado_notificacion_export.setitem(1,"pais"+string(posicion,"##"),f_nombre_pais(array_paises[indice]))	
		
		if posicion = 28 and indice < ultimo_indice_array then
			messagebox("Atención","Pulse Ok despues de introducir otra hoja por la parte posterior.",StopSign!)
			
			dw_listado_notificacion_export.print(false)	
			
			dw_listado_notificacion_export.Retrieve(codigo_empresa,em_anyo.text,uo_mes.em_campo.text,fecha_notificacion)	
		
			dw_listado_notificacion_export.insertrow(1)
			
			dw_listado_notificacion_export.object.empresa[1] = codigo_empresa
			
		end if
	next
	dw_listado_notificacion_export.object.importe_declarado_total[1] = total_declarado
	
	dw_listado_notificacion_export.object.importe_no_declarado_contado[1] = importe_contado
	dw_listado_notificacion_export.object.importe_no_declarado_nada[1]    = importe_nada
	dw_listado_notificacion_export.object.importe_no_declarado_otros[1]   = importe_otros
	dw_listado_notificacion_export.object.importe_no_declarado_total[1]   = total_no_declarado
	
	messagebox("Atención","Pulse Ok despues de introducir otra hoja por la parte posterior.",StopSign!)
	
	dw_listado_notificacion_export.print(false)	
end if
end event

type st_5 from statictext within w_int_confirmacion_notificacion
integer x = 1669
integer y = 268
integer width = 480
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Notificación Export"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_9 from groupbox within w_int_confirmacion_notificacion
integer x = 1655
integer y = 232
integer width = 631
integer height = 148
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_listado_notificacion_export from datawindow within w_int_confirmacion_notificacion
boolean visible = false
integer x = 686
integer width = 562
integer height = 340
integer taborder = 70
boolean bringtotop = true
string dataobject = "report_confirmacion_notificacion_nueva5"
boolean livescroll = true
end type

