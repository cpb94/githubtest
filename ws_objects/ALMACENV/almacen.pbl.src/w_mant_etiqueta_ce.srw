$PBExportHeader$w_mant_etiqueta_ce.srw
forward
global type w_mant_etiqueta_ce from wi_mvent_con_empresa
end type
type st_almacen from statictext within w_mant_etiqueta_ce
end type
type st_2 from statictext within w_mant_etiqueta_ce
end type
type sle_cliente from u_em_campo within w_mant_etiqueta_ce
end type
type pb_2 from upb_imprimir within w_mant_etiqueta_ce
end type
type dw_informe from datawindow within w_mant_etiqueta_ce
end type
end forward

global type w_mant_etiqueta_ce from wi_mvent_con_empresa
integer x = 0
integer y = 0
integer width = 4288
integer height = 1672
st_almacen st_almacen
st_2 st_2
sle_cliente sle_cliente
pb_2 pb_2
dw_informe dw_informe
end type
global w_mant_etiqueta_ce w_mant_etiqueta_ce

type variables

end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
dw_1.Retrieve(codigo_empresa,sle_cliente.text,sle_valor.text)


end subroutine

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Etiquetas para marcado CE"
istr_parametros.s_listado        = ""
This.title=istr_parametros.s_titulo_ventana

dw_informe.SetTransObject(SQLCA);


integer permiso

permiso = f_permiso_usuario(this.classname(), nombre_usuario)
choose case  permiso
	case 1
		This.cb_insertar.visible = false;
		This.cb_borrar.visible = false;
end choose
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
dw_1.setitem(dw_1.getrow(),"cliente",sle_cliente.text)
dw_1.setitem(dw_1.getrow(),"tipo",sle_valor.text)
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_cliente.text))
criterio[2]   =  trim(sle_cliente.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "ce_marcado"



f_control()
CALL Super::ue_recuperar
end event

on w_mant_etiqueta_ce.create
int iCurrent
call super::create
this.st_almacen=create st_almacen
this.st_2=create st_2
this.sle_cliente=create sle_cliente
this.pb_2=create pb_2
this.dw_informe=create dw_informe
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_almacen
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_cliente
this.Control[iCurrent+4]=this.pb_2
this.Control[iCurrent+5]=this.dw_informe
end on

on w_mant_etiqueta_ce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_almacen)
destroy(this.st_2)
destroy(this.sle_cliente)
destroy(this.pb_2)
destroy(this.dw_informe)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_cliente.enabled=FALSE
end event

event ue_activa_claves;call super::ue_activa_claves;sle_cliente.enabled=TRUE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_etiqueta_ce
integer x = 32
integer y = 356
integer width = 4187
integer height = 1088
string dataobject = "dw_mant_etiqueta_ce"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_etiqueta_ce
integer x = 9
integer y = 228
integer width = 357
integer height = 80
integer textsize = -9
fontcharset fontcharset = ansi!
long textcolor = 8388608
string text = "Tipo Etiqueta:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_etiqueta_ce
integer x = 3259
integer y = 176
integer width = 265
integer height = 96
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_etiqueta_ce
integer x = 3534
integer y = 176
integer width = 265
integer height = 96
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_etiqueta_ce
integer x = 393
integer y = 220
integer width = 457
integer taborder = 20
fontcharset fontcharset = ansi!
end type

event sle_valor::modificado;call super::modificado;//st_caja_nombre.text=f_nombre_caja(codigo_empresa,sle_valor.text)
//IF Trim(st_caja_nombre.text)="" THEN 
// IF Trim(sle_valor.text)<>"" Then  f_activar_campo(sle_valor)
// sle_valor.text=""
//END IF
end event

event sle_valor::getfocus;call super::getfocus;//ue_titulo     = "AYUDA SELECCION DE CAJAS"
//ue_datawindow = "dw_ayuda_cajas"
//ue_filtro     = ""
//isle_campo    = This
//
//IF trim(sle_cliente.text)= "" THEN
//	f_activar_campo(sle_cliente)
//	Return	 
//End if	
f_control()
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_etiqueta_ce
integer x = 3808
integer y = 176
integer width = 265
integer height = 96
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_etiqueta_ce
integer taborder = 0
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_etiqueta_ce
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_etiqueta_ce
integer x = 14
integer y = 4
integer width = 3785
integer height = 76
integer textsize = -8
end type

type st_almacen from statictext within w_mant_etiqueta_ce
integer x = 18
integer y = 124
integer width = 343
integer height = 80
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_mant_etiqueta_ce
integer x = 882
integer y = 116
integer width = 1573
integer height = 84
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217752
boolean enabled = false
boolean border = true
boolean focusrectangle = false
end type

type sle_cliente from u_em_campo within w_mant_etiqueta_ce
integer x = 398
integer y = 116
integer width = 462
integer taborder = 10
fontcharset fontcharset = ansi!
end type

event getfocus;call super::getfocus;/*
  ue_titulo     = "AYUDA SELECCION DE ARTÍCULOS"
  ue_datawindow = "dw_ayuda_articulos"
  ue_filtro     = ""
  isle_campo    = This
  sle_valor.Text = ""
  
  f_control()
        
  IF istr_parametros.i_nargumentos>1 THEN
 	  sle_articulo.text=istr_parametros.s_argumentos[2]	
     sle_articulo.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_articulo.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
			 Return
		else
			 f_activar_campo(sle_valor)
			 Return
     END IF
  END IF






*/
ue_titulo     = "AYUDA SELECCION CLIENTES"
ue_datawindow = "dw_ayuda_clientes"
ue_filtro     = "" 	


IF istr_parametros.i_nargumentos>1 THEN
	
	  sle_valor.text=istr_parametros.s_argumentos[2]
 	  istr_parametros.i_nargumentos=0
       	  
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			This.TriggerEvent("modificado")
			Parent.TriggerEvent("ue_recuperar")
     END IF  
  
	  		
END IF


end event

event modificado;call super::modificado;st_2.text = f_nombre_cliente(codigo_empresa,"C",sle_cliente.text)
end event

type pb_2 from upb_imprimir within w_mant_etiqueta_ce
integer x = 4091
integer y = 176
integer taborder = 20
boolean bringtotop = true
end type

event clicked;dw_informe.Retrieve(codigo_empresa,sle_cliente.text,sle_valor.text)

f_imprimir_datawindow(dw_informe)

end event

type dw_informe from datawindow within w_mant_etiqueta_ce
boolean visible = false
integer x = 2784
integer y = 96
integer width = 320
integer height = 248
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_impresion_etiqueta_ce"
boolean border = false
boolean livescroll = true
end type

