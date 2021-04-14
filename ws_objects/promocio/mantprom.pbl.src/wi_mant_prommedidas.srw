$PBExportHeader$wi_mant_prommedidas.srw
forward
global type wi_mant_prommedidas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_prommedidas
end type
end forward

global type wi_mant_prommedidas from wi_mvent_con_empresa
integer width = 2519
integer height = 1100
pb_calculadora pb_calculadora
end type
global wi_mant_prommedidas wi_mant_prommedidas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
 
end event

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento Medidas Paneles"
	istr_parametros.s_listado         = "report_prommedidas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   
	f_mascara_columna(dw_1,"largo","###,###.00")
	f_mascara_columna(dw_1,"alto","###,###.00")
 	f_mascara_columna(dw_1,"coste_manipulacion","###,###")
	
	IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "prommedidas"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_prommedidas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_prommedidas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_prommedidas
integer x = 18
integer y = 336
integer width = 1806
integer height = 508
string dataobject = "dw_prommedidas"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_prommedidas
integer x = 379
integer width = 279
string text = "Código:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_prommedidas
integer x = 1970
integer y = 336
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_prommedidas
integer x = 1970
integer y = 444
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_prommedidas
integer x = 667
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_prommedidas"
ue_titulo      = "AYUDA SELECCION MEDIDAS PANELES"
ue_filtro      = ""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_prommedidas
integer x = 1970
integer y = 556
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_prommedidas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_prommedidas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_prommedidas
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_prommedidas
integer x = 933
integer y = 208
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return

 Integer registros
 Select count(*) Into :registros
 From   prommedidas
 Where  prommedidas.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,prommedidas.codigo)+1)
  Into   :sle_valor.text
  From   prommedidas
  Where  prommedidas.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

