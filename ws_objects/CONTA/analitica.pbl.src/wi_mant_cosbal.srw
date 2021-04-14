$PBExportHeader$wi_mant_cosbal.srw
forward
global type wi_mant_cosbal from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_cosbal
end type
end forward

global type wi_mant_cosbal from wi_mvent_con_empresa
integer width = 2487
integer height = 868
pb_calculadora pb_calculadora
end type
global wi_mant_cosbal wi_mant_cosbal

type variables

end variables

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "cosbal"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Cuadros"
	istr_parametros.s_listado         = ""
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)

end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_cosbal.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_cosbal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

event ue_borra_fila;call super::ue_borra_fila;String cod

cod = sle_valor.text
f_mensaje_proceso("Borrando Mapa",20,100)
  DELETE FROM costesapuman  
   WHERE costesapuman.empresa = :codigo_empresa  
	AND   costesapuman.codigo  = :cod ;
f_mensaje_proceso("Borrando Mapa",60,100)	
COMMIT;
f_mensaje_proceso("Borrando Mapa",100,100)

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_cosbal
integer x = 0
integer y = 336
integer width = 1870
integer height = 216
string dataobject = "dw_cosbal"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_cosbal
integer x = 251
integer width = 270
string text = "Cuadro:"
alignment alignment = right!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_cosbal
integer x = 1893
integer y = 336
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_cosbal
integer x = 1893
integer y = 436
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_cosbal
integer x = 544
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_cosbal"
ue_titulo      = "AYUDA SELECCION DE CUADROS"
ue_filtro      =""
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_cosbal
integer x = 1893
integer y = 536
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_cosbal
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_cosbal
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_cosbal
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_cosbal
integer x = 809
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   cosbal
 Where  cosbal.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,cosbal.codigo)+1)
  Into   :sle_valor.text
  From   cosbal
  Where  cosbal.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end event

