$PBExportHeader$wi_mant_carforpag.srw
forward
global type wi_mant_carforpag from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_carforpag
end type
type dw_idiomas from datawindow within wi_mant_carforpag
end type
end forward

global type wi_mant_carforpag from wi_mvent_con_empresa
integer width = 2894
integer height = 1980
pb_calculadora pb_calculadora
dw_idiomas dw_idiomas
end type
global wi_mant_carforpag wi_mant_carforpag

type variables

end variables

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
dw_idiomas.enabled     = TRUE
end on

event open;call super::open;   dw_idiomas.SetTransObject(SQLCA)
	
	istr_parametros.s_titulo_ventana = "Mantenimiento de Formas de pago"
	istr_parametros.s_listado        = "report_carforpag"
   This.title = istr_parametros.s_titulo_ventana
   tipo_mantenimiento='C'
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       This.TriggerEvent("ue_recuperar")
		 dw_idiomas.retrieve(codigo_empresa,sle_valor.text)
      END IF
   END IF

	
end event

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"forma",sle_valor.text)
end on

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "carforpag"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
dw_idiomas.enabled     = FALSE
end on

on wi_mant_carforpag.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.dw_idiomas=create dw_idiomas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.dw_idiomas
end on

on wi_mant_carforpag.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.dw_idiomas)
end on

event ue_borra_fila;call super::ue_borra_fila;  DELETE FROM carforpagidiomas  
   WHERE ( carforpagidiomas.empresa = :codigo_empresa ) AND  
         ( carforpagidiomas.codigo = :sle_valor.text )   ;

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_carforpag
integer x = 27
integer y = 280
integer width = 2391
integer height = 1068
string dataobject = "dw_carforpag"
end type

event dw_1::clicked;call super::clicked;string ls_objeto
datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow

ls_objeto = dw_1.GetObjectAtPointer()
ls_objeto = Left(ls_objeto, Pos(ls_objeto, "~t", 1) - 1)
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_carforpag"
CHOOSE CASE ls_objeto
  
CASE 'pb_tipodoc'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipodoc")
   OpenWithParm(wi_mant_cartipodoc,lstr_param)  

END CHOOSE






end event

on dw_1::valores_numericos;call wi_mvent_con_empresa`dw_1::valores_numericos;f_valores_numericos(dw_1,"tipodoc")

end on

event dw_1::rbuttondown; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipodoc"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE DOCUMENTOS "
 		bus_datawindow = "dw_ayuda_cartipodoc"
   CASE "codpago1","codpago2","codpago3","codpago4","codpago5","codpago6","codpago7","codpago8","codpago9"
      bus_datawindow = "dw_ayuda_carforpag"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"		 		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::key; bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipodoc"
      bus_titulo     = "VENTANA SELECCION DE TIPOS DE DOCUMENTOS"
 		bus_datawindow = "dw_ayuda_cartipodoc"
   CASE "codpago1","codpago2","codpago3","codpago4","codpago5","codpago6","codpago7","codpago8","codpago9"
      bus_datawindow = "dw_ayuda_carforpag"
     	valor_empresa = true
		bus_titulo = "VENTANA SELECCION DE FORMAS DE PAGO"		 
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key


end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_carforpag
integer x = 192
integer y = 176
integer width = 256
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_carforpag
integer x = 2441
integer y = 280
integer width = 366
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_carforpag
integer x = 2441
integer y = 400
integer width = 366
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_carforpag
integer x = 453
integer y = 176
end type

on sle_valor::modificado;call wi_mvent_con_empresa`sle_valor::modificado;dw_idiomas.retrieve(codigo_empresa,sle_valor.text)
end on

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_carforpag"
   ue_titulo         = "AYUDA SELECCION DE FORMAS DE PAGO"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_carforpag
integer x = 2441
integer y = 524
integer width = 366
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_carforpag
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_carforpag
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_carforpag
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_carforpag
integer x = 718
integer y = 172
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From carforpag
 Where  carforpag.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,carforpag.forma)+1)
  Into   :sle_valor.text
  From   carforpag
  Where  carforpag.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end on

type dw_idiomas from datawindow within wi_mant_carforpag
integer x = 27
integer y = 1360
integer width = 2391
integer height = 400
boolean bringtotop = true
string dataobject = "dw_carforpag1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event clicked;IF cb_insertar.enabled=TRUE THEN Return

datawindow var_datawindow
str_parametros lstr_param
String cod_idioma

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)
		
CASE 'pb_idiomas'
   lstr_param.s_argumentos[2]=sle_valor.text
   OpenWithParm(wi_mant_carforpagidiomas,lstr_param)  
CASE ELSE
	iF row =0 Then Return
 
   lstr_param.i_nargumentos    = 3
	cod_idioma  = dw_idiomas.GetItemString(Row,"idioma")
	lstr_param.s_argumentos[2]=sle_valor.text
	lstr_param.s_argumentos[3]=cod_idioma
   OpenWithParm(wi_mant_carforpagidiomas,lstr_param)  	
END CHOOSE

end event

