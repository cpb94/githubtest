$PBExportHeader$w_int_etiquetas_promocion.srw
$PBExportComments$Ventana para impresión de etiquetas por artículo con varias líneas de texto.
forward
global type w_int_etiquetas_promocion from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_promocion
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_promocion
end type
type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_promocion
end type
type st_texto from statictext within w_int_etiquetas_promocion
end type
type gb_1 from groupbox within w_int_etiquetas_promocion
end type
type uo_articulo from u_em_campo_2 within w_int_etiquetas_promocion
end type
type st_4 from statictext within w_int_etiquetas_promocion
end type
type pb_2 from upb_papelera within w_int_etiquetas_promocion
end type
type em_etiquetas from u_em_campo within w_int_etiquetas_promocion
end type
type st_6 from statictext within w_int_etiquetas_promocion
end type
type dw_proceso from datawindow within w_int_etiquetas_promocion
end type
type em_zoom from u_em_campo within w_int_etiquetas_promocion
end type
type dw_1 from datawindow within w_int_etiquetas_promocion
end type
type dw_preliminar from datawindow within w_int_etiquetas_promocion
end type
type cb_1 from u_boton within w_int_etiquetas_promocion
end type
type st_2 from statictext within w_int_etiquetas_promocion
end type
end forward

global type w_int_etiquetas_promocion from w_int_con_empresa
integer width = 2917
integer height = 1616
pb_1 pb_1
pb_imprimir_etiquetas pb_imprimir_etiquetas
pb_preliminar_etiquetas pb_preliminar_etiquetas
st_texto st_texto
gb_1 gb_1
uo_articulo uo_articulo
st_4 st_4
pb_2 pb_2
em_etiquetas em_etiquetas
st_6 st_6
dw_proceso dw_proceso
em_zoom em_zoom
dw_1 dw_1
dw_preliminar dw_preliminar
cb_1 cb_1
st_2 st_2
end type
global w_int_etiquetas_promocion w_int_etiquetas_promocion

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
public subroutine f_zoom (string valor)
end prototypes

public subroutine f_desactivar (boolean bool);cb_1.enabled = bool
uo_articulo.enabled = bool
em_etiquetas.enabled = bool
dw_1.enabled = bool

end subroutine

public subroutine f_zoom (string valor);dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom =" + valor )
end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana="Listado Etiquetas Promoción"
This.title=istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_1.SetRowFocusIndicator(hand!)
em_zoom.text="80"
uo_articulo.em_campo.SetFocus()
end event

on w_int_etiquetas_promocion.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.pb_preliminar_etiquetas=create pb_preliminar_etiquetas
this.st_texto=create st_texto
this.gb_1=create gb_1
this.uo_articulo=create uo_articulo
this.st_4=create st_4
this.pb_2=create pb_2
this.em_etiquetas=create em_etiquetas
this.st_6=create st_6
this.dw_proceso=create dw_proceso
this.em_zoom=create em_zoom
this.dw_1=create dw_1
this.dw_preliminar=create dw_preliminar
this.cb_1=create cb_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.pb_imprimir_etiquetas
this.Control[iCurrent+3]=this.pb_preliminar_etiquetas
this.Control[iCurrent+4]=this.st_texto
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.uo_articulo
this.Control[iCurrent+7]=this.st_4
this.Control[iCurrent+8]=this.pb_2
this.Control[iCurrent+9]=this.em_etiquetas
this.Control[iCurrent+10]=this.st_6
this.Control[iCurrent+11]=this.dw_proceso
this.Control[iCurrent+12]=this.em_zoom
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.dw_preliminar
this.Control[iCurrent+15]=this.cb_1
this.Control[iCurrent+16]=this.st_2
end on

