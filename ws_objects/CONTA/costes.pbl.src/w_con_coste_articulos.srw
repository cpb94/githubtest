$PBExportHeader$w_con_coste_articulos.srw
$PBExportComments$Consulta del coste de un artículo
forward
global type w_con_coste_articulos from w_int_con_empresa
end type
type gb_125 from groupbox within w_con_coste_articulos
end type
type gb_90 from groupbox within w_con_coste_articulos
end type
type gb_21 from groupbox within w_con_coste_articulos
end type
type gb_20 from groupbox within w_con_coste_articulos
end type
type gb_19 from groupbox within w_con_coste_articulos
end type
type gb_18 from groupbox within w_con_coste_articulos
end type
type gb_17 from groupbox within w_con_coste_articulos
end type
type gb_16 from groupbox within w_con_coste_articulos
end type
type gb_15 from groupbox within w_con_coste_articulos
end type
type gb_14 from groupbox within w_con_coste_articulos
end type
type gb_13 from groupbox within w_con_coste_articulos
end type
type gb_12 from groupbox within w_con_coste_articulos
end type
type gb_11 from groupbox within w_con_coste_articulos
end type
type gb_10 from groupbox within w_con_coste_articulos
end type
type gb_9 from groupbox within w_con_coste_articulos
end type
type gb_7 from groupbox within w_con_coste_articulos
end type
type gb_6 from groupbox within w_con_coste_articulos
end type
type gb_4 from groupbox within w_con_coste_articulos
end type
type gb_8 from groupbox within w_con_coste_articulos
end type
type pb_imprimir from upb_imprimir within w_con_coste_articulos
end type
type gb_1 from groupbox within w_con_coste_articulos
end type
type dw_1 from datawindow within w_con_coste_articulos
end type
type gb_3 from groupbox within w_con_coste_articulos
end type
type cb_1 from u_boton within w_con_coste_articulos
end type
type cbx_1 from checkbox within w_con_coste_articulos
end type
type cbx_2 from checkbox within w_con_coste_articulos
end type
type uo_manejo from u_manejo_datawindow within w_con_coste_articulos
end type
type pb_1 from upb_salir within w_con_coste_articulos
end type
type gb_5 from groupbox within w_con_coste_articulos
end type
type uo_articulo from u_em_campo_2 within w_con_coste_articulos
end type
type uo_formato from u_em_campo_2 within w_con_coste_articulos
end type
type uo_cliente from u_em_campo_2 within w_con_coste_articulos
end type
type r_1 from rectangle within w_con_coste_articulos
end type
type st_total from statictext within w_con_coste_articulos
end type
type uo_g1 from u_em_campo_2 within w_con_coste_articulos
end type
type uo_g2 from u_em_campo_2 within w_con_coste_articulos
end type
type uo_g3 from u_em_campo_2 within w_con_coste_articulos
end type
type uo_g4 from u_em_campo_2 within w_con_coste_articulos
end type
type ddlb_pt from dropdownlistbox within w_con_coste_articulos
end type
type em_fdesde from u_em_campo within w_con_coste_articulos
end type
type em_fhasta from u_em_campo within w_con_coste_articulos
end type
type ddlb_gd from dropdownlistbox within w_con_coste_articulos
end type
type ddlb_nc from dropdownlistbox within w_con_coste_articulos
end type
type ddlb_re from dropdownlistbox within w_con_coste_articulos
end type
type ddlb_ee from dropdownlistbox within w_con_coste_articulos
end type
type ddlb_av from dropdownlistbox within w_con_coste_articulos
end type
type ddlb_pl from dropdownlistbox within w_con_coste_articulos
end type
type uo_ct from u_em_campo_2 within w_con_coste_articulos
end type
type uo_en from u_em_campo_2 within w_con_coste_articulos
end type
type uo_rl from u_em_campo_2 within w_con_coste_articulos
end type
type uo_otr from u_em_campo_2 within w_con_coste_articulos
end type
type ddlb_global from dropdownlistbox within w_con_coste_articulos
end type
type ddlb_n from dropdownlistbox within w_con_coste_articulos
end type
end forward

