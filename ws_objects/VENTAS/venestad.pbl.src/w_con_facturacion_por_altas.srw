$PBExportHeader$w_con_facturacion_por_altas.srw
forward
global type w_con_facturacion_por_altas from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_facturacion_por_altas
end type
type pb_2 from upb_imprimir within w_con_facturacion_por_altas
end type
type cb_1 from commandbutton within w_con_facturacion_por_altas
end type
type dw_resumen from datawindow within w_con_facturacion_por_altas
end type
type uo_cliente from u_em_campo_2 within w_con_facturacion_por_altas
end type
type uo_g1 from u_em_campo_2 within w_con_facturacion_por_altas
end type
type uo_g2 from u_em_campo_2 within w_con_facturacion_por_altas
end type
type uo_g3 from u_em_campo_2 within w_con_facturacion_por_altas
end type
type uo_g4 from u_em_campo_2 within w_con_facturacion_por_altas
end type
type ddlb_pt from dropdownlistbox within w_con_facturacion_por_altas
end type
type ddlb_nc from dropdownlistbox within w_con_facturacion_por_altas
end type
type ddlb_av from dropdownlistbox within w_con_facturacion_por_altas
end type
type uo_ct from u_em_campo_2 within w_con_facturacion_por_altas
end type
type ddlb_n from dropdownlistbox within w_con_facturacion_por_altas
end type
type st_3 from statictext within w_con_facturacion_por_altas
end type
type st_4 from statictext within w_con_facturacion_por_altas
end type
type st_1 from statictext within w_con_facturacion_por_altas
end type
type st_2 from statictext within w_con_facturacion_por_altas
end type
type sle_desde from singlelineedit within w_con_facturacion_por_altas
end type
type sle_hasta from singlelineedit within w_con_facturacion_por_altas
end type
type uo_rl from u_em_campo_2 within w_con_facturacion_por_altas
end type
type uo_agente from u_em_campo_2 within w_con_facturacion_por_altas
end type
type gb_4 from groupbox within w_con_facturacion_por_altas
end type
type gb_125 from groupbox within w_con_facturacion_por_altas
end type
type gb_18 from groupbox within w_con_facturacion_por_altas
end type
type gb_16 from groupbox within w_con_facturacion_por_altas
end type
type gb_13 from groupbox within w_con_facturacion_por_altas
end type
type gb_11 from groupbox within w_con_facturacion_por_altas
end type
type gb_10 from groupbox within w_con_facturacion_por_altas
end type
type gb_9 from groupbox within w_con_facturacion_por_altas
end type
type gb_7 from groupbox within w_con_facturacion_por_altas
end type
type gb_1 from groupbox within w_con_facturacion_por_altas
end type
type gb_2 from groupbox within w_con_facturacion_por_altas
end type
type gb_3 from groupbox within w_con_facturacion_por_altas
end type
end forward

global type w_con_facturacion_por_altas from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5609
integer height = 3144
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
dw_resumen dw_resumen
uo_cliente uo_cliente
uo_g1 uo_g1
uo_g2 uo_g2
uo_g3 uo_g3
uo_g4 uo_g4
ddlb_pt ddlb_pt
ddlb_nc ddlb_nc
ddlb_av ddlb_av
uo_ct uo_ct
ddlb_n ddlb_n
st_3 st_3
st_4 st_4
st_1 st_1
st_2 st_2
sle_desde sle_desde
sle_hasta sle_hasta
uo_rl uo_rl
uo_agente uo_agente
gb_4 gb_4
gb_125 gb_125
gb_18 gb_18
gb_16 gb_16
gb_13 gb_13
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_7 gb_7
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_con_facturacion_por_altas w_con_facturacion_por_altas

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, codestadistico, v_agente
string g1, g2, g3, g4, pt, nc, rect, av, pl, ct, tm, n
int desde, hasta

if not isnull (uo_cliente.em_codigo.text) and uo_cliente.em_codigo.text <> ''then
	v_cliente = uo_cliente.em_codigo.text
else
	v_cliente = "%"
end if

