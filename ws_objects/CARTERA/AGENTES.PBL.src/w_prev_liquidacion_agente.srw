$PBExportHeader$w_prev_liquidacion_agente.srw
$PBExportComments$€
forward
global type w_prev_liquidacion_agente from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_prev_liquidacion_agente
end type
type gb_2 from groupbox within w_prev_liquidacion_agente
end type
type gb_fecha from groupbox within w_prev_liquidacion_agente
end type
type em_fechahasta from u_em_campo within w_prev_liquidacion_agente
end type
type cb_1 from commandbutton within w_prev_liquidacion_agente
end type
type cb_2 from commandbutton within w_prev_liquidacion_agente
end type
type st_4 from statictext within w_prev_liquidacion_agente
end type
type uo_agente from u_em_campo_2 within w_prev_liquidacion_agente
end type
type em_fechadesde from u_em_campo within w_prev_liquidacion_agente
end type
type st_1 from statictext within w_prev_liquidacion_agente
end type
type cobrado from dropdownlistbox within w_prev_liquidacion_agente
end type
type pb_imprimir_factura from upb_imprimir within w_prev_liquidacion_agente
end type
type st_2 from statictext within w_prev_liquidacion_agente
end type
type dw_factura from datawindow within w_prev_liquidacion_agente
end type
type dw_impagados_agente from datawindow within w_prev_liquidacion_agente
end type
type dw_listado from datawindow within w_prev_liquidacion_agente
end type
type pb_1 from upb_salir within w_prev_liquidacion_agente
end type
type dw_1 from datawindow within w_prev_liquidacion_agente
end type
type em_factura_fechahasta from u_em_campo within w_prev_liquidacion_agente
end type
type em_factura_fechadesde from u_em_campo within w_prev_liquidacion_agente
end type
type st_3 from statictext within w_prev_liquidacion_agente
end type
type gb_1 from groupbox within w_prev_liquidacion_agente
end type
end forward

global type w_prev_liquidacion_agente from w_int_con_empresa
integer width = 3790
integer height = 1644
pb_imprimir pb_imprimir
gb_2 gb_2
gb_fecha gb_fecha
em_fechahasta em_fechahasta
cb_1 cb_1
cb_2 cb_2
st_4 st_4
uo_agente uo_agente
em_fechadesde em_fechadesde
st_1 st_1
cobrado cobrado
pb_imprimir_factura pb_imprimir_factura
st_2 st_2
dw_factura dw_factura
dw_impagados_agente dw_impagados_agente
dw_listado dw_listado
pb_1 pb_1
dw_1 dw_1
em_factura_fechahasta em_factura_fechahasta
em_factura_fechadesde em_factura_fechadesde
st_3 st_3
gb_1 gb_1
end type
global w_prev_liquidacion_agente w_prev_liquidacion_agente

type variables
 string detalle="S"
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
public subroutine f_marca_impagados_notificados ()
end prototypes

public subroutine f_cargar (datawindow data);String filtro,agente,cob1,cob2
data.SetFilter(filtro)
data.Filter()
IF uo_agente.em_codigo.text <> "" Then
	agente = uo_agente.em_codigo.text
	IF cobrado.text = "Todos" Then
			cob1 = "S"
			cob2 = "N"
	ELSE
		cob1 = "S"
		cob2 = "S"
	END IF
	if f_comision_fija_agente(codigo_empresa,agente) = "S" then
		data.modify("datawindow.detail.height = 152")
	else
		data.modify("datawindow.detail.height = 72")
	end if
	data.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),agente,cob1,cob2, datetime(date(em_factura_fechadesde.text)), datetime(date(em_factura_fechahasta.text)))	
else
	data.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),'%',cob1,cob2, datetime(date(em_factura_fechadesde.text)), datetime(date(em_factura_fechahasta.text)))
END IF


end subroutine

public subroutine f_marca_impagados_notificados ();boolean bien = true
string  agente

agente = uo_agente.em_codigo.text

update carefectos
set    devuelto_notificado_agente = "S"
where  empresa   = :codigo_empresa
and    agente1   = :agente
and    situacion = "2"
and    gasto    <> "S"
and    devuelto_notificado_agente <> "S";

