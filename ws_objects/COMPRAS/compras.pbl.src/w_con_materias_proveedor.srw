$PBExportHeader$w_con_materias_proveedor.srw
forward
global type w_con_materias_proveedor from w_int_con_empresa
end type
type gb_1 from groupbox within w_con_materias_proveedor
end type
type pb_2 from upb_salir within w_con_materias_proveedor
end type
type cb_consulta from u_boton within w_con_materias_proveedor
end type
type pb_imprimir_preli from picturebutton within w_con_materias_proveedor
end type
type dw_listado from datawindow within w_con_materias_proveedor
end type
type dw_1 from datawindow within w_con_materias_proveedor
end type
type gb_vto from groupbox within w_con_materias_proveedor
end type
type st_4 from statictext within w_con_materias_proveedor
end type
type em_fhasta from editmask within w_con_materias_proveedor
end type
type em_fdesde from editmask within w_con_materias_proveedor
end type
type st_6 from statictext within w_con_materias_proveedor
end type
type st_66 from statictext within w_con_materias_proveedor
end type
type uo_proveedor from u_em_campo_2 within w_con_materias_proveedor
end type
end forward

global type w_con_materias_proveedor from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 2885
integer height = 1652
string title = "Consulta de Movimientos"
string icon = "Application!"
gb_1 gb_1
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
dw_1 dw_1
gb_vto gb_vto
st_4 st_4
em_fhasta em_fhasta
em_fdesde em_fdesde
st_6 st_6
st_66 st_66
uo_proveedor uo_proveedor
end type
global w_con_materias_proveedor w_con_materias_proveedor

type variables
String situacion= "0"
end variables

forward prototypes
public subroutine f_cargar (datawindow dw_data)
end prototypes

public subroutine f_cargar (datawindow dw_data);String prov1,prov2
DateTime	fec1,fec2

if uo_proveedor.em_codigo.text = "" then
	prov1 = "."
	prov2 = "Z"
else
	prov1 = uo_proveedor.em_codigo.text
	prov2 = uo_proveedor.em_codigo.text
end if


dw_data.SetTransObject(sqlca)
dw_data.reset()


fec1 = datetime(date(em_fdesde.text))
fec2 = datetime(date(em_fhasta.text))


str_paramemp em
em =f_paramemp(codigo_empresa) 

f_mascara_columna(dw_data,"cimporte",f_mascara_decimales(f_decimales_moneda(em.moneda_emp)))
f_mascara_columna(dw_data,"total",f_mascara_decimales(f_decimales_moneda(em.moneda_emp)))
f_mascara_columna(dw_data,"total_general",f_mascara_decimales(f_decimales_moneda(em.moneda_emp)))

dw_data.Retrieve(codigo_empresa,fec1,fec2,prov1,prov2)


end subroutine

event open;call super::open;
dw_1.SetTransObject(sqlca)
This.title = " CONSULTA DE COMPRAS DE MATERIAS PRIMAS POR PROVEEDOR"

em_fdesde.text = "01/01/98"
em_fhasta.text = string(today())



f_activar_campo(em_fdesde)





end event

on w_con_materias_proveedor.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.dw_1=create dw_1
this.gb_vto=create gb_vto
this.st_4=create st_4
this.em_fhasta=create em_fhasta
this.em_fdesde=create em_fdesde
this.st_6=create st_6
this.st_66=create st_66
this.uo_proveedor=create uo_proveedor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.pb_2
this.Control[iCurrent+3]=this.cb_consulta
this.Control[iCurrent+4]=this.pb_imprimir_preli
this.Control[iCurrent+5]=this.dw_listado
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_vto
this.Control[iCurrent+8]=this.st_4
this.Control[iCurrent+9]=this.em_fhasta
this.Control[iCurrent+10]=this.em_fdesde
this.Control[iCurrent+11]=this.st_6
this.Control[iCurrent+12]=this.st_66
this.Control[iCurrent+13]=this.uo_proveedor
end on

on w_con_materias_proveedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.dw_1)
destroy(this.gb_vto)
destroy(this.st_4)
destroy(this.em_fhasta)
destroy(this.em_fdesde)
destroy(this.st_6)
destroy(this.st_66)
destroy(this.uo_proveedor)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_materias_proveedor
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_materias_proveedor
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_materias_proveedor
integer x = 64
integer y = 12
integer width = 2642
end type

type gb_1 from groupbox within w_con_materias_proveedor
integer x = 1024
integer y = 116
integer width = 1298
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type pb_2 from upb_salir within w_con_materias_proveedor
integer x = 2734
integer y = 16
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_con_materias_proveedor
integer x = 2345
integer y = 156
integer width = 302
integer height = 112
integer taborder = 40
string text = "&Consulta"
end type

event clicked;call super::clicked;f_cargar(dw_1)
if dw_1.rowcount() > 0 then
	dw_1.visible = true

else
		dw_1.visible = false	
end if
f_activar_campo(em_Fdesde)


end event

type pb_imprimir_preli from picturebutton within w_con_materias_proveedor
integer x = 2665
integer y = 156
integer width = 128
integer height = 112
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar(dw_listado)
if dw_listado.rowcount() > 0 then
	f_imprimir_datawindow(dw_listado)	
end if


end event

type dw_listado from datawindow within w_con_materias_proveedor
boolean visible = false
integer x = 5
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_matprimas_proveedor"
boolean livescroll = true
end type

type dw_1 from datawindow within w_con_materias_proveedor
boolean visible = false
integer x = 59
integer y = 324
integer width = 2683
integer height = 1080
string dataobject = "dw_con_matprimas_proveedor"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_vto from groupbox within w_con_materias_proveedor
integer x = 27
integer y = 116
integer width = 987
integer height = 176
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type st_4 from statictext within w_con_materias_proveedor
integer x = 41
integer y = 180
integer width = 302
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Fecha fra :"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type em_fhasta from editmask within w_con_materias_proveedor
integer x = 690
integer y = 176
integer width = 288
integer height = 76
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = "\"
end type

event modified;IF Date(em_Fdesde.text) > Date(em_Fhasta.text)   THEN
	MessageBox("ERROR EN FECHAS","La Fecha desde mayor que Hasta",Exclamation!)
	f_activar_campo(em_Fhasta)
END IF
end event

type em_fdesde from editmask within w_con_materias_proveedor
integer x = 338
integer y = 176
integer width = 288
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yy"
string displaydata = "Œ¤"
end type

type st_6 from statictext within w_con_materias_proveedor
integer x = 640
integer y = 172
integer width = 46
integer height = 76
boolean bringtotop = true
integer textsize = -12
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "-"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type st_66 from statictext within w_con_materias_proveedor
integer x = 1047
integer y = 184
integer width = 315
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean enabled = false
string text = "Proveedor :"
alignment alignment = center!
long bordercolor = 16711680
boolean focusrectangle = false
end type

type uo_proveedor from u_em_campo_2 within w_con_materias_proveedor
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 1367
integer y = 180
integer width = 933
integer height = 80
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_proveedor.em_campo.text=f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)

IF Trim(uo_proveedor.em_campo.text)="" THEN 
 IF Trim(uo_proveedor.em_codigo.text)<>"" Then uo_proveedor.em_campo.SetFocus()
 uo_proveedor.em_campo.text=""
 uo_proveedor.em_codigo.text=""
 Return
END IF



end event

event getfocus;call super::getfocus;      ue_titulo     = "AYUDA SELECCION DE PROVEEDORES"
		ue_datawindow = "dw_ayuda_proveedores"
		ue_filtro     = ""

end event

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

