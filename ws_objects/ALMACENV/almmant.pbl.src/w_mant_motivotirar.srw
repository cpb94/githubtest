$PBExportHeader$w_mant_motivotirar.srw
forward
global type w_mant_motivotirar from wi_mant_ventanas
end type
type pb_calculadora from u_calculadora within w_mant_motivotirar
end type
type r_1 from rectangle within w_mant_motivotirar
end type
end forward

global type w_mant_motivotirar from wi_mant_ventanas
integer x = 5
integer y = 0
integer width = 2016
integer height = 612
pb_calculadora pb_calculadora
r_1 r_1
end type
global w_mant_motivotirar w_mant_motivotirar

event open;call super::open;istr_parametros.s_titulo_ventana = "Matenimiento de motivos de tirar material"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

 // Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
     sle_valor.text=istr_parametros.s_argumentos[2]
	 IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
        		dw_1.Retrieve(codigo_empresa,sle_valor.text)
     END IF
END IF
end event

on ue_activa_claves;call wi_mant_ventanas::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)

end event

event ue_recuperar;// Valores Para Funcion de bloqueo
 titulo       =  This.title
 longitud     =  len(trim(codigo_empresa))
 criterio[1]  =  trim(codigo_empresa)+ space(20-longitud)
 longitud     =  len(Trim(sle_valor.text))
 criterio[2]  =  trim(sle_valor.text)+space(20-longitud)
 seleccion    =  criterio[1]+criterio[2]
 tabla        = "almmotivostirar"

 dw_1.Retrieve(codigo_empresa, sle_valor.Text)
 CALL Super::ue_recuperar






end event

on w_mant_motivotirar.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.r_1
end on

on w_mant_motivotirar.destroy
call super::destroy
destroy(this.pb_calculadora)
destroy(this.r_1)
end on

on ue_desactiva_claves;call wi_mant_ventanas::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mant_ventanas`dw_1 within w_mant_motivotirar
integer x = 82
integer y = 248
integer width = 1829
integer height = 172
integer taborder = 20
string dataobject = "dw_mant_motivotirar"
borderstyle borderstyle = stylebox!
end type

type st_1 from wi_mant_ventanas`st_1 within w_mant_motivotirar
integer x = 101
integer y = 100
integer width = 261
fontcharset fontcharset = ansi!
long textcolor = 0
string text = "Código"
end type

type cb_insertar from wi_mant_ventanas`cb_insertar within w_mant_motivotirar
integer x = 855
integer y = 92
integer width = 343
integer taborder = 30
end type

type cb_borrar from wi_mant_ventanas`cb_borrar within w_mant_motivotirar
integer x = 1207
integer y = 92
integer width = 343
integer taborder = 40
end type

type sle_valor from wi_mant_ventanas`sle_valor within w_mant_motivotirar
integer x = 375
integer y = 96
fontcharset fontcharset = ansi!
long backcolor = 16777215
end type

event sle_valor::getfocus;call super::getfocus;ue_titulo         = "AYUDA DE MOTIVOS TIRAR MATERIAL"
ue_datawindow     = "dw_ayuda_motivostirar"
ue_filtro         =  ""
valor_empresa     = true
isle_campo        = This

end event

type cb_salir from wi_mant_ventanas`cb_salir within w_mant_motivotirar
integer x = 1559
integer y = 92
integer width = 343
integer taborder = 50
end type

type control_tabulador from wi_mant_ventanas`control_tabulador within w_mant_motivotirar
integer taborder = 0
end type

type pb_calculadora from u_calculadora within w_mant_motivotirar
integer x = 635
integer y = 92
integer width = 105
integer height = 92
integer taborder = 0
boolean originalsize = false
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
Integer registros

Select count(*) Into :registros 
From almmotivostirar
where empresa = :codigo_empresa;

IF registros=0  Then
   sle_valor.text="1"
 ELSE
   Select max(convert(int,codigo)+1) 
   Into   :sle_valor.text
   From   almmotivostirar
	where empresa = :codigo_empresa;
END IF
dw_1.TriggerEvent("Clicked")
end event

type r_1 from rectangle within w_mant_motivotirar
integer linethickness = 4
long fillcolor = 8388608
integer x = 846
integer y = 84
integer width = 1065
integer height = 108
end type

