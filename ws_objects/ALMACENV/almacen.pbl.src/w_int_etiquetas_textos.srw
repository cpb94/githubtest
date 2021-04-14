$PBExportHeader$w_int_etiquetas_textos.srw
$PBExportComments$Obsoleto
forward
global type w_int_etiquetas_textos from w_int_con_empresa
end type
type pb_1 from upb_salir within w_int_etiquetas_textos
end type
type st_texto from statictext within w_int_etiquetas_textos
end type
type st_4 from statictext within w_int_etiquetas_textos
end type
type st_6 from statictext within w_int_etiquetas_textos
end type
type em_texto1 from u_em_campo within w_int_etiquetas_textos
end type
type em_texto3 from u_em_campo within w_int_etiquetas_textos
end type
type em_texto4 from u_em_campo within w_int_etiquetas_textos
end type
type em_texto5 from u_em_campo within w_int_etiquetas_textos
end type
type em_etiquetas from u_em_campo within w_int_etiquetas_textos
end type
type em_texto2 from u_em_campo within w_int_etiquetas_textos
end type
type gb_1 from groupbox within w_int_etiquetas_textos
end type
type st_2 from statictext within w_int_etiquetas_textos
end type
type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_textos
end type
type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_textos
end type
type pb_imprimir_preli from picturebutton within w_int_etiquetas_textos
end type
type uo_manejo from u_manejo_datawindow within w_int_etiquetas_textos
end type
type em_zoom from u_em_campo within w_int_etiquetas_textos
end type
type dw_preliminar from datawindow within w_int_etiquetas_textos
end type
end forward

global type w_int_etiquetas_textos from w_int_con_empresa
integer width = 2917
integer height = 1624
pb_1 pb_1
st_texto st_texto
st_4 st_4
st_6 st_6
em_texto1 em_texto1
em_texto3 em_texto3
em_texto4 em_texto4
em_texto5 em_texto5
em_etiquetas em_etiquetas
em_texto2 em_texto2
gb_1 gb_1
st_2 st_2
pb_imprimir_etiquetas pb_imprimir_etiquetas
pb_preliminar_etiquetas pb_preliminar_etiquetas
pb_imprimir_preli pb_imprimir_preli
uo_manejo uo_manejo
em_zoom em_zoom
dw_preliminar dw_preliminar
end type
global w_int_etiquetas_textos w_int_etiquetas_textos

type variables
String var_zoom
end variables

forward prototypes
public subroutine f_desactivar (boolean bool)
public subroutine f_zoom (string valor)
public subroutine tipo_etiqueta ()
end prototypes

public subroutine f_desactivar (boolean bool);em_texto1.enabled = bool
em_texto2.enabled = bool
em_texto3.enabled = bool
em_texto4.enabled = bool
em_texto5.enabled = bool
em_etiquetas.enabled = bool


end subroutine

public subroutine f_zoom (string valor);dw_preliminar.Modify( "DataWindow.Print.Preview.Zoom =" + valor )
end subroutine

public subroutine tipo_etiqueta ();//dw_preliminar.Modify("Datawindow.Label.Shape= Rectangle" )
//dw_preliminar.Modify("Datawindow.Label.columns=" + uo_etiquetas.columnas.text)
//dw_preliminar.Modify("Datawindow.Label.Rows=" + uo_etiquetas.lineas.text)
//dw_preliminar.Modify("Datawindow.Label.Height=" + uo_etiquetas.largo.text)
//dw_preliminar.Modify("Datawindow.Label.Width=" + uo_etiquetas.ancho.text)
//
end subroutine

event ue_listar;Integer registros
dw_report = dw_preliminar
 registros = dw_report.RowCount()
 IF registros=0 Then
   MessageBox("No existen registros","No realiza el listado",Exclamation!, OK!,1)
   Return
 END IF
 CALL Super::ue_listar


 



end event

event open;call super::open;istr_parametros.s_titulo_ventana="Listado etiquetas articulos"
This.title=istr_parametros.s_titulo_ventana
em_zoom.text="80"

end event

