$PBExportHeader$w_int_venalb2.srw
forward
global type w_int_venalb2 from wc_mantenimientos_tab
end type
type uo_cliente from u_em_campo_2 within pagina_4
end type
type st_2 from statictext within pagina_4
end type
type em_anyo from u_em_campo within w_int_venalb2
end type
type pb_calculadora from u_calculadora within w_int_venalb2
end type
type cb_lineas from u_boton within w_int_venalb2
end type
type dw_proceso from datawindow within w_int_venalb2
end type
type dw_detalle from datawindow within w_int_venalb2
end type
type pb_imprimir from upb_imprimir within w_int_venalb2
end type
type dw_report from datawindow within w_int_venalb2
end type
type gb_1 from groupbox within w_int_venalb2
end type
end forward

global type w_int_venalb2 from wc_mantenimientos_tab
integer width = 2939
integer height = 1784
em_anyo em_anyo
pb_calculadora pb_calculadora
cb_lineas cb_lineas
dw_proceso dw_proceso
dw_detalle dw_detalle
pb_imprimir pb_imprimir
dw_report dw_report
gb_1 gb_1
end type
global w_int_venalb2 w_int_venalb2

type variables
str_venalb  venalb
String antecliente
end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();str_venlialb2 linalb
str_venalb2   ped 
Integer  reg,reg1 
Dec{0}  ultima,albaran,periodo,parcial_pallets
Dec{2}  parcial_cantidad,parcial_cajas
Dec{4}  impdto,importe,acumulado,importedto1,importedto2,importedto3,importedto4,importedtopp,importedtoesp,control_precio,control_bruto,control_importedto,control_importe
Dec{2}  var_dto1,var_dto2,var_dto3,var_dto4,var_dtopp,control_descuento
String  var_tipodto1,var_tipodto2,var_tipodto3,var_tipodto4,var_calculo_dto
Dec{4}  var_impdto1,var_impdto2,var_impdto3,var_impdto4
Integer procesos

periodo   =  Integer(em_anyo.text)
albaran    =  Dec(sle_valor.text)
dw_detalle.Retrieve(codigo_empresa,periodo,albaran)
reg1 = dw_detalle.RowCount()
linalb.empresa   = codigo_empresa
linalb.anyo      = periodo
linalb.albaran  = albaran

 
For reg = 1 To reg1 
linalb.linea  = dw_detalle.GetItemNumber(reg,"linea")
f_actualizar_linea_venalbaran2(linalb.empresa,linalb.anyo,linalb.albaran,linalb.linea)
COMMIT;
NEXT
f_actualizar_venalbaran2(codigo_empresa,periodo,albaran)
dw_detalle.Reset()
COMMIT;
end subroutine

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = TRUE
pag4 = TRUE


prin_pag1  =  TRUE
pag_act4   =  FALSE
pag_act5   =  FALSE

end event

on w_int_venalb2.create
int iCurrent
call super::create
this.em_anyo=create em_anyo
this.pb_calculadora=create pb_calculadora
this.cb_lineas=create cb_lineas
this.dw_proceso=create dw_proceso
this.dw_detalle=create dw_detalle
this.pb_imprimir=create pb_imprimir
this.dw_report=create dw_report
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_anyo
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.cb_lineas
this.Control[iCurrent+4]=this.dw_proceso
this.Control[iCurrent+5]=this.dw_detalle
this.Control[iCurrent+6]=this.pb_imprimir
this.Control[iCurrent+7]=this.dw_report
this.Control[iCurrent+8]=this.gb_1
end on

on w_int_venalb2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_anyo)
destroy(this.pb_calculadora)
destroy(this.cb_lineas)
destroy(this.dw_proceso)
destroy(this.dw_detalle)
destroy(this.pb_imprimir)
destroy(this.dw_report)
destroy(this.gb_1)
end on

event ue_recuperar;//-------------------------------------------------
// Valores Para Funcion de bloqueo-----------------
//-------------------------------------------------

titulo        =  This.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(string(dec(em_anyo.text))))
criterio[2]   =  Trim(string(dec(em_anyo.text)))+space(20-longitud)
longitud      =  len(trim(string(dec(sle_valor.text))))
criterio[3]   =  trim(string(dec(sle_valor.text)))+space(20-longitud)
seleccion[1]  =  criterio[1]+criterio[2]+criterio[3]
tabla[1]      = "venalb2"
dw_pag1.SetTabOrder("cliente",10)
IF dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text)) <> 0 Then
	antecliente  = dw_pag1.GetItemString(1,"cliente")
	//dw_pag1.SetTabOrder("cliente",0)
END IF
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;
IF Trim(f_valor_columna(dw_pag1,1,"empresa")) = "" Then
 dw_pag1.SetItem(1,"albaran",Dec(sle_valor.text))
 dw_pag1.SetItem(1,"falbaran",DateTime(Today()))
 dw_pag1.SetItem(1,"usuario_pedido",nombre_usuario)
 dw_pag1.SetItem(1,"usuario",nombre_usuario)
 dw_pag1.SetItem(1,"abono","N")
