$PBExportHeader$w_con_control_calidad.srw
forward
global type w_con_control_calidad from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_control_calidad
end type
type uo_proveedor from u_em_campo_2 within w_con_control_calidad
end type
type dw_listado from datawindow within w_con_control_calidad
end type
type pb_imprimir from upb_imprimir within w_con_control_calidad
end type
type em_anyo from u_em_campo within w_con_control_calidad
end type
type uo_mprima from u_em_campo_2 within w_con_control_calidad
end type
type gb_9 from groupbox within w_con_control_calidad
end type
type gb_8 from groupbox within w_con_control_calidad
end type
type gb_7 from groupbox within w_con_control_calidad
end type
type gb_2 from groupbox within w_con_control_calidad
end type
type cb_3 from commandbutton within w_con_control_calidad
end type
type gb_5 from groupbox within w_con_control_calidad
end type
type em_alb_desde from u_em_campo within w_con_control_calidad
end type
type st_1 from statictext within w_con_control_calidad
end type
type st_2 from statictext within w_con_control_calidad
end type
type em_alb_hasta from u_em_campo within w_con_control_calidad
end type
type gb_3 from groupbox within w_con_control_calidad
end type
type gb_4 from groupbox within w_con_control_calidad
end type
type gb_1 from groupbox within w_con_control_calidad
end type
type rb_1 from radiobutton within w_con_control_calidad
end type
type rb_2 from radiobutton within w_con_control_calidad
end type
type uo_prueba from u_em_campo_2 within w_con_control_calidad
end type
type dw_1 from datawindow within w_con_control_calidad
end type
type em_fecha_desde from u_em_campo within w_con_control_calidad
end type
type em_fecha_hasta from u_em_campo within w_con_control_calidad
end type
type st_3 from statictext within w_con_control_calidad
end type
type st_4 from statictext within w_con_control_calidad
end type
type gb_6 from groupbox within w_con_control_calidad
end type
type rb_3 from radiobutton within w_con_control_calidad
end type
end forward

shared variables
string pul='N'
end variables

global type w_con_control_calidad from w_int_con_empresa
integer x = 5
integer y = 288
integer width = 2935
integer height = 1720
string icon = "Application!"
pb_1 pb_1
uo_proveedor uo_proveedor
dw_listado dw_listado
pb_imprimir pb_imprimir
em_anyo em_anyo
uo_mprima uo_mprima
gb_9 gb_9
gb_8 gb_8
gb_7 gb_7
gb_2 gb_2
cb_3 cb_3
gb_5 gb_5
em_alb_desde em_alb_desde
st_1 st_1
st_2 st_2
em_alb_hasta em_alb_hasta
gb_3 gb_3
gb_4 gb_4
gb_1 gb_1
rb_1 rb_1
rb_2 rb_2
uo_prueba uo_prueba
dw_1 dw_1
em_fecha_desde em_fecha_desde
em_fecha_hasta em_fecha_hasta
st_3 st_3
st_4 st_4
gb_6 gb_6
rb_3 rb_3
end type
global w_con_control_calidad w_con_control_calidad

type variables
string where_castellano
end variables

forward prototypes
public function string f_filtro (datawindow data)
end prototypes

public function string f_filtro (datawindow data);string filtro,f[1 to 7]
string texto

data.SetTransObject(SQLCA)
texto=data.describe("DataWindow.Table.Select")

if em_alb_desde.text="" or isnull(em_alb_desde.text) then
	if em_alb_hasta.text="" or isnull(em_alb_hasta.text) then
		f[1]=""
	else
		f[1]="albaran <= '"+trim(em_alb_hasta.text)+"'" 
	end if
else
	if em_alb_hasta.text="" or isnull(em_alb_hasta.text) then
		f[1]="albaran >= '"+trim(em_alb_desde.text)+"'" 
	else
		f[1]="albaran >= '"+trim(em_alb_desde.text)+"' and albaran <= '"+trim(em_alb_hasta.text)+"'"
	end if
end if

if em_anyo.text="" or isnull(em_anyo.text) then
	f[2]=""
else
	f[2]="anyo = '" +trim(em_anyo.text)+"'" 
