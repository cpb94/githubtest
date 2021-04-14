$PBExportHeader$w_con_deposito_meses.srw
forward
global type w_con_deposito_meses from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_deposito_meses
end type
type pb_2 from upb_imprimir within w_con_deposito_meses
end type
type cb_1 from commandbutton within w_con_deposito_meses
end type
type gb_6 from groupbox within w_con_deposito_meses
end type
type dw_resumen from datawindow within w_con_deposito_meses
end type
type uo_cliente from u_em_campo_2 within w_con_deposito_meses
end type
type st_2 from statictext within w_con_deposito_meses
end type
type em_anyo from editmask within w_con_deposito_meses
end type
type gb_4 from groupbox within w_con_deposito_meses
end type
end forward

global type w_con_deposito_meses from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 4517
integer height = 2656
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
uo_cliente uo_cliente
st_2 st_2
em_anyo em_anyo
gb_4 gb_4
end type
global w_con_deposito_meses w_con_deposito_meses

type variables

end variables

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string v_cliente, codestadistico
long anyo


if uo_cliente.em_codigo.text = '' or isnull (uo_cliente.em_codigo.text) then
	v_cliente = '%'
else
	v_cliente = uo_cliente.em_codigo.text
end if


data.SetTransObject(SQLCA)
data.Reset()

anyo = long( em_anyo.text)

data.Retrieve(codigo_empresa, v_cliente, anyo)


/*
string filtro, seccion, linea, turno, articulo, formato
string restriccion_cliente, restriccion_g1, restriccion_g2, restriccion_g3, restriccion_g4
string restriccion_pt, restriccion_nc, restriccion_n , restriccion_rect, restriccion_pant
string restriccion_av, restriccion_pl, restriccion_ct, restriccion_en, restriccion_rl
string restriccion_global, restriccion_coleccion
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
	restriccion_cliente = "(articulos_cliente = '"+uo_cliente.em_codigo.text+"' )"
	general = general + "   Cliente: "+uo_cliente.em_campo.text	
else
	restriccion_cliente = '((1=1) or  (isnull(articulos_cliente)))' // Codición que siempre se cumplirá
end if

if uo_coleccion.em_campo.text <> "" and not isnull(uo_coleccion.em_campo.text) then
	restriccion_coleccion = "(articulos_coleccion = '"+uo_coleccion.em_codigo.text+"' )"
	general = general + "   Colección: "+uo_coleccion.em_campo.text	
else
	restriccion_coleccion = '((1=1) or  (isnull(articulos_coleccion)))' // Codición que siempre se cumplirá
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

//choose case ddlb_global.text
//	case "Todo"
//		restriccion_global = '1=1' 
//		general = general + "   Todo "
//	case ""
//		restriccion_global = '1=1' 
//		general = general + "   Todo "
//	case "Acabado"
//		restriccion_global = " (art_codestadistico_g2 <> 'N')  and (art_codestadistico_g2 <> 'B') and (art_codestadistico_g2 <> 'Z') "
//		general = general + "   Acabado "
//	case "Intermedio"
//		restriccion_global = " ((art_codestadistico_g2 = 'N') or (art_codestadistico_g2 = 'B') or (art_codestadistico_g2 = 'Z')) "
//		general = general + "   Intermedio "
//	case "Base"
//		restriccion_global = " ((art_codestadistico_g2 = 'N') or (art_codestadistico_g2 = 'B') or (art_codestadistico_g2 = 'Z')) "
//		general = general + "   Base "
//		
//end choose 

choose case ddlb_global.text
	case "Todo"
		restriccion_global = '1=1' 
		general = general + "   Todo "
	case ""
		restriccion_global = '1=1' 
		general = general + "   Todo "
	case "Acabado"
		restriccion_global = " (articulos_uso = '3' ) "
		general = general + "   Acabado "
	case "Intermedio"
		restriccion_global = "  (articulos_uso = '2' ) " 
		general = general + "   Intermedio "
	case "Base"
		restriccion_global = " (articulos_uso = '1' ) "
		general = general + "   Base "		
end choose 
		
if (ddlb_pt.text = "Todo" or ddlb_pt.text = "" ) then
	restriccion_pt = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pt = "(art_codestadistico_pt = '"+ddlb_pt.text+"')"
	codestadistico = codestadistico + "   PT: "+ddlb_pt.text
	
end if

if (ddlb_nc.text = "Todo" or ddlb_nc.text = "" ) then
	restriccion_nc = '1=1' // Codición que siempre se cumplirá
else
	restriccion_nc = "(art_codestadistico_nc = '"+ddlb_nc.text+"')"
	codestadistico = codestadistico + "   NC: "+ddlb_nc.text	
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

if (ddlb_rectificado.text = "Todo" or ddlb_rectificado.text = "" ) then
	restriccion_rect = '1=1' // Codición que siempre se cumplirá
else
	restriccion_rect = "(art_codestadistico_rectificado = '"+ddlb_rectificado.text+"')"
	codestadistico = codestadistico + "   Rectificado: "+ddlb_rectificado.text
end if

if sle_cod_pantallas.text = '' or isnull(sle_cod_pantallas.text) then
	restriccion_pant = '1=1' // Codición que siempre se cumplirá
else
	restriccion_pant = "(articulos_codigo_pantallas like '"+sle_cod_pantallas.text+"%')"
	codestadistico = codestadistico + "   codigo Pantallas: "+sle_cod_pantallas.text
end if

dw_1.object.general.text = general
dw_1.object.codestadistico.text = codestadistico

filtro = ""
filtro = restriccion_cliente+" and "+ &
			restriccion_global+" and "+ &
			restriccion_coleccion+" and "+ &
			restriccion_g1+" and "+ &
			restriccion_g2+" and "+ &
			restriccion_g3+" and "+ &
			restriccion_g4+" and "+ &
			restriccion_pt+" and "+ &
			restriccion_nc+" and "+ &
			restriccion_av+" and "+ &
			restriccion_pl+" and "+ &
			restriccion_pant+" and "+ &
			restriccion_ct+" and "+ &
			restriccion_en+" and "+ &
			restriccion_rl+" and "+ &
			restriccion_rect+" and "+ &
			restriccion_n

			
dw_1.SetFilter(filtro)
dw_1.Filter()
dw_1.Retrieve(codigo_empresa,fecha1, fecha2, articulo, formato)



if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if
*/
end subroutine

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de Facturación de Depósito por Clientes y Meses."
This.title=istr_parametros.s_titulo_ventana

