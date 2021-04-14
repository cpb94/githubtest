$PBExportHeader$w_artespecif.srw
$PBExportComments$Ventana para la construcción del código del articulo
forward
global type w_artespecif from window
end type
type st_subformato from statictext within w_artespecif
end type
type p_subformato from upb_carpeta within w_artespecif
end type
type sle_subformato from u_em_campo within w_artespecif
end type
type st_5 from statictext within w_artespecif
end type
type st_subfamilia from statictext within w_artespecif
end type
type p_subfamilia from upb_carpeta within w_artespecif
end type
type sle_subfamilia from u_em_campo within w_artespecif
end type
type st_3 from statictext within w_artespecif
end type
type p_familia from upb_carpeta within w_artespecif
end type
type sle_formato from u_em_campo within w_artespecif
end type
type sle_familia from u_em_campo within w_artespecif
end type
type p_formato from upb_carpeta within w_artespecif
end type
type pb_2 from picturebutton within w_artespecif
end type
type st_codigo from statictext within w_artespecif
end type
type st_formato from statictext within w_artespecif
end type
type st_familia from statictext within w_artespecif
end type
type st_4 from statictext within w_artespecif
end type
type st_2 from statictext within w_artespecif
end type
type st_1 from statictext within w_artespecif
end type
type pb_1 from upb_salir within w_artespecif
end type
type gb_1 from groupbox within w_artespecif
end type
end forward

global type w_artespecif from window
integer x = 174
integer y = 260
integer width = 2098
integer height = 964
boolean titlebar = true
string title = "Construcción del Codigo del Articulo"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 12632256
boolean center = true
st_subformato st_subformato
p_subformato p_subformato
sle_subformato sle_subformato
st_5 st_5
st_subfamilia st_subfamilia
p_subfamilia p_subfamilia
sle_subfamilia sle_subfamilia
st_3 st_3
p_familia p_familia
sle_formato sle_formato
sle_familia sle_familia
p_formato p_formato
pb_2 pb_2
st_codigo st_codigo
st_formato st_formato
st_familia st_familia
st_4 st_4
st_2 st_2
st_1 st_1
pb_1 pb_1
gb_1 gb_1
end type
global w_artespecif w_artespecif

type variables
str_parametros  istr_parametros

boolean	ib_familia, ib_formato, ib_modelo
end variables

forward prototypes
public subroutine f_componer ()
end prototypes

public subroutine f_componer ();Dec{0} contador
String txt_contador,var_formato,var_familia
var_formato = sle_formato.text
var_familia = sle_familia.text

Select max(convert(int,modelo)) Into :contador From articulos
Where  articulos.empresa = :codigo_empresa;

IF IsNull(contador) Then contador = 0
contador = contador + 1

txt_contador= String(contador, "00000" )
 
IF Trim(st_formato.Text)<>"" and Trim(st_subformato.Text) <> "" and Trim(st_subfamilia.Text)<>"" THEN

	st_codigo.Text = f_componer_art(sle_familia.Text, &
											 sle_subfamilia.text, &
										 	 sle_formato.Text, &
											 sle_subformato.Text, &
										 	 txt_contador  )
ELSE
	st_codigo.text = ""
END IF

end subroutine

on w_artespecif.create
this.st_subformato=create st_subformato
this.p_subformato=create p_subformato
this.sle_subformato=create sle_subformato
this.st_5=create st_5
this.st_subfamilia=create st_subfamilia
this.p_subfamilia=create p_subfamilia
this.sle_subfamilia=create sle_subfamilia
this.st_3=create st_3
this.p_familia=create p_familia
this.sle_formato=create sle_formato
this.sle_familia=create sle_familia
this.p_formato=create p_formato
this.pb_2=create pb_2
this.st_codigo=create st_codigo
this.st_formato=create st_formato
this.st_familia=create st_familia
this.st_4=create st_4
this.st_2=create st_2
this.st_1=create st_1
this.pb_1=create pb_1
this.gb_1=create gb_1
this.Control[]={this.st_subformato,&
this.p_subformato,&
this.sle_subformato,&
this.st_5,&
this.st_subfamilia,&
this.p_subfamilia,&
this.sle_subfamilia,&
this.st_3,&
this.p_familia,&
this.sle_formato,&
this.sle_familia,&
this.p_formato,&
this.pb_2,&
this.st_codigo,&
this.st_formato,&
this.st_familia,&
this.st_4,&
this.st_2,&
this.st_1,&
this.pb_1,&
this.gb_1}
end on

