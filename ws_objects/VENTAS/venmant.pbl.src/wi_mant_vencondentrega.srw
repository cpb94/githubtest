$PBExportHeader$wi_mant_vencondentrega.srw
$PBExportComments$Mant. Condiciones de entrega.
forward
global type wi_mant_vencondentrega from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_vencondentrega
end type
type dw_idiomas from datawindow within wi_mant_vencondentrega
end type
end forward

global type wi_mant_vencondentrega from wi_mvent_con_empresa
integer width = 2907
integer height = 1672
pb_calculadora pb_calculadora
dw_idiomas dw_idiomas
end type
global wi_mant_vencondentrega wi_mant_vencondentrega

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;   dw_idiomas.SetTransObject(SQLCA)
	
   istr_parametros.s_titulo_ventana = "Mantenimiento pies de factura"
	istr_parametros.s_listado        = "report_vencondentrega"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
		IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       This.TriggerEvent("ue_recuperar")
      END IF
   END IF


end event

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "vencondentrega"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
dw_idiomas.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

on wi_mant_vencondentrega.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_idiomas=create dw_idiomas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_idiomas
end on

on wi_mant_vencondentrega.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_idiomas)
end on

event ue_borra_fila;call super::ue_borra_fila;  DELETE FROM vencondentregaidioma  
   WHERE ( vencondentregaidioma.empresa = :codigo_empresa ) AND  
         ( vencondentregaidioma.codigo = :sle_valor.text )   ;

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_vencondentrega
integer x = 14
integer y = 332
integer width = 2437
integer height = 328
string dataobject = "dw_vencondentrega"
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_condicion'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"condicion")
   OpenWithParm(wi_mant_vencondiciones,lstr_param)  
END CHOOSE


end event

event dw_1::key;valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "condicion"
      bus_titulo     = "VENTANA SELECCION DE CONDICIONES "
 		bus_datawindow = "dw_ayuda_vencondiciones"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
end event

event dw_1::rbuttondown;valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "condicion"
      bus_titulo     = "VENTANA SELECCION DE CONDICIONES "
 		bus_datawindow = "dw_ayuda_vencondiciones"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"condicion")
end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_vencondentrega
integer x = 128
integer y = 220
integer width = 315
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_vencondentrega
integer x = 2473
integer y = 328
integer width = 347
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_vencondentrega
integer x = 2473
integer y = 432
integer width = 347
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_vencondentrega
integer x = 453
integer y = 216
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;   ue_datawindow     = "dw_ayuda_vencondentrega"
   ue_titulo         = "AYUDA SELECCION DE CONDICIONES DE ENTREGA"
   ue_filtro         = ""
   isle_campo        = This
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_vencondentrega
integer x = 2473
integer width = 347
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_vencondentrega
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_vencondentrega
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_vencondentrega
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_vencondentrega
integer x = 713
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From vencondentrega
 Where  vencondentrega.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,vencondentrega.codigo)+1)
  Into   :sle_valor.text
  From   vencondentrega
  Where  vencondentrega.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

type dw_idiomas from datawindow within wi_mant_vencondentrega
integer x = 9
integer y = 668
integer width = 2825
integer height = 756
boolean bringtotop = true
string dataobject = "dw_con_vencondentregaidioma"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return

String cod_idioma
datawindow var_datawindow
str_parametros lstr_param

CHOOSE CASE f_objeto_datawindow(This)
  
CASE 'p_carpeta'
   lstr_param.i_nargumentos    = 2
	lstr_param.s_argumentos[2]=sle_valor.text
	OpenWithParm(wi_mant_vencondentregaidioma,lstr_param)  
CASE ELSE
   iF row =0 Then Return
   	
   lstr_param.i_nargumentos    = 3
   cod_idioma  = dw_idiomas.GetItemString(Row,"idioma")
	lstr_param.s_argumentos[2]=sle_valor.text
	lstr_param.s_argumentos[3]=cod_idioma
	OpenWithParm(wi_mant_vencondentregaidioma,lstr_param)
END CHOOSE



end event

