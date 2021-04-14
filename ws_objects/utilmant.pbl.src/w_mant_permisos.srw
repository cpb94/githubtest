$PBExportHeader$w_mant_permisos.srw
forward
global type w_mant_permisos from wi_mvent_con_empresa
end type
type st_2 from statictext within w_mant_permisos
end type
type sle_usuario from u_em_campo within w_mant_permisos
end type
end forward

global type w_mant_permisos from wi_mvent_con_empresa
integer width = 3099
integer height = 1464
st_2 st_2
sle_usuario sle_usuario
end type
global w_mant_permisos w_mant_permisos

on w_mant_permisos.create
int iCurrent
call super::create
this.st_2=create st_2
this.sle_usuario=create sle_usuario
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_2
this.Control[iCurrent+2]=this.sle_usuario
end on

on w_mant_permisos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.sle_usuario)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de permisos por usuarios"
This.title=istr_parametros.s_titulo_ventana
dw_1.SetTransObject(SQLCA)
f_activar_campo(sle_usuario)
dw_1.setrowfocusindicator(Hand!)
end event

event ue_activa_claves;call super::ue_activa_claves;sle_usuario.enabled=TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;sle_usuario.enabled=FALSE
end event

event ue_inserta_fila;call super::ue_inserta_fila;dw_1.setitem(dw_1.getrow(),"v_usuario",sle_usuario.text)
dw_1.setitem(dw_1.getrow(),"permiso",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"descripcion","")
end event

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        = This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_usuario.text))
criterio[2]   =  trim(sle_usuario.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "permisos"

dw_1.Retrieve(sle_usuario.text,sle_valor.text)

CALL Super::ue_recuperar
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_permisos
integer y = 496
integer width = 2373
integer height = 596
integer taborder = 30
string dataobject = "dw_permisos"
end type

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_permisos
integer y = 368
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_permisos
integer x = 2510
integer y = 492
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_permisos
integer x = 2505
integer y = 616
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_permisos
integer y = 364
integer width = 197
integer taborder = 20
end type

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_permisos
integer x = 2510
integer y = 744
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_permisos
integer taborder = 40
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_permisos
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_permisos
end type

type st_2 from statictext within w_mant_permisos
integer x = 91
integer y = 220
integer width = 361
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Usuario"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_usuario from u_em_campo within w_mant_permisos
integer x = 494
integer y = 212
integer width = 992
integer taborder = 10
boolean bringtotop = true
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event getfocus;call super::getfocus;ue_titulo   = "AYUDA SELECCION DE USUARIOS"
ue_datawindow = "dw_ayuda_usuarios"
ue_filtro = ""
isle_campo = sle_usuario
valor_empresa = FALSE

sle_valor.text = ""         
IF istr_parametros.i_nargumentos>1 THEN
	  sle_usuario.text=istr_parametros.s_argumentos[2]	
     sle_usuario.TriggerEvent("modificado")
     sle_valor.text=istr_parametros.s_argumentos[3]
     sle_valor.TriggerEvent("modificado")
     istr_parametros.i_nargumentos=0
	  IF Trim(sle_valor.text)<>"" and Trim(sle_usuario.text)<>"" THEN
          Parent.TriggerEvent("ue_recuperar")
			 f_activar_campo(sle_valor)
			 Return
		 else
			 f_activar_campo(sle_valor)
			 Return
     END IF
END IF
end event

event modificado;call super::modificado;dw_1.Retrieve(sle_usuario.text,sle_valor.text)
end event

