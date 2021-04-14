$PBExportHeader$w_con_imp_bandas.srw
forward
global type w_con_imp_bandas from w_int_con_empresa
end type
type gb_3 from groupbox within w_con_imp_bandas
end type
type dw_listado from datawindow within w_con_imp_bandas
end type
type pb_imprimir from upb_imprimir within w_con_imp_bandas
end type
type st_nombre from statictext within w_con_imp_bandas
end type
type em_nombre from u_em_campo within w_con_imp_bandas
end type
type em_ciudad from u_em_campo within w_con_imp_bandas
end type
type em_pais from u_em_campo within w_con_imp_bandas
end type
type st_referencia from statictext within w_con_imp_bandas
end type
type em_refe from u_em_campo within w_con_imp_bandas
end type
type st_2 from statictext within w_con_imp_bandas
end type
type st_bulto from statictext within w_con_imp_bandas
end type
type em_bulto from u_em_campo within w_con_imp_bandas
end type
type st_observaciones from statictext within w_con_imp_bandas
end type
type gb_4 from groupbox within w_con_imp_bandas
end type
type gb_1 from groupbox within w_con_imp_bandas
end type
type em_obser from multilineedit within w_con_imp_bandas
end type
type cb_1 from commandbutton within w_con_imp_bandas
end type
type st_1 from statictext within w_con_imp_bandas
end type
type st_3 from statictext within w_con_imp_bandas
end type
type uo_cliente from u_em_campo_2 within w_con_imp_bandas
end type
type ddlb_1 from dropdownlistbox within w_con_imp_bandas
end type
type uo_envio from u_em_campo_2 within w_con_imp_bandas
end type
type gb_2 from groupbox within w_con_imp_bandas
end type
type em_direccion from u_em_campo within w_con_imp_bandas
end type
type pb_1 from upb_salir within w_con_imp_bandas
end type
end forward

global type w_con_imp_bandas from w_int_con_empresa
integer width = 2875
integer height = 1640
gb_3 gb_3
dw_listado dw_listado
pb_imprimir pb_imprimir
st_nombre st_nombre
em_nombre em_nombre
em_ciudad em_ciudad
em_pais em_pais
st_referencia st_referencia
em_refe em_refe
st_2 st_2
st_bulto st_bulto
em_bulto em_bulto
st_observaciones st_observaciones
gb_4 gb_4
gb_1 gb_1
em_obser em_obser
cb_1 cb_1
st_1 st_1
st_3 st_3
uo_cliente uo_cliente
ddlb_1 ddlb_1
uo_envio uo_envio
gb_2 gb_2
em_direccion em_direccion
pb_1 pb_1
end type
global w_con_imp_bandas w_con_imp_bandas

on w_con_imp_bandas.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.st_nombre=create st_nombre
this.em_nombre=create em_nombre
this.em_ciudad=create em_ciudad
this.em_pais=create em_pais
this.st_referencia=create st_referencia
this.em_refe=create em_refe
this.st_2=create st_2
this.st_bulto=create st_bulto
this.em_bulto=create em_bulto
this.st_observaciones=create st_observaciones
this.gb_4=create gb_4
this.gb_1=create gb_1
this.em_obser=create em_obser
this.cb_1=create cb_1
this.st_1=create st_1
this.st_3=create st_3
this.uo_cliente=create uo_cliente
this.ddlb_1=create ddlb_1
this.uo_envio=create uo_envio
this.gb_2=create gb_2
this.em_direccion=create em_direccion
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.pb_imprimir
this.Control[iCurrent+4]=this.st_nombre
this.Control[iCurrent+5]=this.em_nombre
this.Control[iCurrent+6]=this.em_ciudad
this.Control[iCurrent+7]=this.em_pais
this.Control[iCurrent+8]=this.st_referencia
this.Control[iCurrent+9]=this.em_refe
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_bulto
this.Control[iCurrent+12]=this.em_bulto
this.Control[iCurrent+13]=this.st_observaciones
this.Control[iCurrent+14]=this.gb_4
this.Control[iCurrent+15]=this.gb_1
this.Control[iCurrent+16]=this.em_obser
this.Control[iCurrent+17]=this.cb_1
this.Control[iCurrent+18]=this.st_1
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.uo_cliente
this.Control[iCurrent+21]=this.ddlb_1
this.Control[iCurrent+22]=this.uo_envio
this.Control[iCurrent+23]=this.gb_2
this.Control[iCurrent+24]=this.em_direccion
this.Control[iCurrent+25]=this.pb_1
end on

on w_con_imp_bandas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.st_nombre)
destroy(this.em_nombre)
destroy(this.em_ciudad)
destroy(this.em_pais)
destroy(this.st_referencia)
destroy(this.em_refe)
destroy(this.st_2)
destroy(this.st_bulto)
destroy(this.em_bulto)
destroy(this.st_observaciones)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.em_obser)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.uo_cliente)
destroy(this.ddlb_1)
destroy(this.uo_envio)
destroy(this.gb_2)
destroy(this.em_direccion)
destroy(this.pb_1)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Impresión bandas sueltas"
istr_parametros.s_listado        =   "report_bandas_sueltas"
This.title                       =   istr_parametros.s_titulo_ventana

