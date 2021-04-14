$PBExportHeader$w_con_articulos_bases_moldes.srw
forward
global type w_con_articulos_bases_moldes from w_int_con_empresa
end type
type pb_imprimir from upb_imprimir within w_con_articulos_bases_moldes
end type
type dw_1 from datawindow within w_con_articulos_bases_moldes
end type
type cb_1 from u_boton within w_con_articulos_bases_moldes
end type
type pb_1 from upb_salir within w_con_articulos_bases_moldes
end type
type r_1 from rectangle within w_con_articulos_bases_moldes
end type
type st_total from statictext within w_con_articulos_bases_moldes
end type
type uo_base from u_em_campo_2 within w_con_articulos_bases_moldes
end type
type cbx_consumo_base from checkbox within w_con_articulos_bases_moldes
end type
type gb_1 from groupbox within w_con_articulos_bases_moldes
end type
type gb_6 from groupbox within w_con_articulos_bases_moldes
end type
type gb_2 from groupbox within w_con_articulos_bases_moldes
end type
end forward

global type w_con_articulos_bases_moldes from w_int_con_empresa
integer width = 4439
integer height = 2980
string title = "Consulta de artículos (cod. estadístico)"
pb_imprimir pb_imprimir
dw_1 dw_1
cb_1 cb_1
pb_1 pb_1
r_1 r_1
st_total st_total
uo_base uo_base
cbx_consumo_base cbx_consumo_base
gb_1 gb_1
gb_6 gb_6
gb_2 gb_2
end type
global w_con_articulos_bases_moldes w_con_articulos_bases_moldes

forward prototypes
public subroutine f_control (datawindow data)
end prototypes

public subroutine f_control (datawindow data);string anterior
string encajados[]
long i, fila, m
boolean encontrado

str_escandallo escandallo[300]
integer indice, nivel
dec factor_acumulado


dw_1.reset()

if uo_base.em_codigo.text = "" or isnull(uo_base.em_codigo.text) then
	anterior = "%"
else
	anterior = uo_base.em_codigo.text 
end if

/////////// Buscar Encajados ///////////

f_busca_encajados (uo_base.em_codigo.text,  encajados)


if upperbound(encajados) = 0 then
	encajados[1] = uo_base.em_codigo.text
end if
/////////fin Buscar  Encajados //////////

dw_1.Retrieve(codigo_empresa, encajados )

if  cbx_consumo_base.checked then
	indice = 1
	factor_Acumulado = 1
	f_escandallo_factores_up (escandallo, uo_base.em_codigo.text, indice, factor_acumulado )
		
	for i = 1 to indice
		fila = dw_1.Find("articulos_codigo  = '"+escandallo[i].articulo+"' ", 1, dw_1.RowCount())
		if fila <> 0 then
			dw_1.object.base_doce_meses[fila] = dw_1.object.doce_meses[fila] / escandallo[i].factor
			dw_1.object.base_seis_meses[fila] = dw_1.object.seis_meses[fila] / escandallo[i].factor
			dw_1.object.base_tres_meses[fila] = dw_1.object.tres_meses[fila] / escandallo[i].factor
		end if

	next
	
end if

if dw_1.RowCount() = 0 then
	messagebox("Atención","No hay datos")
end if


end subroutine

on w_con_articulos_bases_moldes.create
int iCurrent
call super::create
this.pb_imprimir=create pb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.r_1=create r_1
this.st_total=create st_total
this.uo_base=create uo_base
this.cbx_consumo_base=create cbx_consumo_base
this.gb_1=create gb_1
this.gb_6=create gb_6
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_imprimir
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.pb_1
this.Control[iCurrent+5]=this.r_1
this.Control[iCurrent+6]=this.st_total
this.Control[iCurrent+7]=this.uo_base
this.Control[iCurrent+8]=this.cbx_consumo_base
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_6
this.Control[iCurrent+11]=this.gb_2
end on

on w_con_articulos_bases_moldes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.r_1)
destroy(this.st_total)
destroy(this.uo_base)
destroy(this.cbx_consumo_base)
destroy(this.gb_1)
destroy(this.gb_6)
destroy(this.gb_2)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Encajados de un artículo y su rotación"
istr_parametros.s_listado        =   "dw_con_prodpartes_ot"
This.title                       =   istr_parametros.s_titulo_ventana

uo_base.setfocus()

dw_1.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(FocusRect!)




end event

event ue_pagina_abajo;call super::ue_pagina_abajo;//uo_manejo.triggerEvent("pagina_abajo")
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;//uo_manejo.triggerEvent("pagina_arriba")
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

