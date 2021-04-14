$PBExportHeader$wi_mant_venpieproforma.srw
forward
global type wi_mant_venpieproforma from wi_mvent_con_empresa
end type
type gb_1 from groupbox within wi_mant_venpieproforma
end type
type st_nombre_idioma from statictext within wi_mant_venpieproforma
end type
type dw_2 from datawindow within wi_mant_venpieproforma
end type
end forward

global type wi_mant_venpieproforma from wi_mvent_con_empresa
integer width = 2862
integer height = 1528
gb_1 gb_1
st_nombre_idioma st_nombre_idioma
dw_2 dw_2
end type
global wi_mant_venpieproforma wi_mant_venpieproforma

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"idioma",sle_valor.text)
end event

on ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "venseries"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento pies proforma"
	istr_parametros.s_listado        = "report_venpieproforma"
   This.title = istr_parametros.s_titulo_ventana
	
	dw_2.SetTransObject(SQLCA)
	dw_2.Retrieve(codigo_empresa)
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         This.TriggerEvent("ue_recuperar")
      END IF
   END IF

	
end event

on wi_mant_venpieproforma.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.st_nombre_idioma=create st_nombre_idioma
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.st_nombre_idioma
this.Control[iCurrent+3]=this.dw_2
end on

on wi_mant_venpieproforma.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.st_nombre_idioma)
destroy(this.dw_2)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venpieproforma
integer x = 23
integer y = 336
integer width = 2816
integer height = 280
string dataobject = "dw_venpieproforma"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venpieproforma
integer x = 160
integer y = 228
integer width = 242
string text = "Idioma:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venpieproforma
integer x = 1797
integer y = 228
integer width = 329
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venpieproforma
integer x = 2126
integer y = 228
integer width = 329
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venpieproforma
integer x = 411
integer y = 216
integer height = 92
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_idiomas"
ue_titulo     =  "AYUDA SELECCION IDIOMAS"
ue_filtro     =  ""
isle_campo    = This
valor_empresa   = FALSE

dw_2.Retrieve(codigo_empresa)
end event

event sle_valor::modificado;call super::modificado;st_nombre_idioma.text=f_nombre_idioma(sle_valor.text)

IF Trim(st_nombre_idioma.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venpieproforma
integer x = 2455
integer y = 228
integer width = 329
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venpieproforma
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venpieproforma
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venpieproforma
integer width = 2816
end type

type gb_1 from groupbox within wi_mant_venpieproforma
integer x = 1783
integer y = 192
integer width = 1015
integer height = 140
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type st_nombre_idioma from statictext within wi_mant_venpieproforma
integer x = 686
integer y = 224
integer width = 855
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type dw_2 from datawindow within wi_mant_venpieproforma
integer x = 23
integer y = 616
integer width = 2816
integer height = 668
boolean bringtotop = true
string dataobject = "dw_con_venpieproforma"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;iF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = dw_2.GetItemString(Row,"idioma")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

