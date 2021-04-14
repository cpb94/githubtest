$PBExportHeader$w_con_distribuidores.srw
$PBExportComments$Consulta de distribuidores.
forward
global type w_con_distribuidores from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_distribuidores
end type
type dw_distribuidores from datawindow within w_con_distribuidores
end type
type dw_subdistribuidores from datawindow within w_con_distribuidores
end type
type st_1 from statictext within w_con_distribuidores
end type
type uo_pais from u_em_campo_2 within w_con_distribuidores
end type
type st_2 from statictext within w_con_distribuidores
end type
type uo_provincia from u_em_campo_2 within w_con_distribuidores
end type
type dw_listado from datawindow within w_con_distribuidores
end type
type pb_2 from upb_imprimir within w_con_distribuidores
end type
end forward

global type w_con_distribuidores from w_int_con_empresa
integer width = 2912
integer height = 1664
pb_1 pb_1
dw_distribuidores dw_distribuidores
dw_subdistribuidores dw_subdistribuidores
st_1 st_1
uo_pais uo_pais
st_2 st_2
uo_provincia uo_provincia
dw_listado dw_listado
pb_2 pb_2
end type
global w_con_distribuidores w_con_distribuidores

type variables
string filtro
end variables

on ue_listar;dw_report  = dw_listado
dw_report.SetTransObject(SQLCA)
dw_report.retrieve(uo_pais.em_codigo.text,uo_provincia.em_codigo.text)
IF TRIM(filtro)<>"" THEN
 dw_report.SetFilter(filtro)
 dw_report.Filter()
END IF
CALL Super::ue_listar
end on

on open;call w_int_con_empresa::open;istr_parametros.s_titulo_ventana="Consulta distribuidores"
This.title=istr_parametros.s_titulo_ventana

dw_distribuidores.SetTransObject(SQLCA)
dw_subdistribuidores.SetTransObject(SQLCA)
uo_pais.em_codigo.text = "11"
uo_pais.em_campo.text= f_nombre_pais(uo_pais.em_codigo.text)
uo_provincia.em_campo.SetFocus()

end on

on w_con_distribuidores.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_distribuidores=create dw_distribuidores
this.dw_subdistribuidores=create dw_subdistribuidores
this.st_1=create st_1
this.uo_pais=create uo_pais
this.st_2=create st_2
this.uo_provincia=create uo_provincia
this.dw_listado=create dw_listado
this.pb_2=create pb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_distribuidores
this.Control[iCurrent+3]=this.dw_subdistribuidores
this.Control[iCurrent+4]=this.st_1
this.Control[iCurrent+5]=this.uo_pais
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.uo_provincia
this.Control[iCurrent+8]=this.dw_listado
this.Control[iCurrent+9]=this.pb_2
end on

on w_con_distribuidores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_distribuidores)
destroy(this.dw_subdistribuidores)
destroy(this.st_1)
destroy(this.uo_pais)
destroy(this.st_2)
destroy(this.uo_provincia)
destroy(this.dw_listado)
destroy(this.pb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_distribuidores
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_distribuidores
integer taborder = 80
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_distribuidores
integer x = 27
integer y = 12
integer width = 2661
end type

type pb_1 from upb_salir within w_con_distribuidores
integer x = 2688
integer y = 8
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type dw_distribuidores from datawindow within w_con_distribuidores
integer x = 14
integer y = 284
integer width = 2807
integer height = 596
boolean bringtotop = true
string dataobject = "dw_con_distribuidores3"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]="C"
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_clipro,lstr_param) 
end event

type dw_subdistribuidores from datawindow within w_con_distribuidores
integer x = 18
integer y = 884
integer width = 2802
integer height = 552
string dataobject = "dw_con_distribuidores4"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;IF Row = 0 Then Return

str_parametros lstr_param
lstr_param.i_nargumentos=2
lstr_param.s_argumentos[2]=This.GetItemString(Row,"codigo_cliente")
lstr_param.s_argumentos[3]=This.GetItemString(Row,"codigo")
OpenWithParm(wi_mant_distribuidores,lstr_param) 
end event

type st_1 from statictext within w_con_distribuidores
integer x = 41
integer y = 156
integer width = 151
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Pais"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_pais from u_em_campo_2 within w_con_distribuidores
integer x = 224
integer y = 148
integer width = 617
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on modificado;call u_em_campo_2::modificado;uo_pais.em_campo.text=f_nombre_pais(uo_pais.em_codigo.text)
IF Trim(uo_pais.em_campo.text)="" THEN 
 IF Trim(uo_pais.em_codigo.text)<>"" Then uo_pais.em_campo.SetFocus()
 uo_pais.em_campo.text=""
 uo_pais.em_codigo.text=""
END IF


end on

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de paises"
ue_datawindow = "dw_ayuda_paises"
ue_filtro     = ""
valor_empresa = FALSE

end on

on uo_pais.destroy
call u_em_campo_2::destroy
end on

type st_2 from statictext within w_con_distribuidores
integer x = 887
integer y = 156
integer width = 288
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Provincia"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_provincia from u_em_campo_2 within w_con_distribuidores
integer x = 1179
integer y = 148
integer width = 654
integer taborder = 60
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_provincia.em_campo.text=f_nombre_provincia(uo_pais.em_codigo.text,uo_provincia.em_codigo.text)
IF Trim(uo_provincia.em_campo.text)="" THEN 
 IF Trim(uo_provincia.em_codigo.text)<>"" Then uo_provincia.em_campo.SetFocus()
 uo_provincia.em_campo.text=""
 uo_provincia.em_codigo.text=""
END IF

dw_distribuidores.Retrieve(codigo_empresa,uo_pais.em_codigo.text,uo_provincia.em_codigo.text)
dw_subdistribuidores.Retrieve(codigo_empresa,uo_pais.em_codigo.text,uo_provincia.em_codigo.text)
end event

on getfocus;call u_em_campo_2::getfocus;ue_titulo     = "Ayuda seleccion de provincias"
ue_datawindow = "dw_ayuda_provincias"
ue_filtro      = "pais = '" + uo_pais.em_codigo.text + "' "
valor_empresa = FALSE

end on

on uo_provincia.destroy
call u_em_campo_2::destroy
end on

type dw_listado from datawindow within w_con_distribuidores
boolean visible = false
integer x = 69
integer width = 494
integer height = 152
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_con_distribuidores"
boolean livescroll = true
end type

type pb_2 from upb_imprimir within w_con_distribuidores
integer x = 1861
integer y = 140
integer taborder = 0
string picturename = "print!"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")
uo_provincia.em_campo.Setfocus()
end event

