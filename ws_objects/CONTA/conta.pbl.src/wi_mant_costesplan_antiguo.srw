$PBExportHeader$wi_mant_costesplan_antiguo.srw
forward
global type wi_mant_costesplan_antiguo from wi_mvent_con_empresa
end type
type gb_1 from groupbox within wi_mant_costesplan_antiguo
end type
type gb_2 from groupbox within wi_mant_costesplan_antiguo
end type
type gb_3 from groupbox within wi_mant_costesplan_antiguo
end type
type dw_listado from datawindow within wi_mant_costesplan_antiguo
end type
type pb_imprimir from picturebutton within wi_mant_costesplan_antiguo
end type
type uo_ejercicio from u_ejercicio within wi_mant_costesplan_antiguo
end type
end forward

global type wi_mant_costesplan_antiguo from wi_mvent_con_empresa
integer width = 2569
integer height = 1532
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
dw_listado dw_listado
pb_imprimir pb_imprimir
uo_ejercicio uo_ejercicio
end type
global wi_mant_costesplan_antiguo wi_mant_costesplan_antiguo

type variables
datawindowchild  idwc_tipoalm,idwc_codcli
end variables

event open;call super::open;uo_ejercicio.em_ejercicio.text=String(f_ejercicio_activo(codigo_empresa))

istr_parametros.s_titulo_ventana  = "Mantenimiento de las cuentas de gastos"

This.title = istr_parametros.s_titulo_ventana

dw_listado.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	uo_ejercicio.em_ejercicio.text = istr_parametros.s_argumentos[2]
	sle_valor.text = istr_parametros.s_argumentos[3]
	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text)  or &
		Trim(uo_ejercicio.em_ejercicio.text)<>"" and Not IsNull(uo_ejercicio.em_ejercicio.text)Then
	  dw_1.Retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa,sle_valor.Text)
	END IF
END IF


	
end event

event ue_inserta_fila;call super::ue_inserta_fila; Decimal ejercicio
 Integer v_niveles,v_nivel
 String cta

 cta = f_controlar_numero_digitos_analitica(sle_valor.text)
 sle_valor.text = cta
 ejercicio = Dec(uo_ejercicio.em_ejercicio.text)
 v_nivel   = f_controlar_digitos_analitica(sle_valor.text)

 dw_1.setitem(dw_1.getrow(),"empresa",codigo_empresa)
 dw_1.setitem(dw_1.getrow(),"coste",sle_valor.text)
 dw_1.setitem(dw_1.getrow(),"ejercicio",ejercicio)
 dw_1.setitem(dw_1.getrow(),"nivel",v_nivel)


end event

event ue_recuperar;String cta

// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
longitud      =  len(trim(uo_ejercicio.em_ejercicio.text))
criterio[3]   =  trim(uo_ejercicio.em_ejercicio.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "costesplan"

cta = f_controlar_numero_digitos_analitica(sle_valor.text)
dw_1.Retrieve(Dec(uo_ejercicio.em_ejercicio.text),codigo_empresa,cta)


CALL Super::ue_recuperar
end event

event ue_activa_claves;call super::ue_activa_claves;
uo_ejercicio.enabled = TRUE
end event

on wi_mant_costesplan_antiguo.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.dw_listado=create dw_listado
this.pb_imprimir=create pb_imprimir
this.uo_ejercicio=create uo_ejercicio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_3
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.pb_imprimir
this.Control[iCurrent+6]=this.uo_ejercicio
end on

on wi_mant_costesplan_antiguo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.dw_listado)
destroy(this.pb_imprimir)
destroy(this.uo_ejercicio)
end on

event ue_desactiva_claves;call super::ue_desactiva_claves;
uo_ejercicio.enabled = FALSE
end event

type dw_1 from wi_mvent_con_empresa`dw_1 within wi_mant_costesplan_antiguo
integer x = 46
integer y = 484
integer width = 1742
integer height = 332
string dataobject = "dw_costesplan"
end type

type st_1 from wi_mvent_con_empresa`st_1 within wi_mant_costesplan_antiguo
integer x = 27
integer y = 208
integer width = 416
string text = "Cuenta Coste:"
alignment alignment = left!
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within wi_mant_costesplan_antiguo
integer x = 1934
integer y = 476
integer height = 84
integer textsize = -10
string facename = "Arial"
end type