END IF

dw_pag1.SetItem(1,"empresa",codigo_empresa)
dw_pag1.SetItem(1,"anyo",Dec(em_anyo.text))
dw_pag2.SetItem(1,"empresa",codigo_empresa)







end event

event open;call super::open;titulo= "Consulta / Introducción de Albaranes Volcados"
This.title = titulo
dw_proceso.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_pag1.SetTransObject(SQLCA)
dw_pag2.SetTransObject(SQLCA)
dw_pag4.SetTransObject(SQLCA)
dw_proceso.SetTransObject(SQLCA)
dw_report.SetTransObject(SQLCA)
em_anyo.text = String(Year(Today()))

f_mascara_columna(dw_pag1,"peso","###,###")
f_mascara_columna(dw_pag1,"peso_neto","###,###")
f_mascara_columna(dw_pag2,"dtoesp1","###.00")
f_mascara_columna(dw_pag2,"dtoesp2","###.00")
f_mascara_columna(dw_pag2,"dtoesp3","###.00")
f_mascara_columna(dw_pag2,"dtoesp4","###.00")
f_mascara_columna(dw_pag2,"dtopp","###.00")

f_mascara_columna(dw_pag2,"comision1","###.00")
f_mascara_columna(dw_pag2,"comision11","###.00")
f_mascara_columna(dw_pag2,"comision2","###.00")
f_mascara_columna(dw_pag2,"comision22","###.00")
f_mascara_columna(dw_pag2,"comision31","###.00")
f_mascara_columna(dw_pag2,"comision32","###.00")

 // Si recibo el codigo lo visualizo
   
	IF istr_parametros.i_nargumentos>1 THEN
      em_anyo.text=istr_parametros.s_argumentos[2]
      sle_valor.text=istr_parametros.s_argumentos[3]
      IF len(sle_valor.text) <> 0  and len(em_anyo.text)<> 0 Then
       This.TriggerEvent("ue_recuperar")
		 f_activar_campo(sle_valor)
      END IF
   END IF
	
	
end event

event ue_pase_valores;call super::ue_pase_valores;dw_pag1.SetItem(1,"observaciones",dw_pag2.GetItemString(1,"observaciones"))
dw_pag1.SetItem(1,"agente1",dw_pag2.GetItemString(1,"agente1"))
dw_pag1.SetItem(1,"agente2",dw_pag2.GetItemString(1,"agente2"))
dw_pag1.SetItem(1,"agente3",dw_pag2.GetItemString(1,"agente3"))
dw_pag1.SetItem(1,"comision1",dw_pag2.GetItemNumber(1,"comision1"))
dw_pag1.SetItem(1,"comision2",dw_pag2.GetItemNumber(1,"comision2"))
dw_pag1.SetItem(1,"comision31",dw_pag2.GetItemNumber(1,"comision31"))
dw_pag1.SetItem(1,"comision11",dw_pag2.GetItemNumber(1,"comision11"))
dw_pag1.SetItem(1,"comision22",dw_pag2.GetItemNumber(1,"comision22"))
dw_pag1.SetItem(1,"comision32",dw_pag2.GetItemNumber(1,"comision32"))
dw_pag1.SetItem(1,"agrupa",dw_pag2.GetItemString(1,"agrupa"))
dw_pag1.SetItem(1,"periodo_fac",dw_pag2.GetItemString(1,"periodo_fac"))
dw_pag1.SetItem(1,"dtopp",dw_pag2.GetItemNumber(1,"dtopp"))
dw_pag1.SetItem(1,"dtoesp1",dw_pag2.GetItemNumber(1,"dtoesp1"))
dw_pag1.SetItem(1,"dtoesp2",dw_pag2.GetItemNumber(1,"dtoesp2"))
dw_pag1.SetItem(1,"dtoesp3",dw_pag2.GetItemNumber(1,"dtoesp3"))
dw_pag1.SetItem(1,"dtoesp4",dw_pag2.GetItemNumber(1,"dtoesp4"))
dw_pag1.SetItem(1,"tipodto1",dw_pag2.GetItemString(1,"tipodto1"))
dw_pag1.SetItem(1,"tipodto2",dw_pag2.GetItemString(1,"tipodto2"))
dw_pag1.SetItem(1,"tipodto3",dw_pag2.GetItemString(1,"tipodto3"))
dw_pag1.SetItem(1,"tipodto4",dw_pag2.GetItemString(1,"tipodto4"))
dw_pag1.SetItem(1,"calculo_dto",dw_pag2.GetItemString(1,"calculo_dto"))
dw_pag1.SetItem(1,"calculo_dtoesp",dw_pag2.GetItemString(1,"calculo_dtoesp"))
dw_pag1.SetItem(1,"explicaciondto1",dw_pag2.GetItemString(1,"explicaciondto1"))
dw_pag1.SetItem(1,"explicaciondto2",dw_pag2.GetItemString(1,"explicaciondto2"))
dw_pag1.SetItem(1,"explicaciondto3",dw_pag2.GetItemString(1,"explicaciondto3"))
dw_pag1.SetItem(1,"explicaciondto4",dw_pag2.GetItemString(1,"explicaciondto4"))

