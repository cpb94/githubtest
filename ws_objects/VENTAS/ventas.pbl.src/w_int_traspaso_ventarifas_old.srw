$PBExportHeader$w_int_traspaso_ventarifas_old.srw
$PBExportComments$Transpaso de una tarifa a otra aplicanco un cambio.
forward
global type w_int_traspaso_ventarifas_old from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_traspaso_ventarifas_old
end type
type st_2 from statictext within w_int_traspaso_ventarifas_old
end type
type em_tarifa from u_em_campo within w_int_traspaso_ventarifas_old
end type
type st_nombre_tarifa from statictext within w_int_traspaso_ventarifas_old
end type
type dw_fechas from datawindow within w_int_traspaso_ventarifas_old
end type
type st_3 from statictext within w_int_traspaso_ventarifas_old
end type
type sle_moneda from singlelineedit within w_int_traspaso_ventarifas_old
end type
type gb_10 from groupbox within w_int_traspaso_ventarifas_old
end type
type em_tarifa_destino from u_em_campo within w_int_traspaso_ventarifas_old
end type
type dw_fechas_destino from datawindow within w_int_traspaso_ventarifas_old
end type
type st_5 from statictext within w_int_traspaso_ventarifas_old
end type
type sle_moneda_destino from singlelineedit within w_int_traspaso_ventarifas_old
end type
type st_4 from statictext within w_int_traspaso_ventarifas_old
end type
type rb_descendente from radiobutton within w_int_traspaso_ventarifas_old
end type
type rb_ascendente from radiobutton within w_int_traspaso_ventarifas_old
end type
type rb_lineal from radiobutton within w_int_traspaso_ventarifas_old
end type
type rb_porcentual from radiobutton within w_int_traspaso_ventarifas_old
end type
type st_texto from statictext within w_int_traspaso_ventarifas_old
end type
type em_cantidad from u_em_campo within w_int_traspaso_ventarifas_old
end type
type cb_procesar from u_boton within w_int_traspaso_ventarifas_old
end type
type dw_proceso from datawindow within w_int_traspaso_ventarifas_old
end type
type rb_cambio from radiobutton within w_int_traspaso_ventarifas_old
end type
type pb_2 from upb_carpeta within w_int_traspaso_ventarifas_old
end type
type st_nombre_tarifa_destino from statictext within w_int_traspaso_ventarifas_old
end type
type dw_proceso2 from datawindow within w_int_traspaso_ventarifas_old
end type
type rb_incremento from radiobutton within w_int_traspaso_ventarifas_old
end type
type em_cambio from u_em_campo within w_int_traspaso_ventarifas_old
end type
type st_1 from statictext within w_int_traspaso_ventarifas_old
end type
type uo_pavrev from u_marca_lista within w_int_traspaso_ventarifas_old
end type
type uo_familias from u_marca_lista within w_int_traspaso_ventarifas_old
end type
type uo_marcas from u_marca_lista within w_int_traspaso_ventarifas_old
end type
type uo_submarcas from u_marca_lista within w_int_traspaso_ventarifas_old
end type
type uo_formatos from u_marca_lista within w_int_traspaso_ventarifas_old
end type
type cb_formatos from commandbutton within w_int_traspaso_ventarifas_old
end type
type cb_submarcas from commandbutton within w_int_traspaso_ventarifas_old
end type
type cb_marcas from commandbutton within w_int_traspaso_ventarifas_old
end type
type cb_familias from commandbutton within w_int_traspaso_ventarifas_old
end type
type cb_pavrev from commandbutton within w_int_traspaso_ventarifas_old
end type
type cb_filtrar from u_boton within w_int_traspaso_ventarifas_old
end type
type dw_articulos_origen from datawindow within w_int_traspaso_ventarifas_old
end type
type dw_articulos_destino from datawindow within w_int_traspaso_ventarifas_old
end type
type rb_sobrescribir_en_destino from radiobutton within w_int_traspaso_ventarifas_old
end type
type rb_solo_no_existentes from radiobutton within w_int_traspaso_ventarifas_old
end type
type gb_1 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_2 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_5 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_6 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_7 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_3 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_9 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_8 from groupbox within w_int_traspaso_ventarifas_old
end type
type gb_4 from groupbox within w_int_traspaso_ventarifas_old
end type
end forward

global type w_int_traspaso_ventarifas_old from w_int_con_empresa
integer width = 4878
integer height = 3912
pb_1 pb_1
st_2 st_2
em_tarifa em_tarifa
st_nombre_tarifa st_nombre_tarifa
dw_fechas dw_fechas
st_3 st_3
sle_moneda sle_moneda
gb_10 gb_10
em_tarifa_destino em_tarifa_destino
dw_fechas_destino dw_fechas_destino
st_5 st_5
sle_moneda_destino sle_moneda_destino
st_4 st_4
rb_descendente rb_descendente
rb_ascendente rb_ascendente
rb_lineal rb_lineal
rb_porcentual rb_porcentual
st_texto st_texto
em_cantidad em_cantidad
cb_procesar cb_procesar
dw_proceso dw_proceso
rb_cambio rb_cambio
pb_2 pb_2
st_nombre_tarifa_destino st_nombre_tarifa_destino
dw_proceso2 dw_proceso2
rb_incremento rb_incremento
em_cambio em_cambio
st_1 st_1
uo_pavrev uo_pavrev
uo_familias uo_familias
uo_marcas uo_marcas
uo_submarcas uo_submarcas
uo_formatos uo_formatos
cb_formatos cb_formatos
cb_submarcas cb_submarcas
cb_marcas cb_marcas
cb_familias cb_familias
cb_pavrev cb_pavrev
cb_filtrar cb_filtrar
dw_articulos_origen dw_articulos_origen
dw_articulos_destino dw_articulos_destino
rb_sobrescribir_en_destino rb_sobrescribir_en_destino
rb_solo_no_existentes rb_solo_no_existentes
gb_1 gb_1
gb_2 gb_2
gb_5 gb_5
gb_6 gb_6
gb_7 gb_7
gb_3 gb_3
gb_9 gb_9
gb_8 gb_8
gb_4 gb_4
end type
global w_int_traspaso_ventarifas_old w_int_traspaso_ventarifas_old

