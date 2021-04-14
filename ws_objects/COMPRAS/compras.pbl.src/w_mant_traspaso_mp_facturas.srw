$PBExportHeader$w_mant_traspaso_mp_facturas.srw
forward
global type w_mant_traspaso_mp_facturas from window
end type
type em_2 from u_em_campo within w_mant_traspaso_mp_facturas
end type
type st_descripcion_mp1 from statictext within w_mant_traspaso_mp_facturas
end type
type st_2 from statictext within w_mant_traspaso_mp_facturas
end type
type st_1 from statictext within w_mant_traspaso_mp_facturas
end type
type st_descripcion_mp2 from statictext within w_mant_traspaso_mp_facturas
end type
type em_1 from u_em_campo within w_mant_traspaso_mp_facturas
end type
type cb_2 from commandbutton within w_mant_traspaso_mp_facturas
end type
type cb_1 from commandbutton within w_mant_traspaso_mp_facturas
end type
end forward

global type w_mant_traspaso_mp_facturas from window
integer width = 2194
integer height = 548
boolean titlebar = true
string title = "Sustitución de MP en Facturas de Compra"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
em_2 em_2
st_descripcion_mp1 st_descripcion_mp1
st_2 st_2
st_1 st_1
st_descripcion_mp2 st_descripcion_mp2
em_1 em_1
cb_2 cb_2
cb_1 cb_1
end type
global w_mant_traspaso_mp_facturas w_mant_traspaso_mp_facturas

type variables
Long id_ventana_activa
end variables

on w_mant_traspaso_mp_facturas.create
this.em_2=create em_2
this.st_descripcion_mp1=create st_descripcion_mp1
this.st_2=create st_2
this.st_1=create st_1
this.st_descripcion_mp2=create st_descripcion_mp2
this.em_1=create em_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.em_2,&
this.st_descripcion_mp1,&
this.st_2,&
this.st_1,&
this.st_descripcion_mp2,&
this.em_1,&
this.cb_2,&
this.cb_1}
end on

on w_mant_traspaso_mp_facturas.destroy
destroy(this.em_2)
destroy(this.st_descripcion_mp1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_descripcion_mp2)
destroy(this.em_1)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;

if not isnull(Message.StringParm) and Message.StringParm <> "" then
	em_1.text = Message.StringParm
	em_1.triggerEvent("modificado")
end if
end event

event activate;//Ventanas en el menú principal
id_ventana_activa = f_menu_insertar_ventana(this)

end event

event close;f_menu_cerrar_ventana(this,id_ventana_activa)
end event

type em_2 from u_em_campo within w_mant_traspaso_mp_facturas
integer x = 46
integer y = 308
integer taborder = 20
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmprima"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS"
ue_filtro     =  ""
valor_empresa = TRUE
end event

event modificado;call super::modificado;if not trim(em_2.text) = "" and not IsNull(em_2.text) then
	st_descripcion_mp2.text = f_descripcion_venmprima(codigo_empresa, em_2.text)
else
	st_descripcion_mp2.text = ""
end if
end event

type st_descripcion_mp1 from statictext within w_mant_traspaso_mp_facturas
integer x = 347
integer y = 120
integer width = 1253
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_traspaso_mp_facturas
integer x = 46
integer y = 240
integer width = 722
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 553648127
string text = "Nueva Materia Prima:"
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type st_1 from statictext within w_mant_traspaso_mp_facturas
integer x = 46
integer y = 40
integer width = 727
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 33554432
long backcolor = 553648127
string text = "Materia Prima a sustituir:"
long bordercolor = 1073741824
boolean focusrectangle = false
end type

type st_descripcion_mp2 from statictext within w_mant_traspaso_mp_facturas
integer x = 347
integer y = 308
integer width = 1253
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type em_1 from u_em_campo within w_mant_traspaso_mp_facturas
integer x = 46
integer y = 120
integer taborder = 10
end type

event getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmprima"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS"
ue_filtro     =  ""
valor_empresa = TRUE
end event

event modificado;call super::modificado;if not trim(em_1.text) = "" and not IsNull(em_1.text) then
	st_descripcion_mp1.text = f_descripcion_venmprima(codigo_empresa, em_1.text)
else
	st_descripcion_mp1.text = ""
end if
end event

type cb_2 from commandbutton within w_mant_traspaso_mp_facturas
integer x = 1701
integer y = 128
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sustituir"
end type

event clicked;String origen, nueva, advertencia

if isnull(em_1.text) or em_1.text = "" then
	MessageBox("Error", "Debe indicar la Materia Prima a sustituir en las facturas.")
	return
end if

if isnull(em_2.text) or em_2.text = "" then
	MessageBox("Error", "Debe indicar la Nueva Materia Prima.")
	return
end if

origen = String(em_1.text)
nueva = String(em_2.text)

advertencia = "Vas a sustituir el Articulo "+origen+" por el "+nueva+" en TODAS las facturas que se hayan pasado hasta la fecha "+&
				  "del Articulo "+origen+".~nSe mantendrá la descripción que se grabó en su momento.~n"+&
				  "Gracias por reflexionar detenidamente esta acción.~n"+&
				  "¿Desea Continuar?"

if MessageBox("¡Atención!", advertencia, Question!, YesNo!) <> 1 then
	MessageBox("Info","Acción cancelada")
	return
end if



UPDATE comlinfac SET mprima = :nueva WHERE mprima = :origen USING SQLCA; 

if SQLCA.sqlcode <> 0 then
	MessageBox("Error", "Ha ocurrido un error en la actualización de la materia prima. Avise al administrador.")
else
	MessageBox("Sustitución de Materia Prima en facturas realizada correctamente", "Se ha sustituido con éxito la matera prima "+origen+" por la materia prima "+nueva+" en todas las facturas.")	
end if
end event

type cb_1 from commandbutton within w_mant_traspaso_mp_facturas
integer x = 1705
integer y = 260
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Volver"
end type

event clicked;Close (Parent)
end event