if sqlca.sqlcode <> 0 then
	bien = false
end if

update carefectos
set    devuelto_notificado_agente2 = "S"
where  empresa   = :codigo_empresa
and    agente2   = :agente
and    situacion = "2"
and    gasto    <> "S"
and    devuelto_notificado_agente2 <> "S";

if sqlca.sqlcode <> 0 then
	bien = false
end if

update carefectos
set    devuelto_notificado_agente3 = "S"
where  empresa   = :codigo_empresa
and    agente3   = :agente
and    situacion = "2"
and    gasto    <> "S"
and    devuelto_notificado_agente3 <> "S";

if sqlca.sqlcode <> 0 then
	bien = false
end if

if bien then
	commit;
else
	rollback;
	messagebox("Atención","Se ha producido un error al marcar los impagados como notificados.")
end if
end subroutine

on w_prev_liquidacion_agente.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.gb_2=create gb_2
this.gb_fecha=create gb_fecha
this.em_fechahasta=create em_fechahasta
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_4=create st_4
this.uo_agente=create uo_agente
this.em_fechadesde=create em_fechadesde
this.st_1=create st_1
this.cobrado=create cobrado
this.pb_imprimir_factura=create pb_imprimir_factura
this.st_2=create st_2
this.dw_factura=create dw_factura
this.dw_impagados_agente=create dw_impagados_agente
this.dw_listado=create dw_listado
this.pb_1=create pb_1
this.dw_1=create dw_1
this.em_factura_fechahasta=create em_factura_fechahasta
this.em_factura_fechadesde=create em_factura_fechadesde
this.st_3=create st_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_fecha
this.Control[iCurrent+4]=this.em_fechahasta
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.cb_2
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.uo_agente
this.Control[iCurrent+9]=this.em_fechadesde
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.cobrado
this.Control[iCurrent+12]=this.pb_imprimir_factura
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.dw_factura
this.Control[iCurrent+15]=this.dw_impagados_agente
this.Control[iCurrent+16]=this.dw_listado
this.Control[iCurrent+17]=this.pb_1
this.Control[iCurrent+18]=this.dw_1
this.Control[iCurrent+19]=this.em_factura_fechahasta
this.Control[iCurrent+20]=this.em_factura_fechadesde
this.Control[iCurrent+21]=this.st_3
this.Control[iCurrent+22]=this.gb_1
end on

on w_prev_liquidacion_agente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.gb_2)
destroy(this.gb_fecha)
destroy(this.em_fechahasta)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_4)
destroy(this.uo_agente)
destroy(this.em_fechadesde)
destroy(this.st_1)
destroy(this.cobrado)
destroy(this.pb_imprimir_factura)
destroy(this.st_2)
destroy(this.dw_factura)
destroy(this.dw_impagados_agente)
destroy(this.dw_listado)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.em_factura_fechahasta)
destroy(this.em_factura_fechadesde)
destroy(this.st_3)
destroy(this.gb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Prevision Liquidacion Agentes (Pendientes / No liquidadas)"
istr_parametros.s_listado        =   "report_conpromalb2"
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)
dw_factura.SetTransObject(SQLCA)
dw_impagados_agente.SetTransObject(SQLCA)
cobrado.text = "Todos"
em_fechadesde.text=string(MDY(01,01,Year(Today())))
em_fechahasta.text=string(today())

em_factura_fechadesde.text=string('01-01-01 00:00:00')
em_factura_fechahasta.text=string(today())

end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_prev_liquidacion_agente
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_prev_liquidacion_agente
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(em_fechahasta)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_prev_liquidacion_agente
integer x = 23
integer y = 16
integer width = 2240
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 24011603
long backcolor = 553648127
end type

type pb_imprimir from upb_imprimir within w_prev_liquidacion_agente
integer x = 3589
integer y = 192
integer taborder = 0
boolean originalsize = false
string picturename = "print!"
end type

event clicked;call super::clicked;
f_cargar(dw_listado)