dw_pag1.SetItem(1,"envio",dw_pag2.GetItemString(1,"envio"))
dw_pag1.SetItem(1,"correspondencia",dw_pag2.GetItemString(1,"correspondencia"))
dw_pag1.SetItem(1,"domiciliacion",dw_pag2.GetItemString(1,"domiciliacion"))
dw_pag1.SetItem(1,"transportista",dw_pag2.GetItemString(1,"transportista"))

dw_pag1.SetItem(1,"textcomercial1",dw_pag3.GetItemString(1,"textcomercial1"))
dw_pag1.SetItem(1,"textcomercial2",dw_pag3.GetItemString(1,"textcomercial2"))
dw_pag1.SetItem(1,"textaduanaesp1",dw_pag3.GetItemString(1,"textaduanaesp1"))
dw_pag1.SetItem(1,"textaduanaesp2",dw_pag3.GetItemString(1,"textaduanaesp2"))
dw_pag1.SetItem(1,"textaduanaext1",dw_pag3.GetItemString(1,"textaduanaext1"))
dw_pag1.SetItem(1,"textaduanaext2",dw_pag3.GetItemString(1,"textaduanaext2"))



end event

event ue_activa_claves;call super::ue_activa_claves;apartados.pagina_4.visible = TRUE
cb_lineas.enabled      = TRUE
pb_calculadora.visible = TRUE
pb_imprimir.visible	  = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;apartados.pagina_4.visible = FALSE
cb_lineas.enabled = FALSE
pb_calculadora.visible = FALSE
pb_imprimir.visible = FALSE
end event

event ue_f6;call super::ue_f6;cb_lineas.TriggerEvent(Clicked!)
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;f_control()
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_int_venalb2
integer x = 2144
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_int_venalb2
integer x = 1838
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

event cb_borrar::clicked;//Nada
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_int_venalb2
integer x = 1531
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;IF  cb_insertar.enabled = TRUE Then
String var_codpago,var_bancocobro,control_banco,campo
datawindow dato
Integer numero

var_codpago   = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'codpago')	
var_bancocobro= apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'banco_de_cobro')	

if Trim(var_codpago)<>"" then
	control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
   if control_banco = "S" and Trim(var_bancocobro)="" then
     campo="banco_de_cobro"
	  dato = apartados.pagina_1.dw_pagina1
     numero = 1
   End if
End If

IF Trim(campo)<>"" THEN
  MessageBox(" "+campo+": Campo obligatorio","Introducir el campo ",Exclamation!, OK!,1)
  apartados.SelectTab(numero)
  dato.setfocus()
  dato.SetColumn(campo)
  Return
END IF

