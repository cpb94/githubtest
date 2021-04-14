$PBExportHeader$wi_mant_depalmacenes.srw
forward
global type wi_mant_depalmacenes from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_depalmacenes
end type
end forward

global type wi_mant_depalmacenes from wi_mvent_con_empresa
integer width = 2766
integer height = 1008
pb_calculadora pb_calculadora
end type
global wi_mant_depalmacenes wi_mant_depalmacenes

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;

   istr_parametros.s_titulo_ventana = "Mantenimiento de Almacenes deposito"
	istr_parametros.s_listado        = "report_depalmacenes"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
       dw_1.Retrieve(codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;   dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
   dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
end on

event ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         = "depalmacen"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end event

on wi_mant_depalmacenes.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_depalmacenes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_depalmacenes
integer x = 23
integer y = 332
integer width = 2194
integer height = 436
string dataobject = "dw_depalmacenes"
end type

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipoalm"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almtipoalm"
   CASE "codcli"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_clientes_deposito"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_1::valores_numericos;call super::valores_numericos;f_valores_numericos(dw_1,"codcli")
end event

event dw_1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
	 valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "tipoalm"
      bus_titulo     = "VENTANA SELECCION DE TIPO DE ALMACEN "
 		bus_datawindow = "dw_ayuda_almtipoalm"
   CASE "codcli"
      bus_titulo     = "VENTANA SELECCION DE CLIENTES"
      bus_filtro     = ""
 		bus_datawindow = "dw_ayuda_clientes_deposito"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 
END IF

end event

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_almacenes"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_tipoalm'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipoalm")
   OpenWithParm(wi_mant_almtipoalm,lstr_param)  
CASE 'pb_codcli'
   lstr_param.s_argumentos[2]="C"
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"codcli")
   OpenWithParm(wi_mant_clipro,lstr_param)  

END CHOOSE





end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_depalmacenes
integer x = 187
integer width = 315
string text = "Almacén"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_depalmacenes
integer x = 2267
integer y = 332
end type

event cb_insertar::clicked;IF dw_1.GetRow() <> 0 Then

		 dw_1.AcceptText()
		 String var_descripcion,var_resumido,var_codcli,var_tipoalm,des_codcli,des_tipoalm
		 var_descripcion  = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
		 var_resumido     = dw_1.GetItemString(dw_1.GetRow(),"resumido")
		 var_codcli       = dw_1.GetItemString(dw_1.GetRow(),"codcli")
		 des_codcli       = dw_1.GetItemString(dw_1.GetRow(),"nombre_codcli")
		 
		 // Controla si el cliente tiene "S" en la ficha
		 String variable
		 SELECT venclientes.deposito  
		 INTO  :variable
		 FROM venclientes  
		 WHERE ( venclientes.empresa = :codigo_empresa ) AND  
				  ( venclientes.codigo  = :var_codcli )   ;
		  
		 if Trim(variable)<>"S" or isnull(variable) then
			  MessageBox("Control cliente","No esta marcado como deposito en la ficha cliente",Exclamation!,Ok!,1)
			  dw_1.SetColumn("codcli")
			  dw_1.SetFocus()
			  Return
	    End if

		 if cb_insertar.enabled = TRUE THEN
		 
				 If Trim(var_descripcion) = ""   or ISNULL(var_descripcion)Then
					  MessageBox("Campo Obligatorio","Introduzca la descripcion del tipo de almacen",Exclamation!,Ok!,1)
					  dw_1.SetColumn("descripcion")
					  dw_1.SetFocus()
					  Return
				 END IF
				 If Trim(var_resumido) = ""  or ISNULL(var_resumido) Then
					  MessageBox("Campo Obligatorio","Introduzca el resumido del tipo de almacen",Exclamation!,Ok!,1)
					  dw_1.SetColumn("resumido")
					  dw_1.SetFocus()
					  Return
				 END IF
				
				 If Trim(var_codcli) <> ""  and NOT ISNULL(var_codcli)Then
					 If Trim(des_codcli) = ""  or ISNULL(des_codcli)Then
						  MessageBox("Campo Obligatorio","El cliente no existe",Exclamation!,Ok!,1)
						  dw_1.SetColumn("codcli")
						  dw_1.SetFocus()
						  Return
					 END IF 
				 END IF
		
     END IF
END IF
CALL super::Clicked
end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_depalmacenes
integer x = 2267
integer y = 452
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_depalmacenes
integer x = 512
end type

event sle_valor::getfocus;call super::getfocus;   ue_datawindow     = "dw_ayuda_depalmacenes"
   ue_titulo         = "AYUDA SELECCION DE ALMACENES"
   ue_filtro         = ""
   isle_campo        = This
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_depalmacenes
integer x = 2267
integer y = 572
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_depalmacenes
integer taborder = 30
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_depalmacenes
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_depalmacenes
integer width = 2299
end type

type pb_calculadora from u_calculadora within wi_mant_depalmacenes
integer x = 777
integer y = 204
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros From depalmacen
 Where  depalmacen.empresa = :codigo_empresa;
 IF registros=0  Then
  sle_valor.text="1"
 ELSE
  Select max(convert(int,depalmacen.codigo)+1)
  Into   :sle_valor.text
  From   depalmacen
  Where  depalmacen.empresa = :codigo_empresa;
 END IF
 dw_1.TriggerEvent("Clicked")
end event