end if

if uo_proveedor.em_codigo.text="" or isnull(uo_proveedor.em_codigo.text) then
	f[3]=""
else
	f[3]="proveedor = '"+trim(uo_proveedor.em_codigo.text)+"'"
end if

if uo_mprima.em_codigo.text="" or isnull(uo_mprima.em_codigo.text) then
	f[4]=""
else
	f[4]="mprima = '"+trim(uo_mprima.em_codigo.text)+"'"
end if

if uo_prueba.em_codigo.text="" or isnull(uo_prueba.em_codigo.text) then
	f[5]=""
else
	f[5]="prueba = '"+trim(uo_prueba.em_codigo.text)+"'"
end if

if rb_1.Checked = false then
	if rb_2.Checked= false then 
		f[6]=""
	else
		f[6]="pasa = 'N'"
	end if
else
		f[6]="pasa = 'S'"
end if

f[7]="fecha >= '"+string(date(em_fecha_desde.text),"mm/dd/yy")+"' and fecha <= '"+string(date(em_fecha_hasta.text),"mm/dd/yy")+"'"

long i
filtro=""

for i=1 to 7
	if f[i]<>"" then
		if filtro<>"" then
			filtro=filtro+" and "+f[i]
		else
			filtro=f[i]
		end if
	end if
next

where_castellano=f_reemplazar(filtro,"and","y")
where_castellano=f_reemplazar(where_castellano,"pasa","resultado")
where_castellano=f_reemplazar(where_castellano,"mprima","producto")
where_castellano=f_reemplazar(where_castellano,"anyo","año")

if filtro="" then
	texto=texto
else
	texto=texto+" where "+filtro
end if

return texto
end function

event open;call super::open;istr_parametros.s_titulo_ventana="Confirmación de Albaranes"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
em_anyo.text=string(year(today()))
em_fecha_desde.text=string(datetime(date(year(today()),month(today()),1)))
em_fecha_hasta.text=string(datetime(today()))
f_activar_campo(uo_proveedor.em_campo)
end event

event ue_listar;dw_listado.dataobject="report_con_control_calidad"
dw_listado.modify("DataWindow.Table.Select=~""+f_filtro(dw_listado)+"~"")
dw_listado.Retrieve()
dw_listado.Object.texto.text=where_castellano
dw_report=dw_listado
CALL Super::ue_listar
end event

on w_con_control_calidad.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.uo_proveedor=create uo_proveedor
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.em_anyo=create em_anyo
this.uo_mprima=create uo_mprima
this.gb_9=create gb_9
this.gb_8=create gb_8
this.gb_7=create gb_7
this.gb_2=create gb_2
this.cb_3=create cb_3
this.gb_5=create gb_5
this.em_alb_desde=create em_alb_desde
this.st_1=create st_1
this.st_2=create st_2
this.em_alb_hasta=create em_alb_hasta
this.gb_3=create gb_3
this.gb_4=create gb_4
this.gb_1=create gb_1
this.rb_1=create rb_1
this.rb_2=create rb_2
this.uo_prueba=create uo_prueba
this.dw_1=create dw_1
this.em_fecha_desde=create em_fecha_desde
this.em_fecha_hasta=create em_fecha_hasta
this.st_3=create st_3
this.st_4=create st_4
this.gb_6=create gb_6
this.rb_3=create rb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.uo_proveedor
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.pb_imprimir
this.Control[iCurrent+5]=this.em_anyo
this.Control[iCurrent+6]=this.uo_mprima
this.Control[iCurrent+7]=this.gb_9
this.Control[iCurrent+8]=this.gb_8
this.Control[iCurrent+9]=this.gb_7
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.cb_3
this.Control[iCurrent+12]=this.gb_5
this.Control[iCurrent+13]=this.em_alb_desde
this.Control[iCurrent+14]=this.st_1
this.Control[iCurrent+15]=this.st_2
this.Control[iCurrent+16]=this.em_alb_hasta
this.Control[iCurrent+17]=this.gb_3
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.gb_1
this.Control[iCurrent+20]=this.rb_1
this.Control[iCurrent+21]=this.rb_2
this.Control[iCurrent+22]=this.uo_prueba
this.Control[iCurrent+23]=this.dw_1
this.Control[iCurrent+24]=this.em_fecha_desde
this.Control[iCurrent+25]=this.em_fecha_hasta
this.Control[iCurrent+26]=this.st_3
this.Control[iCurrent+27]=this.st_4
this.Control[iCurrent+28]=this.gb_6
this.Control[iCurrent+29]=this.rb_3
end on

