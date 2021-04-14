$PBExportHeader$wi_mant_contarecur.srw
forward
global type wi_mant_contarecur from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within wi_mant_contarecur
end type
type uo_ejercicio from u_ejercicio within wi_mant_contarecur
end type
type gb_1 from groupbox within wi_mant_contarecur
end type
end forward

global type wi_mant_contarecur from wi_mvent_con_empresa
integer width = 2825
integer height = 1240
pb_calculadora pb_calculadora
uo_ejercicio uo_ejercicio
gb_1 gb_1
end type
global wi_mant_contarecur wi_mant_contarecur

type variables

end variables

on ue_inserta_fila;call wi_mvent_con_empresa::ue_inserta_fila;  Integer ejercicio

 ejercicio = Integer(uo_ejercicio.em_ejercicio.text)
 dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"codigo",sle_valor.text)
dw_1.setitem(dw_1.getrow(),"ejercicio",ejercicio)

end on

on open;call wi_mvent_con_empresa::open;   uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

   istr_parametros.s_titulo_ventana  = "Mantenimiento asientos recurrentes"
	istr_parametros.s_listado         = "report_contarecur"
	istr_parametros.s_filtro          = "ejercicio = " + uo_ejercicio.em_ejercicio.text
   This.title = istr_parametros.s_titulo_ventana

   
   // Si recibo el codigo lo visualizo
   IF istr_parametros.i_nargumentos>1 THEN
      uo_ejercicio.em_ejercicio.text=istr_parametros.s_argumentos[2]
      sle_valor.text=istr_parametros.s_argumentos[3]
      IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text)  or &
         Trim(uo_ejercicio.em_ejercicio.text)<>"" and Not IsNull(uo_ejercicio.em_ejercicio.text)Then
        dw_1.Retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.Text)
      END IF
   END IF

	
end on

on ue_recuperar;

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
longitud      =  len(trim(uo_ejercicio.em_ejercicio.text))
criterio[3]   =  trim(uo_ejercicio.em_ejercicio.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "contarecur"

dw_1.Retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.Text)

CALL Super::ue_recuperar
end on

on ue_activa_claves;call wi_mvent_con_empresa::ue_activa_claves;pb_calculadora.visible = TRUE
uo_ejercicio.enabled = TRUE
end on

on wi_mant_contarecur.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.uo_ejercicio=create uo_ejercicio
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.uo_ejercicio
this.Control[iCurrent+3]=this.gb_1
end on

on wi_mant_contarecur.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.uo_ejercicio)
destroy(this.gb_1)
end on

on ue_desactiva_claves;call wi_mvent_con_empresa::ue_desactiva_claves;pb_calculadora.visible = FALSE
uo_ejercicio.enabled = FALSE
end on

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_contarecur
integer x = 50
integer y = 332
integer width = 1989
integer height = 520
string dataobject = "dw_contarecur"
end type

event dw_1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_contarecur"
CHOOSE CASE f_objeto_datawindow(dw_1)
  
CASE 'pb_origen'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"origen")
   OpenWithParm(wi_mant_contaorigen,lstr_param)  


END CHOOSE


end event

event dw_1::key; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "origen"
      bus_titulo     = "VENTANA SELECCION DE ORIGENES "
 		bus_datawindow = "dw_ayuda_contaorigen"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
 

end event

event dw_1::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "origen"
      bus_titulo     = "VENTANA SELECCION DE ORIGENES "
 		bus_datawindow = "dw_ayuda_contaorigen"
 	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_contarecur
integer x = 151
integer y = 224
integer width = 334
string text = "Recurrente"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_contarecur
integer x = 439
integer y = 876
integer height = 80
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_contarecur
integer x = 846
integer y = 876
integer height = 80
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_contarecur
integer x = 489
integer y = 220
integer width = 293
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_contarecur"
ue_titulo      = "AYUDA SELECCION DE ASIENTOS RECURRENTES"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 


end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_contarecur
integer x = 1253
integer y = 876
integer width = 411
integer height = 80
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_contarecur
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_contarecur
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_contarecur
integer x = 18
integer width = 2697
end type

type pb_calculadora from u_calculadora within wi_mant_contarecur
integer x = 800
integer y = 216
integer width = 119
integer height = 104
integer taborder = 0
string picturename = "c:\bmp\calcula.bmp"
end type

on clicked;call u_calculadora::clicked;IF cb_insertar.enabled = TRUE THEN
  Return
END IF

 Integer registros,var_ejercicio
 var_ejercicio = Integer(uo_ejercicio.em_ejercicio.text)

 Select count(*) Into :registros
 From   contarecur
 Where  contarecur.ejercicio = :var_ejercicio
 and    contarecur.empresa   = :codigo_empresa;
 IF registros=0 THEN
   sle_valor.text="1"
 ELSE
  Select max(convert(int,contarecur.codigo)+1) Into   :sle_valor.text
  From   contarecur
  Where  contarecur.ejercicio = :var_ejercicio
  and    contarecur.empresa   = :codigo_empresa;
END IF
dw_1.triggerEvent("clicked")
  
end on

type uo_ejercicio from u_ejercicio within wi_mant_contarecur
integer x = 2089
integer y = 328
integer height = 480
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

type gb_1 from groupbox within wi_mant_contarecur
integer x = 425
integer y = 832
integer width = 1248
integer height = 136
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