type cb_borrar from wi_mvent_con_empresa`cb_borrar within wi_mant_costesplan_antiguo
integer x = 1934
integer y = 604
integer height = 84
integer textsize = -10
string facename = "Arial"
end type

event cb_borrar::clicked;String cta
Dec vejercicio,numero
IF Trim(sle_valor.text) <> ""  and IsNumber(sle_valor.text)Then
  IF Not(f_controlar_niveles_superiores(codigo_empresa,Integer(uo_ejercicio.em_ejercicio.text),sle_valor.text)) THEN
   MessageBox("No Puede borrar esta cuenta de coste","Existen cuentas a niveles superiores",Exclamation!, OK!,1)
   sle_valor.Text = ""
   dw_1.Reset()
   f_activar_campo(sle_valor)
   Return
  END IF
END IF
cta = sle_valor.text
vejercicio = Dec(uo_ejercicio.em_ejercicio.text)
Select Count(*) Into :numero From costesapu
Where  ejercicio = :vejercicio
And    empresa   = :codigo_empresa
And    coste     = :cta;
IF IsNull(numero) Then numero = 0
IF numero <> 0 Then
	f_mensaje("Control Borrado Cuenta de coste","No se puede Borrar la cuenta Existen movimientos")
	f_activar_campo(sle_valor)
	Return
END IF
CALL Super::Clicked


end event

type sle_valor from wi_mvent_con_empresa`sle_valor within wi_mant_costesplan_antiguo
integer x = 448
integer y = 196
integer width = 498
end type

event sle_valor::losefocus;call super::losefocus;integer n_nivel
IF Trim(This.text) <> ""  and IsNumber(This.text)Then

	This.text = f_controlar_numero_digitos_analitica(this.text)

 	n_nivel=f_controlar_digitos_analitica(sle_valor.text)
 	If n_nivel = 0 Then
   	MessageBox("No Puede grabar esta cuenta de coste","El numero de digitos no coincide con digitos por nivel",Exclamation!, OK!,1)
   	This.Text = ""
   	dw_1.Reset()
   	f_activar_campo(sle_valor)
   	Return
 	END IF


  	IF Not(f_controlar_niveles_anteriores_analitica(codigo_empresa,Dec(uo_ejercicio.em_ejercicio.text),sle_valor.text)) THEN
   	MessageBox("No Puede grabar esta cuenta de coste","No existe cuenta a nivel anterior",Exclamation!, OK!,1)
   	This.Text = ""
   	dw_1.Reset()
   	f_activar_campo(sle_valor)
   	Return
 	END IF

END IF
end event

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_costesplan"
ue_titulo      = "AYUDA SELECCION DE CUENTAS DE COSTE"
ue_filtro      = "ejercicio = " + uo_ejercicio.em_ejercicio.text 
end event

event sle_valor::tecla_tabulador;call super::tecla_tabulador;This.text = f_controlar_numero_digitos_analitica(this.text)
end event

type cb_salir from wi_mvent_con_empresa`cb_salir within wi_mant_costesplan_antiguo
integer x = 1934
integer y = 736
integer height = 84
integer textsize = -10
string facename = "Arial"
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within wi_mant_costesplan_antiguo
integer taborder = 60
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within wi_mant_costesplan_antiguo
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within wi_mant_costesplan_antiguo
integer width = 2487
end type

type gb_1 from groupbox within wi_mant_costesplan_antiguo
integer x = 1920
integer y = 432
integer width = 439
integer height = 136
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_2 from groupbox within wi_mant_costesplan_antiguo
integer x = 1920
integer y = 564
integer width = 439
integer height = 136
integer taborder = 50
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type gb_3 from groupbox within wi_mant_costesplan_antiguo
integer x = 1920
integer y = 696
integer width = 439
integer height = 136
integer taborder = 40
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
end type

type dw_listado from datawindow within wi_mant_costesplan_antiguo
boolean visible = false
integer x = 18
integer y = 156
integer width = 375
integer height = 236
integer taborder = 30
boolean bringtotop = true
string dataobject = "report_costesplan"
boolean livescroll = true
end type

type pb_imprimir from picturebutton within wi_mant_costesplan_antiguo
integer x = 1349
integer y = 188
integer width = 110
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "print!"
alignment htextalign = left!
end type

event clicked;
dw_listado.retrieve(Integer(uo_ejercicio.em_ejercicio.text),codigo_empresa)
f_imprimir_datawindow(dw_listado)
end event

type uo_ejercicio from u_ejercicio within wi_mant_costesplan_antiguo
integer x = 1778
integer y = 200
integer width = 631
integer height = 104
end type

on uo_ejercicio.destroy
call u_ejercicio::destroy
end on