type variables
String var_incremento,var_tipo

end variables

event open;call super::open;istr_parametros.s_titulo_ventana="Traspaso de tarifas"
This.title=istr_parametros.s_titulo_ventana
dw_fechas.SetTransObject(SQLCA)
dw_fechas_destino.SetTransObject(SQLCA)
dw_proceso2.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_fechas.SetRowFocusIndicator(Hand!)
dw_fechas_destino.SetRowFocusIndicator(Hand!)
var_incremento = "A"
var_tipo       = "L"

dw_articulos_origen.SetTransObject(SQLCA)
dw_articulos_destino.SetTransObject(SQLCA)

uo_familias.f_cargar_datos("dw_ayuda_familias","%","","Familia","Descripción")
uo_formatos.f_cargar_datos("dw_ayuda_formatos","%","","Formato","Descripción")
uo_marcas.f_cargar_datos("dw_ayuda_marcas","%","","Marca","Descripción")
uo_pavrev.f_cargar_datos("dw_ayuda_pavrev","%","","PavRev","Descripción")
uo_submarcas.f_cargar_datos("dw_ayuda_Submarcas","%","","Submarca","Descripción")


end event

on w_int_traspaso_ventarifas_old.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_2=create st_2
this.em_tarifa=create em_tarifa
this.st_nombre_tarifa=create st_nombre_tarifa
this.dw_fechas=create dw_fechas
this.st_3=create st_3
this.sle_moneda=create sle_moneda
this.gb_10=create gb_10
this.em_tarifa_destino=create em_tarifa_destino
this.dw_fechas_destino=create dw_fechas_destino
this.st_5=create st_5
this.sle_moneda_destino=create sle_moneda_destino
this.st_4=create st_4
this.rb_descendente=create rb_descendente
this.rb_ascendente=create rb_ascendente
this.rb_lineal=create rb_lineal
this.rb_porcentual=create rb_porcentual
this.st_texto=create st_texto
this.em_cantidad=create em_cantidad
this.cb_procesar=create cb_procesar
this.dw_proceso=create dw_proceso
this.rb_cambio=create rb_cambio
this.pb_2=create pb_2
this.st_nombre_tarifa_destino=create st_nombre_tarifa_destino
this.dw_proceso2=create dw_proceso2
this.rb_incremento=create rb_incremento
this.em_cambio=create em_cambio
this.st_1=create st_1
this.uo_pavrev=create uo_pavrev
this.uo_familias=create uo_familias
this.uo_marcas=create uo_marcas
this.uo_submarcas=create uo_submarcas
this.uo_formatos=create uo_formatos
this.cb_formatos=create cb_formatos
this.cb_submarcas=create cb_submarcas
this.cb_marcas=create cb_marcas
this.cb_familias=create cb_familias
this.cb_pavrev=create cb_pavrev
this.cb_filtrar=create cb_filtrar
this.dw_articulos_origen=create dw_articulos_origen
this.dw_articulos_destino=create dw_articulos_destino
this.rb_sobrescribir_en_destino=create rb_sobrescribir_en_destino
this.rb_solo_no_existentes=create rb_solo_no_existentes
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_5=create gb_5
this.gb_6=create gb_6
this.gb_7=create gb_7
this.gb_3=create gb_3
this.gb_9=create gb_9
this.gb_8=create gb_8
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.em_tarifa
this.Control[iCurrent+4]=this.st_nombre_tarifa
this.Control[iCurrent+5]=this.dw_fechas
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.sle_moneda
this.Control[iCurrent+8]=this.gb_10
this.Control[iCurrent+9]=this.em_tarifa_destino
this.Control[iCurrent+10]=this.dw_fechas_destino
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.sle_moneda_destino
this.Control[iCurrent+13]=this.st_4
this.Control[iCurrent+14]=this.rb_descendente
this.Control[iCurrent+15]=this.rb_ascendente
this.Control[iCurrent+16]=this.rb_lineal
this.Control[iCurrent+17]=this.rb_porcentual
this.Control[iCurrent+18]=this.st_texto
this.Control[iCurrent+19]=this.em_cantidad
this.Control[iCurrent+20]=this.cb_procesar
this.Control[iCurrent+21]=this.dw_proceso
this.Control[iCurrent+22]=this.rb_cambio
this.Control[iCurrent+23]=this.pb_2
this.Control[iCurrent+24]=this.st_nombre_tarifa_destino
this.Control[iCurrent+25]=this.dw_proceso2
this.Control[iCurrent+26]=this.rb_incremento
this.Control[iCurrent+27]=this.em_cambio
this.Control[iCurrent+28]=this.st_1
this.Control[iCurrent+29]=this.uo_pavrev
this.Control[iCurrent+30]=this.uo_familias
this.Control[iCurrent+31]=this.uo_marcas
this.Control[iCurrent+32]=this.uo_submarcas
this.Control[iCurrent+33]=this.uo_formatos
this.Control[iCurrent+34]=this.cb_formatos
this.Control[iCurrent+35]=this.cb_submarcas
this.Control[iCurrent+36]=this.cb_marcas
this.Control[iCurrent+37]=this.cb_familias
this.Control[iCurrent+38]=this.cb_pavrev
this.Control[iCurrent+39]=this.cb_filtrar
this.Control[iCurrent+40]=this.dw_articulos_origen
this.Control[iCurrent+41]=this.dw_articulos_destino
this.Control[iCurrent+42]=this.rb_sobrescribir_en_destino
this.Control[iCurrent+43]=this.rb_solo_no_existentes
this.Control[iCurrent+44]=this.gb_1
this.Control[iCurrent+45]=this.gb_2
this.Control[iCurrent+46]=this.gb_5
this.Control[iCurrent+47]=this.gb_6
this.Control[iCurrent+48]=this.gb_7
this.Control[iCurrent+49]=this.gb_3
this.Control[iCurrent+50]=this.gb_9
this.Control[iCurrent+51]=this.gb_8
this.Control[iCurrent+52]=this.gb_4
end on

