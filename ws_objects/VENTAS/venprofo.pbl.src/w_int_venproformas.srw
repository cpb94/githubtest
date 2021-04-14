$PBExportHeader$w_int_venproformas.srw
forward
global type w_int_venproformas from wc_mantenimientos_tab
end type
type uo_cliente from u_em_campo_2 within pagina_4
end type
type st_2 from statictext within pagina_4
end type
type tipo_cliente from dropdownlistbox within pagina_4
end type
type dw_historico from u_datawindow_consultas within pagina_5
end type
type em_anyo from u_em_campo within w_int_venproformas
end type
type pb_calculadora from u_calculadora within w_int_venproformas
end type
type cb_copiar from u_boton within w_int_venproformas
end type
type cb_lineas from u_boton within w_int_venproformas
end type
type gb_1 from groupbox within w_int_venproformas
end type
type dw_proceso from datawindow within w_int_venproformas
end type
type dw_detalle from datawindow within w_int_venproformas
end type
type pb_imprimir from upb_imprimir within w_int_venproformas
end type
end forward

global type w_int_venproformas from wc_mantenimientos_tab
integer width = 2962
integer height = 1780
em_anyo em_anyo
pb_calculadora pb_calculadora
cb_copiar cb_copiar
cb_lineas cb_lineas
gb_1 gb_1
dw_proceso dw_proceso
dw_detalle dw_detalle
pb_imprimir pb_imprimir
end type
global w_int_venproformas w_int_venproformas

type variables
str_venproformas  profor
String antecliente,antetipocli,control_banco,var_moneda_proforma


end variables

forward prototypes
public subroutine f_control ()
end prototypes

public subroutine f_control ();
str_venliproformas linproformas
str_venproformas   ped 
linproformas.empresa   = codigo_empresa
Integer  reg,reg1 
Dec{0}  ultima,proforma,periodo,parcial_pallets,var_dtoesp
Dec{2}  parcial_cantidad,parcial_cajas
Dec{4}  impdto,importe,acumulado,importedto1,importedto2,importedto3,importedto4,importedtopp,importedtoesp,control_precio,control_bruto,control_importedto,control_importe
Dec{2}  var_dto1,var_dto2,var_dto3,var_dto4,var_dtopp,control_descuento
String  var_tipodto1,var_tipodto2,var_tipodto3,var_tipodto4,var_calculo_dto,var_calculo_dtoesp
Dec{4}  var_impdto1,var_impdto2,var_impdto3,var_impdto4
Integer procesos

periodo   =  Integer(em_anyo.text)
proforma    =  Dec(sle_valor.text)
dw_detalle.Retrieve(codigo_empresa,periodo,proforma)
reg1 = dw_detalle.RowCount()
linproformas.proforma  = proforma
For reg = 1 To reg1 
 linproformas.linea              = Dec(f_valor_columna(dw_detalle,reg,"linea"))
 f_actualizar_linea_venproforma(codigo_empresa,periodo,proforma,linproformas.linea)
NEXT
f_actualizar_venproforma_sinpeso(codigo_empresa,periodo,proforma)
dw_detalle.Reset()
end subroutine

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = TRUE
pag4 = TRUE
pag5 = TRUE


prin_pag1  =  TRUE
pag_act4   =  FALSE
pag_act5   =  FALSE

end event

on w_int_venproformas.create
int iCurrent
call super::create
this.em_anyo=create em_anyo
this.pb_calculadora=create pb_calculadora
this.cb_copiar=create cb_copiar
this.cb_lineas=create cb_lineas
this.gb_1=create gb_1
this.dw_proceso=create dw_proceso
this.dw_detalle=create dw_detalle
this.pb_imprimir=create pb_imprimir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.em_anyo
this.Control[iCurrent+2]=this.pb_calculadora
this.Control[iCurrent+3]=this.cb_copiar
this.Control[iCurrent+4]=this.cb_lineas
this.Control[iCurrent+5]=this.gb_1
this.Control[iCurrent+6]=this.dw_proceso
this.Control[iCurrent+7]=this.dw_detalle
this.Control[iCurrent+8]=this.pb_imprimir
end on

on w_int_venproformas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_anyo)
destroy(this.pb_calculadora)
destroy(this.cb_copiar)
destroy(this.cb_lineas)
destroy(this.gb_1)
destroy(this.dw_proceso)
destroy(this.dw_detalle)
destroy(this.pb_imprimir)
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
tabla[1]      = "venproformas"

dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
IF dw_pag1.Rowcount() <> 0 Then
	dw_pag1.TriggerEvent(Itemfocuschanged!)
END IF
IF dw_pag2.RowCOunt() = 0 Then
 dw_pag2.SetTabOrder("envio",240)	
 dw_pag2.SetTabOrder("correspondencia",250)	
 dw_pag2.SetTabOrder("domiciliacion",260)	
ELSE
IF f_valor_columna(dw_pag2,1,"tipo_cliente")= "S" Then
 dw_pag2.SetTabOrder("envio",240)	
 dw_pag2.SetTabOrder("correspondencia",250)	
 dw_pag2.SetTabOrder("domiciliacion",260)	
ELSE
 dw_pag2.SetTabOrder("envio",0)	
 dw_pag2.SetTabOrder("correspondencia",0)	
 dw_pag2.SetTabOrder("domiciliacion",0)	
  dw_pag2.SetTabOrder("transportista",0)	
 f_asignar_columna(dw_pag2,1,"envio","")
 f_asignar_columna(dw_pag2,1,"domiciliacion","")
 f_asignar_columna(dw_pag2,1,"correspondencia","")
END IF
END IF
apartados.pagina_5.dw_historico.Retrieve(codigo_empresa,&
f_anyo_origen_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text)),&
f_proforma_origen_venproformas(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text)))

CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;
IF Trim(f_valor_columna(dw_pag1,1,"empresa")) = "" Then
 dw_pag1.SetItem(1,"anyo_origen",Dec(em_anyo.text))
 dw_pag1.SetItem(1,"proforma",Dec(sle_valor.text))
 dw_pag1.SetItem(1,"proforma_origen",Dec(sle_valor.text))
 dw_pag1.SetItem(1,"activa","S")
 dw_pag1.SetItem(1,"fproforma",DateTime(Today()))
 dw_pag1.SetItem(1,"tipo_cliente","S")
  dw_pag2.SetItem(1,"calculo_dto","N")
 dw_pag1.SetItem(1,"usuario_proforma",nombre_usuario)
 dw_pag1.SetItem(1,"usuario",nombre_usuario)
END IF

dw_pag1.SetItem(1,"empresa",codigo_empresa)
dw_pag1.SetItem(1,"anyo",Dec(em_anyo.text))
dw_pag2.SetItem(1,"empresa",codigo_empresa)