on w_int_etiquetas_textos.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.st_texto=create st_texto
this.st_4=create st_4
this.st_6=create st_6
this.em_texto1=create em_texto1
this.em_texto3=create em_texto3
this.em_texto4=create em_texto4
this.em_texto5=create em_texto5
this.em_etiquetas=create em_etiquetas
this.em_texto2=create em_texto2
this.gb_1=create gb_1
this.st_2=create st_2
this.pb_imprimir_etiquetas=create pb_imprimir_etiquetas
this.pb_preliminar_etiquetas=create pb_preliminar_etiquetas
this.pb_imprimir_preli=create pb_imprimir_preli
this.uo_manejo=create uo_manejo
this.em_zoom=create em_zoom
this.dw_preliminar=create dw_preliminar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.st_texto
this.Control[iCurrent+3]=this.st_4
this.Control[iCurrent+4]=this.st_6
this.Control[iCurrent+5]=this.em_texto1
this.Control[iCurrent+6]=this.em_texto3
this.Control[iCurrent+7]=this.em_texto4
this.Control[iCurrent+8]=this.em_texto5
this.Control[iCurrent+9]=this.em_etiquetas
this.Control[iCurrent+10]=this.em_texto2
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.st_2
this.Control[iCurrent+13]=this.pb_imprimir_etiquetas
this.Control[iCurrent+14]=this.pb_preliminar_etiquetas
this.Control[iCurrent+15]=this.pb_imprimir_preli
this.Control[iCurrent+16]=this.uo_manejo
this.Control[iCurrent+17]=this.em_zoom
this.Control[iCurrent+18]=this.dw_preliminar
end on

on w_int_etiquetas_textos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.st_texto)
destroy(this.st_4)
destroy(this.st_6)
destroy(this.em_texto1)
destroy(this.em_texto3)
destroy(this.em_texto4)
destroy(this.em_texto5)
destroy(this.em_etiquetas)
destroy(this.em_texto2)
destroy(this.gb_1)
destroy(this.st_2)
destroy(this.pb_imprimir_etiquetas)
destroy(this.pb_preliminar_etiquetas)
destroy(this.pb_imprimir_preli)
destroy(this.uo_manejo)
destroy(this.em_zoom)
destroy(this.dw_preliminar)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_etiquetas_textos
integer x = 603
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_etiquetas_textos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_etiquetas_textos
integer y = 24
integer width = 2674
integer height = 108
end type

type pb_1 from upb_salir within w_int_etiquetas_textos
integer x = 2711
integer y = 24
integer height = 108
integer taborder = 0
string picturename = "c:\bmp\salir1.bmp"
end type

type st_texto from statictext within w_int_etiquetas_textos
boolean visible = false
integer x = 1458
integer y = 248
integer width = 443
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

type st_4 from statictext within w_int_etiquetas_textos
integer x = 1216
integer y = 172
integer width = 219
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Nº Eti."
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_6 from statictext within w_int_etiquetas_textos
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

type em_texto1 from u_em_campo within w_int_etiquetas_textos
integer x = 69
integer y = 244
integer width = 1125
integer taborder = 10
textcase textcase = anycase!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_texto3 from u_em_campo within w_int_etiquetas_textos
integer x = 69
integer y = 420
integer width = 1125
integer taborder = 30
boolean bringtotop = true
textcase textcase = anycase!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_texto4 from u_em_campo within w_int_etiquetas_textos
integer x = 69
integer y = 508
integer width = 1125
integer taborder = 40
boolean bringtotop = true
textcase textcase = anycase!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_texto5 from u_em_campo within w_int_etiquetas_textos
integer x = 69
integer y = 596
integer width = 1125
integer taborder = 90
boolean bringtotop = true
textcase textcase = anycase!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type em_etiquetas from u_em_campo within w_int_etiquetas_textos
integer x = 1216
integer y = 244
integer width = 215
integer taborder = 290
end type

type em_texto2 from u_em_campo within w_int_etiquetas_textos
integer x = 69
integer y = 332
integer width = 1125
integer taborder = 20
textcase textcase = anycase!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type gb_1 from groupbox within w_int_etiquetas_textos
integer x = 1929
integer y = 152
integer width = 613
integer height = 148
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type st_2 from statictext within w_int_etiquetas_textos
integer x = 1943
integer y = 192
integer width = 352
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Etiquetas  "
alignment alignment = right!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type pb_imprimir_etiquetas from upb_imprimir within w_int_etiquetas_textos
integer x = 2299
integer y = 192
integer width = 123
integer height = 104
integer taborder = 0
boolean bringtotop = true
string picturename = "c:\bmp\print.bmp"
end type