on w_int_traspaso_ventarifas_old.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.em_tarifa)
destroy(this.st_nombre_tarifa)
destroy(this.dw_fechas)
destroy(this.st_3)
destroy(this.sle_moneda)
destroy(this.gb_10)
destroy(this.em_tarifa_destino)
destroy(this.dw_fechas_destino)
destroy(this.st_5)
destroy(this.sle_moneda_destino)
destroy(this.st_4)
destroy(this.rb_descendente)
destroy(this.rb_ascendente)
destroy(this.rb_lineal)
destroy(this.rb_porcentual)
destroy(this.st_texto)
destroy(this.em_cantidad)
destroy(this.cb_procesar)
destroy(this.dw_proceso)
destroy(this.rb_cambio)
destroy(this.pb_2)
destroy(this.st_nombre_tarifa_destino)
destroy(this.dw_proceso2)
destroy(this.rb_incremento)
destroy(this.em_cambio)
destroy(this.st_1)
destroy(this.uo_pavrev)
destroy(this.uo_familias)
destroy(this.uo_marcas)
destroy(this.uo_submarcas)
destroy(this.uo_formatos)
destroy(this.cb_formatos)
destroy(this.cb_submarcas)
destroy(this.cb_marcas)
destroy(this.cb_familias)
destroy(this.cb_pavrev)
destroy(this.cb_filtrar)
destroy(this.dw_articulos_origen)
destroy(this.dw_articulos_destino)
destroy(this.rb_sobrescribir_en_destino)
destroy(this.rb_solo_no_existentes)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.gb_7)
destroy(this.gb_3)
destroy(this.gb_9)
destroy(this.gb_8)
destroy(this.gb_4)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_traspaso_ventarifas_old
integer x = 1285
integer y = 24
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_traspaso_ventarifas_old
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_traspaso_ventarifas_old
integer x = 27
integer y = 8
integer width = 2427
end type

type pb_1 from upb_salir within w_int_traspaso_ventarifas_old
integer x = 4754
integer y = 4
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

type st_2 from statictext within w_int_traspaso_ventarifas_old
integer x = 37
integer y = 172
integer width = 256
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_tarifa from u_em_campo within w_int_traspaso_ventarifas_old
integer x = 325
integer y = 168
integer width = 261
integer height = 92
integer taborder = 10
end type

event modificado;call super::modificado;st_nombre_tarifa.text=f_nombre_ventarifa(codigo_empresa,em_tarifa.text)
IF Trim(st_nombre_tarifa.text)="" THEN 
 IF Trim(em_tarifa.text)<>"" Then  f_activar_campo(em_tarifa)
 em_tarifa.text=""
END IF
dw_fechas.retrieve(codigo_empresa,em_tarifa.text)   
sle_moneda.text = f_nombre_moneda_abr(f_moneda_ventarifas(codigo_empresa,em_tarifa.text))



 



end event

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

type st_nombre_tarifa from statictext within w_int_traspaso_ventarifas_old
integer x = 590
integer y = 172
integer width = 1010
integer height = 192
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_fechas from datawindow within w_int_traspaso_ventarifas_old
integer x = 1614
integer y = 132
integer width = 622
integer height = 352
boolean bringtotop = true
string dataobject = "dw_traspaso_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!
end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type st_3 from statictext within w_int_traspaso_ventarifas_old
integer x = 32
integer y = 280
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Moneda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_moneda from singlelineedit within w_int_traspaso_ventarifas_old
integer x = 325
integer y = 280
integer width = 261
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean autohscroll = false
end type

type gb_10 from groupbox within w_int_traspaso_ventarifas_old
integer x = 3154
integer y = 668
integer width = 517
integer height = 216
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type em_tarifa_destino from u_em_campo within w_int_traspaso_ventarifas_old
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 2907
integer y = 172
integer taborder = 70
end type

on getfocus;call u_em_campo::getfocus;      ue_titulo     = "AYUDA SELECCION DE TARIFAS"
		ue_datawindow = "dw_ayuda_ventarifas"
		ue_filtro     = ""
  


 
        
end on

event modificado;call super::modificado;st_nombre_tarifa_destino.text=f_nombre_ventarifa(codigo_empresa,em_tarifa_destino.text)
IF Trim(st_nombre_tarifa_destino.text)="" THEN 
 IF Trim(em_tarifa_destino.text)<>"" Then  f_activar_campo(em_tarifa_destino)
 em_tarifa_destino.text=""
END IF
dw_fechas_destino.retrieve(codigo_empresa,em_tarifa_destino.text)   
sle_moneda_destino.text = f_nombre_moneda_abr(f_moneda_ventarifas(codigo_empresa,em_tarifa_destino.text))



 



end event

type dw_fechas_destino from datawindow within w_int_traspaso_ventarifas_old
integer x = 4201
integer y = 132
integer width = 622
integer height = 352
boolean bringtotop = true
string dataobject = "dw_traspaso_venlintarifas1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event getfocus;This.BorderStyle = StyleLowered!
end event

event losefocus;This.BorderStyle = StyleRaised!
end event

type st_5 from statictext within w_int_traspaso_ventarifas_old
integer x = 2615
integer y = 280
integer width = 265
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Moneda:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_moneda_destino from singlelineedit within w_int_traspaso_ventarifas_old
integer x = 2907
integer y = 280
integer width = 251
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean autohscroll = false
end type

type st_4 from statictext within w_int_traspaso_ventarifas_old
integer x = 2619
integer y = 172
integer width = 256
integer height = 80
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Tarifa:"
alignment alignment = right!
boolean focusrectangle = false
end type

type rb_descendente from radiobutton within w_int_traspaso_ventarifas_old
integer x = 2647
integer y = 800
integer width = 485
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Descendente"
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "D"
rb_ascendente.Checked = False
rb_descendente.Checked = True
end event