global type w_con_coste_articulos from w_int_con_empresa
integer width = 3534
integer height = 2124
string title = "Consumo de bases"
gb_125 gb_125
gb_90 gb_90
gb_21 gb_21
gb_20 gb_20
gb_19 gb_19
gb_18 gb_18
gb_17 gb_17
gb_16 gb_16
gb_15 gb_15
gb_14 gb_14
gb_13 gb_13
gb_12 gb_12
gb_11 gb_11
gb_10 gb_10
gb_9 gb_9
gb_7 gb_7
gb_6 gb_6
gb_4 gb_4
gb_8 gb_8
pb_imprimir pb_imprimir
gb_1 gb_1
dw_1 dw_1
gb_3 gb_3
cb_1 cb_1
cbx_1 cbx_1
cbx_2 cbx_2
uo_manejo uo_manejo
pb_1 pb_1
gb_5 gb_5
uo_articulo uo_articulo
uo_formato uo_formato
uo_cliente uo_cliente
r_1 r_1
st_total st_total
uo_g1 uo_g1
uo_g2 uo_g2
uo_g3 uo_g3
uo_g4 uo_g4
ddlb_pt ddlb_pt
em_fdesde em_fdesde
em_fhasta em_fhasta
ddlb_gd ddlb_gd
ddlb_nc ddlb_nc
ddlb_re ddlb_re
ddlb_ee ddlb_ee
ddlb_av ddlb_av
ddlb_pl ddlb_pl
uo_ct uo_ct
uo_en uo_en
uo_rl uo_rl
uo_otr uo_otr
ddlb_global ddlb_global
ddlb_n ddlb_n
end type
global w_con_coste_articulos w_con_coste_articulos

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string filtro, seccion, linea, turno, articulo, formato
string restriccion_cliente, restriccion_g1, restriccion_g2, restriccion_g3, restriccion_g4
string restriccion_pt, restriccion_gd, restriccion_nc, restriccion_re, restriccion_ee, restriccion_n 
string restriccion_av, restriccion_pl, restriccion_ct, restriccion_en, restriccion_rl, restriccion_otr
string restriccion_global
datetime fecha1, fecha2
string general, codestadistico

dw_1.reset()
if cbx_2.checked then
	dw_1.Modify("DataWindow.Trailer.4.Height=0") 
	dw_1.Modify("DataWindow.Detail.Height=0") 
end if

fecha1 = datetime(date(em_fdesde.text))
fecha2 = datetime(date(em_fhasta.text))

dw_1.object.st_fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")

if uo_articulo.em_codigo.text = "" or isnull(uo_articulo.em_codigo.text) then
	articulo = "%"
else
	articulo = uo_articulo.em_codigo.text	
	general = general + "Articulo: "+uo_articulo.em_campo.text
end if

if uo_formato.em_codigo.text = "" or isnull(uo_formato.em_codigo.text) then
	formato = "%"
else
	formato = uo_formato.em_codigo.text
	general = general + "   Formato: "+uo_formato.em_campo.text
end if

if uo_cliente.em_campo.text <> "" and not isnull(uo_cliente.em_campo.text) then
	restriccion_cliente = "(articulos_cliente = '"+uo_cliente.em_codigo.text+"')"
	general = general + "   Cliente: "+uo_cliente.em_campo.text	
else
	restriccion_cliente = '1=1' // Codición que siempre se cumplirá
end if

if uo_g1.em_campo.text <> "" and not isnull(uo_g1.em_campo.text) then
	restriccion_g1 = "(art_codestadistico_g1 = '"+uo_g1.em_campo.text+"')"
	codestadistico = codestadistico + "   G1: "+uo_g1.em_campo.text
else
	restriccion_g1 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g2.em_campo.text <> "" and not isnull(uo_g2.em_campo.text) then
	restriccion_g2 = "(art_codestadistico_g2 = '"+uo_g2.em_campo.text+"')"
	codestadistico = codestadistico + "   G2: "+uo_g2.em_campo.text	
else
	restriccion_g2 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g3.em_campo.text <> "" and not isnull(uo_g3.em_campo.text) then
	restriccion_g3 = "(art_codestadistico_g3 = '"+uo_g3.em_campo.text+"')"
	codestadistico = codestadistico + "   G3: "+uo_g3.em_campo.text
