$PBExportHeader$w_int_etiquetas_normales.srw
$PBExportComments$Etiquetas Texto Libre
forward
global type w_int_etiquetas_normales from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_normales
end type
type st_6 from statictext within w_int_etiquetas_normales
end type
type em_texto1 from u_em_campo within w_int_etiquetas_normales
end type
type em_texto3 from u_em_campo within w_int_etiquetas_normales
end type
type em_texto4 from u_em_campo within w_int_etiquetas_normales
end type
type em_texto2 from u_em_campo within w_int_etiquetas_normales
end type
type gb_1 from groupbox within w_int_etiquetas_normales
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_normales
end type
type em_texto5 from u_em_campo within w_int_etiquetas_normales
end type
type cbx_ean from checkbox within w_int_etiquetas_normales
end type
type dw_etiqueta from datawindow within w_int_etiquetas_normales
end type
type gb_2 from groupbox within w_int_etiquetas_normales
end type
end forward

global type w_int_etiquetas_normales from w_int_con_empresa
integer width = 1815
integer height = 1032
pb_1 pb_1
st_6 st_6
em_texto1 em_texto1
em_texto3 em_texto3
em_texto4 em_texto4
em_texto2 em_texto2
gb_1 gb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
em_texto5 em_texto5
cbx_ean cbx_ean
dw_etiqueta dw_etiqueta
gb_2 gb_2
end type
global w_int_etiquetas_normales w_int_etiquetas_normales

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
end prototypes

public subroutine f_desactivar (boolean bool);em_texto1.enabled = bool
em_texto2.enabled = bool
em_texto3.enabled = bool
em_texto4.enabled = bool
//em_etiquetas.enabled = bool


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Etiquetas Texto Libre"
This.title=istr_parametros.s_titulo_ventana


end event

on w_int_etiquetas_normales.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_6=create st_6
this.em_texto1=create em_texto1
this.em_texto3=create em_texto3
this.em_texto4=create em_texto4
this.em_texto2=create em_texto2
this.gb_1=create gb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.em_texto5=create em_texto5
this.cbx_ean=create cbx_ean
this.dw_etiqueta=create dw_etiqueta
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_6
this.Control[iCurrent+3]=this.em_texto1
this.Control[iCurrent+4]=this.em_texto3
this.Control[iCurrent+5]=this.em_texto4
this.Control[iCurrent+6]=this.em_texto2
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.pb_imprimir_etiquetas
this.Control[iCurrent+9]=this.em_texto5
this.Control[iCurrent+10]=this.cbx_ean
this.Control[iCurrent+11]=this.dw_etiqueta
this.Control[iCurrent+12]=this.gb_2
end on

on w_int_etiquetas_normales.destroy
call super::destroy
destroy(this.pb_1)
destroy(this.st_6)
destroy(this.em_texto1)
destroy(this.em_texto3)
destroy(this.em_texto4)
destroy(this.em_texto2)
destroy(this.gb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.em_texto5)
destroy(this.cbx_ean)
destroy(this.dw_etiqueta)
destroy(this.gb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_normales
integer x = 59
integer y = 616
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_normales
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_normales
integer y = 24
integer width = 1778
integer height = 80
end type

type pb_1 from upb_salir within w_int_etiquetas_normales
integer x = 1550
integer y = 184
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "Exit!"
end type

type st_6 from statictext within w_int_etiquetas_normales
integer x = 69
integer y = 172
integer width = 1129
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Textos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_texto1 from u_em_campo within w_int_etiquetas_normales
integer x = 69
integer y = 244
integer width = 1125
integer taborder = 20
fontcharset fontcharset = ansi!
string facename = "Arial"
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_texto3 from u_em_campo within w_int_etiquetas_normales
integer x = 69
integer y = 420
integer width = 1125
integer taborder = 40
boolean bringtotop = true
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_texto4 from u_em_campo within w_int_etiquetas_normales
integer x = 69
integer y = 508
integer width = 1125
integer taborder = 50
boolean bringtotop = true
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_texto2 from u_em_campo within w_int_etiquetas_normales
integer x = 69
integer y = 332
integer width = 1125
integer taborder = 30
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type gb_1 from groupbox within w_int_etiquetas_normales
integer x = 1371
integer y = 144
integer width = 146
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_normales
integer x = 1385
integer y = 184
integer width = 110
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
string picturename = "Print!"
end type

event clicked;string t1, t2, t3, t4, t5
long fila
string impresora, impresora_predeterminada

impresora = ''
impresora_predeterminada = f_impresora_predeterminada()

SELECT impresora_etiquetas
INTO   :impresora
FROM   empresas
WHERE  empresa = :codigo_empresa;

if f_cambia_impresora_predeterminada (impresora) then
	if cbx_ean.checked then
		dw_etiqueta.DataObject = "report_etiquetas_normales_ean"
	else
		dw_etiqueta.DataObject = "report_etiquetas_normales"
	end if
	
	dw_etiqueta.reset()
	
	fila = dw_etiqueta.insertrow(0)
	
	t1 = em_texto1.text
	t2 = em_texto2.text
	t3 = em_texto3.text
	t4 = em_texto4.text
	t5 = em_texto5.text
	
	dw_etiqueta.object.t1[fila] = t1
	dw_etiqueta.object.t2[fila] = t2
	dw_etiqueta.object.t3[fila] = t3
	dw_etiqueta.object.t4[fila] = t4
	dw_etiqueta.object.t5[fila] = t5
	
	dw_etiqueta.retrieve()
	
	f_imprimir_datawindow(dw_etiqueta)
else	
	messagebox ("ERROR", "No se pudo definir la impresora de etiquetas")
end if


if not f_cambia_impresora_predeterminada (impresora_predeterminada) then
	messagebox ("ERROR", "No se pudo restablecer la impresora predeterminada")
end if

end event

type em_texto5 from u_em_campo within w_int_etiquetas_normales
integer x = 69
integer y = 600
integer width = 1125
integer taborder = 60
boolean bringtotop = true
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type cbx_ean from checkbox within w_int_etiquetas_normales
integer x = 297
integer y = 732
integer width = 677
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 79741120
string text = "Codigo de barras"
end type

type dw_etiqueta from datawindow within w_int_etiquetas_normales
boolean visible = false
integer x = 1298
integer y = 524
integer width = 434
integer height = 424
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "report_etiquetas_normales"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_int_etiquetas_normales
integer x = 1531
integer y = 144
integer width = 146
integer height = 148
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