dw_listado.SetTransObject(sqlca)
ddlb_1.text = "Si"
f_activar_campo(uo_cliente.em_campo)

end event

event ue_listar;dw_listado.Reset()
dw_listado.SetRedraw (TRUE)

 dw_listado.InsertRow(1)		
 f_asignar_columna(dw_listado,1,"empresa",codigo_empresa)
 f_asignar_columna(dw_listado,1,"ciudad",em_ciudad.text)
 f_asignar_columna(dw_listado,1,"pais",em_pais.text)
 f_asignar_columna(dw_listado,1,"cliente",em_nombre.text)
 f_asignar_columna(dw_listado,1,"direccion",em_direccion.text)
 f_asignar_columna(dw_listado,1,"referencia",em_refe.text)
 f_asignar_columna(dw_listado,1,"bulto",em_bulto.text)
 f_asignar_columna(dw_listado,1,"observaciones",em_obser.text)
 

dw_listado.InsertRow(1)
dw_listado.DeleteRow(1)
dw_listado.SetRedraw (TRUE)
dw_listado.enabled =TRUE

f_imprimir_datawindow(dw_listado)
//dw_listado.Retrieve(em_nombre.text,em_direccion.text,em_pais.text,em_refe.text,codigo_empresa)
//dw_report =dw_listado
//Call Super::ue_listar
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_imp_bandas
integer y = 600
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_imp_bandas
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_imp_bandas
end type

type gb_3 from groupbox within w_con_imp_bandas
integer x = 96
integer y = 144
integer width = 1714
integer height = 264
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
end type

type dw_listado from datawindow within w_con_imp_bandas
boolean visible = false
integer x = 2053
integer y = 640
integer width = 521
integer height = 208
boolean bringtotop = true
string dataobject = "report_bandas_sueltas"
boolean livescroll = true
end type

type pb_imprimir from upb_imprimir within w_con_imp_bandas
event clicked pbm_bnclicked
integer x = 1975
integer y = 212
integer width = 101
integer height = 84
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;Parent.triggerEvent("ue_listar")

f_activar_campo(uo_cliente.em_campo)
end event

type st_nombre from statictext within w_con_imp_bandas
integer x = 233
integer y = 448
integer width = 183
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Datos:"
boolean focusrectangle = false
end type

type em_nombre from u_em_campo within w_con_imp_bandas
integer x = 421
integer y = 444
integer width = 1362
integer taborder = 40
end type

type em_ciudad from u_em_campo within w_con_imp_bandas
integer x = 421
integer y = 636
integer width = 1362
integer taborder = 50
boolean bringtotop = true
end type

type em_pais from u_em_campo within w_con_imp_bandas
integer x = 421
integer y = 732
integer width = 1362
integer taborder = 60
boolean bringtotop = true
end type

type st_referencia from statictext within w_con_imp_bandas
integer x = 123
integer y = 916
integer width = 334
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Referencia:"
boolean focusrectangle = false
end type

type em_refe from u_em_campo within w_con_imp_bandas
integer x = 471
integer y = 900
integer width = 480
integer taborder = 70
boolean bringtotop = true
string mask = "!!!!!!!"
string displaydata = "$"
end type

type st_2 from statictext within w_con_imp_bandas
integer x = 2075
integer y = 212
integer width = 585
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Impresión banda"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_bulto from statictext within w_con_imp_bandas
integer x = 1019
integer y = 924
integer width = 251
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "NºBulto:"
boolean focusrectangle = false
end type

type em_bulto from u_em_campo within w_con_imp_bandas
integer x = 1266
integer y = 900
integer width = 187
integer taborder = 80
boolean bringtotop = true
string mask = "!!!"
string displaydata = "~b"
end type

type st_observaciones from statictext within w_con_imp_bandas
integer x = 123
integer y = 996
integer width = 471
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Observaciones :"
boolean focusrectangle = false
end type

type gb_4 from groupbox within w_con_imp_bandas
integer x = 1952
integer y = 172
integer width = 727
integer height = 220
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_1 from groupbox within w_con_imp_bandas
integer x = 91
integer y = 844
integer width = 1714
integer height = 584
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
end type

type em_obser from multilineedit within w_con_imp_bandas
integer x = 462
integer y = 1048
integer width = 1193
integer height = 340
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_con_imp_bandas
integer x = 1975
integer y = 296
integer width = 686
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Limpiar campos"
end type

event clicked;uo_cliente.em_codigo.text = ""
uo_cliente.em_campo.text  = ""
uo_envio.em_codigo.text   = ""
uo_envio.em_campo.text    = ""

em_nombre.text    = ""
em_bulto.text     = ""
em_bulto.text     = ""
em_ciudad.text    = ""
em_direccion.text = ""
em_obser.text     = ""
em_refe.text      = ""
em_pais.text      = ""