on w_con_control_calidad.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.uo_proveedor)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.em_anyo)
destroy(this.uo_mprima)
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.gb_7)
destroy(this.gb_2)
destroy(this.cb_3)
destroy(this.gb_5)
destroy(this.em_alb_desde)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_alb_hasta)
destroy(this.gb_3)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.uo_prueba)
destroy(this.dw_1)
destroy(this.em_fecha_desde)
destroy(this.em_fecha_hasta)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.gb_6)
destroy(this.rb_3)
end on

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_control_calidad
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_control_calidad
end type

event sle_opcion_orden::getfocus;call super::getfocus;f_activar_campo(uo_proveedor.em_campo)
end event

type st_empresa from w_int_con_empresa`st_empresa within w_con_control_calidad
integer y = 8
integer width = 2679
end type

type pb_1 from upb_salir within w_con_control_calidad
integer x = 2770
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

type uo_proveedor from u_em_campo_2 within w_con_control_calidad
integer x = 1097
integer y = 372
integer width = 887
integer taborder = 80
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_nombre_proveedor(codigo_empresa,uo_proveedor.em_codigo.text)
IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
END IF


end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Proveedores"
ue_datawindow = "dw_ayuda_proveedores"
ue_filtro     = ""
valor_empresa = TRUE

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

type dw_listado from datawindow within w_con_control_calidad
boolean visible = false
integer x = 384
integer width = 443
integer height = 140
boolean bringtotop = true
string dataobject = "report_con_control_calidad"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_control_calidad
event clicked pbm_bnclicked
integer x = 2688
integer y = 176
integer taborder = 0
boolean bringtotop = true
end type

event clicked;call super::clicked;PArent.triggerevent("ue_listar")

end event

type em_anyo from u_em_campo within w_con_control_calidad
integer x = 73
integer y = 188
integer width = 224
integer taborder = 10
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

type uo_mprima from u_em_campo_2 within w_con_control_calidad
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1097
integer y = 188
integer width = 887
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_mprima.em_campo.text=f_nombre_mprima(codigo_empresa,uo_mprima.em_codigo.text)
If Trim(uo_mprima.em_campo.text)="" Then
	If Trim(uo_mprima.em_codigo.text)<>"" then uo_mprima.em_campo.SetFocus()
	uo_mprima.em_campo.text=""
	uo_mprima.em_codigo.text=""
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmprima2"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS POR PROVEEDOR"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_mprima.destroy
call u_em_campo_2::destroy
end on

type gb_9 from groupbox within w_con_control_calidad
integer x = 2633
integer y = 116
integer width = 224
integer height = 184
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_8 from groupbox within w_con_control_calidad
integer x = 2048
integer y = 120
integer width = 553
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Prueba"
end type

type gb_7 from groupbox within w_con_control_calidad
integer x = 2048
integer y = 304
integer width = 553
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Resultado"
end type

type gb_2 from groupbox within w_con_control_calidad
integer x = 1061
integer y = 120
integer width = 955
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Materia Prima"
end type

type cb_3 from commandbutton within w_con_control_calidad
integer x = 2647
integer y = 344
integer width = 197
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;dw_1.dataobject="dw_con_control_calidad"
dw_1.modify("DataWindow.Table.Select=~""+f_filtro(dw_1)+"~"")
dw_1.Retrieve()


end event

type gb_5 from groupbox within w_con_control_calidad
integer x = 2633
integer y = 300
integer width = 224
integer height = 184
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type em_alb_desde from u_em_campo within w_con_control_calidad
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 466
integer y = 188
integer width = 224
integer taborder = 20
boolean bringtotop = true
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comcabalb"
ue_titulo     =  "AYUDA SELECCION DE ALBARANES COMPRAS"
ue_filtro     =  "anyo = '"+em_anyo.text+"'"
valor_empresa = TRUE
end event

type st_1 from statictext within w_con_control_calidad
integer x = 366
integer y = 200
integer width = 96
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "De"
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_control_calidad
integer x = 709
integer y = 200
integer width = 50
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "a"
boolean focusrectangle = false
end type

type em_alb_hasta from u_em_campo within w_con_control_calidad
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 768
integer y = 188
integer width = 224
integer taborder = 30
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "######"
string displaydata = ""
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comcabalb"
ue_titulo     =  "AYUDA SELECCION DE ALBARANES COMPRAS"
ue_filtro     =  "anyo = '"+em_anyo.text+"'"
valor_empresa = TRUE
end event

type gb_3 from groupbox within w_con_control_calidad
integer x = 329
integer y = 120
integer width = 699
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Albarán"
end type

type gb_4 from groupbox within w_con_control_calidad
integer x = 37
integer y = 120
integer width = 302
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
end type

type gb_1 from groupbox within w_con_control_calidad
integer x = 1061
integer y = 304
integer width = 955
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Proveedor"
end type

type rb_1 from radiobutton within w_con_control_calidad
integer x = 2057
integer y = 372
integer width = 128
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Sí"
boolean automatic = false
boolean lefttext = true
end type

type rb_2 from radiobutton within w_con_control_calidad
integer x = 2194
integer y = 372
integer width = 142
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "No"
boolean automatic = false
boolean lefttext = true
end type

type uo_prueba from u_em_campo_2 within w_con_control_calidad
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 2085
integer y = 188
integer width = 485
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;//uo_prueba.em_campo.text=f_nombre_prueba(uo_prueba.em_codigo.text)
If Trim(uo_prueba.em_campo.text)="" Then
	If Trim(uo_prueba.em_codigo.text)<>"" then uo_prueba.em_campo.SetFocus()
	uo_prueba.em_campo.text=""
	uo_prueba.em_codigo.text=""
end if

end event

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_propruebas"
ue_titulo     =  "AYUDA SELECCION DE PRUEBAS"
ue_filtro     =  ""
valor_empresa = TRUE
end event

on uo_prueba.destroy
call u_em_campo_2::destroy
end on

type dw_1 from datawindow within w_con_control_calidad
integer x = 32
integer y = 512
integer width = 2821
integer height = 980
string dataobject = "dw_con_control_calidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type em_fecha_desde from u_em_campo within w_con_control_calidad
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 251
integer y = 372
integer width = 279
integer taborder = 60
boolean bringtotop = true
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
string displaydata = "~b"
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comcabalb"
ue_titulo     =  "AYUDA SELECCION DE ALBARANES COMPRAS"
ue_filtro     =  "anyo = '"+em_anyo.text+"'"
valor_empresa = TRUE
end event

type em_fecha_hasta from u_em_campo within w_con_control_calidad
event getfocus pbm_ensetfocus
event losefocus pbm_enkillfocus
event modificado pbm_custom02
integer x = 713
integer y = 372
integer width = 279
integer taborder = 70
string facename = "Arial"
alignment alignment = right!
maskdatatype maskdatatype = datetimemask!
string mask = "dd-mm-yy"
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_comcabalb"
ue_titulo     =  "AYUDA SELECCION DE ALBARANES COMPRAS"
ue_filtro     =  "anyo = '"+em_anyo.text+"'"
valor_empresa = TRUE
end event

type st_3 from statictext within w_con_control_calidad
integer x = 55
integer y = 384
integer width = 183
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Desde"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_control_calidad
integer x = 549
integer y = 384
integer width = 151
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "hasta"
alignment alignment = right!
boolean focusrectangle = false
end type

type gb_6 from groupbox within w_con_control_calidad
integer x = 37
integer y = 304
integer width = 992
integer height = 180
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Fecha"
end type

type rb_3 from radiobutton within w_con_control_calidad
integer x = 2345
integer y = 372
integer width = 238
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
boolean checked = true
boolean automatic = false
boolean lefttext = true
end type