else
	restriccion_g3 = '1=1' // Codición que siempre se cumplirá
end if

if uo_g4.em_campo.text <> "" and not isnull(uo_g4.em_campo.text) then
	restriccion_g4 = "(art_codestadistico_g4 = '"+uo_g4.em_campo.text+"')"
	codestadistico = codestadistico + "   G4: "+uo_g4.em_campo.text
else
	restriccion_g4 = '1=1' // Codición que siempre se cumplirá
end if

choose case ddlb_global.text
	case "Todo"
		restriccion_global = '1=1' 
		general = general + "   Todo "
	case ""
		restriccion_global = '1=1' 
		general = general + "   Todo "
	case "Acabado"
		restriccion_global = " (art_codestadistico_g2 <> 'N')  and (art_codestadistico_g2 <> 'B') and (art_codestadistico_g2 <> 'Z') "
		general = general + "   Acabado "
	case "Intermedio"
		restriccion_global = " ((art_codestadistico_g2 = 'N') or (art_codestadistico_g2 = 'B') or (art_codestadistico_g2 = 'Z')) "
		general = general + "   Intermedio "
end choose 
		
if (ddlb_pt.text = "Todo" or ddlb_pt.text = "" ) then
	restriccion_pt = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pt = "(art_codestadistico_pt = '"+ddlb_pt.text+"')"
	codestadistico = codestadistico + "   PT: "+ddlb_pt.text
	
end if

if (ddlb_gd.text = "Todo" or ddlb_gd.text = "" ) then
	restriccion_gd = '1=1' // Codición que siempre se cumplirá
else
	restriccion_gd = "(art_codestadistico_gd = '"+ddlb_gd.text+"')"
	codestadistico = codestadistico + "   GD: "+ddlb_gd.text	
end if

if (ddlb_nc.text = "Todo" or ddlb_nc.text = "" ) then
	restriccion_nc = '1=1' // Codición que siempre se cumplirá
else
	restriccion_nc = "(art_codestadistico_nc = '"+ddlb_nc.text+"')"
	codestadistico = codestadistico + "   NC: "+ddlb_nc.text	
end if

if (ddlb_re.text = "Todo" or ddlb_re.text = "" ) then
	restriccion_re = '1=1' // Codición que siempre se cumplirá
else
	restriccion_re = "(art_codestadistico_re = '"+ddlb_re.text+"')"
	codestadistico = codestadistico + "   RE: "+ddlb_re.text
end if

if (ddlb_ee.text = "Todo" or ddlb_ee.text = "" ) then
	restriccion_ee = '1=1' // Codición que siempre se cumplirá
else
	restriccion_ee = "(art_codestadistico_ee = '"+ddlb_ee.text+"')"
	codestadistico = codestadistico + "   EE: "+ddlb_ee.text
end if

if (ddlb_av.text = "Todo" or ddlb_av.text = "" ) then
	restriccion_av = '1=1' // Codición que siempre se cumplirá
else
	restriccion_av = "(art_codestadistico_av = '"+ddlb_av.text+"')"
	codestadistico = codestadistico + "   AV: "+ddlb_av.text
end if

if (ddlb_pl.text = "Todo" or ddlb_pl.text = "" ) then
	restriccion_pl = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pl = "(art_codestadistico_pl = '"+ddlb_pl.text+"')"
	codestadistico = codestadistico + "   PL: "+ddlb_pl.text
end if

if (ddlb_n.text = "Todo" or ddlb_n.text = "" ) then
	restriccion_n = '1=1' // Codición que siempre se cumplirá
else
	restriccion_n = "(art_codestadistico_n = '"+ddlb_n.text+"')"
	codestadistico = codestadistico + "   N: "+ddlb_n.text
end if

if uo_ct.em_campo.text <> "" and not isnull(uo_ct.em_campo.text) then
	restriccion_ct = "(art_codestadistico_ct = '"+uo_ct.em_campo.text+"')"
	codestadistico = codestadistico + "   CT: "+uo_ct.em_campo.text
else
	restriccion_ct = '1=1' // Codición que siempre se cumplirá
end if