if not isnull (uo_agente.em_codigo.text) and uo_agente.em_codigo.text <> '' then
	v_agente = uo_agente.em_codigo.text
else
	v_agente = "%"
end if


data.SetTransObject(SQLCA)
data.Reset()

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22


if uo_g1.em_campo.text <> "" and not isnull(uo_g1.em_campo.text) then
	g1 = uo_g1.em_campo.text
	codestadistico = codestadistico + "   G1: "+uo_g1.em_campo.text
else
	g1 = '%' // Codición que siempre se cumplirá
end if
if uo_g2.em_campo.text <> "" and not isnull(uo_g2.em_campo.text) then
	g2 = uo_g2.em_campo.text
	codestadistico = codestadistico + "   G2: "+uo_g2.em_campo.text
else
	g2 = '%' // Codición que siempre se cumplirá
end if
if uo_g3.em_campo.text <> "" and not isnull(uo_g3.em_campo.text) then
	g3 = uo_g3.em_campo.text
	codestadistico = codestadistico + "   G3: "+uo_g3.em_campo.text
else
	g3 = '%' // Codición que siempre se cumplirá
end if
if uo_g4.em_campo.text <> "" and not isnull(uo_g4.em_campo.text) then
	g4 = uo_g4.em_campo.text
	codestadistico = codestadistico + "   G4: "+uo_g4.em_campo.text
else
	g4 = '%' // Codición que siempre se cumplirá
end if
if (ddlb_pt.text = "Todo" or ddlb_pt.text = "" ) then
	pt = '%' // Codición que siempre se cumplirá
else
	pt = ddlb_pt.text
	codestadistico = codestadistico + "   PT: "+ddlb_pt.text
	
end if

if (ddlb_nc.text = "Todo" or ddlb_nc.text = "" ) then
	nc = '%' // Codición que siempre se cumplirá
else
	nc = ddlb_nc.text
	codestadistico = codestadistico + "   NC: "+ddlb_nc.text	
end if

if (ddlb_av.text = "Todo" or ddlb_av.text = "" ) then
	av = '%' // Codición que siempre se cumplirá
else
	av = ddlb_av.text
	codestadistico = codestadistico + "   AV: "+ddlb_av.text
end if
if uo_ct.em_campo.text <> "" and not isnull(uo_ct.em_campo.text) then
	ct = uo_ct.em_campo.text
	codestadistico = codestadistico + "   CT: "+uo_ct.em_campo.text
else
	ct = '%' // Codición que siempre se cumplirá
end if
if uo_rl.em_campo.text <> "" and not isnull(uo_rl.em_campo.text) then
	tm = uo_rl.em_codigo.text
	codestadistico = codestadistico + "   RL: "+uo_rl.em_campo.text
else
	tm = '%' // Codición que siempre se cumplirá
end if
if (ddlb_n.text = "Todo" or ddlb_n.text = "" ) then
	n = '%' // Codición que siempre se cumplirá
else
	n = ddlb_n.text
	codestadistico = codestadistico + "   N: "+ddlb_n.text
end if

//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22
//@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@22

if isnull(sle_desde.text) or sle_desde.text = "" then 
	sle_desde.text = "2001"
elseif long(sle_desde.text) <= 0 then
	sle_desde.text = "2001"
end if

if isnull(sle_hasta.text) or sle_hasta.text = "" then 
	sle_hasta.text = String(year(today()) + 1)
elseif long(sle_hasta.text) <= 0 then
	sle_hasta.text = String(year(today()) + 1)
end if

desde = long(sle_desde.text)
hasta = long(sle_hasta.text)

data.Retrieve(codigo_empresa, v_cliente, v_agente, g1, g2, g3, g4, pt, nc, av, ct, tm, n, desde, hasta)

dw_resumen.object.t_cliente.text = uo_cliente.em_campo.text



end subroutine

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Facturación por años y fecha de alta del artículo."
This.title=istr_parametros.s_titulo_ventana

sle_desde.text = "2001"
sle_hasta.text = String(year(today()) + 1)

//em_anyo.text = string (year(today()))
end event

