$PBExportHeader$wi_mant_venprecioportes.srw
forward
global type wi_mant_venprecioportes from w_int_con_empresa
end type
type em_transpor from u_em_campo within wi_mant_venprecioportes
end type
type st_1 from statictext within wi_mant_venprecioportes
end type
type dw_1 from datawindow within wi_mant_venprecioportes
end type
type cb_insertar from u_boton within wi_mant_venprecioportes
end type
type cb_borrar from u_boton within wi_mant_venprecioportes
end type
type cb_grabar from u_boton within wi_mant_venprecioportes
end type
type st_trans from statictext within wi_mant_venprecioportes
end type
type gb_1 from groupbox within wi_mant_venprecioportes
end type
type pb_1 from upb_salir within wi_mant_venprecioportes
end type
end forward

global type wi_mant_venprecioportes from w_int_con_empresa
integer width = 2651
integer height = 1628
em_transpor em_transpor
st_1 st_1
dw_1 dw_1
cb_insertar cb_insertar
cb_borrar cb_borrar
cb_grabar cb_grabar
st_trans st_trans
gb_1 gb_1
pb_1 pb_1
end type
global wi_mant_venprecioportes wi_mant_venprecioportes

event open;call super::open;title='Mantenimiento de tarifas de portes'

dw_1.settransobject(sqlca)

dw_1.setrowfocusindicator(hand!)
end event

on wi_mant_venprecioportes.create
int iCurrent
call super::create
this.em_transpor=create em_transpor
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_insertar=create cb_insertar
this.cb_borrar=create cb_borrar
this.cb_grabar=create cb_grabar
this.st_trans=create st_trans
this.gb_1=create gb_1
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_transpor
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_insertar
this.Control[iCurrent+5]=this.cb_borrar
this.Control[iCurrent+6]=this.cb_grabar
this.Control[iCurrent+7]=this.st_trans
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.pb_1
end on

on wi_mant_venprecioportes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_transpor)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_insertar)
destroy(this.cb_borrar)
destroy(this.cb_grabar)
destroy(this.st_trans)
destroy(this.gb_1)
destroy(this.pb_1)
end on

event ue_f2;cb_insertar.triggerevent(clicked!)
end event

event ue_f3;cb_borrar.triggerevent(clicked!)
end event

event ue_f5;cb_grabar.triggerevent(clicked!)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within wi_mant_venprecioportes
integer taborder = 20
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within wi_mant_venprecioportes
end type

type st_empresa from w_int_con_empresa`st_empresa within wi_mant_venprecioportes
end type

type em_transpor from u_em_campo within wi_mant_venprecioportes
integer x = 448
integer y = 208
integer height = 92
integer taborder = 10
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_ventransportistas"
ue_titulo     =  "AYUDA SELECCION TRANSPORTISTAS"
ue_filtro     =  ""

end event

event modificado;call super::modificado; st_trans.text = f_nombre_ventransportista(codigo_empresa,em_transpor.text)	
 if Trim(st_trans.text)="" Then
      IF len( st_trans.text) <> 0 Then f_activar_campo(em_transpor)
		em_transpor.text = ""
      return
 End If
 
 dw_1.retrieve(codigo_empresa,em_transpor.text)
end event

type st_1 from statictext within wi_mant_venprecioportes
integer x = 32
integer y = 220
integer width = 407
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Transportista:"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from datawindow within wi_mant_venprecioportes
integer x = 151
integer y = 356
integer width = 1344
integer height = 992
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_venportesprecio"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_insertar from u_boton within wi_mant_venprecioportes
integer x = 1719
integer y = 492
integer height = 92
integer taborder = 30
boolean bringtotop = true
string text = "F2 - &Insertar"
end type

event clicked;int cont,donde,max=0

for cont=1 to dw_1.rowcount()
	if dw_1.object.contador[cont]>max then
		max=dw_1.object.contador[cont]
	end if
next

donde=dw_1.insertrow(0)

max++

dw_1.object.empresa[donde]=codigo_empresa
dw_1.object.transportista[donde]=em_transpor.text
dw_1.object.contador[donde]=max

dw_1.setfocus()
dw_1.setrow(donde)
dw_1.scrolltorow(donde)
dw_1.setcolumn("peso")
end event

type cb_borrar from u_boton within wi_mant_venprecioportes
integer x = 1719
integer y = 612
integer height = 92
integer taborder = 40
boolean bringtotop = true
string text = "F3 - &Borrar"
end type

event clicked;dw_1.deleterow(dw_1.getrow())
end event

type cb_grabar from u_boton within wi_mant_venprecioportes
integer x = 1719
integer y = 732
integer height = 92
integer taborder = 50
boolean bringtotop = true
string text = "F5 - &Grabar"
end type

event clicked;long cont,cont2

for cont=1 to dw_1.rowcount()
	for cont2=cont+1 to dw_1.rowcount()
		if dw_1.object.peso[cont]=dw_1.object.peso[cont2] then
			f_mensaje("Atención","El peso "+string(dw_1.object.peso[cont])+" está repetido."+char(13)+"Modifiquelo")
			return
		end if
	next
next

if dw_1.update()<>1 then
	f_mensaje("Atención","Error al grabar")
else
	f_mensaje("Ok","Datos grabados correctamente")
end if
end event

type st_trans from statictext within wi_mant_venprecioportes
integer x = 731
integer y = 216
integer width = 1435
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type gb_1 from groupbox within wi_mant_venprecioportes
integer x = 1701
integer y = 452
integer width = 439
integer height = 384
integer taborder = 70
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_1 from upb_salir within wi_mant_venprecioportes
integer x = 2491
integer y = 24
integer width = 110
integer height = 96
integer taborder = 10
boolean bringtotop = true
boolean originalsize = true
string picturename = "exit!"
end type