//em_fdesde.text = string (RelativeDate (date(today()), -365), "dd-mm-yy")
//em_fhasta.text = string (date(today() ), "dd-mm-yy")
em_anyo.text = string(year (date(today())))
end event

on w_con_deposito_meses.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.uo_cliente=create uo_cliente
this.st_2=create st_2
this.em_anyo=create em_anyo
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.uo_cliente
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.em_anyo
this.Control[iCurrent+9]=this.gb_4
end on

on w_con_deposito_meses.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.uo_cliente)
destroy(this.st_2)
destroy(this.em_anyo)
destroy(this.gb_4)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_deposito_meses
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_deposito_meses
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_deposito_meses
integer x = 9
integer y = 8
integer width = 4201
integer height = 88
boolean italic = true
long textcolor = 8388608
end type

type pb_1 from upb_salir within w_con_deposito_meses
integer x = 4261
integer y = 8
integer width = 119
integer height = 100
integer taborder = 0
string text = "1"
end type

type pb_2 from upb_imprimir within w_con_deposito_meses
integer x = 4247
integer y = 140
integer width = 128
integer height = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_con_deposito_meses
integer x = 3950
integer y = 140
integer width = 288
integer height = 104
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

type gb_6 from groupbox within w_con_deposito_meses
integer x = 3931
integer y = 100
integer width = 462
integer height = 160
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_resumen from datawindow within w_con_deposito_meses
integer x = 27
integer y = 284
integer width = 4389
integer height = 2124
string dataobject = "dw_con_deposito_meses"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_cliente from u_em_campo_2 within w_con_deposito_meses
event destroy ( )
integer x = 37
integer y = 144
integer width = 1573
integer height = 80
integer taborder = 10
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

type st_2 from statictext within w_con_deposito_meses
integer x = 1760
integer y = 148
integer width = 224
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año:"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_anyo from editmask within w_con_deposito_meses
integer x = 1989
integer y = 140
integer width = 210
integer height = 84
integer taborder = 20
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
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "0000"
end type

type gb_4 from groupbox within w_con_deposito_meses
integer x = 18
integer y = 100
integer width = 1614
integer height = 144
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

