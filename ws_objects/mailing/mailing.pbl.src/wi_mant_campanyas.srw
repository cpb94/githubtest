$PBExportHeader$wi_mant_campanyas.srw
forward
global type wi_mant_campanyas from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_campanyas
end type
type pb_1 from upb_salir within wi_mant_campanyas
end type
end forward

global type wi_mant_campanyas from wi_mvent_con_empresa
integer width = 2606
integer height = 1252
pb_calculadora pb_calculadora
pb_1 pb_1
end type
global wi_mant_campanyas wi_mant_campanyas

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "mcampanya"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

event open;call super::open;   istr_parametros.s_titulo_ventana = "Mantenimiento de Campañas"
	istr_parametros.s_listado        = "report_campanyas"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on wi_mant_campanyas.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.pb_1
end on

on wi_mant_campanyas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.pb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_campanyas
integer x = 59
integer y = 336
integer width = 1742
integer height = 608
string dataobject = "dw_campanyas"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_campanyas
integer x = 210
integer width = 283
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_campanyas
integer x = 1893
integer y = 336
end type

event cb_insertar::clicked;IF cb_Insertar.enabled=TRUE THEN

  dw_1.acceptText()
  datetime fdesde,fhasta
  integer codigo
  dec{0} fd,fh

  fdesde = dw_1.GetItemDatetime(1,"fdesde")
  fhasta = dw_1.GetItemDatetime(1,"fhasta")
  fd = dec(String(fdesde,"yyyymmdd"))
  fh = dec(String(fhasta,"yyyymmdd"))
  
  if fd > fh then
     f_mensaje("!Atención¡","Error en fechas")
     dw_1.setfocus()
     dw_1.SetColumn("fdesde")
  	  return
  End if
  
  Select count(*) Into :codigo From mcampanya
  WHERE  mcampanya.empresa = :codigo_empresa  AND  
         mcampanya.codigo <> :sle_valor.text and 
		  ((mcampanya.fdesde <= :fdesde AND mcampanya.fhasta >= :fdesde) OR 
		  (mcampanya.fdesde  <= :fhasta AND mcampanya.fhasta >= :fhasta));			 
			 
  if IsNull(codigo) then codigo=0
  
  if SQLCA.sqlcode<>0 then 
     f_mensaje("!Atención¡","Error comprobando campañas")
	  cb_salir.TriggerEvent("Clicked")
	  Return
  End if	  
  
  if codigo>0 then
     f_mensaje("!Atención¡","El periodo elegido ya esta en otras campañas")
	  cb_salir.TriggerEvent("Clicked")
	  Return
  End if

End if

call super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_campanyas
integer x = 1893
integer y = 456
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_campanyas
integer x = 498
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_mcampanya"
ue_titulo     =  "AYUDA SELECCION CAMPAÑAS"
ue_filtro     =  ""
isle_campo    = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_campanyas
integer x = 1893
integer y = 576
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_campanyas
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_campanyas
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_campanyas
integer width = 2149
end type

type pb_calculadora from u_calculadora within wi_mant_campanyas
integer x = 763
integer y = 208
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From mcampanya
 Where  mcampanya.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,mcampanya.codigo)+1)
  Into   :sle_valor.text
  From   mcampanya
  Where  mcampanya.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type pb_1 from upb_salir within wi_mant_campanyas
integer x = 2450
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
string picturename = "exit!"
end type