if uo_en.em_campo.text <> "" and not isnull(uo_en.em_campo.text) then
	restriccion_en = "(art_codestadistico_en = '"+uo_en.em_campo.text+"')"
	codestadistico = codestadistico + "   EN: "+uo_en.em_campo.text
else
	restriccion_en = '1=1' // Codición que siempre se cumplirá
end if

if uo_rl.em_campo.text <> "" and not isnull(uo_rl.em_campo.text) then
	restriccion_rl = "(art_codestadistico_tm = '"+uo_rl.em_campo.text+"')"
	codestadistico = codestadistico + "   RL: "+uo_rl.em_campo.text
else
	restriccion_rl = '1=1' // Codición que siempre se cumplirá
end if

if uo_otr.em_campo.text <> "" and not isnull(uo_otr.em_campo.text) then
	restriccion_otr = "(art_codestadistico_otr = '"+uo_otr.em_campo.text+"')"
	codestadistico = codestadistico + "   OTR: "+uo_otr.em_campo.text
else
	restriccion_otr = '1=1' // Codición que siempre se cumplirá
end if

dw_1.object.general.text = general
dw_1.object.codestadistico.text = codestadistico

filtro = ""
filtro = restriccion_cliente+" and "+ &
			restriccion_global+" and "+ &
			restriccion_g1+" and "+ &
			restriccion_g2+" and "+ &
			restriccion_g3+" and "+ &
			restriccion_g4+" and "+ &
			restriccion_pt+" and "+ &
			restriccion_gd+" and "+ &
			restriccion_nc+" and "+ &
			restriccion_re+" and "+ &
			restriccion_ee+" and "+ &
			restriccion_av+" and "+ &
			restriccion_pl+" and "+ &
			restriccion_ct+" and "+ &
			restriccion_en+" and "+ &
			restriccion_rl+" and "+ &
			restriccion_n+" and "+ &
			restriccion_otr
			
dw_1.SetFilter(filtro)
dw_1.Filter()
dw_1.Retrieve(codigo_empresa,fecha1, fecha2, articulo, formato)



if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if

end subroutine