on w_int_etiquetas_promocion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.pb_imprimir_etiquetas)
destroy(this.pb_preliminar_etiquetas)
destroy(this.st_texto)
destroy(this.gb_1)
destroy(this.uo_articulo)
destroy(this.st_4)
destroy(this.pb_2)
destroy(this.em_etiquetas)
destroy(this.st_6)
destroy(this.dw_proceso)
destroy(this.em_zoom)
destroy(this.dw_1)
destroy(this.dw_preliminar)
destroy(this.cb_1)
destroy(this.st_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_promocion
integer taborder = 10
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_promocion
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_promocion
integer x = 18
integer y = 24
integer width = 2574
integer height = 108
end type

type pb_1 from upb_salir within w_int_etiquetas_promocion
integer x = 2670
integer y = 24
integer height = 108
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_promocion
integer x = 1531
integer y = 216
integer height = 100
integer taborder = 0
boolean originalsize = false
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;Integer 	registro,registros,contador,reg

dw_1.AcceptText()
dw_report = dw_preliminar
dw_preliminar.reset()
dw_preliminar.SetTransObject(SQLCA)

contador = 0
registros = dw_1.RowCount()
IF registros = 0 THEN 
	Return
ELSE	
	FOR registro = 1 TO registros
		FOR reg = 1 TO dw_1.GetItemNumber(registro,"etiquetas")
  			 contador =contador + 1
		  	 dw_preliminar.InsertRow(contador)
			 dw_preliminar.SetItem(contador,"texto",dw_1.GetItemString(registro,"articulo"))
		  NEXT
	f_contador_procesos(registro,registros)
	Next
END IF
   
f_imprimir_datawindow(dw_preliminar)	
//st_texto.text= String(dw_preliminar.RowCount()) + " Etiquetas"
//f_activar_campo(uo_articulo.em_campo)
end event

type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_promocion
integer x = 1655
integer y = 216
integer taborder = 0
boolean originalsize = false
end type

event clicked;call super::clicked;Integer	registro,registros,contador,reg

dw_1.AcceptText()
dw_preliminar.reset()
dw_preliminar.SetTransObject(SQLCA)
contador = 0

f_zoom(em_zoom.text)
registros = dw_1.RowCount()
IF registros = 0 THEN 
	Return
ELSE
	FOR registro = 1 TO registros
		FOR reg = 1 TO dw_1.GetItemNumber(registro,"etiquetas")
  	 		contador =contador + 1
  	 		dw_preliminar.InsertRow(contador)
	 		dw_preliminar.SetItem(contador,"texto",dw_1.GetItemString(registro,"articulo"))
  	NEXT
	f_contador_procesos(registro,registros)
	NEXT
   
	st_texto.text= String(dw_preliminar.RowCount()) + " Etiquetas"
	dw_preliminar.visible =  TRUE
	em_zoom.visible =  TRUE
	st_2.visible = TRUE
	f_desactivar(FALSE)
END IF


end event

type st_texto from statictext within w_int_etiquetas_promocion
boolean visible = false
integer x = 928
integer y = 344
integer width = 704
integer height = 68
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_int_etiquetas_promocion
integer x = 1157
integer y = 168
integer width = 640
integer height = 160
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type uo_articulo from u_em_campo_2 within w_int_etiquetas_promocion
event modificado pbm_custom01
event getfocus pbm_custom04
event destroy ( )
integer x = 69
integer y = 240
integer width = 654
integer height = 88
integer taborder = 20
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_articulo.em_campo.text=f_nombre_articulo(codigo_empresa,uo_articulo.em_codigo.text)

IF Trim(uo_articulo.em_campo.text) = "" THEN 
	IF Trim(uo_articulo.em_codigo.text) <> "" THEN 
		uo_articulo.em_campo.SetFocus()
		uo_articulo.em_campo.text=""
		uo_articulo.em_codigo.text=""
 		Return
	END IF
END IF

end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda Seleccion de Artículos"
ue_datawindow = "dw_ayuda_articulos"
ue_filtro     = ""


end event

on uo_articulo.destroy
call u_em_campo_2::destroy
end on

type st_4 from statictext within w_int_etiquetas_promocion
integer x = 727
integer y = 172
integer width = 402
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Etiquetas"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_2 from upb_papelera within w_int_etiquetas_promocion
integer x = 2121
integer y = 380
integer width = 183
integer height = 160
integer taborder = 0
end type

event clicked;call super::clicked;// Borra líneas de la datawindows de etiquetas.
IF dw_1.GetRow() = 0 THEN
	Return
ELSE
	dw_1.DeleteRow(dw_1.GetRow())
END IF
end event

type em_etiquetas from u_em_campo within w_int_etiquetas_promocion
integer x = 727
integer y = 240
integer width = 398
integer height = 88
integer taborder = 30
end type

event modificado;call super::modificado;//cb_1.triggerEvent(Clicked!)
end event

type st_6 from statictext within w_int_etiquetas_promocion
integer x = 69
integer y = 172
integer width = 658
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Artículo"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_proceso from datawindow within w_int_etiquetas_promocion
boolean visible = false
integer x = 5
integer width = 494
integer height = 92
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_proceso_almartplantilla"
boolean livescroll = true
end type

type em_zoom from u_em_campo within w_int_etiquetas_promocion
boolean visible = false
integer x = 2656
integer y = 236
integer width = 133
integer taborder = 60
string mask = "#####"
string displaydata = ""
end type

event modified;call super::modified;f_zoom(This.text)
end event

event tecla_tabulador;call super::tecla_tabulador;f_activar_campo(em_zoom)
end event

type dw_1 from datawindow within w_int_etiquetas_promocion
integer x = 439
integer y = 352
integer width = 1646
integer height = 1072
integer taborder = 50
string dataobject = "dw_int_etiquetas_promoción"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

type dw_preliminar from datawindow within w_int_etiquetas_promocion
boolean visible = false
integer x = 55
integer y = 348
integer width = 2747
integer height = 1028
boolean bringtotop = true
boolean titlebar = true
string title = "Preliminar"
string dataobject = "dw_int_eti_promocion_present"
boolean controlmenu = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;dw_preliminar.visible   = False
em_zoom.visible =  FALSE
st_2.visible = FALSE
f_desactivar(TRUE)
dw_preliminar.reset()
f_activar_campo(uo_articulo.em_campo)
end event

type cb_1 from u_boton within w_int_etiquetas_promocion
integer x = 1166
integer y = 212
integer width = 357
integer height = 104
integer taborder = 0
boolean bringtotop = true
string text = "&Etiquetas"
end type

event clicked;call super::clicked;// AÑADE FILAS EN LA DATAWINDOW PARA DISTINTAS ETIQUETAS.
Integer registro

// Inserta fila nueva
registro = dw_1.RowCount()
registro = registro + 1
dw_1.InsertRow(registro)
dw_1.SetItem(registro,"articulo",uo_articulo.em_campo.text)
dw_1.SetItem(registro,"etiquetas",Integer(em_etiquetas.text))

// Pasamos el foco a la fila activa de la datawindow
uo_articulo.em_campo.text  = "" 
uo_articulo.em_codigo.text = "" 
em_etiquetas.text          = ""

dw_1.SetRowFocusIndicator(Hand!) 
end event

type st_2 from statictext within w_int_etiquetas_promocion
boolean visible = false
integer x = 2299
integer y = 244
integer width = 352
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Zoom (%) :"
alignment alignment = center!
boolean focusrectangle = false
end type