f_activar_campo(uo_cliente.em_campo)

end event

type st_1 from statictext within w_con_imp_bandas
integer x = 128
integer y = 196
integer width = 219
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
boolean focusrectangle = false
end type

type st_3 from statictext within w_con_imp_bandas
integer x = 274
integer y = 300
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Dire.Envio:"
boolean focusrectangle = false
end type

type uo_cliente from u_em_campo_2 within w_con_imp_bandas
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 617
integer y = 184
integer width = 1170
integer height = 88
integer taborder = 20
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;if ddlb_1.text = "Si" then
	uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
Else
   uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)	
End if

If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	em_nombre.text = ""
	em_ciudad.text = ""
	em_direccion.text = ""
	em_pais.text  = ""
	em_refe.text = ""
	Return
end if 
string tipo_cli
tipo_cli ="N"

if ddlb_1.text = "Si" then 	tipo_cli = "S"

if tipo_cli = "S" then
	em_nombre.text    = f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
	em_direccion.text = f_domicilio_genter(codigo_empresa,"C",uo_cliente.em_codigo.text)
	em_pais.text      = f_nombre_pais(f_pais_genter(codigo_empresa,"C",uo_cliente.em_codigo.text))
   em_ciudad.text    = f_nombre_poblacion(codigo_empresa,"C",uo_cliente.em_codigo.text)
   if trim(em_ciudad.text)="" then em_ciudad.text = f_nombre_provincia(f_pais_genter(codigo_empresa,"C",uo_cliente.em_codigo.text),f_provincia_genter(codigo_empresa,"C",uo_cliente.em_codigo.text))
   
else
   em_nombre.text    = f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)	
	em_direccion.text = f_domicilio_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)
	em_pais.text      = f_nombre_pais(f_pais_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text))
   em_ciudad.text    = f_poblacion_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)
   if trim(em_ciudad.text)="" then em_ciudad.text = f_nombre_provincia(f_pais_genter(codigo_empresa,"C",uo_cliente.em_codigo.text),f_provincia_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text))	
End if



end event

event getfocus;call super::getfocus;if ddlb_1.text = "Si" then
	ue_titulo = "Selección de Clientes"
   ue_datawindow ="dw_ayuda_clientes"
   ue_filtro = ""
	uo_envio.visible = True
	st_3.visible     = TRue
Else
	ue_titulo = "Selección de no clientes"
   ue_datawindow ="dw_ayuda_vencliproforma"
   ue_filtro = ""
	uo_envio.visible = False
	st_3.visible     = False

End if
	
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

type ddlb_1 from dropdownlistbox within w_con_imp_bandas
integer x = 361
integer y = 184
integer width = 247
integer height = 272
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33551093
boolean vscrollbar = true
string item[] = {"Si","No"}
end type

type uo_envio from u_em_campo_2 within w_con_imp_bandas
event modificado pbm_custom01
event getfocus pbm_custom04
integer x = 617
integer y = 292
integer width = 1170
integer height = 88
integer taborder = 30
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_envio.em_campo.text=f_nombre_venenvio(codigo_empresa,uo_cliente.em_codigo.text,uo_envio.em_codigo.text)
If Trim(uo_envio.em_campo.text)="" then
	uo_envio.em_campo.text=""
	uo_envio.em_codigo.text=""
	Return
end if 

em_nombre.text    = uo_envio.em_campo.text

em_pais.text      = f_nombre_pais(f_pais_venenvio(codigo_empresa,uo_cliente.em_codigo.text,uo_envio.em_codigo.text))
em_ciudad.text    = f_localidad_venenvio(codigo_empresa,uo_cliente.em_codigo.text,uo_envio.em_codigo.text)
em_direccion.text = f_domicilio_venenvio(codigo_empresa,uo_cliente.em_codigo.text,uo_envio.em_codigo.text)
if trim(em_ciudad.text)="" then em_ciudad.text = f_nombre_provincia(em_pais.text,f_provincia_venenvio(codigo_empresa,uo_cliente.em_codigo.text,uo_envio.em_codigo.text)) 



end event

event getfocus;call super::getfocus;ue_titulo = "Selección direcciones de envios"
ue_datawindow ="dw_ayuda_venenvio"
ue_filtro = " cliente = '"+uo_cliente.em_codigo.text+"'"
	
end event

on uo_envio.destroy
call u_em_campo_2::destroy
end on

type gb_2 from groupbox within w_con_imp_bandas
integer x = 96
integer y = 396
integer width = 1714
integer height = 448
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 12632256
end type

type em_direccion from u_em_campo within w_con_imp_bandas
integer x = 421
integer y = 540
integer width = 1362
integer taborder = 51
boolean bringtotop = true
end type

type pb_1 from upb_salir within w_con_imp_bandas
integer x = 2683
integer y = 28
integer width = 110
integer height = 96
integer taborder = 0
boolean bringtotop = true
boolean originalsize = true
end type

