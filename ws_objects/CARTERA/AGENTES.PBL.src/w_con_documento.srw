$PBExportHeader$w_con_documento.srw
$PBExportComments$€
forward
global type w_con_documento from w_int_con_empresa
end type
type pb_1 from upb_salir within w_con_documento
end type
type dw_listado from datawindow within w_con_documento
end type
type gb_4 from groupbox within w_con_documento
end type
type gb_3 from groupbox within w_con_documento
end type
type gb_1 from groupbox within w_con_documento
end type
type gb_documento from groupbox within w_con_documento
end type
type gb_fecha from groupbox within w_con_documento
end type
type dw_1 from datawindow within w_con_documento
end type
type em_documento from u_em_campo within w_con_documento
end type
type st_2 from statictext within w_con_documento
end type
type cb_1 from commandbutton within w_con_documento
end type
type st_3 from statictext within w_con_documento
end type
type em_anyo from editmask within w_con_documento
end type
type pb_impresora from picturebutton within w_con_documento
end type
end forward

global type w_con_documento from w_int_con_empresa
integer width = 2944
integer height = 1652
pb_1 pb_1
dw_listado dw_listado
gb_4 gb_4
gb_3 gb_3
gb_1 gb_1
gb_documento gb_documento
gb_fecha gb_fecha
dw_1 dw_1
em_documento em_documento
st_2 st_2
cb_1 cb_1
st_3 st_3
em_anyo em_anyo
pb_impresora pb_impresora
end type
global w_con_documento w_con_documento

type variables
 string detalle="S"
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
end prototypes

public subroutine f_cargar (datawindow data);datetime fdesde,fhasta

fdesde = datetime(date("1/1/"+ em_anyo.text))
fhasta = datetime(date("31/12/"+ em_anyo.text))


data.retrieve(codigo_empresa,fdesde,fhasta,long(em_documento.text))


end subroutine

on w_con_documento.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.dw_listado=create dw_listado
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_1=create gb_1
this.gb_documento=create gb_documento
this.gb_fecha=create gb_fecha
this.dw_1=create dw_1
this.em_documento=create em_documento
this.st_2=create st_2
this.cb_1=create cb_1
this.st_3=create st_3
this.em_anyo=create em_anyo
this.pb_impresora=create pb_impresora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.dw_listado
this.Control[iCurrent+3]=this.gb_4
this.Control[iCurrent+4]=this.gb_3
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.gb_documento
this.Control[iCurrent+7]=this.gb_fecha
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.em_documento
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.cb_1
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.em_anyo
this.Control[iCurrent+14]=this.pb_impresora
end on

on w_con_documento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.dw_listado)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.gb_documento)
destroy(this.gb_fecha)
destroy(this.dw_1)
destroy(this.em_documento)
destroy(this.st_2)
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.em_anyo)
destroy(this.pb_impresora)
end on

event open;call super::open;istr_parametros.s_titulo_ventana =   "Consulta de Documentos de Liquidación"
istr_parametros.s_listado        =   ""
This.title                       =   istr_parametros.s_titulo_ventana

dw_1.SetTransObject(SQLCA)
dw_listado.SetTransObject(SQLCA)

em_anyo.text = string(Year(Today()))



end event

event ue_pagina_abajo;call super::ue_pagina_abajo;f_pagina_abajo(dw_1)
end event

event ue_pagina_arriba;call super::ue_pagina_arriba;f_pagina_arriba(dw_1)
end event

event ue_cursor_abajo;call super::ue_cursor_abajo;f_cursor_abajo(dw_1)
end event

event ue_cursor_arriba;call super::ue_cursor_arriba;f_cursor_arriba(dw_1)
end event

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_documento
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_documento
integer width = 78
integer height = 100
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_documento
integer x = 18
integer y = 12
end type

type pb_1 from upb_salir within w_con_documento
integer x = 2734
integer y = 204
integer width = 110
integer height = 96
integer taborder = 0
string picturename = "exit!"
end type

type dw_listado from datawindow within w_con_documento
boolean visible = false
integer x = 2222
integer width = 325
integer height = 200
boolean bringtotop = true
string dataobject = "report_con_documento"
boolean livescroll = true
end type

type gb_4 from groupbox within w_con_documento
integer x = 2085
integer y = 160
integer width = 343
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha"
end type

type gb_3 from groupbox within w_con_documento
integer x = 1125
integer y = 160
integer width = 960
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Agente"
end type

type gb_1 from groupbox within w_con_documento
integer x = 731
integer y = 160
integer width = 384
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_documento from groupbox within w_con_documento
integer x = 343
integer y = 160
integer width = 384
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Documento"
end type

type gb_fecha from groupbox within w_con_documento
integer x = 9
integer y = 160
integer width = 329
integer height = 152
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Año "
end type

type dw_1 from datawindow within w_con_documento
integer x = 5
integer y = 332
integer width = 2839
integer height = 1072
string dataobject = "dw_con_documento"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;//if row=0 then Return
//string albaran
//date fec
//str_parametros lstr_param 
//  lstr_param.i_nargumentos=3
//  lstr_param.s_argumentos[2]=String(dw_1.GetItemNumber(This.GetRow(),"anyo"))
//  lstr_param.s_argumentos[3]=String(dw_1.GetItemNumber(This.GetRow(),"albaran"))
//  OpenWithParm(w_con_promalbaranes,lstr_param)
//
end event

type em_documento from u_em_campo within w_con_documento
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 402
integer y = 216
integer width = 265
integer taborder = 10
boolean bringtotop = true
long backcolor = 16777215
alignment alignment = right!
maskdatatype maskdatatype = numericmask!
string mask = "##########"
string displaydata = "Ä"
end type

event getfocus;call super::getfocus;ue_titulo     = "AYUDA SELECCION DOCUMENTOS LIQUIDACIÓN"
ue_datawindow = "dw_ayuda_doc_liquidacion"
ue_filtro     = ""		
//isle_campo    = this

end event

event modificado;call super::modificado;

st_2.text=f_nombre_agente_doc(codigo_empresa, dec(em_anyo.text), long(em_documento.text))
st_3.text = string(date(f_fecha_doc(codigo_empresa, dec(em_anyo.text), long(em_documento.text))))

IF Trim(st_2.text)="" THEN 
 IF Trim(st_2.text)<>"" Then f_activar_campo(em_documento)
 em_documento.text=""
 st_3.text = ""
 st_2.text = ""
END IF
end event

type st_2 from statictext within w_con_documento
integer x = 1138
integer y = 220
integer width = 919
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_con_documento
integer x = 754
integer y = 204
integer width = 338
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
string text = "Consultar"
end type

event clicked;f_cargar(dw_1)
end event

type st_3 from statictext within w_con_documento
integer x = 2107
integer y = 220
integer width = 288
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type em_anyo from editmask within w_con_documento
integer x = 73
integer y = 208
integer width = 224
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "yyyy"
string displaydata = "x"
end type

type pb_impresora from picturebutton within w_con_documento
event clicked pbm_bnclicked
integer x = 2592
integer y = 204
integer width = 110
integer height = 96
integer taborder = 1
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "print!"
string disabledname = "c:\bmp\imp32_no.bmp"
alignment htextalign = left!
end type

event clicked;f_cargar(dw_listado)

f_imprimir_datawindow(dw_listado)
end event

