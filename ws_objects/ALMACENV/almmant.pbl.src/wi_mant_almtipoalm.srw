$PBExportHeader$wi_mant_almtipoalm.srw
$PBExportComments$Mant. Tipos de almacen.
forward
global type wi_mant_almtipoalm from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_almtipoalm
end type
end forward

global type wi_mant_almtipoalm from wi_mvent_con_empresa
integer width = 2533
integer height = 956
pb_calculadora pb_calculadora
end type
global wi_mant_almtipoalm wi_mant_almtipoalm

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"tipoalm",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"externo","N")
end on

on open;call wi_mvent_con_empresa::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Tipos de Almacen"
	istr_parametros.s_listado         = "report_tiposalm"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "almtipo"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on wi_mant_almtipoalm.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_almtipoalm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_almtipoalm
integer x = 82
integer width = 1742
integer height = 384
string dataobject = "dw_almtipoalm"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_almtipoalm
integer x = 119
integer width = 434
string text = "Tipo Almacen:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_almtipoalm
integer x = 1893
integer y = 376
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_almtipoalm
integer x = 1893
integer y = 484
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_almtipoalm
integer x = 562
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow  = "dw_ayuda_almtipoalm"
ue_titulo      = "AYUDA SELECCION DE TIPOS ALMACENES"
ue_filtro      =""
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_almtipoalm
integer x = 1893
integer y = 592
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_almtipoalm
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_almtipoalm
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_almtipoalm
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_almtipoalm
integer x = 827
integer y = 204
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   almtipo
 Where  almtipo.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,almtipo.tipoalm)+1)
  Into   :sle_valor.text
  From   almtipo
  Where  almtipo.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