on w_con_coste_articulos.create
int iCurrent
call super::create
this.gb_125=create gb_125
this.gb_90=create gb_90
this.gb_21=create gb_21
this.gb_20=create gb_20
this.gb_19=create gb_19
this.gb_18=create gb_18
this.gb_17=create gb_17
this.gb_16=create gb_16
this.gb_15=create gb_15
this.gb_14=create gb_14
this.gb_13=create gb_13
this.gb_12=create gb_12
this.gb_11=create gb_11
this.gb_10=create gb_10
this.gb_9=create gb_9
this.gb_7=create gb_7
this.gb_6=create gb_6
this.gb_4=create gb_4
this.gb_8=create gb_8
this.pb_imprimir=create pb_imprimir
this.gb_1=create gb_1
this.dw_1=create dw_1
this.gb_3=create gb_3
this.cb_1=create cb_1
this.cbx_1=create cbx_1
this.cbx_2=create cbx_2
this.uo_manejo=create uo_manejo
this.pb_1=create pb_1
this.gb_5=create gb_5
this.uo_articulo=create uo_articulo
this.uo_formato=create uo_formato
this.uo_cliente=create uo_cliente
this.r_1=create r_1
this.st_total=create st_total
this.uo_g1=create uo_g1
this.uo_g2=create uo_g2
this.uo_g3=create uo_g3
this.uo_g4=create uo_g4
this.ddlb_pt=create ddlb_pt
this.em_fdesde=create em_fdesde
this.em_fhasta=create em_fhasta
this.ddlb_gd=create ddlb_gd
this.ddlb_nc=create ddlb_nc
this.ddlb_re=create ddlb_re
this.ddlb_ee=create ddlb_ee
this.ddlb_av=create ddlb_av
this.ddlb_pl=create ddlb_pl
this.uo_ct=create uo_ct
this.uo_en=create uo_en
this.uo_rl=create uo_rl
this.uo_otr=create uo_otr
this.ddlb_global=create ddlb_global
this.ddlb_n=create ddlb_n
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_125
this.Control[iCurrent+2]=this.gb_90
this.Control[iCurrent+3]=this.gb_21
this.Control[iCurrent+4]=this.gb_20
this.Control[iCurrent+5]=this.gb_19
this.Control[iCurrent+6]=this.gb_18
this.Control[iCurrent+7]=this.gb_17
this.Control[iCurrent+8]=this.gb_16
this.Control[iCurrent+9]=this.gb_15
this.Control[iCurrent+10]=this.gb_14
this.Control[iCurrent+11]=this.gb_13
this.Control[iCurrent+12]=this.gb_12
this.Control[iCurrent+13]=this.gb_11
this.Control[iCurrent+14]=this.gb_10
this.Control[iCurrent+15]=this.gb_9
this.Control[iCurrent+16]=this.gb_7
this.Control[iCurrent+17]=this.gb_6
this.Control[iCurrent+18]=this.gb_4
this.Control[iCurrent+19]=this.gb_8
this.Control[iCurrent+20]=this.pb_imprimir
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.dw_1
this.Control[iCurrent+23]=this.gb_3
this.Control[iCurrent+24]=this.cb_1
this.Control[iCurrent+25]=this.cbx_1
this.Control[iCurrent+26]=this.cbx_2
this.Control[iCurrent+27]=this.uo_manejo
this.Control[iCurrent+28]=this.pb_1
this.Control[iCurrent+29]=this.gb_5
this.Control[iCurrent+30]=this.uo_articulo
this.Control[iCurrent+31]=this.uo_formato
this.Control[iCurrent+32]=this.uo_cliente
this.Control[iCurrent+33]=this.r_1
this.Control[iCurrent+34]=this.st_total
this.Control[iCurrent+35]=this.uo_g1
this.Control[iCurrent+36]=this.uo_g2
this.Control[iCurrent+37]=this.uo_g3
this.Control[iCurrent+38]=this.uo_g4
this.Control[iCurrent+39]=this.ddlb_pt
this.Control[iCurrent+40]=this.em_fdesde
this.Control[iCurrent+41]=this.em_fhasta
this.Control[iCurrent+42]=this.ddlb_gd
this.Control[iCurrent+43]=this.ddlb_nc
this.Control[iCurrent+44]=this.ddlb_re
this.Control[iCurrent+45]=this.ddlb_ee
this.Control[iCurrent+46]=this.ddlb_av
this.Control[iCurrent+47]=this.ddlb_pl
this.Control[iCurrent+48]=this.uo_ct
this.Control[iCurrent+49]=this.uo_en
this.Control[iCurrent+50]=this.uo_rl
this.Control[iCurrent+51]=this.uo_otr
this.Control[iCurrent+52]=this.ddlb_global
this.Control[iCurrent+53]=this.ddlb_n
end on

on w_con_coste_articulos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_125)
destroy(this.gb_90)
destroy(this.gb_21)
destroy(this.gb_20)
destroy(this.gb_19)
destroy(this.gb_18)
destroy(this.gb_17)
destroy(this.gb_16)
destroy(this.gb_15)
destroy(this.gb_14)
destroy(this.gb_13)
destroy(this.gb_12)
destroy(this.gb_11)
destroy(this.gb_10)
destroy(this.gb_9)
destroy(this.gb_7)
destroy(this.gb_6)
destroy(this.gb_4)
destroy(this.gb_8)
destroy(this.pb_imprimir)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.gb_3)
destroy(this.cb_1)
destroy(this.cbx_1)
destroy(this.cbx_2)
destroy(this.uo_manejo)
destroy(this.pb_1)
destroy(this.gb_5)
destroy(this.uo_articulo)
destroy(this.uo_formato)
destroy(this.uo_cliente)
destroy(this.r_1)
destroy(this.st_total)
destroy(this.uo_g1)
destroy(this.uo_g2)
destroy(this.uo_g3)
destroy(this.uo_g4)
destroy(this.ddlb_pt)
destroy(this.em_fdesde)
destroy(this.em_fhasta)
destroy(this.ddlb_gd)
destroy(this.ddlb_nc)
destroy(this.ddlb_re)
destroy(this.ddlb_ee)
destroy(this.ddlb_av)
destroy(this.ddlb_pl)
destroy(this.uo_ct)
destroy(this.uo_en)
destroy(this.uo_rl)
destroy(this.uo_otr)
destroy(this.ddlb_global)
destroy(this.ddlb_n)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Coste"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