end event

event open;call super::open;titulo= " Introducción de Proformas "
This.title = titulo
dw_proceso.SetTransObject(SQLCA)
dw_detalle.SetTransObject(SQLCA)
dw_pag1.SetTransObject(SQLCA)
dw_pag2.SetTransObject(SQLCA)
dw_pag4.SetTransObject(SQLCA)
apartados.pagina_5.dw_historico.SetTransObject(SQLCA)
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
dw_pag1.SetItem(1,"explicaciondto1",dw_pag2.GetItemString(1,"explicaciondto1"))
dw_pag1.SetItem(1,"explicaciondto2",dw_pag2.GetItemString(1,"explicaciondto2"))
dw_pag1.SetItem(1,"explicaciondto3",dw_pag2.GetItemString(1,"explicaciondto3"))
dw_pag1.SetItem(1,"explicaciondto4",dw_pag2.GetItemString(1,"explicaciondto4"))

dw_pag1.SetItem(1,"envio",dw_pag2.GetItemString(1,"envio"))
dw_pag1.SetItem(1,"correspondencia",dw_pag2.GetItemString(1,"correspondencia"))
dw_pag1.SetItem(1,"domiciliacion",dw_pag2.GetItemString(1,"domiciliacion"))
dw_pag1.SetItem(1,"transportista",dw_pag2.GetItemString(1,"transportista"))
dw_pag1.SetItem(1,"calculo_dto",dw_pag2.GetItemString(1,"calculo_dto"))
dw_pag1.SetItem(1,"calculo_dtoesp",dw_pag2.GetItemString(1,"calculo_dtoesp"))
dw_pag1.SetItem(1,"textcomercial1",dw_pag3.GetItemString(1,"textcomercial1"))
dw_pag1.SetItem(1,"textcomercial2",dw_pag3.GetItemString(1,"textcomercial2"))
dw_pag1.SetItem(1,"textaduanaesp1",dw_pag3.GetItemString(1,"textaduanaesp1"))
dw_pag1.SetItem(1,"textaduanaesp2",dw_pag3.GetItemString(1,"textaduanaesp2"))
dw_pag1.SetItem(1,"textaduanaext1",dw_pag3.GetItemString(1,"textaduanaext1"))
dw_pag1.SetItem(1,"textaduanaext2",dw_pag3.GetItemString(1,"textaduanaext2"))

end event

event ue_activa_claves;call super::ue_activa_claves;apartados.pagina_4.visible = TRUE
apartados.pagina_5.visible = TRUE
cb_lineas.enabled      = TRUE
cb_copiar.enabled      = TRUE
pb_calculadora.visible = TRUE
pb_imprimir.visible	  = TRUE
end event

event ue_desactiva_claves;call super::ue_desactiva_claves;apartados.pagina_4.visible = FALSE
apartados.pagina_5.visible = FALSE
cb_lineas.enabled = FALSE
cb_copiar.enabled = FALSE
pb_calculadora.visible = FALSE
pb_imprimir.visible = FALSE
end event

event ue_f6;call super::ue_f6;cb_lineas.TriggerEvent(Clicked!)
end event

event ue_borra_fila;call super::ue_borra_fila;Integer anyo
Dec{0}  proforma
anyo = Dec(em_anyo.text)
proforma = Dec(sle_valor.text)
Delete from  venliproformas
Where  empresa  = :codigo_empresa
And    anyo     = :anyo
And    proforma = :proforma;
end event

event ue_f5;call super::ue_f5;cb_copiar.TriggerEvent(Clicked!)
end event

event ue_actualiza_dw;call super::ue_actualiza_dw;Str_venliproformas v
v.empresa   = codigo_empresa
v.anyo      =  Dec(em_anyo.text)
v.proforma  =  Dec(sle_valor.text)

  SELECT venproformas.cliente,   
         venproformas.agente1,   
         venproformas.agente2,   
         venproformas.comision1,   
         venproformas.comision2,   
         venproformas.comision11,   
         venproformas.comision22,   
         venproformas.divisa,   
         venproformas.serie,   
         venproformas.zona,   
         venproformas.agente3,   
         venproformas.comision32,   
         venproformas.comision31,   
         venproformas.tipo_cliente,   
         venproformas.transportista  
    INTO :v.cliente,   
         :v.agente1,   
         :v.agente2,   
         :v.comision11,   
         :v.comision21,   
         :v.comision12,   
         :v.comision22,   
         :v.divisa,   
         :v.serie,   
         :v.zona,   
         :v.agente3,   
         :v.comision32,   
         :v.comision31,   
         :v.tipo_cliente,   
         :v.transportista  
    FROM venproformas  
   WHERE venproformas.empresa = :v.empresa
	AND   venproformas.anyo = :v.anyo
	AND   venproformas.proforma = :v.proforma ;
	
	v.pais      = f_pais_genter(v.empresa,"C",v.cliente)
	v.provincia = f_provincia_genter(v.empresa,"C",v.cliente)


Update  venliproformas 
Set venliproformas.tipo_cliente   = :v.tipo_cliente,
    venliproformas.cliente        = :v.cliente,
    venliproformas.agente1        = :v.agente1,   
    venliproformas.agente2        = :v.agente2,   
    venliproformas.comision11     = :v.comision11,   
    venliproformas.comision21     = :v.comision21,   
    venliproformas.comision12     = :v.comision12,   
    venliproformas.comision22     = :v.comision22,   
    venliproformas.divisa         = :v.divisa,   
    venliproformas.serie          = :v.serie,   
    venliproformas.zona           = :v.zona,   
    venliproformas.agente3        = :v.agente3,   
    venliproformas.comision32     = :v.comision32,   
    venliproformas.comision31     = :v.comision31,   
    venliproformas.transportista   = :v.transportista,
	 venliproformas.pais            = :v.pais,
	 venliproformas.provincia       = :v.provincia
	 
Where   venliproformas.empresa  = :v.empresa
And     venliproformas.anyo     = :v.anyo
And     venliproformas.proforma = :v.proforma;
COMMIT;

									 
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_int_venproformas
integer x = 2450
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Salir"
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_int_venproformas
integer x = 2144
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
string text = "&Borrar"
end type

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_int_venproformas
integer x = 1838
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;IF  cb_insertar.enabled = TRUE Then
String var_codpago,var_bancocobro,campo,var_cliente,var_tipocliente
String var_tarifa,var_divisa,var_tipiva
datawindow dato
Integer numero
apartados.pagina_1.dw_pagina1.accepttext()

