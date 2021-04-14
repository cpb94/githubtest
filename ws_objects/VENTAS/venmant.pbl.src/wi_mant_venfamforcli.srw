$PBExportHeader$wi_mant_venfamforcli.srw
forward
global type wi_mant_venfamforcli from wi_mvent_con_empresa
end type
type st_nombre_calidad from statictext within wi_mant_venfamforcli
end type
type st_cliente from statictext within wi_mant_venfamforcli
end type
type sle_cliente from u_em_campo within wi_mant_venfamforcli
end type
type st_nombre_cliente from statictext within wi_mant_venfamforcli
end type
type dw_calidades from datawindow within wi_mant_venfamforcli
end type
type st_familia from statictext within wi_mant_venfamforcli
end type
type sle_familia from u_em_campo within wi_mant_venfamforcli
end type
type st_nombre_familia from statictext within wi_mant_venfamforcli
end type
type st_formato from statictext within wi_mant_venfamforcli
end type
type sle_formato from u_em_campo within wi_mant_venfamforcli
end type
type st_nombre_formato from statictext within wi_mant_venfamforcli
end type
end forward

global type wi_mant_venfamforcli from wi_mvent_con_empresa
integer width = 2400
integer height = 1664
st_nombre_calidad st_nombre_calidad
st_cliente st_cliente
sle_cliente sle_cliente
st_nombre_cliente st_nombre_cliente
dw_calidades dw_calidades
st_familia st_familia
sle_familia sle_familia
st_nombre_familia st_nombre_familia
st_formato st_formato
sle_formato sle_formato
st_nombre_formato st_nombre_formato
end type
global wi_mant_venfamforcli wi_mant_venfamforcli

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();IF Trim(sle_cliente.text)= "" or Trim(sle_familia.text) = "" or &
Trim(sle_valor.Text)=""  or Trim(sle_formato.text) = ""THEN
  dw_1.Reset()
ELSE
  dw_1.Retrieve(codigo_empresa,sle_cliente.text,sle_familia.text,sle_formato.text,sle_valor.Text)
END IF

end subroutine

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)

longitud      =  len(trim(sle_cliente.text))
criterio[2]   =  trim(sle_cliente.text)+space(20-longitud)

longitud      =  len(trim(sle_familia.text))
criterio[3]   =  trim(sle_familia.text)+space(20-longitud)

longitud      =  len(trim(sle_formato.text))
criterio[4]   =  trim(sle_formato.text)+space(20-longitud)

longitud      =  len(trim(sle_valor.text))
criterio[5]   =  trim(sle_valor.text)+space(20-longitud)

seleccion     =  criterio[1]+criterio[2]+criterio[3]+criterio[4]+criterio[5]
tabla         =  "venfamforcli"


f_control()

CALL Super::ue_recuperar
end event

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de familias-formatos/clientes"
istr_parametros.s_listado        = "report_venfamforcli"
This.title=istr_parametros.s_titulo_ventana
dw_calidades.SetTransObject(SQLCA)

end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"familia",sle_familia.text)
dw_1.setitem(dw_1.getrow(),"formato",sle_formato.text)
dw_1.setitem(dw_1.getrow(),"calidad",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"cliente",sle_cliente.text)


end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_familia.enabled=FALSE
sle_formato.enabled=FALSE
sle_cliente.enabled=FALSE
end event

on wi_mant_venfamforcli.create
int iCurrent
call super::create
this.st_nombre_calidad=create st_nombre_calidad
this.st_cliente=create st_cliente
this.sle_cliente=create sle_cliente
this.st_nombre_cliente=create st_nombre_cliente
this.dw_calidades=create dw_calidades
this.st_familia=create st_familia
this.sle_familia=create sle_familia
this.st_nombre_familia=create st_nombre_familia
this.st_formato=create st_formato
this.sle_formato=create sle_formato
this.st_nombre_formato=create st_nombre_formato
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nombre_calidad
this.Control[iCurrent+2]=this.st_cliente
this.Control[iCurrent+3]=this.sle_cliente
this.Control[iCurrent+4]=this.st_nombre_cliente
this.Control[iCurrent+5]=this.dw_calidades
this.Control[iCurrent+6]=this.st_familia
this.Control[iCurrent+7]=this.sle_familia
this.Control[iCurrent+8]=this.st_nombre_familia
this.Control[iCurrent+9]=this.st_formato
this.Control[iCurrent+10]=this.sle_formato
this.Control[iCurrent+11]=this.st_nombre_formato
end on

on wi_mant_venfamforcli.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_calidad)
destroy(this.st_cliente)
destroy(this.sle_cliente)
destroy(this.st_nombre_cliente)
destroy(this.dw_calidades)
destroy(this.st_familia)
destroy(this.sle_familia)
destroy(this.st_nombre_familia)
destroy(this.st_formato)
destroy(this.sle_formato)
destroy(this.st_nombre_formato)
end on

event ue_activa_claves;call super::ue_activa_claves;sle_familia.enabled=TRUE
sle_formato.enabled=TRUE
sle_cliente.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venfamforcli
integer x = 46
integer y = 420
integer width = 1765
integer height = 208
string dataobject = "dw_venfamforcli"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venfamforcli
integer x = 27
integer y = 320
integer width = 238
integer height = 80
string text = "Calidad:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venfamforcli
integer x = 1851
integer y = 340
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venfamforcli
integer x = 1851
integer y = 436
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venfamforcli
integer x = 270
integer y = 316
integer width = 297
integer taborder = 50
end type