on w_artespecif.destroy
destroy(this.st_subformato)
destroy(this.p_subformato)
destroy(this.sle_subformato)
destroy(this.st_5)
destroy(this.st_subfamilia)
destroy(this.p_subfamilia)
destroy(this.sle_subfamilia)
destroy(this.st_3)
destroy(this.p_familia)
destroy(this.sle_formato)
destroy(this.sle_familia)
destroy(this.p_formato)
destroy(this.pb_2)
destroy(this.st_codigo)
destroy(this.st_formato)
destroy(this.st_familia)
destroy(this.st_4)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.pb_1)
destroy(this.gb_1)
end on

type st_subformato from statictext within w_artespecif
integer x = 859
integer y = 288
integer width = 1134
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type p_subformato from upb_carpeta within w_artespecif
integer x = 750
integer y = 284
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;str_parametros lstr_param
lstr_param.s_argumentos[1]  = "wi_mant_subformatos"
lstr_param.s_argumentos[2]  = sle_subformato.Text
lstr_param.i_nargumentos    = 2
         
OpenWithParm(wi_mant_subformatos, lstr_param)

sle_formato.TriggerEvent("modificado")
end event

type sle_subformato from u_em_campo within w_artespecif
integer x = 485
integer y = 284
integer taborder = 20
end type

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_subformatos"
ue_titulo         = "AYUDA SELECCION DE SUBFORMATOS"
ue_filtro         = ""

if Trim(st_formato.text) = "" then
	f_activar_campo(sle_formato)
	Return
End if

end event

event modificado;call super::modificado;st_subformato.Text =f_nombre_subformato( codigo_empresa,sle_subformato.Text)
IF Len(st_subformato.Text) = 0 Then
	 sle_subformato.text = ""
END IF
IF Trim(st_formato.Text)<>"" and Trim(st_subformato.Text) <> "" and Trim(st_subfamilia.Text)<>"" THEN
	f_componer()
End if

end event

type st_5 from statictext within w_artespecif
integer x = 101
integer y = 296
integer width = 375
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "SubFormato:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_subfamilia from statictext within w_artespecif
integer x = 855
integer y = 492
integer width = 1134
integer height = 88
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type p_subfamilia from upb_carpeta within w_artespecif
integer x = 750
integer y = 492
integer width = 110
integer height = 96
integer taborder = 0
end type

event clicked;str_parametros lstr_param
lstr_param.s_argumentos[1]  = "wi_mant_subfamilias"
lstr_param.s_argumentos[2]  = sle_subfamilia.Text
lstr_param.i_nargumentos    = 2
         
OpenWithParm(wi_mant_subfamilias, lstr_param)

sle_familia.TriggerEvent(Modified!)
end event

type sle_subfamilia from u_em_campo within w_artespecif
integer x = 485
integer y = 492
integer taborder = 50
end type

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_subfamilias"
ue_titulo         = "AYUDA SELECCION DE SUBFAMILIAS"
ue_filtro         = ""

if Trim(st_familia.text) = "" then
	f_activar_campo(sle_familia)
	Return
End if
	
end event

event modificado;call super::modificado;st_subfamilia.Text = f_nombre_subfamilia( codigo_empresa,sle_subfamilia.Text)
IF Len(st_subfamilia.Text) = 0 Then
	 sle_subfamilia.text = ""
END IF
IF Trim(st_formato.Text)<>"" and Trim(st_subformato.Text) <> "" and Trim(st_subfamilia.Text)<>"" THEN
	f_componer()