on w_con_facturacion_por_altas.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.dw_resumen=create dw_resumen
this.uo_cliente=create uo_cliente
this.uo_g1=create uo_g1
this.uo_g2=create uo_g2
this.uo_g3=create uo_g3
this.uo_g4=create uo_g4
this.ddlb_pt=create ddlb_pt
this.ddlb_nc=create ddlb_nc
this.ddlb_av=create ddlb_av
this.uo_ct=create uo_ct
this.ddlb_n=create ddlb_n
this.st_3=create st_3
this.st_4=create st_4
this.st_1=create st_1
this.st_2=create st_2
this.sle_desde=create sle_desde
this.sle_hasta=create sle_hasta
this.uo_rl=create uo_rl
this.uo_agente=create uo_agente
this.gb_4=create gb_4
this.gb_125=create gb_125
this.gb_18=create gb_18
this.gb_16=create gb_16
this.gb_13=create gb_13
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_7=create gb_7
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_resumen
this.Control[iCurrent+5]=this.uo_cliente
this.Control[iCurrent+6]=this.uo_g1
this.Control[iCurrent+7]=this.uo_g2
this.Control[iCurrent+8]=this.uo_g3
this.Control[iCurrent+9]=this.uo_g4
this.Control[iCurrent+10]=this.ddlb_pt
this.Control[iCurrent+11]=this.ddlb_nc
this.Control[iCurrent+12]=this.ddlb_av
this.Control[iCurrent+13]=this.uo_ct
this.Control[iCurrent+14]=this.ddlb_n
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.st_4
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.sle_desde
this.Control[iCurrent+20]=this.sle_hasta
this.Control[iCurrent+21]=this.uo_rl
this.Control[iCurrent+22]=this.uo_agente
this.Control[iCurrent+23]=this.gb_4
this.Control[iCurrent+24]=this.gb_125
this.Control[iCurrent+25]=this.gb_18
this.Control[iCurrent+26]=this.gb_16
this.Control[iCurrent+27]=this.gb_13
this.Control[iCurrent+28]=this.gb_11
this.Control[iCurrent+29]=this.gb_10
this.Control[iCurrent+30]=this.gb_9
this.Control[iCurrent+31]=this.gb_7
this.Control[iCurrent+32]=this.gb_1
this.Control[iCurrent+33]=this.gb_2
this.Control[iCurrent+34]=this.gb_3
end on

on w_con_facturacion_por_altas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.dw_resumen)
destroy(this.uo_cliente)
destroy(this.uo_g1)
destroy(this.uo_g2)
destroy(this.uo_g3)
destroy(this.uo_g4)
destroy(this.ddlb_pt)
destroy(this.ddlb_nc)
destroy(this.ddlb_av)
destroy(this.uo_ct)
destroy(this.ddlb_n)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_desde)
destroy(this.sle_hasta)
destroy(this.uo_rl)
destroy(this.uo_agente)
destroy(this.gb_4)
destroy(this.gb_125)
destroy(this.gb_18)
destroy(this.gb_16)
destroy(this.gb_13)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_7)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_facturacion_por_altas
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_facturacion_por_altas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_facturacion_por_altas
integer x = 41
integer y = 16
integer width = 4201
integer height = 88
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 24011603
long backcolor = 12632256
end type

type pb_1 from upb_salir within w_con_facturacion_por_altas
integer x = 5408
integer y = 12
integer width = 119
integer height = 100
integer taborder = 0
string picturename = "C:\Tencer_PB12\Log Out_24x24.png"
end type

type pb_2 from upb_imprimir within w_con_facturacion_por_altas
integer x = 5403
integer y = 132
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_facturacion_por_altas
integer x = 5106
integer y = 132
integer width = 288
integer height = 104
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;	
	f_control(dw_resumen)
	

/*
if rb_pm.checked then
	f_control_pm(dw_detalle)
else
	f_control(dw_detalle)
end if
*/
end event

type dw_resumen from datawindow within w_con_facturacion_por_altas
integer x = 27
integer y = 420
integer width = 5509
integer height = 2364
integer taborder = 70
string dataobject = "dw_con_facturacion_por_altas_filtro_anyo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type uo_cliente from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 37
integer y = 144
integer width = 1573
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select razon
into :des_cliente
from genter
where empresa = :codigo_empresa
and codigo = :uo_cliente.em_codigo.text
and tipoter = 'C';