type rb_ascendente from radiobutton within w_int_traspaso_ventarifas_old
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 2647
integer y = 716
integer width = 485
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Ascendente"
boolean checked = true
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "A"
rb_ascendente.Checked = True
rb_descendente.Checked = False
end event

type rb_lineal from radiobutton within w_int_traspaso_ventarifas_old
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 3177
integer y = 716
integer width = 485
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Lineal"
boolean checked = true
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "D"
rb_lineal.Checked = True
rb_porcentual.Checked = False
end event

type rb_porcentual from radiobutton within w_int_traspaso_ventarifas_old
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 3177
integer y = 800
integer width = 485
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Porcentual"
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;var_incremento = "A"
rb_lineal.Checked = False
rb_porcentual.Checked = TRUE
end event

type st_texto from statictext within w_int_traspaso_ventarifas_old
integer x = 3698
integer y = 716
integer width = 485
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = " Incremento"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_cantidad from u_em_campo within w_int_traspaso_ventarifas_old
integer x = 3698
integer y = 796
integer width = 485
integer taborder = 0
string text = "0"
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = decimalmask!
string mask = "###,###,###.##0"
end type

type cb_procesar from u_boton within w_int_traspaso_ventarifas_old
integer x = 2597
integer y = 912
integer width = 2258
integer height = 116
integer taborder = 0
string text = "&Procesar"
end type

event clicked;DateTime fecha_origen,fecha_destino,venfalta,venfecha   
String   tarifa_origen, tarifa_destino
Integer  registro,registros,numero,lI_existe
String   venempresa,ventarifa,venarticulo,vencalidad,venmontajeartcal
String   venfamilia,venformato,venmodelo,venactivo,venlistar,venusuario
String   vendescripcion,venexcepcion,ventipo_linea,var_moneda,vensub_familia
Dec      venprecio,incremento,venprecio_euros
Integer bien

uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false