event activate;call super::activate;w_con_articulos_bases_moldes = ventanas_activas[id_ventana_activa].ventana
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_articulos_bases_moldes
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_articulos_bases_moldes
integer x = 3040
integer y = 20
integer width = 178
integer height = 52
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_articulos_bases_moldes
integer x = 37
integer width = 4311
integer height = 76
integer textsize = -8
end type

type pb_imprimir from upb_imprimir within w_con_articulos_bases_moldes
event clicked pbm_bnclicked
integer x = 4078
integer y = 104
integer taborder = 0
boolean originalsize = false
end type

event clicked;Parent.triggerEvent("ue_listar")

end event

type dw_1 from datawindow within w_con_articulos_bases_moldes
integer x = 32
integer y = 228
integer width = 4315
integer height = 2452
integer taborder = 20
string dataobject = "dw_con_articulos_bases_moldes"
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

event clicked;string orden, filtro
filtro = ''
orden = ''
choose case dwo.name
	case "t_c1"
		orden = "articulos_codigo, doce_meses D"
		filtro = 'not Isnull(doce_meses)'
		dw_1.SetRedraw(false)
		dw_1.Setfilter(filtro)
		dw_1.filter()
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_c2"
		orden = "articulos_codigo, base_doce_meses D"
		filtro = 'not Isnull(base_doce_meses)'
		dw_1.SetRedraw(false)
		dw_1.Setfilter(filtro)
		dw_1.filter()
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_c3"
		orden = "articulos_codigo, seis_meses D"
		filtro = 'not Isnull(seis_meses)'
		dw_1.SetRedraw(false)
		dw_1.Setfilter(filtro)
		dw_1.filter()
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_c4"
		orden = "articulos_codigo, base_seis_meses D"
		filtro = 'not Isnull(base_seis_meses)'
		dw_1.SetRedraw(false)
		dw_1.Setfilter(filtro)
		dw_1.filter()
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_c5"
		orden = "articulos_codigo, tres_meses D"
		filtro = 'not Isnull(tres_meses)'
		dw_1.SetRedraw(false)
		dw_1.Setfilter(filtro)
		dw_1.filter()
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
	case "t_c6"
		orden = "articulos_codigo, base_tres_meses D"
		filtro = 'not Isnull(base_tres_meses)'
		dw_1.SetRedraw(false)
		dw_1.Setfilter(filtro)
		dw_1.filter()
		dw_1.SetSort(orden)
		dw_1.Sort()
		dw_1.SetRedraw(true)
end choose
end event

type cb_1 from u_boton within w_con_articulos_bases_moldes
integer x = 3726
integer y = 104
integer width = 357
integer height = 96
integer taborder = 0
boolean bringtotop = true
string text = "Consulta"
end type

event clicked;f_control(dw_1)

end event

type pb_1 from upb_salir within w_con_articulos_bases_moldes
integer x = 4206
integer y = 104
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

type r_1 from rectangle within w_con_articulos_bases_moldes
integer linethickness = 4
long fillcolor = 12639424
integer x = 32
integer y = 2680
integer width = 4311
integer height = 76
end type

type st_total from statictext within w_con_articulos_bases_moldes
integer x = 567
integer y = 2684
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

type uo_base from u_em_campo_2 within w_con_articulos_bases_moldes
event destroy ( )
integer x = 59
integer y = 124
integer width = 1714
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_base.destroy
call u_em_campo_2::destroy
end on

event modificado;
uo_base.em_campo.text=f_nombre_articulo(codigo_empresa,uo_base.em_codigo.text)
IF Trim(uo_base.em_campo.text)="" THEN 
 IF Trim(uo_base.em_codigo.text)<>"" Then uo_base.em_campo.SetFocus()
 uo_base.em_campo.text=""
 uo_base.em_codigo.text=""
END IF




end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de articulos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""

end event

type cbx_consumo_base from checkbox within w_con_articulos_bases_moldes
integer x = 2894
integer y = 124
integer width = 750
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Calcular Consumo de Base"
end type

type gb_1 from groupbox within w_con_articulos_bases_moldes
integer x = 37
integer y = 72
integer width = 1765
integer height = 156
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Base"
end type

type gb_6 from groupbox within w_con_articulos_bases_moldes
integer x = 2839
integer y = 68
integer width = 846
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_2 from groupbox within w_con_articulos_bases_moldes
integer x = 3694
integer y = 68
integer width = 645
integer height = 156
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

