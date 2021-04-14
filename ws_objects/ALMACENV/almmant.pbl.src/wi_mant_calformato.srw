$PBExportHeader$wi_mant_calformato.srw
$PBExportComments$Mant. calidades por formato.
forward
global type wi_mant_calformato from wi_mvent_con_empresa
end type
type st_almacen from statictext within wi_mant_calformato
end type
type st_nombre_formato from statictext within wi_mant_calformato
end type
type sle_formato from u_em_campo within wi_mant_calformato
end type
type st_nombre_calidad from statictext within wi_mant_calformato
end type
type dw_calidades from datawindow within wi_mant_calformato
end type
end forward

global type wi_mant_calformato from wi_mvent_con_empresa
integer width = 2377
integer height = 1400
st_almacen st_almacen
st_nombre_formato st_nombre_formato
sle_formato sle_formato
st_nombre_calidad st_nombre_calidad
dw_calidades dw_calidades
end type
global wi_mant_calformato wi_mant_calformato

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();dw_1.Retrieve(codigo_empresa,sle_formato.text,sle_valor.Text)
dw_calidades.Retrieve(codigo_empresa,sle_formato.text)

end subroutine

on ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_formato.text))
criterio[2]   =  trim(sle_formato.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "calformato"

f_control()
CALL Super::ue_recuperar
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"formato",sle_formato.text)
dw_1.setitem(dw_1.getrow(),"calidad",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"fechaalta",today())
end on

on ue_actualiza_dw;call wi_mvent_con_empresa::ue_actualiza_dw;dw_calidades.Retrieve(codigo_empresa,sle_formato.text)
end on

on open;call wi_mvent_con_empresa::open;istr_parametros.s_titulo_ventana = "Mantenimiento de calidades por formato"
istr_parametros.s_listado        = "report_calformatos"
This.title=istr_parametros.s_titulo_ventana

dw_calidades.SetTransObject(SQLCA)

end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;sle_formato.enabled=FALSE
end on

on wi_mant_calformato.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_nombre_formato=create st_nombre_formato
this.sle_formato=create sle_formato
this.st_nombre_calidad=create st_nombre_calidad
this.dw_calidades=create dw_calidades
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_nombre_formato
this.Control[iCurrent+3]=this.sle_formato
this.Control[iCurrent+4]=this.st_nombre_calidad
this.Control[iCurrent+5]=this.dw_calidades
end on

on wi_mant_calformato.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_nombre_formato)
destroy(this.sle_formato)
destroy(this.st_nombre_calidad)
destroy(this.dw_calidades)
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;sle_formato.enabled=TRUE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_calformato
integer x = 119
integer y = 440
integer height = 240
string dataobject = "dw_calformatos"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_calformato
integer x = 219
integer y = 316
integer width = 343
integer height = 80
string text = "Calidad"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_calformato
integer x = 1554
integer y = 440
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_calformato
integer x = 1554
integer y = 544
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_calformato
integer x = 599
integer y = 316
integer height = 92
integer taborder = 30
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;st_nombre_calidad.text=f_nombre_calidad(codigo_empresa,sle_valor.text)
IF Trim(st_nombre_calidad.text)="" THEN 
 IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
 sle_valor.text=""
END IF

end on

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_titulo 	= "AYUDA SELECCION DE CALIDADES "
ue_datawindow	= "dw_ayuda_calidades"
ue_filtro 		   = "" 
isle_campo        = sle_valor
IF trim(sle_formato.text)= "" THEN f_activar_campo(sle_formato)
IF trim(sle_valor.text)  = "" THEN f_control()

end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_calformato
integer x = 1554
integer y = 648
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_calformato
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_calformato
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_calformato
end type

type st_almacen from statictext within wi_mant_calformato
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
string text = "Formato"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre_formato from statictext within wi_mant_calformato
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

type sle_formato from u_em_campo within wi_mant_calformato
integer x = 599
integer y = 196
integer height = 92
integer taborder = 10
fontfamily fontfamily = roman!
string facename = "Times New Roman"
end type

on modificado;call u_em_campo::modificado;st_nombre_formato.text=f_nombre_formato(codigo_empresa,sle_formato.text)
IF Trim(st_nombre_formato.text)="" THEN 
 IF Trim(sle_formato.text)<>"" Then  f_activar_campo(sle_formato)
 sle_formato.text=""
END IF


end on

event getfocus;call super::getfocus;      ue_titulo         = "AYUDA SELECCION DE FORMATOS"
		ue_datawindow     = "dw_ayuda_formatos"
		ue_filtro         = "" 
      isle_campo        = sle_formato

      sle_valor.text =""
 
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_formato.text=istr_parametros.s_argumentos[2]	
     f_no_nulo(sle_formato)
     sle_formato.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     f_no_nulo(sle_valor)
     sle_valor.TriggerEvent("modificado")
     IF Trim(sle_valor.text)<>"" and Trim(sle_formato.text)<>"" THEN
          dw_1.retrieve(sle_formato.text,sle_valor.text)
           
     END IF
     istr_parametros.i_nargumentos=0
    END IF







end event

type st_nombre_calidad from statictext within wi_mant_calformato
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

type dw_calidades from datawindow within wi_mant_calformato
integer x = 379
integer y = 688
integer width = 759
integer height = 444
string dataobject = "dw_calformatos1"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event clicked;IF row =0 Then Return
IF cb_insertar.enabled=TRUE THEN Return

sle_valor.text  = dw_calidades.GetItemString(Row,"calidad")
sle_valor.TriggerEvent("modificado")

Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)

end event