uo_articulo.setfocus()

em_fhasta.text = string(today(), "dd-mm-yy")
em_fdesde.text = "01-01-01"

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(FocusRect!)




end event

event ue_pagina_abajo;call super::ue_pagina_abajo;uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;uo_manejo.triggerEvent("pagina_arriba")
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

event ue_listar;f_control(dw_1)


//string seccion, linea, turno, articulo
//datetime fecha1, fecha2
//
//fecha1 = datetime(date(em_fdesde.text))
//fecha2 = datetime(date(em_fhasta.text))
//dw_1.object.fechas.text = "Fecha: "+string(fecha1,"dd-mm-yy")+" / "+string(fecha2,"dd-mm-yy")
//
//seccion = "%"
//linea = "%"
//turno = "%"
//articulo = "%"
//
//dw_1.Retrieve(codigo_empresa,fecha1, fecha2, seccion, linea, turno, articulo)
//
//if dw_1.RowCount() = 0 then
//	messagebox("Atención","No hay datos")
//	return
//end if
//
dw_report =dw_1
Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_coste_articulos
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_coste_articulos
integer x = 3369
integer y = 284
integer width = 114
integer height = 76
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_coste_articulos
integer width = 3442
integer textsize = -8
boolean italic = true
end type

type gb_125 from groupbox within w_con_coste_articulos
integer x = 3099
integer y = 236
integer width = 256
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "N"
end type

type gb_90 from groupbox within w_con_coste_articulos
integer x = 1856
integer y = 72
integer width = 389
integer height = 140
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tipo Prod."
end type

type gb_21 from groupbox within w_con_coste_articulos
integer x = 2921
integer y = 236
integer width = 187
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "OTR"
end type

type gb_20 from groupbox within w_con_coste_articulos
integer x = 2757
integer y = 236
integer width = 174
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "RL"
end type

type gb_19 from groupbox within w_con_coste_articulos
integer x = 2592
integer y = 236
integer width = 174
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "EN"
end type

type gb_18 from groupbox within w_con_coste_articulos
integer x = 2427
integer y = 236
integer width = 174
integer height = 140
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

type gb_17 from groupbox within w_con_coste_articulos
integer x = 2181
integer y = 236
integer width = 256
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "PL"
end type

type gb_16 from groupbox within w_con_coste_articulos
integer x = 1934
integer y = 236
integer width = 256
integer height = 140
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

type gb_15 from groupbox within w_con_coste_articulos
integer x = 1687
integer y = 236
integer width = 256
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "EE"
end type

type gb_14 from groupbox within w_con_coste_articulos
integer x = 1440
integer y = 236
integer width = 256
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "RE"
end type

type gb_13 from groupbox within w_con_coste_articulos
integer x = 1193
integer y = 236
integer width = 256
integer height = 140
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

type gb_12 from groupbox within w_con_coste_articulos
integer x = 946
integer y = 236
integer width = 256
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "GD"
end type

type gb_11 from groupbox within w_con_coste_articulos
integer x = 699
integer y = 236
integer width = 256
integer height = 140
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

type gb_10 from groupbox within w_con_coste_articulos
integer x = 535
integer y = 236
integer width = 174
integer height = 140
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

type gb_9 from groupbox within w_con_coste_articulos
integer x = 370
integer y = 236
integer width = 174
integer height = 140
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

type gb_7 from groupbox within w_con_coste_articulos
integer x = 183
integer y = 236
integer width = 197
integer height = 140
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

type gb_6 from groupbox within w_con_coste_articulos
integer x = 23
integer y = 236
integer width = 169
integer height = 140
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

type gb_4 from groupbox within w_con_coste_articulos
integer x = 859
integer y = 72
integer width = 352
integer height = 140
integer taborder = 170
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cliente"
end type

