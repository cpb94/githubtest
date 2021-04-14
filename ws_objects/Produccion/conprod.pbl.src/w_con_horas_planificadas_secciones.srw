$PBExportHeader$w_con_horas_planificadas_secciones.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_horas_planificadas_secciones from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_horas_planificadas_secciones
end type
type cb_2 from commandbutton within w_con_horas_planificadas_secciones
end type
type pb_imprimir_preli from upb_imprimir within w_con_horas_planificadas_secciones
end type
type gb_2 from groupbox within w_con_horas_planificadas_secciones
end type
type st_titulo from statictext within w_con_horas_planificadas_secciones
end type
type p_logo from picture within w_con_horas_planificadas_secciones
end type
type dw_1 from datawindow within w_con_horas_planificadas_secciones
end type
type st_1 from statictext within w_con_horas_planificadas_secciones
end type
type st_2 from statictext within w_con_horas_planificadas_secciones
end type
type em_hasta from u_em_campo within w_con_horas_planificadas_secciones
end type
type em_desde from u_em_campo within w_con_horas_planificadas_secciones
end type
end forward

global type w_con_horas_planificadas_secciones from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5609
integer height = 3456
string title = "Informe Horas Planificadas por Linea y Año"
long backcolor = 67108864
string icon = "Application!"
pb_2 pb_2
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
gb_2 gb_2
st_titulo st_titulo
p_logo p_logo
dw_1 dw_1
st_1 st_1
st_2 st_2
em_hasta em_hasta
em_desde em_desde
end type
global w_con_horas_planificadas_secciones w_con_horas_planificadas_secciones

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

event open;call super::open;
This.title = "Informe Horas Planificadas por Linea y Año"
this.st_titulo.text = this.st_empresa.text

dw_1.SetTransObject(sqlca)

em_desde.text = String(Year(Today()))
em_hasta.text = String(Year(Today()))

f_activar_campo(em_desde)




end event

on w_con_horas_planificadas_secciones.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.gb_2=create gb_2
this.st_titulo=create st_titulo
this.p_logo=create p_logo
this.dw_1=create dw_1
this.st_1=create st_1
this.st_2=create st_2
this.em_hasta=create em_hasta
this.em_desde=create em_desde
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.st_titulo
this.Control[iCurrent+6]=this.p_logo
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.st_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.em_hasta
this.Control[iCurrent+11]=this.em_desde
end on

on w_con_horas_planificadas_secciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.gb_2)
destroy(this.st_titulo)
destroy(this.p_logo)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.em_hasta)
destroy(this.em_desde)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_horas_planificadas_secciones
integer x = 27
integer y = 1004
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_horas_planificadas_secciones
boolean visible = false
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_horas_planificadas_secciones
boolean visible = false
integer width = 2738
integer height = 84
end type

type pb_2 from upb_salir within w_con_horas_planificadas_secciones
integer x = 5394
integer y = 148
integer width = 146
integer height = 128
integer taborder = 0
boolean originalsize = true
string picturename = "C:\TENCER_PB12\Log Out_24x24Gris.png"
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type cb_2 from commandbutton within w_con_horas_planificadas_secciones
event clicked pbm_bnclicked
integer x = 4837
integer y = 148
integer width = 361
integer height = 128
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;String fecha_tope

fecha_tope = "01-"+String(Month(Today())) + "-" + String(Year(Today()))

dw_1.retrieve(Long(em_desde.text),Long(em_hasta.text),Datetime(fecha_tope))
end event

type pb_imprimir_preli from upb_imprimir within w_con_horas_planificadas_secciones
event clicked pbm_bnclicked
integer x = 5221
integer y = 148
integer width = 146
integer height = 128
integer taborder = 0
string picturename = "C:\TENCER_PB12\printer-icon2_24x24.png"
end type

event clicked;String fecha_tope

if dw_1.rowcount() <= 0 then

	fecha_tope = "01-"+String(Month(Today())) + "-" + String(Year(Today()))
	
	dw_1.retrieve(Long(em_desde.text),Long(em_hasta.text),Datetime(fecha_tope))
end if

f_imprimir_datawindow(dw_1)



end event

type gb_2 from groupbox within w_con_horas_planificadas_secciones
integer x = 32
integer y = 104
integer width = 1422
integer height = 180
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Períodos (ambos incluídos)"
end type

type st_titulo from statictext within w_con_horas_planificadas_secciones
integer x = 23
integer y = 20
integer width = 1710
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 23016974
long backcolor = 553648127
string text = "Nombre Empresa"
boolean focusrectangle = false
end type

type p_logo from picture within w_con_horas_planificadas_secciones
integer x = 5019
integer y = 12
integer width = 517
integer height = 96
boolean bringtotop = true
string picturename = "C:\Tencer_PB12\tencer24.jpg"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_con_horas_planificadas_secciones
integer x = 27
integer y = 316
integer width = 5518
integer height = 2952
integer taborder = 80
string title = "none"
string dataobject = "dw_horas_planificadas_lineas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

type st_1 from statictext within w_con_horas_planificadas_secciones
integer x = 128
integer y = 188
integer width = 215
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Desde:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_con_horas_planificadas_secciones
integer x = 786
integer y = 184
integer width = 197
integer height = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Hasta:"
boolean focusrectangle = false
end type

type em_hasta from u_em_campo within w_con_horas_planificadas_secciones
integer x = 987
integer y = 176
integer width = 411
integer height = 80
integer taborder = 20
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "2000~~"
end type

type em_desde from u_em_campo within w_con_horas_planificadas_secciones
integer x = 347
integer y = 176
integer width = 411
integer height = 80
integer taborder = 30
boolean bringtotop = true
alignment alignment = center!
maskdatatype maskdatatype = numericmask!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "2000~~"
end type