event clicked;call super::clicked;tipo_etiqueta()
dw_report = dw_preliminar
dw_preliminar.reset()
Integer registro,registros,contador,reg
dw_preliminar.SetTransObject(SQLCA)
contador = 0
FOR reg = 1 To Dec(em_etiquetas.text)
 contador =contador + 1
 dw_preliminar.InsertRow(contador)
 dw_preliminar.SetItem(contador,"texto1",em_texto1.text)
 dw_preliminar.SetItem(contador,"texto2",em_texto2.text)
 dw_preliminar.SetItem(contador,"texto3",em_texto3.text)
 dw_preliminar.SetItem(contador,"texto4",em_texto4.text)
 dw_preliminar.SetItem(contador,"texto5",em_texto5.text)
 f_contador_procesos(reg,Dec(em_etiquetas.text))
NEXT
Parent.TriggerEvent("ue_listar")
f_activar_campo(em_texto1)
end event

type pb_preliminar_etiquetas from upb_preliminar within w_int_etiquetas_textos
integer x = 2414
integer y = 192
integer taborder = 0
boolean bringtotop = true
boolean originalsize = false
end type

event clicked;call super::clicked;tipo_etiqueta()
dw_preliminar.reset()
Integer registro,registros,contador,reg
dw_preliminar.SetTransObject(SQLCA)
contador = 0
f_zoom(em_zoom.text)
registros = Dec(em_etiquetas.text)
If registros = 0 then Return
For registro = 1 To registros
  	 contador =contador + 1
  	 dw_preliminar.InsertRow(contador)
    dw_preliminar.SetItem(contador,"texto1",em_texto1.text)
    dw_preliminar.SetItem(contador,"texto2",em_texto2.text)
    dw_preliminar.SetItem(contador,"texto3",em_texto3.text)
    dw_preliminar.SetItem(contador,"texto4",em_texto4.text)
    dw_preliminar.SetItem(contador,"texto5",em_texto5.text)
    f_contador_procesos(registro,registros)
Next

uo_manejo.visible = TRUE
pb_imprimir_preli.visible = TRUE
dw_preliminar.visible =  TRUE
em_zoom.visible =  TRUE
f_desactivar(FALSE)
  


end event

type pb_imprimir_preli from picturebutton within w_int_etiquetas_textos
integer x = 2400
integer y = 196
integer width = 110
integer height = 84
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "\bmp\print.bmp"
end type

event clicked;str_parametros pa
pa.s_listado = dw_preliminar.DataObject
OpenWithParm(w_impresoras_v2,dw_preliminar)
f_activar_campo(em_texto1)
end event

type uo_manejo from u_manejo_datawindow within w_int_etiquetas_textos
event destroy ( )
boolean visible = false
integer x = 1925
integer y = 148
integer width = 658
integer taborder = 50
end type

on uo_manejo.destroy
call u_manejo_datawindow::destroy
end on

event valores;call super::valores;dw_data = dw_preliminar
end event

type em_zoom from u_em_campo within w_int_etiquetas_textos
boolean visible = false
integer x = 2555
integer y = 192
integer width = 133
integer taborder = 190
string mask = "#####"
string displaydata = ""
end type

event modified;call super::modified;f_zoom(This.text)
end event

event tecla_tabulador;call super::tecla_tabulador;f_activar_campo(em_zoom)
end event

type dw_preliminar from datawindow within w_int_etiquetas_textos
boolean visible = false
integer x = 69
integer y = 332
integer width = 2770
integer height = 1080
string dataobject = "dw_int_etiquetas_textos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event doubleclicked;uo_manejo.visible = FALSE
dw_preliminar.visible   = False
pb_imprimir_preli.visible = False
em_zoom.visible =  FALSE
f_desactivar(TRUE)
dw_preliminar.reset()
uo_manejo.visible = FALSE
pb_imprimir_preli.visible = FALSE
dw_preliminar.visible =  FALSE
em_zoom.visible =  false
f_activar_campo(em_texto1)
end event