end if

end event

type st_3 from statictext within w_artespecif
integer x = 123
integer y = 504
integer width = 352
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "SubFamilia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type p_familia from upb_carpeta within w_artespecif
event clicked pbm_bnclicked
integer x = 750
integer y = 388
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;str_parametros lstr_param
lstr_param.s_argumentos[1]  = "wi_mant_familias"
lstr_param.s_argumentos[2]  = sle_familia.Text
lstr_param.i_nargumentos    = 2
         
OpenWithParm(wi_mant_familias, lstr_param)

sle_familia.TriggerEvent(Modified!)
end event

type sle_formato from u_em_campo within w_artespecif
integer x = 485
integer y = 180
integer taborder = 10
end type

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_formatos"
ue_titulo         = "AYUDA SELECCION DE FORMATOS"
ue_filtro         = ""

end event

event modificado;call super::modificado;st_formato.Text =f_nombre_formato( codigo_empresa,sle_formato.Text)
IF Len(st_formato.Text) = 0 Then
	 sle_formato.text = ""
END IF
IF Trim(st_formato.Text)<>"" and Trim(st_subformato.Text) <> "" and Trim(st_subfamilia.Text)<>"" THEN
	f_componer()
End if

end event

type sle_familia from u_em_campo within w_artespecif
integer x = 485
integer y = 388
integer taborder = 30
end type

event modificado;call super::modificado;st_familia.Text =f_nombre_familia( codigo_empresa,sle_familia.Text)
IF Len(st_familia.Text) = 0 Then
	 sle_familia.text = ""
END IF
IF Trim(st_formato.Text)<>"" and Trim(st_subformato.Text) <> "" and Trim(st_subfamilia.Text)<>"" THEN
	f_componer()
end if

end event

event getfocus;call super::getfocus;ue_datawindow      = "dw_ayuda_familias"
ue_titulo         = "AYUDA SELECCION DE FAMILIAS"
ue_filtro         = ""

if Trim(st_subformato.text) = "" then
	f_activar_campo(sle_subformato)
	Return
End if
	
end event

type p_formato from upb_carpeta within w_artespecif
integer x = 750
integer y = 180
integer width = 110
integer height = 96
integer taborder = 0
string disabledname = "c:\bmp\carpeta.bmp"
end type

event clicked;call super::clicked;str_parametros lstr_param
lstr_param.s_argumentos[1]  = "wi_mant_formatos"
lstr_param.s_argumentos[2]  = sle_formato.Text
lstr_param.i_nargumentos    = 2
         
OpenWithParm(wi_mant_formatos, lstr_param)

sle_formato.TriggerEvent("modificado")
end event

type pb_2 from picturebutton within w_artespecif
integer x = 1207
integer y = 660
integer width = 96
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "c:\bmp\design1.bmp"
end type

event clicked;CloseWithReturn(Parent,st_codigo.Text)
end event

type st_codigo from statictext within w_artespecif
integer x = 146
integer y = 660
integer width = 1061
integer height = 88
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_formato from statictext within w_artespecif
integer x = 859
integer y = 184
integer width = 1134
integer height = 76
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_familia from statictext within w_artespecif
integer x = 855
integer y = 388
integer width = 1134
integer height = 88
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_4 from statictext within w_artespecif
integer x = 146
integer y = 592
integer width = 1061
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Código del artículo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_2 from statictext within w_artespecif
integer x = 187
integer y = 192
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Formato:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_artespecif
integer x = 187
integer y = 400
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Familia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type pb_1 from upb_salir within w_artespecif
integer x = 1975
integer y = 8
integer width = 101
integer height = 84
integer taborder = 0
string picturename = "exit!"
end type

type gb_1 from groupbox within w_artespecif
integer x = 91
integer y = 84
integer width = 1925
integer height = 704
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Especificaciones del artículo"
borderstyle borderstyle = styleraised!
end type