var_codpago    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'codpago')	
var_bancocobro = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'banco_de_cobro')	
var_tipocliente   = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'tipo_cliente')	
var_cliente    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'cliente')	
var_tarifa     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'tarifa')	
var_divisa     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'divisa')	
var_codpago    = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'codpago')	
var_tipiva     = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),'tipoiva')	

if isNull(var_codpago)    then var_codpago    = ""
if isNull(var_tipocliente)     then var_tipocliente     = ""
if isNull(var_cliente)     then var_cliente     = ""
if isNull(var_tarifa)     then var_tarifa     = ""
if isNull(var_divisa)     then var_divisa     = ""
if isNull(var_bancocobro) then var_bancocobro = ""
if isNull(var_tipiva)     then var_tipiva     = ""

if Trim(var_codpago)="" then
     campo="codpago"
	  dato = apartados.pagina_1.dw_pagina1
     numero = 1
End If

if Trim(var_divisa)="" then
     campo="divisa"
	  dato = apartados.pagina_1.dw_pagina1
     numero = 1
End If

if Trim(var_tarifa)="" then
     campo="tarifa"
	  dato = apartados.pagina_1.dw_pagina1
     numero = 1
End If

if Trim(var_tipiva)="" then
     campo="tipoiva"
	  dato = apartados.pagina_1.dw_pagina1
     numero = 1
End If

if Trim(var_cliente)="" then
     campo="cliente"
	  dato = apartados.pagina_1.dw_pagina1
     numero = 1
End If

if Trim(var_codpago)<>""  then
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
   f_control()
  ELSE
	call super::clicked
END IF 
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_int_venproformas
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_int_venproformas
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

type sle_valor from wc_mantenimientos_tab`sle_valor within w_int_venproformas
integer x = 571
integer y = 172
integer width = 302
integer taborder = 30
end type

event sle_valor::getfocus;call super::getfocus;dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag2.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))
dw_pag3.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text))

end event

type st_1 from wc_mantenimientos_tab`st_1 within w_int_venproformas
integer x = 37
integer y = 176
integer width = 302
string text = "Proforma:"
end type

