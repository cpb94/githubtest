$PBExportHeader$w_informe_produccion_anyos_secciones.srw
forward
global type w_informe_produccion_anyos_secciones from w_int_con_empresa
end type
type pb_1 from upb_salir within w_informe_produccion_anyos_secciones
end type
type pb_2 from upb_imprimir within w_informe_produccion_anyos_secciones
end type
type cb_1 from commandbutton within w_informe_produccion_anyos_secciones
end type
type gb_6 from groupbox within w_informe_produccion_anyos_secciones
end type
type dw_resumen from datawindow within w_informe_produccion_anyos_secciones
end type
type uo_secciones from u_marca_lista within w_informe_produccion_anyos_secciones
end type
type cb_2 from commandbutton within w_informe_produccion_anyos_secciones
end type
type cbx_resumido from checkbox within w_informe_produccion_anyos_secciones
end type
type lista_f1 from dropdownlistbox within w_informe_produccion_anyos_secciones
end type
type lista_f2 from dropdownlistbox within w_informe_produccion_anyos_secciones
end type
type gb_1 from groupbox within w_informe_produccion_anyos_secciones
end type
type gb_2 from groupbox within w_informe_produccion_anyos_secciones
end type
type gb_3 from groupbox within w_informe_produccion_anyos_secciones
end type
end forward

global type w_informe_produccion_anyos_secciones from w_int_con_empresa
integer x = 46
integer y = 32
integer width = 5600
integer height = 3320
pb_1 pb_1
pb_2 pb_2
cb_1 cb_1
gb_6 gb_6
dw_resumen dw_resumen
uo_secciones uo_secciones
cb_2 cb_2
cbx_resumido cbx_resumido
lista_f1 lista_f1
lista_f2 lista_f2
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_informe_produccion_anyos_secciones w_informe_produccion_anyos_secciones

type variables

end variables

event close;call super::close;
//dw_detalle.reset()

end event

event open;call super::open;istr_parametros.s_titulo_ventana="Informe de producción por años y secciones."
This.title=istr_parametros.s_titulo_ventana
Int anyo, i
/*
em_fdesde.text = string(year (date(today()))-1)
em_fhasta.text = string(year (date(today())))
*/
anyo = year (date(today()))
for i=2001 To anyo
	lista_f1.AddItem (String(i))
	lista_f2.AddItem (String(i))
Next

lista_f1.SelectItem(lista_f1.TotalItems()-1)
lista_f2.SelectItem(lista_f2.TotalItems())

uo_secciones.f_cargar_datos("dw_ayuda_secciones","","","Código","Descripción")
end event

on w_informe_produccion_anyos_secciones.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_2=create pb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.dw_resumen=create dw_resumen
this.uo_secciones=create uo_secciones
this.cb_2=create cb_2
this.cbx_resumido=create cbx_resumido
this.lista_f1=create lista_f1
this.lista_f2=create lista_f2
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_6
this.Control[iCurrent+5]=this.dw_resumen
this.Control[iCurrent+6]=this.uo_secciones
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.cbx_resumido
this.Control[iCurrent+9]=this.lista_f1
this.Control[iCurrent+10]=this.lista_f2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_3
end on

on w_informe_produccion_anyos_secciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.dw_resumen)
destroy(this.uo_secciones)
destroy(this.cb_2)
destroy(this.cbx_resumido)
destroy(this.lista_f1)
destroy(this.lista_f2)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event ue_f5;//f_control(dw_detalle)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_informe_produccion_anyos_secciones
integer y = 612
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_informe_produccion_anyos_secciones
end type

type st_empresa from w_int_con_empresa`st_empresa within w_informe_produccion_anyos_secciones
integer y = 8
integer width = 5531
integer height = 84
boolean italic = true
end type

type pb_1 from upb_salir within w_informe_produccion_anyos_secciones
integer x = 5390
integer y = 156
integer width = 110
integer height = 96
integer taborder = 0
string text = "1"
boolean originalsize = true
end type

type pb_2 from upb_imprimir within w_informe_produccion_anyos_secciones
integer x = 5266
integer y = 156
integer taborder = 0
end type

event clicked;f_imprimir_datawindow(dw_resumen)

end event

type cb_1 from commandbutton within w_informe_produccion_anyos_secciones
integer x = 4969
integer y = 156
integer width = 288
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;string var_seccion[]
long   indice,indice_array
Long fdesde, fhasta


dw_resumen.SetTransObject(SQLCA)
dw_resumen.Reset()


uo_secciones.visible = false

indice_array = 0
for indice = 1 to uo_secciones.dw_marca.rowcount()
	if uo_secciones.dw_marca.getitemstring(indice,"marca")="S" then
		indice_array ++		
		var_seccion[indice_array] = uo_secciones.dw_marca.getitemstring(indice,"codigo")
	end if
next

if indice_array > 0 then
	dw_resumen.reset()
	if cbx_resumido.checked then
		dw_resumen.Object.DataWindow.Detail.height = 0
	else
		dw_resumen.Object.DataWindow.Detail.height = 54
	end if
	
	/*
	dw_resumen.Modify("#1.width = 200")	
	dw_resumen.Modify("#2.width = 100")	
	dw_resumen.Modify("#3.width = 140")	
	dw_resumen.Modify("#4.width = 60")	
	dw_resumen.Modify("#5.width = 60")	
	dw_resumen.Modify("#6.width = 3")	
	dw_resumen.Modify("#7.width = 3")	
	*/
	
	fdesde = Long(lista_f1.text)
	fhasta = Long(lista_f2.text)
	
	dw_resumen.Retrieve(codigo_empresa, fdesde, fhasta, var_seccion)


end if




end event

type gb_6 from groupbox within w_informe_produccion_anyos_secciones
integer x = 4942
integer y = 112
integer width = 590
integer height = 156
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_resumen from datawindow within w_informe_produccion_anyos_secciones
integer x = 27
integer y = 284
integer width = 5509
integer height = 2784
integer taborder = 10
string dataobject = "dw_informe_produccion_anyos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_secciones from u_marca_lista within w_informe_produccion_anyos_secciones
event destroy ( )
boolean visible = false
integer x = 2560
integer y = 268
integer width = 1362
integer height = 668
integer taborder = 90
boolean bringtotop = true
boolean border = false
end type

on uo_secciones.destroy
call u_marca_lista::destroy
end on

type cb_2 from commandbutton within w_informe_produccion_anyos_secciones
integer x = 4526
integer y = 156
integer width = 411
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Secciones"
end type

event clicked;uo_secciones.visible = not(uo_secciones.visible)

end event

type cbx_resumido from checkbox within w_informe_produccion_anyos_secciones
integer x = 1353
integer y = 172
integer width = 343
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Resumido"
end type

type lista_f1 from dropdownlistbox within w_informe_produccion_anyos_secciones
integer x = 55
integer y = 156
integer width = 549
integer height = 400
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
end type

type lista_f2 from dropdownlistbox within w_informe_produccion_anyos_secciones
integer x = 690
integer y = 156
integer width = 549
integer height = 400
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean vscrollbar = true
end type

type gb_1 from groupbox within w_informe_produccion_anyos_secciones
integer x = 658
integer y = 96
integer width = 626
integer height = 176
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Año 2"
end type

type gb_2 from groupbox within w_informe_produccion_anyos_secciones
integer x = 4503
integer y = 112
integer width = 439
integer height = 156
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_informe_produccion_anyos_secciones
integer x = 18
integer y = 96
integer width = 626
integer height = 176
integer taborder = 40
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Año 1"
end type