event sle_valor::getfocus;ue_titulo       	= "AYUDA SELECCION DE CALIDADES "
ue_datawindow   	= "dw_ayuda_calidades"
ue_filtro 		   = "" 
isle_campo        = This
ue_campo          = This

IF trim(sle_familia.text)= "" THEN f_activar_campo(sle_familia)
IF trim(sle_formato.text)= "" THEN f_activar_campo(sle_formato)

IF trim(sle_valor.text)  = "" THEN f_control()

end event

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nombre_calidad.text=f_nombre_calidad(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_calidad.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venfamforcli
integer x = 1851
integer y = 532
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venfamforcli
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venfamforcli
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venfamforcli
end type

type st_nombre_calidad from statictext within wi_mant_venfamforcli
integer x = 576
integer y = 328
integer width = 777
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_cliente from statictext within wi_mant_venfamforcli
integer x = 18
integer y = 148
integer width = 247
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
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_cliente from u_em_campo within wi_mant_venfamforcli
integer x = 270
integer y = 144
integer width = 297
integer taborder = 10
end type

event modificado;call super::modificado;st_nombre_cliente.text=f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
dw_calidades.Retrieve(codigo_empresa,sle_cliente.text)
IF Trim(st_nombre_cliente.text)="" THEN 
 IF Trim(sle_cliente.text)<>"" Then  f_activar_campo(sle_cliente)
 sle_cliente.text=""
END IF
f_mascara_columna(dw_1,"precio",f_mascara_moneda(f_moneda_genter(codigo_empresa,"C",sle_cliente.text)))
f_mascara_columna(dw_calidades,"venfamforcli_precio",f_mascara_moneda(f_moneda_genter(codigo_empresa,"C",sle_cliente.text)))
end event

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE CLIENTES"
 ue_datawindow = "dw_ayuda_clientes"
 ue_filtro     = "" 	
 isle_campo    = This
 sle_valor.text = ""
 f_control()
         
 IF istr_parametros.i_nargumentos>1 THEN
     sle_cliente.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_cliente)
     sle_cliente.TriggerEvent("modificado")
	  sle_familia.text=istr_parametros.s_argumentos[3]	
     sle_familia.TriggerEvent("modificado")
	  sle_formato.text=istr_parametros.s_argumentos[4]	
     sle_formato.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[5]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
     IF Trim(sle_valor.text)<>"" and Trim(sle_familia.text)<>"" and Trim(sle_formato.text)<>""and Trim(sle_cliente.text)<>""THEN
          f_activar_campo(sle_valor)
          Parent.TriggerEvent("ue_recuperar")
	  END IF
 END IF







end event

type st_nombre_cliente from statictext within wi_mant_venfamforcli
integer x = 581
integer y = 156
integer width = 1029
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type dw_calidades from datawindow within wi_mant_venfamforcli
event clicked pbm_dwnlbuttonclk
integer x = 37
integer y = 632
integer width = 2277
integer height = 776
boolean bringtotop = true
string dataobject = "dw_venfamforcli1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF Row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return
sle_familia.text  = This.GetItemString(Row,"venfamforcli_familia")
sle_formato.text  = This.GetItemString(Row,"venfamforcli_formato")
sle_valor.text  = This.GetItemString(Row,"venfamforcli_calidad")
sle_familia.TriggerEvent("modificado")
sle_formato.TriggerEvent("modificado")
sle_valor.TriggerEvent("modificado")
st_nombre_calidad.text=f_nombre_calidad(codigo_empresa,sle_valor.text)
wi_mant_venfamforcli.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type st_familia from statictext within wi_mant_venfamforcli
integer x = 18
integer y = 236
integer width = 247
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
string text = "Familia:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_familia from u_em_campo within wi_mant_venfamforcli
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 270
integer y = 228
integer width = 297
integer taborder = 11
end type

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE FAMILIAS"
 ue_datawindow = "dw_ayuda_familias"
 ue_filtro     = "" 	
 isle_campo    = This
 sle_valor.text = ""
         

end event

event modificado;call super::modificado;st_nombre_familia.text=f_nombre_familia(codigo_empresa,sle_familia.text)
IF Trim(st_nombre_familia.text)="" THEN 
 IF Trim(sle_familia.text)<>"" Then  f_activar_campo(sle_familia)
 sle_familia.text=""
END IF

end event

type st_nombre_familia from statictext within wi_mant_venfamforcli
integer x = 576
integer y = 240
integer width = 777
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type st_formato from statictext within wi_mant_venfamforcli
integer x = 1358
integer y = 244
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
string text = "Formato:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_formato from u_em_campo within wi_mant_venfamforcli
event getfocus pbm_ensetfocus
event modificado pbm_custom02
integer x = 1618
integer y = 240
integer width = 261
integer taborder = 20
end type

event getfocus;call super::getfocus; ue_titulo     = "AYUDA SELECCION DE FORMATOS"
 ue_datawindow = "dw_ayuda_formatos"
 ue_filtro     = "" 	
 isle_campo    = This
 sle_valor.text = ""

         

end event

event modificado;call super::modificado;st_nombre_formato.text=f_nombre_formato(codigo_empresa,sle_formato.text)
IF Trim(st_nombre_formato.text)="" THEN 
 IF Trim(sle_formato.text)<>"" Then  f_activar_campo(sle_formato)
 sle_formato.text=""
END IF

end event

type st_nombre_formato from statictext within wi_mant_venfamforcli
integer x = 1888
integer y = 248
integer width = 375
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Small Fonts"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