f_imprimir_datawindow(dw_listado)
end event

type gb_2 from groupbox within w_prev_liquidacion_agente
integer x = 3154
integer y = 148
integer width = 329
integer height = 172
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_fecha from groupbox within w_prev_liquidacion_agente
integer x = 9
integer y = 160
integer width = 686
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Vencimiento"
end type

type em_fechahasta from u_em_campo within w_prev_liquidacion_agente
integer x = 393
integer y = 220
integer width = 274
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type cb_1 from commandbutton within w_prev_liquidacion_agente
integer x = 3168
integer y = 164
integer width = 302
integer height = 68
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;f_cargar(dw_1)
dw_1.Modify("DataWindow.detail.Height=73")
dw_1.Modify("DataWindow.trailer.1.Height=155")
dw_listado.Modify("DataWindow.detail.Height=73")
dw_listado.Modify("DataWindow.trailer.1.Height=155")

end event

type cb_2 from commandbutton within w_prev_liquidacion_agente
integer x = 3168
integer y = 236
integer width = 302
integer height = 68
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Resumen"
end type

event clicked;f_cargar(dw_1)
dw_1.Modify("DataWindow.detail.Height=0")
dw_1.Modify("DataWindow.trailer.1.Height=155")
dw_listado.Modify("DataWindow.detail.Height=0")
dw_listado.Modify("DataWindow.trailer.1.Height=155")

end event

type st_4 from statictext within w_prev_liquidacion_agente
integer x = 1632
integer y = 148
integer width = 1070
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "A  g  e  n  t  e"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_agente from u_em_campo_2 within w_prev_liquidacion_agente
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 1632
integer y = 220
integer width = 1477
integer height = 92
integer taborder = 50
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_agente.em_campo.text=f_nombre_venagentes(codigo_empresa,uo_agente.em_codigo.text)
IF Trim(uo_agente.em_campo.text)="" THEN 
 IF Trim(uo_agente.em_codigo.text)<>"" Then uo_agente.em_campo.SetFocus()
 uo_agente.em_campo.text=""
 uo_agente.em_codigo.text=""
END IF





end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de agentes"
ue_datawindow = "dw_ayuda_venagentes"
ue_filtro     = ""
IF tipo_vista= "Nacional"    Then   ue_filtro     = "nacional = 'S'"
IF tipo_vista= "Exportacion" Then   ue_filtro     = "nacional = 'N'"



end event

on uo_agente.destroy
call u_em_campo_2::destroy
end on

type em_fechadesde from u_em_campo within w_prev_liquidacion_agente
integer x = 32
integer y = 216
integer width = 293
integer taborder = 30
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_1 from statictext within w_prev_liquidacion_agente
integer x = 334
integer y = 224
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type cobrado from dropdownlistbox within w_prev_liquidacion_agente
boolean visible = false
integer x = 2638
integer y = 152
integer width = 375
integer height = 280
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean vscrollbar = true
string item[] = {"Cobrados","Todos"}
borderstyle borderstyle = stylelowered!
end type

type pb_imprimir_factura from upb_imprimir within w_prev_liquidacion_agente
event clicked pbm_bnclicked
boolean visible = false
integer x = 3415
integer y = 88
integer taborder = 20
boolean originalsize = false
string picturename = "print!"
end type

event clicked;long i,fila
string marca,naci
boolean alguno

alguno = false


if dw_1.rowcount() <= 0 then
	messagebox("Atención","No hay efectos o no se ha consultado")
	return
end if


f_mascara_columna(dw_factura,"basepts",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"comision",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"comisionpts",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"total",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"tot",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"iva",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"irpf",f_mascara_decimales(2))
f_mascara_columna(dw_factura,"base_imponible",f_mascara_decimales(2))


naci = f_nacional_agente(codigo_empresa,uo_agente.em_codigo.text)

if (naci = "") or isnull(naci) then naci = "S"

dw_factura.retrieve(codigo_empresa,datetime(date(em_fechadesde.text)),datetime(date(em_fechahasta.text)),uo_agente.em_codigo.text,naci)