type apartados from wc_mantenimientos_tab`apartados within w_int_venproformas
integer x = 46
integer y = 272
integer width = 2811
integer height = 1268
boolean multiline = true
end type

event apartados::selectionchanged;call super::selectionchanged;IF wc_index = 4 Then
	f_activar_campo(apartados.pagina_4.uo_cliente.em_campo)
END IF
end event

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 2775
integer height = 1140
string text = "Datos Facturación."
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 55
integer width = 2715
integer height = 1148
string dataobject = "dw_int_venproformas1"
end type

event dw_pagina1::clicked;call super::clicked;IF GetRow() = 0  Then return
str_parametros lstr_param
CHOOSE CASE f_objeto_datawindow(This)

CASE "pb_cliente"
IF f_valor_columna(This,1,"tipo_cliente") = "S" Then
 
 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
 OpenWithParm(wi_mant_clientes2,lstr_param)  
ELSE

 lstr_param.i_nargumentos    = 2
 lstr_param.s_argumentos[2]=f_valor_columna(This,This.GetRow(),"cliente")
 OpenWithParm(wi_mant_vencliproforma,lstr_param)  
END IF

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

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;String  var_texto1,var_texto2,var_condicion,var_moneda,var_tarifa,var_idioma
string  var_codpago, clase_cli
dec{2}  var_cambio
	
var_texto1  = f_valor_columna(This,This.GetRow(),'textopie1')
var_texto2  = f_valor_columna(This,This.GetRow(),'textopie2')
var_tarifa  = f_valor_columna(This,This.GetRow(),'tarifa')
var_idioma  = f_valor_columna(This,This.GetRow(),'idioma')
var_codpago = f_valor_columna(This,This.GetRow(),'codpago')
var_cambio  = dw_pag1.GetItemNumber(dw_pag1.GetRow(),'cambio')

clase_cli = f_valor_columna(This,This.GetRow(),'tipo_cliente')

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

IF Trim(var_tarifa) <> "" and Not IsNull(var_tarifa) Then
	var_moneda = f_moneda_ventarifas(codigo_empresa,var_tarifa)
	if trim(var_moneda)="" then f_asignar_columna(This,This.GetRow(),"divisa",var_moneda)
END IF

control_banco = f_cartipodoc_controlbanco(codigo_empresa,f_tipodoc_carforpag(codigo_empresa,var_codpago))
This.SetTabOrder("banco_de_cobro",130)
if control_banco = "N" then
	This.SetTabOrder("banco_de_cobro",0)
	f_asignar_columna(dw_pag1,1,"banco_de_cobro","")
END IF

 // Controla el cambio que se tiene que aplicar
 string var_moneda_tarifa
 
 var_moneda_tarifa   = f_moneda_ventarifas(codigo_empresa,var_tarifa)

 IF IsNull(var_moneda_proforma) or var_moneda_proforma <> GetItemString(This.GetRow(),"divisa")Then
		 This.SetItem(1,"cambio",f_cambio_moneda(var_moneda_proforma))
 END IF
 var_moneda_proforma = GetItemString(This.GetRow(),"divisa")
 if isnull(var_moneda_tarifa)   then var_moneda_tarifa   = ""
 if isnull(var_moneda_proforma) then var_moneda_proforma = ""
 IF This.GetItemNumber(1,"cambio") = 0 or IsNull(This.GetItemNumber(1,"cambio")) Then
	 This.SetItem(1,"cambio",f_cambio_moneda(var_moneda_proforma))
 END IF
 if Trim(var_moneda_tarifa)<>Trim(var_moneda_proforma) then
	 if f_cambio_moneda(var_moneda_tarifa)=1 then
		 This.SetTabOrder("cambio",110) 		
	 else 
	  	 This.SetItem(1,"cambio",f_cambio_moneda(var_moneda_proforma))
	End if
End if

end event

event dw_pagina1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 valor_empresa = TRUE
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo

  CASE "cliente"
	IF f_valor_columna(This,GetRow(),"tipo_cliente") = "S" Then
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
	ELSE
 		bus_datawindow = "dw_ayuda_vencliproforma"
		bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
 	END IF
   CASE "envio"
 		bus_datawindow = "dw_ayuda_venenvio"
		bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
   CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION SERIES CLIENTES"
      bus_filtro = ""   
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

 String codcli,clase_cli
 IF GetRow() =0 Then Return
 codcli    = GetItemString(This.GetRow(),"cliente")
 clase_cli = GetItemString(This.GetRow(),"tipo_cliente")

 IF clase_cli = antetipocli and Not IsNull(antetipocli) and & 
	codcli = antecliente and Not IsNull(antecliente) Then 
	Return
 END IF

 if Integer(codcli)=0 or isnull(codcli) then Return
     
 AcceptText()
 String var_Nombre,var_direcc,var_codpostal,var_provincia,var_pais,var_localidad
 
 IF clase_cli <> antetipocli or IsNull(antetipocli) Then 
	apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"codpago","")
	apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"tipoiva","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente1","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente2","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente3","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision1","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision2","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision31","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision11","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision22","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision32","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtopp","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp1","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp2","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp3","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp4","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto1","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto2","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto3","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto4","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto1","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto2","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto3","")
	apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto4","")   
End if
apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipo_cliente",clase_cli)			  
 CHOOSE CASE clase_cli
	CASE "S"
		 dw_pag2.SetTabOrder("envio",240)	
		 dw_pag2.SetTabOrder("correspondencia",250)	
		 dw_pag2.SetTabOrder("domiciliacion",260)	

		str_venped ped
		Integer  var_ejercicio
		String var_empresa,var_codigo,var_tipoter
		var_ejercicio = f_ejercicio_activo(codigo_empresa)
		profor.cliente  = GetItemString(This.GetRow(),"cliente")
  
		IF profor.cliente <> antecliente or IsNull(antecliente) Then
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
					 venclientes.correspondencia,venclientes.domiciliacion,venclientes.transportista,venclientes.calculo_dtoesp
			INTO   :profor.zona, :profor.serie, :profor.agente1, :profor.agente2,:profor.agente3,:profor.comision1,   
					 :profor.comision2,:profor.comision31,:profor.codpago,:profor.dtopp,:profor.dtoesp1,
					 :profor.dtoesp2,:profor.tipoiva, :profor.forma_envio,   
					 :profor.tipo_portes,:profor.cod_entrega,:profor.periodo_fac,
					 :profor.explicaciondto1,:profor.explicaciondto2,   
					 :profor.tarifa,:profor.comision11,:profor.comision22,:profor.comision31,:profor.dtoesp3,   
					 :profor.dtoesp4,:profor.explicaciondto3,:profor.explicaciondto4,
					 :profor.tipodto1,:profor.tipodto2,:profor.tipodto3,:profor.tipodto4,   
					 :profor.empresa,:profor.cliente ,:profor.cod_entrega,
					 :profor.calculo_dto,:profor.banco_de_cobro,
					 :profor.envio,:profor.correspondencia,
					 :profor.domiciliacion,:profor.transportista,:profor.calculo_dtoesp
			FROM   venclientes  
			WHERE  ( venclientes.empresa = :codigo_empresa ) AND  
					 ( venclientes.codigo = :profor.cliente )   
			ORDER BY venclientes.empresa ASC,venclientes.codigo ASC  ;
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",profor.cliente)

			Select  genter.empresa,genter.tipoter,genter.codigo,genter.idioma,genter.moneda
			Into    :var_empresa,:var_tipoter,:var_codigo,:profor.idioma,:profor.divisa
			From genter
			Where   genter.empresa = :codigo_empresa 
					 And     genter.tipoter = 'C'
					 And     genter.codigo  = :profor.cliente;

  
			SELECT contaiva.iva  INTO :profor.iva  
			FROM contaiva  
			WHERE ( contaiva.ejercicio = :var_ejercicio ) AND  
					( contaiva.empresa = :codigo_empresa ) AND  
					( contaiva.tipoiva = :profor.tipoiva )   ;

			apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"codpago",profor.codpago)
			apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"banco_de_cobro",profor.banco_de_cobro)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"cliente",profor.cliente)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente1",profor.agente1)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente2",profor.agente2)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente3",profor.agente3)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision1",profor.comision1)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision2",profor.comision2)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision31",profor.comision31)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision11",profor.comision11)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision22",profor.comision22)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision32",profor.comision32)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtopp",profor.dtopp)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp1",profor.dtoesp1)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp2",profor.dtoesp2)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp3",profor.dtoesp3)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp4",profor.dtoesp4)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto1",profor.tipodto1)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto2",profor.tipodto2)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto3",profor.tipodto3)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto4",profor.tipodto4)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto1",profor.explicaciondto1)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto2",profor.explicaciondto2)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto3",profor.explicaciondto3)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto4",profor.explicaciondto4)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dto",profor.calculo_dto)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"calculo_dtoesp",profor.calculo_dtoesp)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"envio",profor.envio)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"correspondencia",profor.correspondencia)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"domiciliacion",profor.domiciliacion)
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"transportista",profor.transportista)
					
			SetItem(GetRow(),"tipoiva",profor.tipoiva)
			SetItem(GetRow(),"iva",profor.iva)	  
			SetItem(GetRow(),"serie",profor.serie)
			SetItem(GetRow(),"zona",profor.zona)
			SetItem(GetRow(),"forma_envio",profor.forma_envio)
			SetItem(GetRow(),"cod_entrega",profor.cod_entrega)
	  End if

	  CASE "N"
		profor.cliente  = GetItemString(This.GetRow(),"cliente")
		 dw_pag2.SetTabOrder("envio",0)	
		 dw_pag2.SetTabOrder("correspondencia",0)	
		 dw_pag2.SetTabOrder("domiciliacion",0)
		 f_asignar_columna(dw_pag2,1,"envio","")
		 f_asignar_columna(dw_pag2,1,"domiciliacion","")
		 f_asignar_columna(dw_pag2,1,"correspondencia","")

		 IF profor.cliente <> antecliente or IsNull(antecliente) Then
			
			SELECT  vencliproforma.razon,vencliproforma.pais,   
					  vencliproforma.provincia,vencliproforma.cod_postal,   
					  vencliproforma.localidad,vencliproforma.domicilio,   
					  vencliproforma.moneda,vencliproforma.idioma  
			INTO    :var_nombre,:var_pais,   
					  :var_provincia,:var_codpostal,   
					  :var_localidad,:var_direcc,   
					  :profor.divisa,:profor.idioma  
			FROM    vencliproforma  

			WHERE  ( vencliproforma.empresa = :codigo_empresa ) AND  
					 ( vencliproforma.codigo = :profor.cliente ); 		
					 IF f_tipo_pais(var_pais) = "N" Then
						profor.serie = "1"
					 ELSE
						profor.serie = "2"
					 END IF
							SetItem(GetRow(),"serie",profor.serie)
			apartados.pagina_1.dw_pagina1.SetItem(GetRow(),"codpago","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente1","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente2","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"agente3","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision1","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision2","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision31","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision11","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision22","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"comision32","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtopp","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp1","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp2","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp3","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"dtoesp4","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto1","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto2","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto3","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"tipodto4","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto1","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto2","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto3","")
			apartados.pagina_2.dw_pagina2.SetItem(GetRow(),"explicaciondto4","")   
	  End if
		
	END CHOOSE	
		 
	SetItem(GetRow(),"idioma",profor.idioma)
	SetItem(GetRow(),"divisa",profor.divisa)
	SetItem(GetRow(),"tarifa",profor.tarifa)
	antecliente = GetItemString(GetRow(),"cliente")
	antetipocli = GetItemString(GetRow(),"tipo_cliente")    





END IF


end event

event dw_pagina1::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
   CASE "cod_entrega"
 		bus_datawindow = "dw_ayuda_vencondentrega"
		bus_titulo     = "VENTANA SELECCION DE CONDICIONES DE ENTREGA"
   CASE "serie"
 		bus_datawindow = "dw_ayuda_venseries"
		bus_titulo = "VENTANA SELECCION SERIES CLIENTES"
      bus_filtro = ""   
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
	IF GetItemString(GetRow(),"tipo_cliente") = "S" Then
		bus_titulo     = "VENTANA SELECCION CLIENTES"
 		bus_datawindow = "dw_ayuda_clientes"
		bus_filtro     = ""
	ELSE
		bus_titulo     = "VENTANA SELECCION CLIENTES"
 		bus_datawindow = "dw_ayuda_vencliproforma"
		bus_filtro     = ""
	END IF
		

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

event dw_pagina1::getfocus;call super::getfocus;IF apartados.pagina_1.dw_pagina1.GetRow()= 0 Then Return

 antecliente = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),"cliente")
 antetipocli = apartados.pagina_1.dw_pagina1.GetItemString(apartados.pagina_1.dw_pagina1.GetRow(),"tipo_cliente")
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 2775
integer height = 1140
string text = "Datos Comerciales"
end type

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 4
integer width = 2770
integer height = 1160
string dataobject = "dw_int_venproformas2"
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
IF f_valor_columna(dw_pag1,1,"tipo_cliente") = "S" Then
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
 OpenWithParm(wi_mant_venenvio,lstr_param)
END IF

CASE "pb_correspondencia"
	IF f_valor_columna(dw_pag1,1,"tipo_cliente") = "S" Then
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
END IF
CASE "pb_transportista"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
 OpenWithParm(wi_mant_ventransportistas,lstr_param)
 
CASE "pb_domiciliacion"
	IF f_valor_columna(dw_pag1,1,"tipo_cliente") = "S" Then
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cliente")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
 OpenWithParm(wi_mant_vendomiciliacion,lstr_param)
END IF
 
 

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
		IF f_valor_columna(dw_pag2,1,"tipo_cliente") = "S" Then
	 		bus_datawindow = "dw_ayuda_venenvio"
			bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		END IF
   CASE "correspondencia"
		IF f_valor_columna(dw_pag2,1,"tipo_cliente") = "S" Then
			bus_datawindow = "dw_ayuda_vencorrespondencia"
			bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		END IF
   CASE "domiciliacion"
		IF f_valor_columna(dw_pag2,1,"tipo_cliente") = "S" Then
			bus_datawindow = "dw_ayuda_vendomiciliacion"
			bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		END IF
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
		IF f_valor_columna(dw_pag1,1,"tipo_cliente") = "S" Then
			bus_datawindow = "dw_ayuda_vendomiciliacion"
			bus_titulo = "VENTANA SELECCION DIRECCIONES DOMICILIACIONES"
	      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		END IF
  CASE "transportista"
		   bus_datawindow = "dw_ayuda_ventransportistas"
			bus_titulo     = "VENTANA SELECCION DIRECCIONES TRANSPORTISTAS"
	      bus_filtro     = ""
  CASE "envio"
		IF f_valor_columna(dw_pag1,1,"tipo_cliente") = "S" Then
	 		bus_datawindow = "dw_ayuda_venenvio"
			bus_titulo = "VENTANA SELECCION DE DIRECCIONES DE ENVIO"
      	bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		END IF

   CASE "correspondencia"
		IF f_valor_columna(dw_pag1,1,"tipo_cliente") = "S" Then
	 		bus_datawindow = "dw_ayuda_vencorrespondencia"
			bus_titulo = "VENTANA SELECCION DIREECIONES CORRESPONDENCIA"
	      bus_filtro = " cliente = '" + GetItemString(GetRow(),"cliente") + "'"
		END IF
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
integer width = 2775
integer height = 1140
string text = "Textos"
end type

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 0
integer width = 2720
integer height = 1164
string dataobject = "dw_int_venproformas3"
end type

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer width = 2775
integer height = 1140
string text = "Consultar"
uo_cliente uo_cliente
st_2 st_2
tipo_cliente tipo_cliente
end type

on pagina_4.create
this.uo_cliente=create uo_cliente
this.st_2=create st_2
this.tipo_cliente=create tipo_cliente
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_cliente
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.tipo_cliente
end on

on pagina_4.destroy
call super::destroy
destroy(this.uo_cliente)
destroy(this.st_2)
destroy(this.tipo_cliente)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
integer x = 14
integer y = 136
integer width = 2592
integer height = 984
string dataobject = "dw_int_venproformas10"
boolean vscrollbar = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event dw_pagina4::doubleclicked;call super::doubleclicked;IF row=0 then Return
em_anyo.text= String(GetItemNumber(row,"anyo"))
sle_valor.text= String(GetItemNumber(row,"proforma"))
apartados.getParent().TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
apartados.SelectTab(1)
end event

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 2775
integer height = 1140
string text = "Historico~r~n"
dw_historico dw_historico
end type

on pagina_5.create
this.dw_historico=create dw_historico
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_historico
end on

on pagina_5.destroy
call super::destroy
destroy(this.dw_historico)
end on

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
integer width = 2775
integer height = 1140
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
integer width = 2775
integer height = 1140
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
integer width = 2775
integer height = 1140
string text = ""
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
end type

type uo_cliente from u_em_campo_2 within pagina_4
integer x = 526
integer y = 24
integer width = 1682
integer height = 88
integer taborder = 3
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event modificado;call super::modificado;String tipo
iF tipo_cliente.text = "Si" Then
	tipo = "S"
	uo_cliente.em_campo.text=f_nombre_cliente(codigo_empresa,"C",uo_cliente.em_codigo.text)
Else
	uo_cliente.em_campo.text=f_nombre_vencliproforma(codigo_empresa,uo_cliente.em_codigo.text)
	tipo = "N"
End If
If Trim(uo_cliente.em_campo.text)="" then
	uo_cliente.em_campo.text=""
	uo_cliente.em_codigo.text=""
	Return
end if 
dw_pag4.Retrieve(codigo_empresa,uo_cliente.em_codigo.text,tipo)
end event

on uo_cliente.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;iF tipo_cliente.text = "Si" Then
   ue_titulo     = "AYUDA SELECCION DE CLIENTES"
	ue_datawindow = "dw_ayuda_clientes"
	ue_filtro     = ""
ELSE
   ue_titulo     = "AYUDA SELECCION DE CLIENTES"
	ue_datawindow = "dw_ayuda_vencliproforma"
	ue_filtro     = ""
END IF
  


 
        
end event

type st_2 from statictext within pagina_4
integer x = 23
integer y = 24
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

type tipo_cliente from dropdownlistbox within pagina_4
integer x = 256
integer y = 20
integer width = 270
integer height = 240
integer taborder = 2
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Si"
boolean vscrollbar = true
string item[] = {"Si","No"}
borderstyle borderstyle = stylelowered!
end type

type dw_historico from u_datawindow_consultas within pagina_5
integer x = 14
integer y = 40
integer width = 2629
integer height = 1072
integer taborder = 2
string dataobject = "dw_int_venproformas11"
boolean vscrollbar = true
end type

event doubleclicked;call super::doubleclicked;IF row=0 then Return
em_anyo.text= String(GetItemNumber(row,"anyo"))
sle_valor.text= String(GetItemNumber(row,"proforma"))
apartados.getParent().TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
apartados.SelectTab(1)
end event

type em_anyo from u_em_campo within w_int_venproformas
integer x = 343
integer y = 172
integer width = 233
integer taborder = 0
end type

type pb_calculadora from u_calculadora within w_int_venproformas
event clicked pbm_bnclicked
integer x = 891
integer y = 164
integer taborder = 0
end type

event clicked;call super::clicked;IF cb_insertar.enabled=TRUE THEN Return
IF Trim(em_anyo.text)=""  THEN Return


dec{0} n_proforma
Integer registros,numero,anyo
String  var_empresa

anyo = Integer(em_anyo.text)

  SELECT venparamprofor.empresa,venparamprofor.proforma
    INTO :var_empresa,:registros  
    FROM venparamprofor  
   WHERE venparamprofor.empresa = :codigo_empresa  
   And   venparamprofor.anyo    = :anyo;
   If Sqlca.Sqlcode=100 Then
       INSERT INTO venparamprofor  
              (empresa,anyo,proforma)  
       VALUES (:codigo_empresa,:anyo,:registros );
       COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_proforma= registros

   Select count(*) Into :numero From venproformas
   Where   venproformas.empresa   = :codigo_empresa
   And     venproformas.anyo       = :anyo
   And     venproformas.proforma   = :n_proforma;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((venproformas.proforma)+1)
       Into   :sle_valor.text
       From   venproformas
       Where  venproformas.empresa = :codigo_empresa
       And    venproformas.anyo    = :anyo;
       registros= Integer(sle_valor.text)
   End If
   UPDATE venparamprofor
   SET    proforma = :registros  
   WHERE  venparamprofor.empresa = :codigo_empresa
   And    venparamprofor.anyo    = :anyo;
   COMMIT;

   sle_valor.text=String(registros)
   apartados.TriggerEvent("pulsar_datawindow")
end event

type cb_copiar from u_boton within w_int_venproformas
event clicked pbm_bnclicked
integer x = 1216
integer y = 160
integer width = 315
integer height = 76
integer taborder = 0
string text = "F5 Volcado"
end type

event clicked;call super::clicked;IF This.enabled = FALSE THEN RETURN
IF Trim(em_anyo.text) = "" or IsNull(em_anyo.text) Then 
	f_activar_campo(sle_valor)
	Return
END IF

IF Trim(sle_valor.text) = "" or IsNull(sle_valor.text) Then 
	f_activar_campo(sle_valor)
	Return
END IF

IF f_valor_columna(dw_pag1,1,"activa")= "N" Then
	f_mensaje("Esta proforma no se puede duplicar"," Proforma inactiva")
	f_activar_campo(sle_valor)
	return
END IF
IF messageBox("Proceso de volcado!!!","Desea realizar el volcado a otra proforma",Question!,YesNo!)= 2 Then Return
Integer  bien
bien = 0
str_venproformas  pro
str_venliproformas  lpro
Dec{0} n_proforma,registros,reg,reg1
Dec{0}  var_proforma,var_anyo,var_proforma_origen
Integer numero,anyo
String  var_empresa

var_anyo = Integer(em_anyo.text)

  SELECT venparamprofor.empresa,venparamprofor.proforma
    INTO :var_empresa,:registros  
    FROM venparamprofor  
   WHERE venparamprofor.empresa = :codigo_empresa  
   And   venparamprofor.anyo    = :var_anyo;
   If Sqlca.Sqlcode=100 Then
       INSERT INTO venparamprofor  
              (empresa,anyo,proforma)  
       VALUES (:codigo_empresa,:anyo,:registros );
       COMMIT;
   END IF
   IF IsNull(registros) Then registros=0
   registros=registros + 1
   n_proforma= registros

   Select count(*) Into :numero From venproformas
   Where   venproformas.empresa   = :codigo_empresa
   And     venproformas.anyo       = :var_anyo
   And     venproformas.proforma   = :n_proforma;
   If IsNull(numero) Then numero=0
   If numero<>0 Then
       Select max((venproformas.proforma)+1)
       Into   :sle_valor.text
       From   venproformas
       Where  venproformas.empresa = :codigo_empresa
       And    venproformas.anyo    = :var_anyo;
       registros= Integer(sle_valor.text)
   End If
   UPDATE venparamprofor
   SET    proforma = :registros  
   WHERE  venparamprofor.empresa = :codigo_empresa
   And    venparamprofor.anyo    = :var_anyo;
   COMMIT;
   var_proforma=registros
   var_proforma_origen=Dec(sle_valor.text)
	pro.anyo_origen =     f_anyo_origen_venproformas(codigo_empresa,var_anyo,var_proforma_origen)
	pro.proforma_origen = f_proforma_origen_venproformas(codigo_empresa,var_anyo,var_proforma_origen)
	Update  venproformas
	Set activa = "N"
	WHERE ( venproformas.empresa = :codigo_empresa ) AND  
         ( venproformas.anyo = :var_anyo ) AND  
         ( venproformas.proforma = :var_proforma_origen )   ;
	
	pro.activa = "S"

	  SELECT venproformas.fproforma,   
         venproformas.falta,   
         venproformas.cliente,   
         venproformas.observaciones,   
         venproformas.codpago,   
         venproformas.agente1,   
         venproformas.agente2,   
         venproformas.comision1,   
         venproformas.comision2,   
         venproformas.comision11,   
         venproformas.comision22,   
         venproformas.dtopp,   
         venproformas.dtoesp1,   
         venproformas.dtoesp2,   
         venproformas.dtoesp3,   
         venproformas.dtoesp4,   
         venproformas.tipodto1,   
         venproformas.tipodto2,   
         venproformas.tipodto3,   
         venproformas.tipodto4,   
         venproformas.explicaciondto1,   
         venproformas.explicaciondto2,   
         venproformas.explicaciondto3,   
         venproformas.explicaciondto4,   
         venproformas.tipoiva,   
         venproformas.iva,   
         venproformas.numpedcli,   
         venproformas.idioma,   
         venproformas.divisa,   
         venproformas.cambio,   
         venproformas.tarifa,   
         venproformas.ftarifa,   
         venproformas.fbloqueo,   
         venproformas.serie,   
         venproformas.zona,   
         venproformas.forma_envio,   
         venproformas.cod_entrega,   
         venproformas.usuario,   
         venproformas.tipo_portes,   
         venproformas.periodo_fac,   
         venproformas.peso_neto,   
         venproformas.usuario_proforma,   
         venproformas.agente3,   
         venproformas.comision31,   
         venproformas.comision32,   
         venproformas.textcomercial1,   
         venproformas.textcomercial2,   
         venproformas.textaduanaesp1,   
         venproformas.textaduanaesp2,   
         venproformas.textaduanaext1,   
         venproformas.textaduanaext2,   
         venproformas.tipo_cliente,   
         venproformas.textopie1,   
         venproformas.textopie2,   
         venproformas.condicion,   
         venproformas.peso,   
         venproformas.banco_de_cobro,   
         venproformas.porcentaje_aduana  ,
	      venproformas.calculo_dto,
	      venproformas.envio,
         venproformas.correspondencia,
			venproformas.domiciliacion,  
			venproformas.transportista
    INTO :pro.fproforma,   
         :pro.falta,   
         :pro.cliente,   
         :pro.observaciones,   
         :pro.codpago,   
         :pro.agente1,   
         :pro.agente2,   
         :pro.comision1,   
         :pro.comision2,   
         :pro.comision11,   
         :pro.comision22,   
         :pro.dtopp,   
         :pro.dtoesp1,   
         :pro.dtoesp2,   
         :pro.dtoesp3,   
         :pro.dtoesp4,   
         :pro.tipodto1,   
         :pro.tipodto2,   
         :pro.tipodto3,   
         :pro.tipodto4,   
         :pro.explicaciondto1,   
         :pro.explicaciondto2,   
         :pro.explicaciondto3,   
         :pro.explicaciondto4,   
         :pro.tipoiva,   
         :pro.iva,   
         :pro.numpedcli,   
         :pro.idioma,   
         :pro.divisa,   
         :pro.cambio,   
         :pro.tarifa,   
         :pro.ftarifa,   
         :pro.fbloqueo,   
         :pro.serie,   
         :pro.zona,   
         :pro.forma_envio,   
         :pro.cod_entrega,   
         :pro.usuario,   
         :pro.tipo_portes,   
         :pro.periodo_fac,   
         :pro.peso_neto,   
         :pro.usuario_proforma,   
         :pro.agente3,   
         :pro.comision31,   
         :pro.comision32,   
         :pro.textcomercial1,   
         :pro.textcomercial2,   
         :pro.textaduanaesp1,   
         :pro.textaduanaesp2,   
         :pro.textaduanaext1,   
         :pro.textaduanaext2,   
         :pro.tipo_cliente,   
         :pro.textopie1,   
         :pro.textopie2,   
         :pro.condicion,   
         :pro.peso,   
         :pro.banco_de_cobro,   
         :pro.porcentaje_aduana,
	      :pro.calculo_dto,
	      :pro.envio,
         :pro.correspondencia,
			:pro.domiciliacion,  
			:pro.transportista
			
    FROM venproformas  
   WHERE ( venproformas.empresa = :codigo_empresa ) AND  
         ( venproformas.anyo = :var_anyo ) AND  
         ( venproformas.proforma = :var_proforma_origen )   ;
			IF sqlca.Sqlcode = 100 Then
				f_mensaje ("Error en proceso","Avise al administrador del sistema ")
				return
			END IF

   pro.empresa = codigo_empresa	
	pro.anyo = var_anyo
	pro.proforma = var_proforma
  IF Not f_insertar_venproformas(pro) Then
				bien = 1
 				f_mensaje("Error en proceso",SQLCA.SQLErrText)
	  END IF


reg =	 dw_proceso.Retrieve(codigo_empresa,var_anyo,var_proforma_origen)
For reg1 = 1 To reg
	
lpro.empresa= codigo_empresa
lpro.anyo = var_anyo
lpro.proforma= var_proforma
lpro.linea = reg1
lpro.serie = f_valor_columna(dw_proceso,reg1,"serie")
lpro.fproforma = dw_proceso.GetItemDateTime(reg1,"fproforma")
lpro.cliente   = f_valor_columna(dw_proceso,reg1,"cliente")
lpro.tipo_unidad = f_valor_columna(dw_proceso,reg1,"tipo_unidad")
lpro.articulo  = f_valor_columna(dw_proceso,reg1,"articulo")
lpro.familia    = f_valor_columna(dw_proceso,reg1,"familia")
lpro.formato = f_valor_columna(dw_proceso,reg1,"formato")
lpro.modelo    = f_valor_columna(dw_proceso,reg1,"modelo")
lpro.calidad = f_valor_columna(dw_proceso,reg1,"calidad")
lpro.tono  = Dec(f_valor_columna(dw_proceso,reg1,"tono"))
lpro.calibre = Dec(f_valor_columna(dw_proceso,reg1,"calibre"))
lpro.precio    = Dec(f_valor_columna(dw_proceso,reg1,"precio"))
lpro.precio_estand = Dec(f_valor_columna(dw_proceso,reg1,"precio_estand"))
lpro.cantidad = Dec(f_valor_columna(dw_proceso,reg1,"cantidad"))
lpro.pallets    = Dec(f_valor_columna(dw_proceso,reg1,"pallets"))
lpro.total_cajas = Dec(f_valor_columna(dw_proceso,reg1,"total_cajas"))
lpro.cajas = Dec(f_valor_columna(dw_proceso,reg1,"cajas"))
lpro.dtocomer = Dec(f_valor_columna(dw_proceso,reg1,"dtocomer"))
lpro.dtoesp   = Dec(f_valor_columna(dw_proceso,reg1,"dtoesp"))
lpro.descripcion = f_valor_columna(dw_proceso,reg1,"descripcion")
lpro.tipoiva = f_valor_columna(dw_proceso,reg1,"tipoiva")
lpro.iva = Dec(f_valor_columna(dw_proceso,reg1,"iva"))
lpro.linfab = f_valor_columna(dw_proceso,reg1,"linfab")
lpro.provincia = f_valor_columna(dw_proceso,reg1,"provincia")
lpro.pais = f_valor_columna(dw_proceso,reg1,"pais")
lpro.zona = f_valor_columna(dw_proceso,reg1,"zona")
lpro.tipolinea = f_valor_columna(dw_proceso,reg1,"tipolinea")
lpro.texto1  = f_valor_columna(dw_proceso,reg1,"texto1")
lpro.texto2 = f_valor_columna(dw_proceso,reg1,"texto2")
lpro.texto3 = f_valor_columna(dw_proceso,reg1,"texto3")
lpro.texto4 = f_valor_columna(dw_proceso,reg1,"texto4")
lpro.referencia    = f_valor_columna(dw_proceso,reg1,"referencia")
lpro.montajeartcal    = f_valor_columna(dw_proceso,reg1,"montajeartcal")
lpro.situacion = f_valor_columna(dw_proceso,reg1,"situacion")
lpro.divisa  = f_valor_columna(dw_proceso,reg1,"divisa")
lpro.metros_lineales = Dec(f_valor_columna(dw_proceso,reg1,"metros_lineales"))
lpro.peso_neto = Dec(f_valor_columna(dw_proceso,reg1,"peso_neto"))
lpro.falta = DateTime(Today(),Now())
lpro.usuario       = f_valor_columna(dw_proceso,reg1,"usuario")
lpro.tipo_pallet   = f_valor_columna(dw_proceso,reg1,"tipo_pallet")
lpro.importe       = Dec(f_valor_columna(dw_proceso,reg1,"importe"))
lpro.descuento     = Dec(f_valor_columna(dw_proceso,reg1,"descuento"))
lpro.importedto    = Dec(f_valor_columna(dw_proceso,reg1,"importedto"))
lpro.clase         = f_valor_columna(dw_proceso,reg1,"clase")
lpro.sector        = f_valor_columna(dw_proceso,reg1,"sector")
lpro.agente1       = f_valor_columna(dw_proceso,reg1,"agente1")
lpro.agente2       = f_valor_columna(dw_proceso,reg1,"agente2")
lpro.agente3       = f_valor_columna(dw_proceso,reg1,"agente3")
lpro.comision11    = Dec(f_valor_columna(dw_proceso,reg1,"comision11"))
lpro.comision12    = Dec(f_valor_columna(dw_proceso,reg1,"comision12"))
lpro.comision21    = Dec(f_valor_columna(dw_proceso,reg1,"comision21"))
lpro.comision22    = Dec(f_valor_columna(dw_proceso,reg1,"comision22"))
lpro.comision31    = Dec(f_valor_columna(dw_proceso,reg1,"comision31"))
lpro.comision32    = Dec(f_valor_columna(dw_proceso,reg1,"comision32"))
lpro.deposito      = f_valor_columna(dw_proceso,reg1,"deposito")
lpro.control_incremento = f_valor_columna(dw_proceso,reg1,"control_incremento")
lpro.peso          = Dec(f_valor_columna(dw_proceso,reg1,"peso"))
lpro.tipo_cliente  = f_valor_columna(dw_proceso,reg1,"tipo_cliente")
lpro.precio_aduana = Dec(f_valor_columna(dw_proceso,reg1,"precio_aduana"))
IF Not f_insertar_venliproformas(lpro) Then
	bien = 1
	f_mensaje("Error en proceso",SQLCA.SQLErrText)
END IF



Next
	
	
IF bien = 0 Then	
COMMIT;	
Else
	ROLLBack;
	F_mensaje("Error en proceso"," Avise al administrador del sistema")
END IF
sle_valor.text= String(var_proforma)
Parent.TriggerEvent("ue_recuperar")
f_activar_campo(sle_valor)
end event

type cb_lineas from u_boton within w_int_venproformas
event clicked pbm_bnclicked
integer x = 1531
integer y = 160
integer width = 306
integer height = 76
integer taborder = 0
string text = "F6 lineas"
end type

event clicked;call super::clicked;IF This.enabled = FALSE THEN RETURN
Integer anyo
Dec proforma
String tipo,cliente

anyo    = Integer(em_anyo.text)
proforma  = Dec(sle_valor.text)

Select venproformas.proforma,
       venproformas.tipo_cliente,
		 venproformas.cliente
Into   :proforma,:tipo,:cliente
From   venproformas
where  venproformas.empresa = :codigo_empresa
and    venproformas.anyo    = :anyo
and    venproformas.proforma  = :proforma;
IF SQLCA.SQLCODE = 100 Then
   MessageBox("Codigo de la proforma no existe","Introduzca la proforma",Exclamation!, OK!,1)
   f_activar_campo(sle_valor)
   Return
END IF

IF tipo = "S" Then
	IF f_activo_genter(codigo_empresa,"C",cliente)= "N" Then
		IF MessageBox("Cliente Inactivo","¿Continuar?",Question!,YesNo!) = 2 Then
			f_activar_campo(sle_valor)
			Return
		END IF
	END IF
END IF



titulo        =  Parent.title

longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(em_anyo.text))
criterio[2]   =  Trim(em_anyo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]
tabla[1]         = "venproformas"
IF NOT f_bloquear(tabla[1],seleccion[1],titulo) THEN
 COMMIT;
 str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 f_activar_campo(sle_valor)
 OpenWithParm(w_int_venliproformas,lstr_param)
 Return
END IF
 f_activar_campo(sle_valor)
end event

type gb_1 from groupbox within w_int_venproformas
integer x = 1207
integer y = 124
integer width = 1563
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_proceso from datawindow within w_int_venproformas
boolean visible = false
integer width = 247
integer height = 72
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_proceso_venliproformas"
boolean livescroll = true
end type

type dw_detalle from datawindow within w_int_venproformas
boolean visible = false
integer x = 2249
integer width = 494
integer height = 132
integer taborder = 10
boolean bringtotop = true
string dataobject = "dw_proceso_venliproformas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type pb_imprimir from upb_imprimir within w_int_venproformas
integer x = 1010
integer y = 164
integer taborder = 0
end type

event clicked;call super::clicked; str_parametros lstr_param
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=em_anyo.text
 lstr_param.s_argumentos[3]=sle_valor.text
 OpenWithParm(w_lis_venproformas,lstr_param)
 dw_pag1.Retrieve(codigo_empresa,Dec(em_anyo.text),Dec(sle_valor.text)) 
 f_activar_campo(sle_valor)
end event

