$PBExportHeader$wi_mant_venincrempais.srw
$PBExportComments$Mant. incermentos de precios por pais.
forward
global type wi_mant_venincrempais from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_venincrempais
end type
type st_nombre_familia from statictext within wi_mant_venincrempais
end type
type sle_familia from u_em_campo within wi_mant_venincrempais
end type
type st_nombre_pais from statictext within wi_mant_venincrempais
end type
type dw_detalle from datawindow within wi_mant_venincrempais
end type
end forward

global type wi_mant_venincrempais from wi_mvent_con_empresa
integer height = 1492
st_almacen st_almacen
st_nombre_familia st_nombre_familia
sle_familia sle_familia
st_nombre_pais st_nombre_pais
dw_detalle dw_detalle
end type
global wi_mant_venincrempais wi_mant_venincrempais

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,sle_familia.text,sle_valor.Text)
dw_detalle.Retrieve(codigo_empresa,sle_familia.text)

end subroutine

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;sle_familia.enabled=TRUE
end on

on ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_familia.text))
criterio[2]   =  trim(sle_familia.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "venincrempais"

f_control()
CALL Super::ue_recuperar
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"familia",sle_familia.text)
dw_1.setitem(dw_1.getrow(),"pais",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"tipo","L")

end event

on ue_actualiza_dw;call wi_mvent_con_empresa::ue_actualiza_dw;dw_detalle.Retrieve(codigo_empresa,sle_familia.text)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de incrementos por familia y pais"
istr_parametros.s_listado        = "report_venincrempais"
This.title=istr_parametros.s_titulo_ventana

dw_detalle.SetTransObject(SQLCA)

end event

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;sle_familia.enabled=FALSE
end on

on wi_mant_venincrempais.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_familia=create st_nombre_familia
this.sle_familia=create sle_familia
this.st_nombre_pais=create st_nombre_pais
this.dw_detalle=create dw_detalle
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_familia
this.Control[iCurrent+3]=this.sle_familia
this.Control[iCurrent+4]=this.st_nombre_pais
this.Control[iCurrent+5]=this.dw_detalle
end on

on wi_mant_venincrempais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_familia)
destroy(this.sle_familia)
destroy(this.st_nombre_pais)
destroy(this.dw_detalle)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_venincrempais
integer x = 133
integer y = 420
integer width = 1403
integer height = 300
string dataobject = "dw_venincrempais"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_venincrempais
integer x = 219
integer y = 316
integer width = 343
integer height = 80
string text = "Pais"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_venincrempais
integer x = 1554
integer y = 424
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_venincrempais
integer x = 1554
integer y = 524
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_venincrempais
integer x = 599
integer y = 316
integer height = 92
integer taborder = 20
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_titulo 	= "AYUDA SELECCION DE PAISES "
ue_datawindow	= "dw_ayuda_paises"
ue_filtro 		   = "" 
valor_empresa = FALSE
isle_campo        = sle_valor
IF trim(sle_familia.text)= "" THEN f_activar_campo(sle_familia)
IF trim(sle_valor.text)  = "" THEN f_control()

end on

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nombre_pais.text=f_nombre_pais(sle_valor.text)
IF Trim(st_nombre_pais.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF

end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_venincrempais
integer x = 1554
integer y = 624
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_venincrempais
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_venincrempais
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_venincrempais
end type

type st_almacen from statictext within wi_mant_venincrempais
integer x = 219
integer y = 200
integer width = 343
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
string text = "Familia"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_familia from statictext within wi_mant_venincrempais
integer x = 878
integer y = 208
integer width = 1170
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

type sle_familia from u_em_campo within wi_mant_venincrempais
integer x = 599
integer y = 196
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

event getfocus;call super::getfocus;      ue_titulo         = "AYUDA SELECCION DE FAMILIAS"
		ue_datawindow     = "dw_ayuda_familiaS"
		ue_filtro         = "" 
      isle_campo        = sle_familia
   
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_familia.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_familia)
     sle_familia.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     if trim(sle_valor.text)<>"" then sle_valor.TriggerEvent("modificado")
     IF Trim(sle_valor.text)<>"" and Trim(sle_familia.text)<>"" THEN
          dw_1.retrieve(codigo_empresa,sle_familia.text,sle_valor.text)
 	  END IF
     dw_detalle.retrieve(codigo_empresa,sle_familia.text)
     istr_parametros.i_nargumentos=0
     f_activar_campo(sle_familia)  
  END IF

end event

on modificado;call u_em_campo::modificado;st_nombre_familia.text=f_nombre_familia(codigo_empresa,sle_familia.text)
IF Trim(st_nombre_familia.text)="" THEN 
 IF Trim(sle_familia.text)<>"" Then  f_activar_campo(sle_familia)
 sle_familia.text=""
END IF


end on

type st_nombre_pais from statictext within wi_mant_venincrempais
integer x = 878
integer y = 324
integer width = 1189
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

type dw_detalle from datawindow within wi_mant_venincrempais
integer x = 128
integer y = 720
integer width = 1385
integer height = 444
boolean bringtotop = true
string dataobject = "dw_venimcrempais1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_familia.text = This.GetItemString(row,"familia")
sle_valor.text = This.GetItemString(row,"pais")
sle_valor.TriggerEvent("modificado")
sle_familia.TriggerEvent("modificado")
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