type gb_8 from groupbox within w_con_coste_articulos
boolean visible = false
integer x = 1554
integer y = 92
integer width = 686
integer height = 148
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_imprimir from upb_imprimir within w_con_coste_articulos
event clicked pbm_bnclicked
integer x = 3127
integer y = 120
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type gb_1 from groupbox within w_con_coste_articulos
integer x = 1225
integer y = 72
integer width = 617
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type dw_1 from datawindow within w_con_coste_articulos
integer x = 32
integer y = 400
integer width = 3438
integer height = 1400
string dataobject = "dw_con_coste_articulos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//str_parametros lstr_param 
//  lstr_param.i_nargumentos=2
//  lstr_param.s_argumentos[1]="w_con_prodpartes_ot"
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemString(This.GetRow(),"codigo"))
//  OpenWithParm(w_int_prodpartes_ot,lstr_param)

end event

event retrieveend;st_total.text = ""
st_total.text = "Total: "+string(dw_1.Rowcount())
end event

event rowfocuschanged;This.SelectRow(0, FALSE)	
This.SelectRow ( currentrow, True )
	
	
	

end event

type gb_3 from groupbox within w_con_coste_articulos
integer x = 503
integer y = 72
integer width = 352
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Formato"
end type

type cb_1 from u_boton within w_con_coste_articulos
integer x = 2281
integer y = 112
integer width = 315
integer height = 104
integer taborder = 220
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type cbx_1 from checkbox within w_con_coste_articulos
boolean visible = false
integer x = 1929
integer y = 152
integer width = 256
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Detalle"
boolean checked = true
boolean lefttext = true
end type

event clicked;if cbx_1.checked = true then
	cbx_2.checked = false
	cbx_1.checked = true
	dw_1.Modify("DataWindow.Detail.Height=72")
else
	cbx_2.checked = true
	cbx_1.checked = false
	dw_1.Modify("DataWindow.Detail.Height=0")
end if
end event

type cbx_2 from checkbox within w_con_coste_articulos
boolean visible = false
integer x = 1582
integer y = 152
integer width = 311
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Resumen"
boolean lefttext = true
end type

event clicked;if cbx_2.checked = true then
	cbx_1.checked = false
	cbx_2.checked = true
	dw_1.Modify("DataWindow.Detail.Height=0")
else
	cbx_1.checked = true
	cbx_2.checked = false
	dw_1.Modify("DataWindow.Detail.Height=72")
end if
end event

type uo_manejo from u_manejo_datawindow within w_con_coste_articulos
event valores pbm_custom01
integer x = 2651
integer y = 72
integer width = 599
integer height = 148
end type

event valores;call super::valores;dw_data=dw_1
//f_activar_campo(uo_1.em_campo)
end event

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

type pb_1 from upb_salir within w_con_coste_articulos
integer x = 3305
integer y = 104
integer width = 119
integer height = 112
integer taborder = 0
boolean bringtotop = true
end type

type gb_5 from groupbox within w_con_coste_articulos
integer x = 23
integer y = 72
integer width = 475
integer height = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Articulo"
end type

type uo_articulo from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 46
integer y = 128
integer width = 425
integer height = 68
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)
IF Trim(uo_articulo.em_campo.text)="" THEN 
 IF Trim(uo_articulo.em_codigo.text)<>"" Then uo_articulo.em_campo.SetFocus()
 uo_articulo.em_campo.text=""
 uo_articulo.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type uo_formato from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 517
integer y = 128
integer width = 315
integer height = 68
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_formato.destroy
call u_em_campo_2::destroy
end on

event modificado;uo_formato.em_campo.text=f_nombre_formato_abr(codigo_empresa,uo_formato.em_codigo.text)

IF Trim(uo_formato.em_campo.text)="" THEN 
 	IF Trim(uo_formato.em_codigo.text)<>"" Then 
		uo_formato.em_campo.SetFocus()
	END IF
 	uo_formato.em_campo.text=""
 	uo_formato.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de formatos"
ue_datawindow = "dw_ayuda_formatos"
ue_filtro     = ""

end event

type uo_cliente from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 878
integer y = 128
integer width = 315
integer height = 68
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

type r_1 from rectangle within w_con_coste_articulos
integer linethickness = 4
long fillcolor = 12639424
integer x = 32
integer y = 1804
integer width = 3433
integer height = 76
end type