IF Dec(f_valor_columna(dw_pag2,1,"dtoesp1")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto1","")
IF Dec(f_valor_columna(dw_pag2,1,"dtoesp2")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto2","")
IF Dec(f_valor_columna(dw_pag2,1,"dtoesp3")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto3","")

IF Dec(f_valor_columna(dw_pag2,1,"dtoesp4")) = 0 Then f_asignar_columna(dw_pag2,1,"tipodto4","")
   f_asignar_columna(dw_pag1,1,"iva",String(f_iva_contaiva(f_ejercicio_activo(codigo_empresa),codigo_empresa,f_valor_columna(dw_pag1,1,"tipoiva"))))
	call super::clicked
   //f_control() // Lo hace actualiza_dw
  ELSE 
	call super::clicked
END IF 
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_int_venalb2
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_int_venalb2
integer height = 92
end type

event st_empresa::clicked;call super::clicked;str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_lis_venproformas,lstr_param)
 f_activar_campo(sle_valor)
end event

type sle_valor from wc_mantenimientos_tab`sle_valor within w_int_venalb2
integer x = 585
integer y = 156
integer width = 302
integer taborder = 40
end type

event sle_valor::getfocus;call super::getfocus;dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

end event

type st_1 from wc_mantenimientos_tab`st_1 within w_int_venalb2
integer x = 37
integer y = 164
integer width = 302
string text = "Volcado:"
alignment alignment = right!
end type

type apartados from wc_mantenimientos_tab`apartados within w_int_venalb2
integer x = 9
integer y = 260
integer width = 2848
integer height = 1288
boolean multiline = true
end type

event apartados::clicked;call super::clicked;IF index = 4 Then f_activar_campo(apartados.pagina_4.uo_cliente.em_campo)
end event

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 2811
integer height = 1160
string text = "Datos Facturación."
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 0
integer y = 12
integer width = 2802
integer height = 1152
string dataobject = "dw_int_venalb21"
end type

event dw_pagina1::clicked;call super::clicked;IF GetRow() = 0  Then return
str_parametros lstr_param
CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_cliente"
 
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
 OpenWithParm(wi_mant_clientes2,lstr_param)  

CASE "pb_envio"
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"envio")
   OpenWithParm(wi_mant_venenvio,lstr_param)  
CASE "pb_correspondencia"
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=f_valor_columna(This,This.GetRow(),"correspondencia")
   OpenWithParm(wi_mant_vencorrespondencia,lstr_param)  
CASE "pb_codentrega" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cod_entrega")
	OpenWithParm(wi_mant_vencondentrega,lstr_param)  
CASE "pb_codpago" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"codpago")
	OpenWithParm(wi_mant_carforpag,lstr_param)  

CASE "pb_idioma" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"idioma")
	OpenWithParm(wi_mant_idiomas,lstr_param)  
CASE "pb_tipo_iva" 
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=String(f_ejercicio_activo(codigo_empresa))
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"tipoiva")
	OpenWithParm(wi_mant_contaiva,lstr_param)  
 
END CHOOSE


end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;String var_texto1,var_texto2,var_condicion,var_moneda,var_tarifa,var_idioma
string control_banco, var_codpago

var_texto1  = f_valor_columna(This,This.GetRow(),'textopie1')
var_texto2  = f_valor_columna(This,This.GetRow(),'textopie2')
var_tarifa  = f_valor_columna(This,This.GetRow(),'tarifa')
var_idioma  = f_valor_columna(This,This.GetRow(),'idioma')
var_codpago = f_valor_columna(This,This.GetRow(),'codpago')


IF Trim(var_texto1) = "" or IsNull(var_texto1)   then
	var_texto1 = f_nombre_vencondentrega(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'))
   f_asignar_columna(This,This.getrow(),"textopie1",var_texto1)
END IF

IF Trim(var_texto2) = "" or IsNull(var_texto2) then
	var_texto2 = f_nombre_vencondentrega_idioma(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'),var_idioma)
   f_asignar_columna(This,This.getrow(),"textopie2",var_texto2)
END IF

var_condicion = f_condicion_vencondentrega(codigo_empresa,f_valor_columna(This,This.GetRow(),'cod_entrega'))
f_asignar_columna(This,This.getrow(),"condicion",var_condicion)
This.SetTabOrder("divisa",90)
IF Trim(var_tarifa) <> "" and Not IsNull(var_tarifa) Then
	var_moneda = f_moneda_ventarifas(codigo_empresa,var_tarifa)
	f_asignar_columna(This,This.GetRow(),"divisa",var_moneda)
	This.SetTabOrder("divisa",0)
END IF

control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))

This.SetTabOrder("banco_de_cobro",130)
if control_banco = "N" then
	This.SetTabOrder("banco_de_cobro",0)
	f_asignar_columna(dw_pag1,1,"banco_de_cobro","")
END IF


end event

event dw_pagina1::key; bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  CASE "cliente"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"

  CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
      valor_empresa = FALSE		  
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISAS"
		   valor_empresa = FALSE
  CASE "tarifa"
      bus_datawindow = "dw_ayuda_ventarifas"
     	bus_titulo     = "VENTANA SELECCION DE TARIFAS"
  CASE "tipoiva"
      bus_datawindow = "dw_ayuda_contaiva"
    	bus_titulo     = "VENTANA SELECCION DE Tipos de Iva"
		 bus_filtro = " ejercicio = "+String(f_ejercicio_activo(codigo_empresa))
  CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
  CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "VENTANA SELECCION BANCOS DE COBRO"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

 CHOOSE CASE bus_campo
     CASE "cliente"
	  This.TriggerEvent("itemchanged")
 END CHOOSE




end event

event dw_pagina1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
   CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
   CASE "tipoiva"
      bus_datawindow = "dw_ayuda_contaiva"
    	bus_titulo     = "VENTANA SELECCION DE Tipos de Iva"
  	   bus_filtro = " ejercicio = "+String(f_ejercicio_activo(codigo_empresa))		
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
      valor_empresa = FALSE		  
  CASE "tarifa"
      bus_datawindow = "dw_ayuda_ventarifas"
     	bus_titulo     = "VENTANA SELECCION DE TARIFAS"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISA"
	   valor_empresa = FALSE
  CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo     = "VENTANA SELECCION BANCOS DE COBRO"
  CASE "cliente"
		bus_titulo     = "VENTANA SELECCION CLIENTES"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		

  CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"

   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIRECCIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina1::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(This,"codpago")
       f_valores_numericos(This,"divisa")
       f_valores_numericos(This,"tarifa")
       f_valores_numericos(This,"cliente")
      
//---------------------------------------------//
//---------------------------------------------//
end event

event dw_pagina1::itemchanged;call super::itemchanged;String codcli
IF GetRow() =0 Then Return
codcli    = GetItemString(This.GetRow(),"cliente")

if Integer(codcli)=0 then Return

CHOOSE CASE GetColumnName()
   
   CASE "cliente"
       
		AcceptText()
	   String var_Nombre,var_direcc,var_codpostal,var_provincia,var_pais,var_localidad
		str_venalb ped
		Integer  var_ejercicio
		String var_empresa,var_codigo,var_tipoter
		var_ejercicio = f_ejercicio_activo(codigo_empresa)
		venalb.cliente  = GetItemString(This.GetRow(),"cliente")
  
      IF venalb.cliente <> antecliente or IsNull(antecliente) Then
               SELECT venclientes.zona,venclientes.serie,venclientes.agente1,   
                      venclientes.agente2,venclientes.agente3,venclientes.comision1, venclientes.comision2,   venclientes.comision31,
                      venclientes.cod_pago,venclientes.dtopp,venclientes.dtoesp1,   
                      venclientes.dtoesp2, venclientes.tipoiva,
						    venclientes.forma_envio, venclientes.tipo_portes,   
							 venclientes.cod_entrega, venclientes.periodo_fac,   
							 venclientes.explicaciondto1, venclientes.explicaciondto2,   
							 venclientes.tarifa,   
							 venclientes.comision11,      venclientes.comision22,   venclientes.comision31, 
							 venclientes.dtoesp3,         venclientes.dtoesp4,   
							 venclientes.explicaciondto3, venclientes.explicaciondto4,   
							 venclientes.tipodto1,        venclientes.tipodto2,   
							 venclientes.tipodto3,        venclientes.tipodto4,   
							 venclientes.empresa,         venclientes.codigo  ,
							 venclientes.cod_entrega,     venclientes.calculo_dto  ,
							 venclientes.banco_de_cobro,  venclientes.envio,
							 venclientes.correspondencia,venclientes.domiciliacion,venclientes.transportista,
							 venclientes.deposito,venclientes.agrupa, venclientes.calculo_dtoesp
					INTO   :venalb.zona, :venalb.serie, :venalb.agente1, :venalb.agente2,:venalb.agente3,:venalb.comision1,   
                      :venalb.comision2,:venalb.comision31,:venalb.codpago,:venalb.dtopp,:venalb.dtoesp1,
						    :venalb.dtoesp2,:venalb.tipoiva, :venalb.forma_envio,   
						    :venalb.tipo_portes,:venalb.cod_entrega,:venalb.periodo_fac,
						    :venalb.explicaciondto1,:venalb.explicaciondto2,   
						    :venalb.tarifa,:venalb.comision11,:venalb.comision22,:venalb.comision31,:venalb.dtoesp3,   
					       :venalb.dtoesp4,:venalb.explicaciondto3,:venalb.explicaciondto4,
						    :venalb.tipodto1,:venalb.tipodto2,:venalb.tipodto3,:venalb.tipodto4,   
						    :venalb.empresa,:venalb.cliente ,:venalb.cod_entrega,
							 :venalb.calculo_dto,:venalb.banco_de_cobro,
							 :venalb.envio,:venalb.correspondencia,
							 :venalb.domiciliacion,:venalb.transportista,
							 :venalb.deposito,:venalb.agrupa, :venalb.calculo_dtoesp
					FROM   venclientes  
               WHERE  ( venclientes.empresa = :codigo_empresa ) AND  
                      ( venclientes.codigo = :venalb.cliente )   
               ORDER BY venclientes.empresa ASC,venclientes.codigo ASC  ;
					venalb.deposito = "N"
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",venalb.cliente)

               Select  genter.empresa,genter.tipoter,genter.codigo,genter.idioma,genter.moneda
               Into    :var_empresa,:var_tipoter,:var_codigo,:venalb.idioma,:venalb.divisa
               From genter
               Where   genter.empresa = :codigo_empresa 
               And     genter.tipoter = 'C'
               And     genter.codigo  = :venalb.cliente
               Order by genter.empresa Asc, genter.tipoter Asc,genter.codigo Asc;
   	  
					SELECT contaiva.iva  INTO :venalb.iva  
					FROM contaiva  
					WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
					   	( contaiva.empresa = :codigo_empresa ) AND  
							( contaiva.tipoiva = :venalb.tipoiva )   ;
	  
					apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"codpago",venalb.codpago)
					apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"banco_de_cobro",venalb.banco_de_cobro)
               apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",venalb.cliente)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente1",venalb.agente1)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente2",venalb.agente2)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente3",venalb.agente3)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision1",venalb.comision1)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision2",venalb.comision2)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision31",venalb.comision31)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision11",venalb.comision11)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision22",venalb.comision22)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision32",venalb.comision32)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtopp",venalb.dtopp)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp1",venalb.dtoesp1)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp2",venalb.dtoesp2)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp3",venalb.dtoesp3)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp4",venalb.dtoesp4)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto1",venalb.tipodto1)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto2",venalb.tipodto2)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto3",venalb.tipodto3)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto4",venalb.tipodto4)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto1",venalb.explicaciondto1)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto2",venalb.explicaciondto2)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto3",venalb.explicaciondto3)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto4",venalb.explicaciondto4)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dto",venalb.calculo_dto)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"envio",venalb.envio)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"correspondencia",venalb.correspondencia)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"domiciliacion",venalb.domiciliacion)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"transportista",venalb.transportista)
					apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dtoesp",venalb.calculo_dtoesp)
					apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"deposito",venalb.deposito)
					apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"agrupa",venalb.agrupa)
					apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"periodo_fac",venalb.periodo_fac)
					dw_pag2.SetItem(GetRow(),"agrupa",venalb.agrupa)
					dw_pag2.SetItem(GetRow(),"periodo_fac",venalb.periodo_fac)
      
					SetItem(GetRow(),"tipoiva",venalb.tipoiva)
					SetItem(GetRow(),"iva",venalb.iva)	  
               SetItem(GetRow(),"serie",venalb.serie)
               SetItem(GetRow(),"zona",venalb.zona)
               SetItem(GetRow(),"forma_envio",venalb.forma_envio)
               SetItem(GetRow(),"cod_entrega",venalb.cod_entrega)
      End if
 
      SetItem(GetRow(),"idioma",venalb.idioma)
      SetItem(GetRow(),"divisa",venalb.divisa)
      SetItem(GetRow(),"tarifa",venalb.tarifa)
      antecliente = GetItemString(GetRow(),"cliente")
             

END CHOOSE



end event

event dw_pagina1::getfocus;call super::getfocus;IF apartados.pagina_1.dw_pagina1.GetRow()= 0 Then Return

 antecliente = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),"cliente")

end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 2811
integer height = 1160
string text = "Datos Comerciales"
end type

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 4
integer width = 2789
integer height = 1148
string dataobject = "dw_int_venalb22"
end type

event dw_pagina2::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_agente1'
   
	lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(this,This.GetRow(),"agente1")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  

CASE 'pb_agente2'
	
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente2")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  
	  
CASE 'pb_agente3'
	
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"agente3")
  	OpenWithParm(wi_mant_venagentes,lstr_param)  

CASE "pb_envio"
   
	lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
   OpenWithParm(wi_mant_venenvio,lstr_param)

CASE "pb_correspondencia"

   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
   OpenWithParm(wi_mant_vencorrespondencia,lstr_param)

CASE "pb_transportista"
  
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)

CASE "pb_domiciliacion"
  
   lstr_param.i_nargumentos    = 3
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
   lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
   OpenWithParm(wi_mant_vendomiciliacion,lstr_param)

END CHOOSE



end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;String li_codprov
String li_codpais

CHOOSE CASE This.GetColumnName()
CASE "localidad"
  String var_provincia,var_pais
  String var_postal,var_localidad

  var_pais      = This.GetItemString(This.GetRow(),'pais')
  var_provincia = This.GetItemString(This.GetRow(),'provincia')	
  var_postal    = This.GetItemString(This.GetRow(),'codpostal')	
  var_localidad = This.GetItemString(This.GetRow(),'localidad')
 
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
  SELECT  codpostales.provincia,codpostales.ciudad  
    INTO  :var_provincia,:var_localidad  
    FROM  codpostales  
   WHERE (codpostales.pais      = :var_pais ) AND  
         (codpostales.codpostal = :var_postal);
   This.SetItem(This.getrow(),"provincia",var_provincia)
   This.SetItem(This.getrow(),"localidad",var_localidad)   
END IF
END CHOOSE


end event

event dw_pagina2::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo


   CASE "envio"
		   bus_datawindow = "dw_ayuda_venenvio"
			bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "correspondencia"
			bus_datawindow = "dw_ayuda_vencorrespondencia"
			bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "domiciliacion"
			bus_datawindow = "dw_ayuda_vendomiciliacion"
			bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
	CASE "transportista"
			bus_datawindow = "dw_ayuda_ventransportistas"
			bus_titulo = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	      bus_filtro = ""
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE

 CALL Super::Key

 CHOOSE CASE bus_campo
     CASE "cliente"
	  This.TriggerEvent("itemchanged")
 END CHOOSE

END IF


end event

event dw_pagina2::rbuttondown; valor_empresa = TRUE	
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "codpago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo     = "VENTANA SELECCION FORMAS DE PAGO"
   CASE "agente1"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
   CASE "agente2"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
	CASE "agente3"
      bus_datawindow = "dw_ayuda_venagentes"
     	bus_titulo     = "VENTANA SELECCION DE AGENTES"
  CASE "idioma"
      bus_datawindow = "dw_ayuda_idiomas"
     	bus_titulo     = "VENTANA SELECCION DE IDIOMAS"
  CASE "divisa"
      bus_datawindow = "dw_ayuda_divisas"
     	bus_titulo     = "VENTANA SELECCION DE DIVISAS"
   CASE "domiciliacion"
		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	   bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE "transportista"
		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo     = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	   bus_filtro     = ""
  CASE "envio"
		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE "correspondencia"
		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
	   bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
  CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina2::valores_numericos;call super::valores_numericos;//---------------------------------------------//
// Controla que solo permina valores numericos //
//---------------------------------------------//
       f_valores_numericos(this,"agente1")
       f_valores_numericos(This,"agente2")
       f_valores_numericos(This,"agente3")
//---------------------------------------------//
//---------------------------------------------//
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 2811
integer height = 1160
string text = "Textos"
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 0
integer width = 2784
integer height = 1212
string dataobject = "dw_int_venalb23"
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 2811
integer height = 1160
string text = "Consultar"
uo_cliente uo_cliente
st_2 st_2
end type

on pagina_4.create
this.uo_cliente=create uo_cliente
this.st_2=create st_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.st_2
end on

on pagina_4.destroy
call super::destroy
destroy(this.uo_cliente)
destroy(this.st_2)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 0
integer y = 128
integer width = 2811
integer height = 1024
string dataobject = "dw_int_venalb24"
boolean vscrollbar = true
end type

event dw_pagina4::doubleclicked;call super::doubleclicked;IF row=0 then Return
em_anyo.text= String(GetItemNumber(row,"anyo"))
sle_valor.text= String(GetItemNumber(row,"albaran"))
apartados.getParent().TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
apartados.SelectTab(1)
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 2811
integer height = 1160
string text = "~r~n"
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
boolean visible = false
integer x = 0
integer y = 16
integer width = 2235
integer height = 1100
end type

event dw_pagina5::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina5::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_agente1"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente1")
   OpenWithParm(wi_mant_venagentes,lstr_param)  
CASE "pb_agente2"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_agente3"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"agente2")
   OpenWithParm(wi_mant_venagentes,lstr_param)
CASE "pb_cod_pago"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_carforpag,lstr_param)
	CASE "pb_cod_entrega"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_pago")
   OpenWithParm(wi_mant_vencondentrega,lstr_param)
END CHOOSE





end event

event dw_pagina5::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "pb_banco_cobro"
  		bus_datawindow = "dw_ayuda_carbancos"
 		bus_titulo = "VENTANA SELECCION BANCOS EMPRESA"
	CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina5::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"cod_pago")
f_valores_numericos(This,"agente1")
f_valores_numericos(This,"agente2")
f_valores_numericos(This,"agente3")
end event

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 2811
integer height = 1160
string text = ""
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
integer width = 2318
end type

event dw_pagina6::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina6::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param



lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_zona"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
CASE "pb_serie"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
END CHOOSE





end event

event dw_pagina6::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 2811
integer height = 1160
string text = ""
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer width = 1911
integer height = 896
end type

event dw_pagina7::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
   CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
   CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
  	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina7::clicked;call super::clicked;
datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2

CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_transportista"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_tarifa"
 	lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tarifa")
	 OpenWithParm(wi_mant_ventarifas,lstr_param)
END CHOOSE





end event

event dw_pagina7::rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  	CASE "banco_de_cobro"
 		bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS"
 	CASE "zona"
 		bus_datawindow = "dw_ayuda_venzonas"
		bus_titulo = "VENTANA SELECCION DE ZONAS"
 	CASE "tipo_cliente"
 		bus_datawindow = "dw_ayuda_ventipocli"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE CLIENTES"
 	CASE "grupo"
 		bus_datawindow = "dw_ayuda_vengrupos"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
 	CASE "agente1"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "agente2"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
CASE "agente3"
 		bus_datawindow = "dw_ayuda_venagentes"
		bus_titulo = "VENTANA SELECCION DE AGENTES"
 	CASE "cod_pago"
 		bus_datawindow = "dw_ayuda_carforpag"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE PAGO"
 	CASE "tipoiva"
 		bus_datawindow = "dw_ayuda_contaiva"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE IVA"
 	CASE "transportista"
 		bus_datawindow = "dw_ayuda_ventransportistas"
		bus_titulo = "VENTANA SELECCION DE TRANSPORTISTA"
 	CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
 	CASE "tarifa"
 		bus_datawindow = "dw_ayuda_ventarifas"
		bus_titulo = "VENTANA SELECCION DE TARIFAS"
 	CASE "domiciliacion"
 		bus_datawindow = "dw_ayuda_vendomiciliacion"
		bus_titulo = "VENTANA SELECCION DE DOMICILIACIONES"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIREECIONES DE ENVIO"
     bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE "forma_envio"
 		bus_datawindow = "dw_ayuda_venformaenvio"
		bus_titulo = "VENTANA SELECCION DE FORMAS DE ENVIO"
   CASE "tipo_portes"
 		bus_datawindow = "dw_ayuda_ventipoportes"
		bus_titulo = "VENTANA SELECCION DE TIPOS DE PORTES"
 	CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION DE SERIES"
   CASE "correspondencia"
 		bus_datawindow = "dw_ayuda_vencorrespondencia"
		bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      bus_filtro = " cliente = '" + isle_campo.text + "'"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 2811
integer height = 1160
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
end type

type uo_cliente from u_em_campo_2 within pagina_4
integer x = 256
integer y = 20
integer width = 1934
integer height = 88
integer taborder = 3
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_pag4.Retrieve(codigo_empresa,uo_cliente.em_codigo.text)
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;
   ue_titulo     = "AYUDA SELECCION DE CLIENTES"
	ue_datawindow = "dw_ayuda_clientes"
	ue_filtro     = ""



 
        
end event

type st_2 from statictext within pagina_4
integer x = 23
integer y = 32
integer width = 219
integer height = 72
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Cliente:"
boolean focusrectangle = false
end type

type em_anyo from u_em_campo within w_int_venalb2
integer x = 347
integer y = 156
integer width = 233
integer taborder = 0
end type

type pb_calculadora from u_calculadora within w_int_venalb2
event clicked pbm_bnclicked
integer x = 891
integer y = 152
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
IF Trim(em_anyo.text)=""  THEN Return


dec{0} n_albaran
Integer registros,numero,anyo
String  var_empresa

anyo = Integer(em_anyo.text)

  
  SELECT venparamalb2.empresa,venparamalb2.albaran
    INTO :var_empresa,:registros  
    FROM venparamalb2  
   WHERE venparamalb2.empresa = :codigo_empresa  
   And   venparamalb2.anyo    = :anyo;
   If Sqlca.Sqlcode=100 Then
       INSERT INTO venparamalb2
              (empresa,anyo,albaran)  
       VALUES (:codigo_empresa,:anyo,:registros );
       COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_albaran= registros

   Select count(*) Into :numero From venalb2
   Where   venalb2.empresa   = :codigo_empresa
   And     venalb2.anyo       = :anyo
   And     venalb2.albaran   = :n_albaran;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((venalb2.albaran)+1)
       Into   :sle_valor.text
       From   venalb2
       Where  venalb2.empresa = :codigo_empresa
       And    venalb2.anyo    = :anyo;
       registros= Integer(sle_valor.text)
   End If
   UPDATE venparamalb2
   SET    albaran = :registros  
   WHERE  venparamalb2.empresa = :codigo_empresa
   And    venparamalb2.anyo    = :anyo;
   COMMIT;

   sle_valor.text=String(registros)
   apartados.TriggerEvent("pulsar_datawindow")
end event

type cb_lineas from u_boton within w_int_venalb2
event clicked pbm_bnclicked
integer x = 1225
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
string text = "F6 lineas"
end type

event clicked;call super::clicked;IF This.enabled = FALSE THEN RETURN
Integer anyo
Dec albaran

anyo    = Integer(em_anyo.text)
albaran  = Dec(sle_valor.text)

Select venalb2.albaran Into :albaran from venalb2
where  venalb2.empresa = :codigo_empresa
and    venalb2.anyo    = :anyo
and    venalb2.albaran  = :albaran;
IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo del albaran no existe","Introduzca el albaran",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF
//IF f_deposito_venalb(codigo_empresa,anyo,albaran) = "S" Then
//   MessageBox("Codigo del albaran de deposito","Introduzca otro albaran",Exclamation!, OK!,1)
//   f_activar_campo(sle_valor)
//   Return
//END IF
//


titulo        =  Parent.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[2]   =  Trim(em_anyo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]
tabla[1]         = "venalb2"
IF NOT f_bloquear(tabla[1],seleccion[1],titulo) THEN
 COMMIT;
 str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_int_venlialb2,lstr_param)
 Return
END IF
 f_activar_campo(sle_valor)
end event

type dw_proceso from datawindow within w_int_venalb2
boolean visible = false
integer width = 247
integer height = 72
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_venliproformas"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_int_venalb2
boolean visible = false
integer x = 2249
integer width = 494
integer height = 132
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_proceso_venlialb"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_imprimir from upb_imprimir within w_int_venalb2
integer x = 1010
integer y = 152
integer taborder = 0
end type

event clicked;call super::clicked; str_parametros lstr_param
 lstr_param.i_nargumentos  = 6
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 lstr_param.s_argumentos[4]="3"
 lstr_param.s_argumentos[5]="S"
 lstr_param.s_argumentos[6]="N"
 OpenWithParm(w_lis_venalbaranes_volcados,lstr_param)
 f_activar_campo(sle_valor)
end event

type dw_report from datawindow within w_int_venalb2
boolean visible = false
integer width = 494
integer height = 108
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_venliped"
boolean livescroll = true
end type

type gb_1 from groupbox within w_int_venalb2
integer x = 1211
integer y = 124
integer width = 1253
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