IF Trim(em_tarifa.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca la tarifa origen")
	f_activar_campo(em_tarifa)
	Return
END IF

IF Trim(em_cantidad.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca el incremento")
	f_activar_campo(em_cantidad)
	Return
END IF

IF Trim(em_tarifa_destino.text) = "" Then 
	f_mensaje("Campo Obligatorio","Introduzca la tarifa destino")
	f_activar_campo(em_tarifa_destino)
	Return
END IF
var_moneda = f_moneda_ventarifas(codigo_empresa,em_tarifa_destino.text)

if rb_cambio.checked = TRUE Then
    var_incremento = "C"
  else	
    if rb_ascendente.checked = TRUE then
	    var_incremento = "A"
     else
	    var_incremento = "D"
    End if
End if

IF (Dec(em_cambio.text)= 0 or IsNull(em_cambio.text)) and var_incremento="C"  Then
		f_mensaje("Campo Obligatorio","El cambio no puede ser 0 ")
		f_activar_campo(em_cantidad)
		Return
END IF

if dw_articulos_origen.rowcount() = 0 then
	f_mensaje("Campo Obligatorio","No hay articulos para traspasar.")
	return
end if

if rb_lineal.checked = TRUE Then
   var_tipo = "L"
  Else 
   var_tipo = "P"
End if

bien = 0

fecha_origen  = dw_fechas.GetItemDateTime(dw_fechas.GetRow(),"fecha")
fecha_destino = dw_fechas_destino.GetItemDateTime(dw_fechas_destino.GetRow(),"fecha")

tarifa_origen = em_tarifa.text
tarifa_destino= em_tarifa_destino.text


Select count(*) Into :numero From venlintarifas
Where  venlintarifas.empresa = :codigo_empresa
And    venlintarifas.tarifa  = :tarifa_destino
And    venlintarifas.fecha   = :fecha_destino;
IF ISNull(numero) Then numero=0

//IF numero <>0 THEN
//	MessageBox("Tarifa ya generada","Esta tarifa ya existe",Exclamation!, OK!,1)
//	f_activar_campo(em_tarifa_destino)
//	Return
//END IF
//
//registros = dw_proceso2.Retrieve(codigo_empresa,tarifa_origen,fecha_origen)
//
//For registro = 1 To registros
//   venempresa  = codigo_empresa
//   ventarifa   = tarifa_destino
//   venfecha    = fecha_destino
//	venfamilia  = dw_proceso2.GetItemString(registro,"familia")
//   venformato  = dw_proceso2.GetItemString(registro,"formato")
//   vencalidad  = dw_proceso2.GetItemString(registro,"calidad")
//   venprecio   = dw_proceso2.GetItemNumber(registro,"precio")
//	IF var_incremento = "C" Then
//			   venprecio = venprecio / Dec(em_cantidad.text)
//			ELSE
//				If var_tipo = "L" Then incremento = Dec(em_cantidad.text)
//	  			If var_tipo = "P" Then incremento = (venprecio * Dec(em_cantidad.text))/100
//         	IF var_incremento = "D" Then incremento = incremento  * (-1)
//				venprecio = venprecio + incremento
//    		END IF
//			venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
//	  INSERT INTO ventarfamfor  
//         ( empresa,tarifa,fecha,familia,formato,calidad,precio)  
//  VALUES ( :venempresa,:ventarifa,:venfecha,:venfamilia,   
//           :venformato,:vencalidad,:venprecio )  ;
//
//Next

//registros = dw_proceso.Retrieve(codigo_empresa,tarifa_origen,fecha_origen)
//For registro = 1 To registros
//         venempresa  = codigo_empresa
//         ventarifa   = tarifa_destino
//         venfecha    = fecha_destino
//         venarticulo = dw_proceso.GetItemString(registro,"articulo")
//         vencalidad  = dw_proceso.GetItemString(registro,"calidad")
//         venprecio   = dw_proceso.GetItemNumber(registro,"precio")
//         venfalta    = DateTime(Today())
//         venmontajeartcal = dw_proceso.GetItemString(registro,"montajeartcal")
//         venfamilia       = dw_proceso.GetItemString(registro,"familia")
//         venformato       = dw_proceso.GetItemString(registro,"formato")
//         venmodelo        = dw_proceso.GetItemString(registro,"modelo")
//         venactivo        = dw_proceso.GetItemString(registro,"activo")
//         venlistar        = dw_proceso.GetItemString(registro,"listar")
//         venusuario       = nombre_usuario
//         vendescripcion   = dw_proceso.GetItemString(registro,"descripcion")
//         venexcepcion     = dw_proceso.GetItemString(registro,"excepcion")
//         ventipo_linea    = dw_proceso.GetItemString(registro,"tipo_linea")
//			IF var_incremento = "C" Then
//			 venprecio = venprecio / Dec(em_cantidad.text)
//			ELSE
//				If var_tipo = "L" Then incremento = Dec(em_cantidad.text)
//	  			If var_tipo = "P" Then incremento = (venprecio * Dec(em_cantidad.text))/100
//			   IF var_incremento = "D" Then incremento = incremento  * (-1)
//				venprecio = venprecio + incremento
//    		END IF
//			venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
//         
//	
//	INSERT INTO venlintarifas  
//   (empresa,tarifa,fecha,articulo,calidad,precio,falta,montajeartcal,
//	 familia,formato,modelo,activo,listar,usuario,descripcion,excepcion,   
//    tipo_linea )  
//  VALUES (:venempresa,:ventarifa,:venfecha,:venarticulo,:vencalidad,   
//          :venprecio, :venfalta, :venmontajeartcal,:venfamilia,:venformato,:venmodelo,   
//          :venactivo,:venlistar,:venusuario,:vendescripcion,:venexcepcion,:ventipo_linea);
//			 IF Sqlca.SqlCode<> 0 Then bien = 1
//		    f_contador_procesos(registro,registros)
//Next	
//

registros = dw_articulos_origen.rowcount()

For registro = 1 To registros
	f_contador_procesos(registro,registros)
	
	venarticulo = dw_articulos_origen.object.venlintarifas_articulo[registro]
	vencalidad  = dw_articulos_origen.object.calidad[registro]
	
	SELECT isnull(venlintarifas.precio,0), 
			 venlintarifas.montajeartcal, 
			 venlintarifas.familia, 
			 venlintarifas.formato, 
			 venlintarifas.modelo, 
			 venlintarifas.activo, 
			 venlintarifas.listar, 
			 venlintarifas.descripcion, 
			 venlintarifas.excepcion, 
			 venlintarifas.tipo_linea, 
			 venlintarifas.sub_familia, 
			 isnull(venlintarifas.precio_euros,0) 
	into  :venprecio, 
			:venmontajeartcal, 
			:venfamilia, 
			:venformato, 
			:venmodelo, 
			:venactivo, 
			:venlistar, 
			:vendescripcion, 
			:venexcepcion, 
			:ventipo_linea, 
			:vensub_familia, 
			:venprecio_euros 
	FROM   venlintarifas
	WHERE  venlintarifas.empresa  = :codigo_empresa
	AND    venlintarifas.tarifa   = :tarifa_origen
	AND    venlintarifas.fecha    = :fecha_origen
	AND    venlintarifas.articulo = :venarticulo
	AND    venlintarifas.calidad  = :vencalidad;
			
	if sqlca.sqlcode = 0 then
		
		//si el registro existe lo borramos
		
		lI_existe = 0
		
		SELECT isnull(count(*),0)
		INTO   :lI_existe
		FROM   venlintarifas
		WHERE  venlintarifas.empresa  = :codigo_empresa
		AND    venlintarifas.tarifa   = :tarifa_destino
		AND    venlintarifas.fecha    = :fecha_destino
		AND    venlintarifas.articulo = :venarticulo
		AND    venlintarifas.calidad  = :vencalidad;		
		
		if lI_existe > 0 then
			DELETE venlintarifas
			WHERE  venlintarifas.empresa  = :codigo_empresa
			AND    venlintarifas.tarifa   = :tarifa_destino
			AND    venlintarifas.fecha    = :fecha_destino
			AND    venlintarifas.articulo = :venarticulo
			AND    venlintarifas.calidad  = :vencalidad;					
		end if
		
		venempresa  = codigo_empresa
		ventarifa   = tarifa_destino
		venfecha    = fecha_destino
		venfalta    = DateTime(Today())
		venusuario  = nombre_usuario
		
		IF var_incremento = "C" Then
			venprecio = venprecio / Dec(em_cambio.text)
		ELSE
			If var_tipo = "L" Then incremento = Dec(em_cantidad.text)
			If var_tipo = "P" Then incremento = (venprecio * Dec(em_cantidad.text))/100
			IF var_incremento = "D" Then incremento = incremento  * (-1)
			venprecio = venprecio + incremento
		END IF
				 
		venprecio = Dec(String(venprecio,f_mascara_precios_moneda(var_moneda))) 
					
		INSERT INTO venlintarifas  
			(empresa,				tarifa,				fecha,
			 articulo,				calidad,				precio,
			 falta,					montajeartcal,		familia,
			 formato,				modelo,				activo,
			 listar,					usuario,				descripcion,
			 excepcion,				tipo_linea,			sub_familia,
			 precio_euros)  
		VALUES
			(:venempresa,			:ventarifa,			:venfecha,
			 :venarticulo,			:vencalidad,		:venprecio,
			 :venfalta,				:venmontajeartcal,:venfamilia,
			 :venformato,			:venmodelo,			:venactivo,
			 :venlistar,			:venusuario,		:vendescripcion,
			 :venexcepcion,		:ventipo_linea,	:vensub_familia,
			 :venprecio_euros);
			 
		IF Sqlca.SqlCode<> 0 Then bien = 1	
	else
		bien = 1
		messagebox("Error","Se ha producido un error de lectura.")
	end if	

Next	



  UPDATE venmapatarifas  
     SET tarifa_origen = :tarifa_origen,   
         fecha_origen  = :fecha_origen  
   WHERE ( venmapatarifas.empresa  = :codigo_empresa ) AND  
         ( venmapatarifas.tarifa   = :tarifa_destino ) AND  
         ( venmapatarifas.fecha    = :fecha_destino )   ;

IF bien = 0 Then
   COMMIT;
	f_mensaje("Proceso Finalizado","Proceso finalizado correctamente")
ELSE
	ROLLBACK;
	f_mensaje("ERROR!! en proceso ","Proceso finalizado con problemas")
END IF
//w_int_traspaso_ventarifas.enabled = TRUE
cb_filtrar.event clicked()
end event

type dw_proceso from datawindow within w_int_traspaso_ventarifas_old
boolean visible = false
integer width = 494
integer height = 80
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_proceso_venlintarifas"
boolean livescroll = true
end type

type rb_cambio from radiobutton within w_int_traspaso_ventarifas_old
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
event losefocus pbm_bnkillfocus
integer x = 4270
integer y = 612
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;this.checked = not(this.checked)

rb_incremento.checked = not(this.checked)


//var_incremento = "C"
//IF This.Checked = True Then
//	rb_cambio.Checked      = False
//Else
//	rb_cambio.Checked      = True
//End if
//
//st_texto.text  = "Cambio tarifa destino"
//st_texto.text  = "Cantidad Incremento"

end event

type pb_2 from upb_carpeta within w_int_traspaso_ventarifas_old
integer x = 3163
integer y = 164
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

 lstr_param.s_argumentos[2]=em_tarifa_destino.text
 f_activar_campo(em_tarifa_destino)
 OpenWithParm(wi_mant_ventarifas,lstr_param)



end event

type st_nombre_tarifa_destino from statictext within w_int_traspaso_ventarifas_old
integer x = 3273
integer y = 172
integer width = 914
integer height = 192
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type dw_proceso2 from datawindow within w_int_traspaso_ventarifas_old
boolean visible = false
integer x = 535
integer width = 494
integer height = 80
integer taborder = 1
boolean bringtotop = true
string dataobject = "dw_proceso_ventarfamfor"
boolean livescroll = true
end type

type rb_incremento from radiobutton within w_int_traspaso_ventarifas_old
integer x = 2642
integer y = 612
integer width = 82
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean checked = true
boolean automatic = false
borderstyle borderstyle = styleraised!
end type

event clicked;this.checked = not(this.checked)

rb_cambio.checked = not(this.checked)
end event

type em_cambio from u_em_campo within w_int_traspaso_ventarifas_old
integer x = 4265
integer y = 796
integer width = 485
integer taborder = 110
boolean bringtotop = true
string text = "0"
alignment alignment = right!
textcase textcase = anycase!
maskdatatype maskdatatype = decimalmask!
string mask = "###.##0.00####"
end type

type st_1 from statictext within w_int_traspaso_ventarifas_old
integer x = 4265
integer y = 716
integer width = 485
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Cambio"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type uo_pavrev from u_marca_lista within w_int_traspaso_ventarifas_old
event destroy ( )
boolean visible = false
integer x = 27
integer y = 700
integer taborder = 140
boolean bringtotop = true
boolean border = false
end type

on uo_pavrev.destroy
call u_marca_lista::destroy
end on

type uo_familias from u_marca_lista within w_int_traspaso_ventarifas_old
event destroy ( )
boolean visible = false
integer x = 402
integer y = 700
integer taborder = 150
boolean bringtotop = true
boolean border = false
end type

on uo_familias.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;//Aqui vamos a filtrar las marcas que debemos ver
long ll_indice,ll_total,ll_indice2,ll_total2
string ls_sel,ls_marcas_a_mostrar,ls_marca
datastore ds_datos

ll_total = this.dw_marca.RowCount()

for ll_indice = 1 to ll_total
	if (this.dw_marca.object.marca[ll_indice] = 'S' or (ll_indice = row and data = 'S')) and not(ll_indice = row and data = 'N') then
		ls_sel = "select marcas.codigo from marcas where empresa = '"+codigo_empresa+"' and familias_codigo = '"+this.dw_marca.object.codigo[ll_indice]+"'"
		
		ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice2 = 1 to ll_total2
			ls_marca = ds_datos.object.codigo[ll_indice2]
			
			if ls_marcas_a_mostrar = "" then
				ls_marcas_a_mostrar = "'"+ls_marca+"'"
			else
				ls_marcas_a_mostrar += ",'"+ls_marca+"'"
			end if
		next
		
		destroy ds_datos
		
	end if
next

if ls_marcas_a_mostrar <> "" then
	uo_marcas.dw_marca.setfilter("codigo in ("+ls_marcas_a_mostrar+")")
else
	uo_marcas.dw_marca.setfilter("0 = 1")
end if
uo_marcas.dw_marca.filter()
uo_marcas.event itemchanged(0,dwo,"")

end event

type uo_marcas from u_marca_lista within w_int_traspaso_ventarifas_old
event destroy ( )
boolean visible = false
integer x = 777
integer y = 700
integer taborder = 160
boolean bringtotop = true
boolean border = false
end type

on uo_marcas.destroy
call u_marca_lista::destroy
end on

event itemchanged;call super::itemchanged;//Aqui vamos a filtrar las submarcas que debemos ver
long ll_indice,ll_total,ll_indice2,ll_total2
string ls_sel,ls_submarcas_a_mostrar,ls_submarca
datastore ds_datos

ll_total = this.dw_marca.RowCount()

for ll_indice = 1 to ll_total
	if (this.dw_marca.object.marca[ll_indice] = 'S' or (ll_indice = row and data = 'S')) and not(ll_indice = row and data = 'N') then
		ls_sel = "select submarcas.codigo from submarcas where empresa = '"+codigo_empresa+"' and marcas_codigo = '"+this.dw_marca.object.codigo[ll_indice]+"'"
		
		ll_total2 = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
		
		for ll_indice2 = 1 to ll_total2
			ls_submarca = ds_datos.object.codigo[ll_indice2]
			
			if ls_submarcas_a_mostrar = "" then
				ls_submarcas_a_mostrar = "'"+ls_submarca+"'"
			else
				ls_submarcas_a_mostrar += ",'"+ls_submarca+"'"
			end if
		next
		
		destroy ds_datos
		
	end if
next

if ls_submarcas_a_mostrar <> "" then
	uo_submarcas.dw_marca.setfilter("codigo in ("+ls_submarcas_a_mostrar+")")
else
	uo_submarcas.dw_marca.setfilter("0 = 1")
end if
uo_submarcas.dw_marca.filter()
uo_submarcas.event itemchanged(0,dwo,"")

end event

type uo_submarcas from u_marca_lista within w_int_traspaso_ventarifas_old
event destroy ( )
boolean visible = false
integer x = 1152
integer y = 700
integer taborder = 170
boolean bringtotop = true
boolean border = false
end type

on uo_submarcas.destroy
call u_marca_lista::destroy
end on

type uo_formatos from u_marca_lista within w_int_traspaso_ventarifas_old
event destroy ( )
boolean visible = false
integer x = 1527
integer y = 700
integer taborder = 180
boolean bringtotop = true
boolean border = false
end type

on uo_formatos.destroy
call u_marca_lista::destroy
end on

type cb_formatos from commandbutton within w_int_traspaso_ventarifas_old
integer x = 1527
integer y = 568
integer width = 379
integer height = 116
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Formatos"
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = not(uo_formatos.visible)
uo_marcas.visible = false

uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_submarcas from commandbutton within w_int_traspaso_ventarifas_old
integer x = 1152
integer y = 568
integer width = 379
integer height = 116
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SubMarcas"
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false

uo_pavrev.visible = false
uo_submarcas.visible = not(uo_submarcas.visible)
end event

type cb_marcas from commandbutton within w_int_traspaso_ventarifas_old
integer x = 777
integer y = 568
integer width = 379
integer height = 116
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Marcas"
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = not(uo_marcas.visible)

uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_familias from commandbutton within w_int_traspaso_ventarifas_old
integer x = 402
integer y = 568
integer width = 379
integer height = 116
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Familias"
end type

event clicked;
uo_familias.visible = not(uo_familias.visible)
uo_formatos.visible = false
uo_marcas.visible = false

uo_pavrev.visible = false
uo_submarcas.visible = false
end event

type cb_pavrev from commandbutton within w_int_traspaso_ventarifas_old
integer x = 27
integer y = 568
integer width = 379
integer height = 116
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Pav./Rev."
end type

event clicked;
uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false

uo_pavrev.visible = not(uo_pavrev.visible)
uo_submarcas.visible = false
end event

type cb_filtrar from u_boton within w_int_traspaso_ventarifas_old
integer x = 18
integer y = 912
integer width = 2258
integer height = 116
integer taborder = 120
boolean bringtotop = true
string text = "Filtrar"
end type

event clicked;call super::clicked;int li_opciones,li_opciones_marcadas,li_indice
string ls_filtro,ls_texto_seleccion,ls_filtro_pavrev,ls_texto_filtro
string ls_filtro_familias,ls_filtro_marcas,ls_filtro_submarcas,ls_filtro_formatos
string ls_tarifa,ls_pavrev[],ls_familias[],ls_marcas[],ls_submarcas[],ls_formatos[]
datetime ldt_fecha_tarifa

uo_familias.visible = false
uo_formatos.visible = false
uo_marcas.visible = false
uo_pavrev.visible = false
uo_submarcas.visible = false

//Filtro de pavrev
li_opciones = uo_pavrev.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_pavrev.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_pavrev[li_opciones_marcadas] = uo_pavrev.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_pavrev.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_pavrev.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_pavrev.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') in ("+ls_filtro+") "
	else
		ls_filtro_pavrev = " and isnull(art_codestadistico.G1,'') = "+ls_filtro+" "
	end if
else
	ls_pavrev[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "PAVIMENTO Y REVESTIMIENTO"	
	else
		ls_texto_filtro += "~nPAVIMENTO Y REVESTIMIENTO"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = ls_texto_seleccion
	else
		ls_texto_filtro += "~n"+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de pavrev

//Filtro de familias
li_opciones = uo_familias.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_familias.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_familias[li_opciones_marcadas] = uo_familias.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_familias.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_familias.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_familias.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_familias = " and articulos.familia in ("+ls_filtro+") "
	else
		ls_filtro_familias = " and articulos.familia = "+ls_filtro+" "
	end if
else
	ls_familias[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS FAMILIAS"	
	else
		ls_texto_filtro += "~nTODAS LAS FAMILIAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FAMILIAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFAMILIAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de familias

//Filtro de marcas
li_opciones = uo_marcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_marcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_marcas[li_opciones_marcadas] = uo_marcas.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_marcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_marcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_marcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_marcas = " and articulos.marcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_marcas = " and articulos.marcas_codigo = "+ls_filtro+" "
	end if
else
	ls_marcas[1] = ""
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS MARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS MARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "MARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de marcas

//Filtro de submarcas
li_opciones = uo_submarcas.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_submarcas.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_submarcas[li_opciones_marcadas] = uo_submarcas.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_submarcas.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_submarcas.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_submarcas.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_submarcas = " and articulos.submarcas_codigo in ("+ls_filtro+") "
	else
		ls_filtro_submarcas = " and articulos.submarcas_codigo = "+ls_filtro+" "
	end if
else
	ls_submarcas[1] = ""	
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODAS LAS SUBMARCAS"	
	else
		ls_texto_filtro += "~nTODAS LAS SUBMARCAS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "SUBMARCAS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nSUBMARCAS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de submarcas

//Filtro de formatos
li_opciones = uo_formatos.dw_marca.RowCount()
li_opciones_marcadas = 0
ls_filtro= ''
ls_texto_seleccion = ''
for li_indice = 1 to li_opciones
	if uo_formatos.dw_marca.object.marca[li_indice]='S' then
		li_opciones_marcadas ++
		ls_formatos[li_opciones_marcadas] = uo_formatos.dw_marca.object.codigo[li_indice]
		if li_opciones_marcadas > 1 then
			ls_filtro += ",'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion += ","+uo_formatos.dw_marca.object.texto[li_indice]
		else
			ls_filtro = "'"+uo_formatos.dw_marca.object.codigo[li_indice]+"'"
			ls_texto_seleccion = uo_formatos.dw_marca.object.texto[li_indice]
		end if
	end if
next

if li_opciones_marcadas > 0 then
	if li_opciones_marcadas > 1 then
		ls_filtro_formatos = " and articulos.formato in ("+ls_filtro+") "
	else
		ls_filtro_formatos = " and articulos.formato = "+ls_filtro+" "
	end if
else
	ls_formatos[1] = ""	
end if

if li_opciones_marcadas = li_opciones or li_opciones_marcadas = 0 then
	if ls_texto_filtro = "" then
		ls_texto_filtro = "TODOS LOS FORMATOS"	
	else
		ls_texto_filtro += "~nTODOS LOS FORMATOS"	
	end if		
else
	if ls_texto_filtro = "" then
		ls_texto_filtro = "FORMATOS : "+ls_texto_seleccion
	else
		ls_texto_filtro += "~nFORMATOS : "+ls_texto_seleccion
	end if				
end if	
//Fin de filtro de formatos

//Origen
ls_tarifa        = em_tarifa.text
if dw_fechas.GetRow() > 0 then
	ldt_fecha_tarifa = dw_fechas.GetItemDateTime(dw_fechas.GetRow(),"fecha")
end if

dw_articulos_origen.retrieve(codigo_empresa,ls_tarifa,ldt_fecha_tarifa,ls_pavrev,ls_familias,ls_marcas,ls_submarcas,ls_formatos)

//Destino
ls_tarifa        = em_tarifa_destino.text
if dw_fechas_destino.GetRow() > 0 then
	ldt_fecha_tarifa = dw_fechas_destino.GetItemDateTime(dw_fechas_destino.GetRow(),"fecha")
end if

dw_articulos_destino.retrieve(codigo_empresa,ls_tarifa,ldt_fecha_tarifa,ls_pavrev,ls_familias,ls_marcas,ls_submarcas,ls_formatos)

if rb_solo_no_existentes.checked and dw_articulos_destino.rowcount() > 0 and dw_articulos_origen.rowcount() > 0 then
	long   ll_indice,ll_total,ll_existe
	string ls_articulo,ls_calidad,ls_busqueda
	
	ll_total = dw_articulos_destino.rowcount()
	
	for ll_indice = 1 to ll_total
		ls_articulo = dw_articulos_destino.object.venlintarifas_articulo[ll_indice]
		ls_calidad = dw_articulos_destino.object.calidad[ll_indice]
		
		ls_busqueda = "venlintarifas_articulo = '"+ls_articulo+"' and calidad = '"+ls_calidad+"'"
		
		ll_existe = dw_articulos_origen.find(ls_busqueda,1,dw_articulos_destino.rowcount())
		
		if ll_existe > 0 then
			dw_articulos_origen.deleterow(ll_existe)
		end if
		
	next
end if
end event

type dw_articulos_origen from datawindow within w_int_traspaso_ventarifas_old
integer x = 18
integer y = 1040
integer width = 2350
integer height = 2704
integer taborder = 130
boolean bringtotop = true
boolean titlebar = true
string title = "Articulos Origen"
string dataobject = "dw_int_traspaso_ventarifas_familia_marca_submarca1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_articulos_destino from datawindow within w_int_traspaso_ventarifas_old
integer x = 2505
integer y = 1040
integer width = 2350
integer height = 2704
integer taborder = 150
boolean bringtotop = true
boolean titlebar = true
string title = "Articulos Destino"
string dataobject = "dw_int_traspaso_ventarifas_familia_marca_submarca2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_sobrescribir_en_destino from radiobutton within w_int_traspaso_ventarifas_old
integer x = 745
integer y = 756
integer width = 1120
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Sobrescribir articulos en destino"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;cb_filtrar.event clicked()
end event

type rb_solo_no_existentes from radiobutton within w_int_traspaso_ventarifas_old
integer x = 745
integer y = 828
integer width = 1518
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 12632256
string text = "Solo traspasar los que no existen en destino"
borderstyle borderstyle = styleraised!
end type

event clicked;cb_filtrar.event clicked()
end event

type gb_1 from groupbox within w_int_traspaso_ventarifas_old
integer x = 18
integer y = 92
integer width = 2258
integer height = 400
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tarifa Origen"
end type

type gb_2 from groupbox within w_int_traspaso_ventarifas_old
integer x = 2597
integer y = 92
integer width = 2258
integer height = 400
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Tarifa Destino"
end type

type gb_5 from groupbox within w_int_traspaso_ventarifas_old
integer x = 18
integer y = 512
integer width = 2258
integer height = 400
integer taborder = 90
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Filtro"
end type

type gb_6 from groupbox within w_int_traspaso_ventarifas_old
integer x = 2624
integer y = 668
integer width = 517
integer height = 216
integer taborder = 90
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_7 from groupbox within w_int_traspaso_ventarifas_old
integer x = 3685
integer y = 668
integer width = 517
integer height = 216
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_3 from groupbox within w_int_traspaso_ventarifas_old
integer x = 2606
integer y = 600
integer width = 1614
integer height = 300
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "    Aplicar Incremento"
end type

type gb_9 from groupbox within w_int_traspaso_ventarifas_old
integer x = 4251
integer y = 668
integer width = 517
integer height = 216
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
end type

type gb_8 from groupbox within w_int_traspaso_ventarifas_old
integer x = 4233
integer y = 600
integer width = 608
integer height = 300
integer taborder = 100
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "    Aplicar Cambio"
end type

type gb_4 from groupbox within w_int_traspaso_ventarifas_old
integer x = 2597
integer y = 512
integer width = 2258
integer height = 400
integer taborder = 90
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Opciones del proceso"
end type