for i = 1 to dw_1.rowcount()
	marca = dw_1.getitemstring(i,"punteado")
	if marca = "S" then
		alguno = true	
		fila = dw_factura.insertrow(0)
		
		dw_factura.setitem(fila,"factura",string(dw_1.getitemnumber(i,"factura")))
		dw_factura.setitem(fila,"ffactura",dw_1.getitemdatetime(i,"ffra"))
		dw_factura.setitem(fila,"razon",dw_1.getitemstring(i,"genter_razon"))
		dw_factura.setitem(fila,"basepts",dw_1.getitemnumber(i,"carcomisiones_baseliquipts"))
		dw_factura.setitem(fila,"basedivisas",dw_1.getitemstring(i,"basedivisas"))
		dw_factura.setitem(fila,"moneda",dw_1.getitemstring(i,"monedas_abreviado"))
		dw_factura.setitem(fila,"comision",dw_1.getitemnumber(i,"comision"))
		dw_factura.setitem(fila,"comisiondivisas",dw_1.getitemstring(i,"comisiondivisas"))
		dw_factura.setitem(fila,"comisionpts",dw_1.getitemnumber(i,"carcomisiones_comisionliquipts"))		
	end if
next

if alguno then
	f_imprimir_datawindow(dw_factura)
	if f_impagados_agente(codigo_empresa,uo_agente.em_codigo.text) <> 0 then
		if MessageBox("Agente con impagados","¿Desea imprimir los impagados de este agente?",Question!,YesNo!,1) = 1 then		 
			dw_impagados_agente.retrieve(codigo_empresa,uo_agente.em_codigo.text)
			f_imprimir_datawindow(dw_impagados_agente)
			if MessageBox("Agente con impagados","¿Desea marcar como notificados los impagados de este agente?",Question!,YesNo!,1) = 1 then		 
				f_marca_impagados_notificados()
			end if
		end if
	end if
else
	messagebox("Atención","No hay efectos seleccionados")
end if
end event

type st_2 from statictext within w_prev_liquidacion_agente
boolean visible = false
integer x = 3355
integer y = 32
integer width = 192
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Factura"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_factura from datawindow within w_prev_liquidacion_agente
boolean visible = false
integer x = 3287
integer y = 44
integer width = 46
integer height = 68
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_factura_agente"
boolean livescroll = true
end type

type dw_impagados_agente from datawindow within w_prev_liquidacion_agente
boolean visible = false
integer x = 3163
integer y = 164
integer width = 151
integer height = 132
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_impagados_agente"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_listado from datawindow within w_prev_liquidacion_agente
boolean visible = false
integer x = 3086
integer y = 48
integer width = 101
integer height = 84
string dataobject = "report_prev_liquidacion_agente2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type pb_1 from upb_salir within w_prev_liquidacion_agente
integer x = 3584
integer y = 24
integer width = 123
integer height = 108
integer taborder = 0
string picturename = "exit!"
end type

type dw_1 from datawindow within w_prev_liquidacion_agente
integer x = 14
integer y = 336
integer width = 3712
integer height = 1072
string dataobject = "dw_prev_liquidacion_agente"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;long i 

if dwo.name = "marcar" then
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,"punteado","S")		
	next
	setpointer(arrow!)
end if


if dwo.name = "desmarcar" then
	setpointer(hourglass!)
	for i = 1 to dw_1.rowcount()
		dw_1.setitem(i,"punteado","N")		
	next
	setpointer(arrow!)
end if
end event

type em_factura_fechahasta from u_em_campo within w_prev_liquidacion_agente
integer x = 1111
integer y = 220
integer width = 274
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type em_factura_fechadesde from u_em_campo within w_prev_liquidacion_agente
integer x = 750
integer y = 216
integer width = 293
integer taborder = 40
boolean bringtotop = true
integer textsize = -9
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = ""
end type

type st_3 from statictext within w_prev_liquidacion_agente
integer x = 1051
integer y = 224
integer width = 46
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_prev_liquidacion_agente
integer x = 727
integer y = 160
integer width = 686
integer height = 152
integer taborder = 70
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Factura"
end type