uo_cliente.em_campo.text = des_cliente

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Clientes"
ue_datawindow  = "dw_ayuda_clientes"
ue_filtro = ""
end event

type uo_g1 from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 1701
integer y = 148
integer width = 142
integer height = 68
integer taborder = 80
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g1.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g1.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo1
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g1.em_campo.text = descripcion
IF Trim(uo_g1.em_campo.text)="" THEN 
 IF Trim(uo_g1.em_codigo.text)<>"" Then uo_g1.em_campo.SetFocus()
 uo_g1.em_campo.text=""
 uo_g1.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G1"
ue_datawindow = "dw_ayuda_art_grupo1"
ue_filtro     = ""

end event

type uo_g2 from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 1865
integer y = 148
integer width = 169
integer height = 68
integer taborder = 90
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g2.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g2.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo2
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g2.em_campo.text = descripcion
IF Trim(uo_g2.em_campo.text)="" THEN 
 IF Trim(uo_g2.em_codigo.text)<>"" Then uo_g2.em_campo.SetFocus()
 uo_g2.em_campo.text=""
 uo_g2.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G2"
ue_datawindow = "dw_ayuda_art_grupo2"
ue_filtro     = ""

end event

type uo_g3 from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 2048
integer y = 148
integer width = 142
integer height = 68
integer taborder = 100
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g3.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g3.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo3
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g3.em_campo.text = descripcion
IF Trim(uo_g3.em_campo.text)="" THEN 
 IF Trim(uo_g3.em_codigo.text)<>"" Then uo_g3.em_campo.SetFocus()
 uo_g3.em_campo.text=""
 uo_g3.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G3"
ue_datawindow = "dw_ayuda_art_grupo3"
ue_filtro     = ""

end event

type uo_g4 from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 2213
integer y = 148
integer width = 142
integer height = 68
integer taborder = 110
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_g4.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_g4.em_codigo.text

select descripcion_abr
into :descripcion
from art_grupo4
where empresa = :codigo_empresa
and codigo = :codigo;

uo_g4.em_campo.text = descripcion
IF Trim(uo_g4.em_campo.text)="" THEN 
 IF Trim(uo_g4.em_codigo.text)<>"" Then uo_g4.em_campo.SetFocus()
 uo_g4.em_campo.text=""
 uo_g4.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de G4"
ue_datawindow = "dw_ayuda_art_grupo4"
ue_filtro     = ""

end event

type ddlb_pt from dropdownlistbox within w_con_facturacion_por_altas
integer x = 2377
integer y = 144
integer width = 224
integer height = 336
integer taborder = 150
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","R","B","P"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_nc from dropdownlistbox within w_con_facturacion_por_altas
integer x = 2638
integer y = 144
integer width = 224
integer height = 484
integer taborder = 160
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","0","1","2","3","4","5"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_av from dropdownlistbox within w_con_facturacion_por_altas
integer x = 2898
integer y = 144
integer width = 224
integer height = 420
integer taborder = 170
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","1","2","3","4","5"}
borderstyle borderstyle = stylelowered!
end type

type uo_ct from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 3163
integer y = 148
integer width = 142
integer height = 68
integer taborder = 120
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_ct.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_ct.em_codigo.text

select descripcion_abr
into :descripcion
from art_cortes
where empresa = :codigo_empresa
and codigo = :codigo;

uo_ct.em_campo.text = descripcion
IF Trim(uo_ct.em_campo.text)="" THEN 
 IF Trim(uo_ct.em_codigo.text)<>"" Then uo_ct.em_campo.SetFocus()
 uo_ct.em_campo.text=""
 uo_ct.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Cortes"
ue_datawindow = "dw_ayuda_art_cortes"
ue_filtro     = ""

end event

type ddlb_n from dropdownlistbox within w_con_facturacion_por_altas
integer x = 3758
integer y = 148
integer width = 279
integer height = 332
integer taborder = 150
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","S","N"}
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_con_facturacion_por_altas
integer x = 46
integer y = 2812
integer width = 1349
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "No incluye facturas ajenas a la activdad."
boolean focusrectangle = false
end type