type st_total from statictext within w_con_coste_articulos
integer x = 197
integer y = 1808
integer width = 3131
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_g1 from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 37
integer y = 284
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

type uo_g2 from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 201
integer y = 284
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

type uo_g3 from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 384
integer y = 284
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

type uo_g4 from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 549
integer y = 284
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

type ddlb_pt from dropdownlistbox within w_con_coste_articulos
integer x = 713
integer y = 280
integer width = 224
integer height = 336
integer taborder = 120
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

type em_fdesde from u_em_campo within w_con_coste_articulos
integer x = 1243
integer y = 124
integer width = 288
integer height = 72
integer taborder = 60
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type em_fhasta from u_em_campo within w_con_coste_articulos
integer x = 1536
integer y = 124
integer width = 288
integer height = 72
integer taborder = 70
boolean bringtotop = true
fontcharset fontcharset = ansi!
long backcolor = 79741120
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd-mm-yy"
end type

type ddlb_gd from dropdownlistbox within w_con_coste_articulos
integer x = 960
integer y = 280
integer width = 224
integer height = 336
integer taborder = 130
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
string item[] = {"Todo","A","B","C"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_nc from dropdownlistbox within w_con_coste_articulos
integer x = 1207
integer y = 280
integer width = 224
integer height = 484
integer taborder = 140
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

type ddlb_re from dropdownlistbox within w_con_coste_articulos
integer x = 1454
integer y = 280
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
string item[] = {"Todo","S","N"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_ee from dropdownlistbox within w_con_coste_articulos
integer x = 1701
integer y = 280
integer width = 224
integer height = 336
integer taborder = 180
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

type ddlb_av from dropdownlistbox within w_con_coste_articulos
integer x = 1947
integer y = 280
integer width = 224
integer height = 420
integer taborder = 190
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

type ddlb_pl from dropdownlistbox within w_con_coste_articulos
integer x = 2194
integer y = 280
integer width = 224
integer height = 332
integer taborder = 210
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

type uo_ct from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 2441
integer y = 284
integer width = 142
integer height = 68
integer taborder = 230
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

type uo_en from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 2606
integer y = 284
integer width = 142
integer height = 68
integer taborder = 240
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_en.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_en.em_codigo.text

select descripcion_abr
into :descripcion
from art_encajado
where empresa = :codigo_empresa
and codigo = :codigo;

uo_en.em_campo.text = descripcion
IF Trim(uo_en.em_campo.text)="" THEN 
 IF Trim(uo_en.em_codigo.text)<>"" Then uo_en.em_campo.SetFocus()
 uo_en.em_campo.text=""
 uo_en.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Encajados"
ue_datawindow = "dw_ayuda_art_encajado"
ue_filtro     = ""

end event

type uo_rl from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 2770
integer y = 284
integer width = 142
integer height = 68
integer taborder = 250
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_rl.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_rl.em_codigo.text

select descripcion_abr
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

type uo_otr from u_em_campo_2 within w_con_coste_articulos
event destroy ( )
integer x = 2935
integer y = 284
integer width = 160
integer height = 68
integer taborder = 260
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_otr.destroy
call u_em_campo_2::destroy
end on

event modificado;string descripcion, codigo

codigo = uo_otr.em_codigo.text

select descripcion_abr
into :descripcion
from art_tipomoldura
where empresa = :codigo_empresa
and codigo = :codigo;

uo_otr.em_campo.text = descripcion
IF Trim(uo_otr.em_campo.text)="" THEN 
 IF Trim(uo_otr.em_codigo.text)<>"" Then uo_otr.em_campo.SetFocus()
 uo_otr.em_campo.text=""
 uo_otr.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de Tipos de Otros"
ue_datawindow = "dw_ayuda_art_otros"
ue_filtro     = ""

end event

type ddlb_global from dropdownlistbox within w_con_coste_articulos
integer x = 1870
integer y = 120
integer width = 361
integer height = 300
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
string item[] = {"Todo","Acabado","Intermedio"}
borderstyle borderstyle = stylelowered!
end type

type ddlb_n from dropdownlistbox within w_con_coste_articulos
integer x = 3113
integer y = 280
integer width = 224
integer height = 332
integer taborder = 200
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

