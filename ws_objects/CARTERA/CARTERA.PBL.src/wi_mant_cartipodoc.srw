$PBExportHeader$wi_mant_cartipodoc.srw
forward
global type wi_mant_cartipodoc from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_cartipodoc
end type
end forward

global type wi_mant_cartipodoc from wi_mvent_con_empresa
integer width = 2683
integer height = 1092
pb_calculadora pb_calculadora
end type
global wi_mant_cartipodoc wi_mant_cartipodoc

type variables

end variables

event ue_inserta_fila;call super::ue_inserta_fila; dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"tipodoc",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"control_banco","N")
 dw_1.setitem(dw_1.getrow(),"control_precartera","N")

end event

on ue_recuperar;

// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]
tabla         =  "cartipodoc"

dw_1.Retrieve(codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

event open;call super::open;   istr_parametros.s_titulo_ventana  = "Mantenimiento de Tipos de Control"
	istr_parametros.s_listado         = "report_cartipodoc"
   This.title = istr_parametros.s_titulo_ventana
   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      sle_valor.text=istr_parametros.s_argumentos[2]
		istr_parametros.i_nargumentos=0
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then
         This.TriggerEvent("ue_recuperar")
			Return
      END IF
   END IF

	
end event

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
end on

on wi_mant_cartipodoc.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
end on

on wi_mant_cartipodoc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_cartipodoc
integer x = 14
integer y = 324
integer width = 1984
integer height = 516
string dataobject = "dw_cartipodoc"
end type

event dw_1::key;bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "situacion_pase_cartera"
		bus_datawindow = "dw_ayuda_carsituacion"
		bus_titulo = "VENTANA SELECCION DE SITUACIONES EN CARTERA"
		valor_empresa = true
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::Key
end event

event dw_1::rbuttondown;call super::rbuttondown;bus_filtro=""
bus_titulo=""
bus_campo = This.GetColumnName()

CHOOSE CASE bus_campo
	CASE "situacion_pase_cartera"
		bus_datawindow = "dw_ayuda_carsituacion"
		bus_titulo = "VENTANA SELECCION DE SITUACIONES EN CARTERA"
		valor_empresa = true
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown
end event

event dw_1::clicked;call super::clicked;valor_empresa = TRUE
str_parametros lstr_param
lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_cartipodoc"

CHOOSE CASE f_objeto_datawindow(This)
	CASE 'pb_situacion'
		lstr_param.s_argumentos[2] = This.object.situacion_pase_cartera[GetRow()]
		OpenWithParm(wi_mant_carsituacion,lstr_param)  
END CHOOSE



end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_cartipodoc
integer x = 151
integer width = 270
string text = "Código"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_cartipodoc
integer x = 2089
integer y = 320
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_cartipodoc
integer x = 2089
integer y = 424
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_cartipodoc
integer x = 453
end type

on sle_valor::getfocus;call wi_mvent_con_empresa`sle_valor::getfocus;ue_datawindow  = "dw_ayuda_cartipodoc"
ue_titulo      = "AYUDA SELECCION DE TIPOS DE DOCUMENTOS"
ue_filtro      =""
end on

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_cartipodoc
integer x = 2089
integer y = 528
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_cartipodoc
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_cartipodoc
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_cartipodoc
integer width = 2834
end type

type pb_calculadora from u_calculadora within wi_mant_cartipodoc
integer x = 718
integer y = 212
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled=TRUE THEN Return
 Integer registros
 Select count(*) Into :registros
 From   cartipodoc
 Where  cartipodoc.empresa = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,cartipodoc.tipodoc)+1)
  Into   :sle_valor.text
  From   cartipodoc
  Where  cartipodoc.empresa = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