type st_4 from statictext within w_con_facturacion_por_altas
integer x = 46
integer y = 2860
integer width = 1275
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388736
long backcolor = 12632256
string text = "Incluye todos los dtos excepto rappel y dtopp."
boolean focusrectangle = false
end type

type st_1 from statictext within w_con_facturacion_por_altas
integer x = 4087
integer y = 148
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Desde:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_facturacion_por_altas
integer x = 4571
integer y = 152
integer width = 247
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Hasta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_desde from singlelineedit within w_con_facturacion_por_altas
integer x = 4347
integer y = 144
integer width = 206
integer height = 76
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type sle_hasta from singlelineedit within w_con_facturacion_por_altas
integer x = 4832
integer y = 144
integer width = 206
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean border = false
end type

type uo_rl from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 3360
integer y = 148
integer width = 357
integer height = 68
integer taborder = 200
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_rl.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_rl.em_codigo.text

select descripcion
into :descripcion
from art_tipomoldura
where empresa = :codigo_empresa
and codigo = :codigo;

uo_rl.em_campo.text = descripcion
IF Trim(uo_rl.em_campo.text)="" THEN 
 IF Trim(uo_rl.em_codigo.text)<>"" Then uo_rl.em_campo.SetFocus()
 uo_rl.em_campo.text=""
 uo_rl.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Relieve"
ue_datawindow = "dw_ayuda_art_tipomoldura"
ue_filtro     = ""

end event

type uo_agente from u_em_campo_2 within w_con_facturacion_por_altas
event destroy ( )
integer x = 41
integer y = 288
integer width = 1573
integer height = 80
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_agente.destroy
call u_em_campo_2::destroy
end on

event modificado;string des_cliente

select nombre
into :des_cliente
from venagentes
where empresa = :codigo_empresa
and agente = :uo_agente.em_codigo.text;

uo_agente.em_campo.text = des_cliente

If Trim(uo_agente.em_campo.text)="" then
	uo_agente.em_campo.text=""
	uo_agente.em_codigo.text=""
	Return
end if 


end event

event getfocus;ue_titulo = "Selección de Agente"
ue_datawindow  = "dw_ayuda_venagentes"
ue_filtro = ""
end event

type gb_4 from groupbox within w_con_facturacion_por_altas
integer x = 18
integer y = 100
integer width = 1614
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Cliente"
end type

type gb_125 from groupbox within w_con_facturacion_por_altas
integer x = 3744
integer y = 100
integer width = 302
integer height = 140
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "B. Cliente"
end type

type gb_18 from groupbox within w_con_facturacion_por_altas
integer x = 3150
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "CT"
end type

type gb_16 from groupbox within w_con_facturacion_por_altas
integer x = 2885
integer y = 100
integer width = 256
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "AV"
end type

type gb_13 from groupbox within w_con_facturacion_por_altas
integer x = 2624
integer y = 100
integer width = 256
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "NC"
end type

type gb_11 from groupbox within w_con_facturacion_por_altas
integer x = 2363
integer y = 100
integer width = 256
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "PT"
end type

type gb_10 from groupbox within w_con_facturacion_por_altas
integer x = 2199
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G4"
end type

type gb_9 from groupbox within w_con_facturacion_por_altas
integer x = 2034
integer y = 100
integer width = 174
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G3"
end type

type gb_7 from groupbox within w_con_facturacion_por_altas
integer x = 1847
integer y = 100
integer width = 197
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G2"
end type

type gb_1 from groupbox within w_con_facturacion_por_altas
integer x = 1687
integer y = 100
integer width = 169
integer height = 140
integer taborder = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "G1"
end type

type gb_2 from groupbox within w_con_facturacion_por_altas
integer x = 3328
integer y = 100
integer width = 411
integer height = 140
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Relieve"
end type

type gb_3 from groupbox within w_con_facturacion_por_altas
integer x = 23
integer y = 244
integer width = 1614
integer height = 144
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Agente"
end type

