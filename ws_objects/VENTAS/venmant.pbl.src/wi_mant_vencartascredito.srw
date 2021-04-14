$PBExportHeader$wi_mant_vencartascredito.srw
$PBExportComments$Introducion cartas de crédito.
forward
global type wi_mant_vencartascredito from wc_mantenimientos_tab
end type
type dw_lineas from u_datawindow_consultas within pagina_2
end type
type dw_dmto1 from u_datawindow_consultas within pagina_3
end type
type pb_1 from upb_imprimir within pagina_3
end type
type st_2 from statictext within pagina_3
end type
type st_3 from statictext within pagina_3
end type
type pb_2 from upb_imprimir within pagina_3
end type
type dw_dmto2 from u_datawindow_consultas within pagina_4
end type
type gb_1 from groupbox within wi_mant_vencartascredito
end type
type dw_proceso from datawindow within wi_mant_vencartascredito
end type
type dw_listado from datawindow within wi_mant_vencartascredito
end type
type dw_listado2 from datawindow within wi_mant_vencartascredito
end type
end forward

global type wi_mant_vencartascredito from wc_mantenimientos_tab
integer width = 2962
integer height = 1768
gb_1 gb_1
dw_proceso dw_proceso
dw_listado dw_listado
dw_listado2 dw_listado2
end type
global wi_mant_vencartascredito wi_mant_vencartascredito

type variables
String var_domi,var_envio,var_correspondencia
Integer var_anyo,var_contador
end variables

forward prototypes
public function boolean f_control_dmto1 ()
public subroutine f_cargar_dmto1 ()
public function boolean f_control_dmto2 ()
public subroutine f_cargar_dmto2 ()
public subroutine f_insertar_dmto2 ()
public subroutine f_borrar_dmto2 ()
public subroutine f_borrar_dmto1 ()
public subroutine f_insertar_dmto1 ()
public subroutine f_borrar_linea ()
public subroutine f_insertar_linea ()
public function boolean f_control_linea ()
public subroutine f_modificar_linea ()
end prototypes

public function boolean f_control_dmto1 ();Integer bien,contador,contado

 
bien = 0

contador = apartados.pagina_3.dw_dmto1.RowCount()
For contado = 1 To contador
	apartados.pagina_3.dw_dmto1.SetItem(contado,"tipo","1")
	apartados.pagina_3.dw_dmto1.SetItem(contado,"orden",contado)
   apartados.pagina_3.dw_dmto1.SetItem(contado,"contador",var_contador)
Next



IF bien = 0 Then
	 Return TRUE
ELSE
	Return FALSE
END IF
end function

public subroutine f_cargar_dmto1 ();Integer contador, contado
contador = dw_proceso.Retrieve(codigo_empresa,"1")
String  var_descripcion
Integer var_copias,var_originales
For contado = 1 To contador
	var_copias       = dw_proceso.GetItemNumber(contado,"copias")
	var_descripcion       = dw_proceso.GetItemString(contado,"descripcion")
	var_originales   = dw_proceso.GetItemNumber(contado,"originales")
	apartados.pagina_3.dw_dmto1.InsertRow(contado)
	apartados.pagina_3.dw_dmto1.SetItem(contado,"empresa",codigo_empresa)
	apartados.pagina_3.dw_dmto1.SetItem(contado,"periodo",var_anyo)
	apartados.pagina_3.dw_dmto1.SetItem(contado,"orden",contado)
	apartados.pagina_3.dw_dmto1.SetItem(contado,"contador",var_contador)
	apartados.pagina_3.dw_dmto1.SetItem(contado,"num_credito",sle_valor.text)
   apartados.pagina_3.dw_dmto1.SetItem(contado,"descripcion",var_descripcion)
   apartados.pagina_3.dw_dmto1.SetItem(contado,"copias",var_copias)
   apartados.pagina_3.dw_dmto1.SetItem(contado,"originales",var_originales)
   apartados.pagina_3.dw_dmto1.SetItem(contado,"tipo","1")

	
Next

end subroutine

public function boolean f_control_dmto2 ();Integer bien,contador,contado
bien = 0

contador = apartados.pagina_4.dw_dmto2.RowCount()
For contado = 1 To contador
	apartados.pagina_4.dw_dmto2.SetItem(contado,"tipo","2")
	apartados.pagina_4.dw_dmto2.SetItem(contado,"orden",contado)
	apartados.pagina_4.dw_dmto2.SetItem(contado,"contador",var_contador)
Next



IF bien = 0 Then
	 Return TRUE
ELSE
	Return FALSE
END IF
end function

public subroutine f_cargar_dmto2 ();Integer contador, contado
contador = dw_proceso.Retrieve(codigo_empresa,"2")
String  var_descripcion
Integer var_copias,var_originales
For contado = 1 To contador
	
	var_copias       = dw_proceso.GetItemNumber(contado,"copias")
	var_descripcion       = dw_proceso.GetItemString(contado,"descripcion")
	var_originales   = dw_proceso.GetItemNumber(contado,"originales")
	apartados.pagina_4.dw_dmto2.InsertRow(contado)
	apartados.pagina_4.dw_dmto2.SetItem(contado,"empresa",codigo_empresa)
	apartados.pagina_4.dw_dmto2.SetItem(contado,"periodo",var_anyo)
	apartados.pagina_4.dw_dmto2.SetItem(contado,"orden",contado)
		apartados.pagina_4.dw_dmto2.SetItem(contado,"contador",var_contador)
	apartados.pagina_4.dw_dmto2.SetItem(contado,"num_credito",sle_valor.text)
   apartados.pagina_4.dw_dmto2.SetItem(contado,"descripcion",var_descripcion)
   apartados.pagina_4.dw_dmto2.SetItem(contado,"copias",var_copias)
   apartados.pagina_4.dw_dmto2.SetItem(contado,"originales",var_originales)
   apartados.pagina_4.dw_dmto2.SetItem(contado,"tipo","2")

	
Next

end subroutine

public subroutine f_insertar_dmto2 ();Integer reg
reg = apartados.pagina_4.dw_dmto2.GetRow() + 1
IF NOT f_control_dmto2()  Then Return
	apartados.pagina_4.dw_dmto2.insertRow(reg)
	apartados.pagina_4.dw_dmto2.SetItem(reg,"empresa",codigo_empresa)
	apartados.pagina_4.dw_dmto2.SetItem(reg,"periodo",var_anyo)
	apartados.pagina_4.dw_dmto2.SetItem(reg,"num_credito",sle_valor.text)
	apartados.pagina_4.dw_dmto2.SetItem(reg,"tipo","2")
	apartados.pagina_4.dw_dmto2.Setfocus()
	apartados.pagina_4.dw_dmto2.SetRow(reg)
	apartados.pagina_4.dw_dmto2.SetColumn("descripcion")
	apartados.pagina_4.dw_dmto2.ScrollToRow(reg)
end subroutine

public subroutine f_borrar_dmto2 ();	IF apartados.pagina_4.dw_dmto2.GetRow() = 0 Then Return
	apartados.pagina_4.dw_dmto2.DeleteRow(apartados.pagina_4.dw_dmto2.GetRow())
end subroutine

public subroutine f_borrar_dmto1 ();	IF apartados.pagina_3.dw_dmto1.GetRow() = 0 Then Return
	apartados.pagina_3.dw_dmto1.DeleteRow(apartados.pagina_3.dw_dmto1.GetRow())
end subroutine

public subroutine f_insertar_dmto1 ();Integer reg
reg = apartados.pagina_3.dw_dmto1.GetRow() + 1
IF NOT f_control_dmto1()  Then Return
	apartados.pagina_3.dw_dmto1.insertRow(reg)
	apartados.pagina_3.dw_dmto1.SetItem(reg,"empresa",codigo_empresa)
	apartados.pagina_3.dw_dmto1.SetItem(reg,"periodo",var_anyo)
	apartados.pagina_3.dw_dmto1.SetItem(reg,"num_credito",sle_valor.text)
	apartados.pagina_3.dw_dmto1.SetItem(reg,"tipo","1")
	apartados.pagina_3.dw_dmto1.Setfocus()
	apartados.pagina_3.dw_dmto1.SetRow(reg)
	apartados.pagina_3.dw_dmto1.SetColumn("descripcion")
	apartados.pagina_3.dw_dmto1.ScrollToRow(reg)
end subroutine

public subroutine f_borrar_linea ();	IF apartados.pagina_2.dw_lineas.GetRow() = 0 Then Return
	apartados.pagina_2.dw_lineas.DeleteRow(apartados.pagina_2.dw_lineas.GetRow())
end subroutine

public subroutine f_insertar_linea ();Integer reg
String var_texto_destino,var_texto_origen,var_bienes,var_observaciones,var_puerto_destino,var_puerto_origen
apartados.pagina_2.dw_pagina2.AcceptText()

reg = apartados.pagina_2.dw_lineas.GetRow() + 1
IF NOT f_control_linea()  Then Return
   var_texto_destino = apartados.pagina_2.dw_pagina2.GetItemString(1,"texto_destino")
   var_texto_origen = apartados.pagina_2.dw_pagina2.GetItemString(1,"texto_origen")
	var_puerto_destino = apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_destino")
	var_puerto_origen = apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_origen")
	var_observaciones = apartados.pagina_2.dw_pagina2.GetItemString(1,"observ_embar")
	var_bienes        = apartados.pagina_2.dw_pagina2.GetItemString(1,"bienes")
	
	apartados.pagina_2.dw_lineas.InsertRow(reg)
	apartados.pagina_2.dw_lineas.SetItem(reg,"empresa",codigo_empresa)
	apartados.pagina_2.dw_lineas.SetItem(reg,"periodo",var_anyo)
	apartados.pagina_2.dw_lineas.SetItem(reg,"num_credito",sle_valor.text)
	apartados.pagina_2.dw_lineas.SetItem(reg,"moneda",apartados.pagina_1.dw_pagina1.GetItemString(1,"moneda"))
	apartados.pagina_2.dw_lineas.SetItem(reg,"texto_destino",var_texto_destino)
	apartados.pagina_2.dw_lineas.SetItem(reg,"texto_origen",var_texto_origen)
	apartados.pagina_2.dw_lineas.SetItem(reg,"observaciones",var_observaciones)
	apartados.pagina_2.dw_lineas.SetItem(reg,"bienes",var_bienes)
	apartados.pagina_2.dw_lineas.SetItem(reg,"puerto_destino",var_puerto_destino)
	apartados.pagina_2.dw_lineas.SetItem(reg,"pais_destino",f_pais_venlugares(codigo_empresa,var_puerto_destino))
	apartados.pagina_2.dw_lineas.SetItem(reg,"puerto_origen",var_puerto_origen)
	apartados.pagina_2.dw_lineas.Setfocus()
	apartados.pagina_2.dw_lineas.SetRow(reg)
	apartados.pagina_2.dw_lineas.SetColumn("texto_destino")
	apartados.pagina_2.dw_lineas.ScrollToRow(reg)
end subroutine

public function boolean f_control_linea ();Integer bien,contador,contado

 
bien = 0

contador = apartados.pagina_2.dw_lineas.RowCount()
For contado = 1 To contador
	apartados.pagina_2.dw_lineas.SetItem(contado,"linea",contado)
		apartados.pagina_2.dw_lineas.SetItem(contado,"contador",var_contador)
Next



IF bien = 0 Then
	 Return TRUE
ELSE
	Return FALSE
END IF
end function

public subroutine f_modificar_linea ();Integer reg
String var_texto_destino,var_texto_origen,var_bienes,var_observaciones,var_puerto_destino,var_puerto_origen
reg = apartados.pagina_2.dw_lineas.GetRow()
apartados.pagina_2.dw_pagina2.AcceptText()
IF NOT f_control_linea()  Then Return
   var_texto_destino = apartados.pagina_2.dw_pagina2.GetItemString(1,"texto_destino")
   var_texto_origen = apartados.pagina_2.dw_pagina2.GetItemString(1,"texto_origen")
	var_puerto_destino = apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_destino")
	var_puerto_origen = apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_origen")
	var_observaciones = apartados.pagina_2.dw_pagina2.GetItemString(1,"observ_embar")
	var_bienes        = apartados.pagina_2.dw_pagina2.GetItemString(1,"bienes")
	apartados.pagina_2.dw_lineas.SetItem(reg,"empresa",codigo_empresa)
	apartados.pagina_2.dw_lineas.SetItem(reg,"periodo",var_anyo)
	apartados.pagina_2.dw_lineas.SetItem(reg,"num_credito",sle_valor.text)
	apartados.pagina_2.dw_lineas.SetItem(reg,"moneda",apartados.pagina_1.dw_pagina1.GetItemString(1,"moneda"))
	apartados.pagina_2.dw_lineas.SetItem(reg,"texto_destino",var_texto_destino)
	apartados.pagina_2.dw_lineas.SetItem(reg,"texto_origen",var_texto_origen)
	apartados.pagina_2.dw_lineas.SetItem(reg,"observaciones",var_observaciones)
	apartados.pagina_2.dw_lineas.SetItem(reg,"bienes",var_bienes)
	apartados.pagina_2.dw_lineas.SetItem(reg,"puerto_destino",var_puerto_destino)
	apartados.pagina_2.dw_lineas.SetItem(reg,"pais_destino",f_pais_venlugares(codigo_empresa,var_puerto_destino))
	apartados.pagina_2.dw_lineas.SetItem(reg,"puerto_origen",var_puerto_origen)
	apartados.pagina_2.dw_lineas.Setfocus()
	apartados.pagina_2.dw_lineas.SetRow(reg)
	apartados.pagina_2.dw_lineas.SetColumn("texto_destino")
	   
	
end subroutine

event ue_valores;call super::ue_valores;pag1 = TRUE	
pag2 = TRUE
pag3 = TRUE
pag4 = TRUE
pag_act4 = FALSE

prin_pag1 = TRUE

end event

on wi_mant_vencartascredito.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_proceso=create dw_proceso
this.dw_listado=create dw_listado
this.dw_listado2=create dw_listado2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_proceso
this.Control[iCurrent+3]=this.dw_listado
this.Control[iCurrent+4]=this.dw_listado2
end on

on wi_mant_vencartascredito.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.dw_proceso)
destroy(this.dw_listado)
destroy(this.dw_listado2)
end on

event ue_recuperar;// Valores Para Funcion de bloqueo
titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(String(var_anyo)))
criterio[2]   =  Trim(String(var_anyo))+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]+criterio[3]

tabla[1]         = "vencartascredito"

apartados.pagina_1.dw_pagina1.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
apartados.pagina_2.dw_pagina2.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
apartados.pagina_3.dw_dmto1.Retrieve(codigo_empresa,var_anyo,sle_valor.text,"1")
apartados.pagina_4.dw_dmto2.Retrieve(codigo_empresa,var_anyo,sle_valor.text,"2")

apartados.pagina_2.dw_lineas.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
IF apartados.pagina_1.dw_pagina1.RowCount() <> 0 Then
  var_contador = apartados.pagina_1.dw_pagina1.GetItemNumber(1,"contador")
END IF

CALL Super::ue_recuperar

end event

event ue_inserta_fila;call super::ue_inserta_fila;apartados.pagina_1.dw_pagina1.SetItem(1,"empresa",codigo_empresa)
apartados.pagina_1.dw_pagina1.SetItem(1,"num_credito",sle_valor.text)
apartados.pagina_1.dw_pagina1.SetItem(1,"periodo",var_anyo)
apartados.pagina_1.dw_pagina1.SetItem(1,"f_apertura",DateTime(Today()))
IF apartados.pagina_1.dw_pagina1.RowCount() = 0 Then
    f_cargar_dmto1()	
    f_cargar_dmto2()	
END IF	




end event

event open;call super::open;titulo= " Mantenimiento de Cartas de creditos "
This.title = titulo
dw_proceso.SetTransObject(SQLCA)
tipo_mantenimiento = "C"
var_anyo = Year(Today())
f_mascara_columna(apartados.pagina_1.dw_pagina1,"divisas","##,###,###.00")
dw_proceso.SetTransObject(SQLCA)
apartados.pagina_3.dw_dmto1.SetTransObject(SQLCA)
apartados.pagina_3.dw_dmto1.SetRowFocusIndicator(Hand!)
apartados.pagina_4.dw_dmto2.SetTransObject(SQLCA)
apartados.pagina_4.dw_dmto2.SetRowFocusIndicator(Hand!)
apartados.pagina_2.dw_lineas.SetTransObject(SQLCA)



end event

event ue_actualiza_dw;call super::ue_actualiza_dw;apartados.pagina_3.dw_dmto1.UPDATE()
apartados.pagina_4.dw_dmto2.UPDATE()
apartados.pagina_2.dw_lineas.UPDATE()
COMMIT;
end event

event ue_pase_valores;call super::ue_pase_valores;apartados.pagina_1.dw_pagina1.SetItem(1,"puerto_origen",apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_origen"))
apartados.pagina_1.dw_pagina1.SetItem(1,"puerto_destino",apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_destino"))
apartados.pagina_1.dw_pagina1.SetItem(1,"texto_destino",apartados.pagina_2.dw_pagina2.GetItemString(1,"texto_destino"))
apartados.pagina_1.dw_pagina1.SetItem(1,"texto_origen",apartados.pagina_2.dw_pagina2.GetItemString(1,"texto_origen"))
apartados.pagina_1.dw_pagina1.SetItem(1,"observ_embar",apartados.pagina_2.dw_pagina2.GetItemString(1,"observ_embar"))
apartados.pagina_1.dw_pagina1.SetItem(1,"bienes",apartados.pagina_2.dw_pagina2.GetItemString(1,"bienes"))


apartados.pagina_1.dw_pagina1.SetItem(1,"texto1_giro",apartados.pagina_3.dw_pagina3.GetItemString(1,"texto1_giro"))
apartados.pagina_1.dw_pagina1.SetItem(1,"texto2_giro",apartados.pagina_3.dw_pagina3.GetItemString(1,"texto2_giro"))
apartados.pagina_1.dw_pagina1.SetItem(1,"texto3_giro",apartados.pagina_3.dw_pagina3.GetItemString(1,"texto3_giro"))
apartados.pagina_1.dw_pagina1.SetItem(1,"copias_efectos",apartados.pagina_3.dw_pagina3.GetItemNumber(1,"copias_efectos"))
apartados.pagina_1.dw_pagina1.SetItem(1,"banco_negociador",apartados.pagina_3.dw_pagina3.GetItemString(1,"banco_negociador"))


end event

event ue_f2;//
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within wi_mant_vencartascredito
integer x = 2240
integer width = 370
integer height = 76
integer taborder = 0
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within wi_mant_vencartascredito
integer x = 1870
integer width = 370
integer height = 76
integer taborder = 0
end type

event cb_borrar::clicked;  DELETE FROM vendetallcredit  
   WHERE ( vendetallcredit.empresa = :codigo_empresa ) AND  
         ( vendetallcredit.periodo = :var_anyo ) AND  
         ( vendetallcredit.contador = :var_contador );

Call Super ::Clicked
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within wi_mant_vencartascredito
integer x = 1499
integer width = 370
integer height = 76
integer taborder = 0
end type

event cb_insertar::clicked;IF insercion = "S" Then
	Select max(contador) Into :var_contador From vencartascredito
	Where  vencartascredito.empresa   =   :codigo_empresa
	And    vencartascredito.periodo      =   :var_anyo;
	IF IsNull(var_contador) Then var_contador = 0
	var_contador = var_contador +1
	apartados.pagina_1.dw_pagina1.SetItem(1,"contador",var_contador)
END IF
IF Not f_control_dmto1() Then Return
IF Not f_control_dmto2() Then Return
IF Not f_control_linea() Then Return
CALL Super::clicked
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within wi_mant_vencartascredito
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within wi_mant_vencartascredito
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within wi_mant_vencartascredito
integer x = 768
integer width = 562
integer taborder = 40
end type

event sle_valor::getfocus;call super::getfocus; ue_datawindow = "dw_ayuda_vencartascredito"
 ue_titulo ="AYUDA BUSQUEDA CARTAS CREDITO"
 ue_filtro =""
IF istr_parametros.i_nargumentos>1 THEN
	
	  sle_valor.text=istr_parametros.s_argumentos[2]
 	  istr_parametros.i_nargumentos=0
       	  
	  IF TRIM(sle_valor.text)<>"" AND Not IsNull(sle_valor.text) THEN
			Parent.TriggerEvent("ue_recuperar")
     END IF  
  
	  		
END IF


end event

type st_1 from wc_mantenimientos_tab`st_1 within wi_mant_vencartascredito
integer x = 9
integer width = 745
string text = "Nº Credito documentario:"
end type

type apartados from wc_mantenimientos_tab`apartados within wi_mant_vencartascredito
integer x = 14
integer y = 224
integer width = 2853
integer height = 1276
integer textsize = -8
integer weight = 700
boolean multiline = true
end type

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer y = 160
integer width = 2816
integer height = 1100
string text = "General"
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 0
integer y = 0
integer width = 2743
integer height = 1124
string dataobject = "dw_cartascredito1"
end type

event dw_pagina1::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param


lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_genter"

CHOOSE CASE f_objeto_datawindow(This)


CASE 'pb_banco_avisador'
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"banco_avisador")
   OpenWithParm(wi_mant_venbancredit,lstr_param)  
CASE 'pb_codcondicion'
   lstr_param.i_nargumentos    = 2
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codcondicion")
   OpenWithParm(wi_mant_vencondimporte,lstr_param)  
END CHOOSE





end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;
  String var_localidad,var_nombre,var_domicilio,var_codigo_ord
  String var_banco_avisador,var_texto1_avisador,var_moneda
  var_moneda         = This.GetItemString(This.GetRow(),'moneda')
  var_localidad      = This.GetItemString(This.GetRow(),'localidad_ord')
  var_nombre         = This.GetItemString(This.GetRow(),'nombre_ord')
  var_domicilio      = This.GetItemString(This.GetRow(),'domicilio_ord')
  var_codigo_ord     = This.GetItemString(This.GetRow(),'codigo_ord')
  var_texto1_avisador     = This.GetItemString(This.GetRow(),'text1_avisador')
  var_banco_avisador     = This.GetItemString(This.GetRow(),'banco_avisador')
IF IsNull(var_moneda) Or Trim(var_moneda)="" THEN
	var_moneda = f_moneda_genter(codigo_empresa,"C",var_codigo_ord)
	This.SetItem(1,"moneda",var_moneda)
END IF  
IF IsNull(var_nombre) Or Trim(var_nombre)="" THEN
	var_nombre = f_razon_genter(codigo_empresa,"C",var_codigo_ord)
	This.SetItem(1,"nombre_ord",var_nombre)
END IF
IF IsNull(var_localidad) Or Trim(var_localidad)="" THEN
	var_localidad = f_localidad_genter(codigo_empresa,"C",var_codigo_ord)
	This.SetItem(1,"localidad_ord",var_localidad)
END IF

IF IsNull(var_domicilio) Or Trim(var_domicilio)="" THEN
	var_domicilio = f_domicilio_genter(codigo_empresa,"C",var_codigo_ord)
	This.SetItem(1,"domicilio_ord",var_domicilio)
END IF


IF IsNull(var_texto1_avisador) Or Trim(var_texto1_avisador)="" THEN
	var_texto1_avisador = f_nombre_venbancredit(codigo_empresa,var_banco_avisador)
	This.SetItem(1,"text1_avisador",var_texto1_avisador)
END IF



end event

event dw_pagina1::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "cod_condicion"
      bus_datawindow = "dw_ayuda_vencondimporte"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CONDICIONES IMPORTE"

   CASE "codigo_ord"
      bus_datawindow = "dw_ayuda_clientes"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"

   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
	CASE "banco_avisador"
      bus_datawindow = "dw_ayuda_venbancredit"
		bus_titulo = "VENTANA SELECCION DE BANCOS AVISADORES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event dw_pagina1::rbuttondown;call super::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
  CASE "codigo_ord"
      bus_datawindow = "dw_ayuda_clientes"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CLIENTES"
  CASE "cod_condicion"
      bus_datawindow = "dw_ayuda_vencondimporte"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE CONDICIONES IMPORTE"

   CASE "moneda"
      bus_datawindow = "dw_ayuda_divisas"
		bus_titulo = "VENTANA SELECCION DE DIVISAS"
	CASE "banco_avisador"
      bus_datawindow = "dw_ayuda_venbancredit"
		bus_titulo = "VENTANA SELECCION DE BANCOS AVISADORES"
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer y = 160
integer width = 2816
integer height = 1100
string text = "Instrucciones~r~n  embarque"
dw_lineas dw_lineas
end type

on pagina_2.create
this.dw_lineas=create dw_lineas
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_lineas
end on

on pagina_2.destroy
call super::destroy
destroy(this.dw_lineas)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 0
integer y = 0
integer width = 2651
integer height = 708
string dataobject = "dw_cartascredito2"
end type

event dw_pagina2::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param
// Devuelve el objeto al que apunta seguido del tabulador (~t) y 
// el numero de fila en la Datawindow


lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_vencartascredito"

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_puerto_origen'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"puerto_origen")
   OpenWithParm(wi_mant_venlugares,lstr_param)  
CASE 'pb_puerto_destino'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"puerto_destino")
   OpenWithParm(wi_mant_venlugares,lstr_param)  

END CHOOSE



end event

event dw_pagina2::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "puerto_origen"
 		bus_datawindow = "dw_ayuda_venlugares"
		bus_titulo = "VENTANA SELECCION DE LUGARES"
		
   CASE "puerto_destino"
      bus_datawindow = "dw_ayuda_venlugares"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE LUGARES"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF


end event

event dw_pagina2::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
		CASE "puerto_origen"
 		bus_datawindow = "dw_ayuda_venlugares"
		bus_titulo = "VENTANA SELECCION DE LUGARES"
		
   CASE "puerto_destino"
      bus_datawindow = "dw_ayuda_venlugares"
      bus_filtro     = ""
		bus_titulo = "VENTANA SELECCION DE LUGARES"
  
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

event dw_pagina2::itemfocuschanged;call super::itemfocuschanged;String var_texto_destino,origen,destino,torigen,tdestino,var_texto_origen
This.Accepttext()
var_texto_destino  = This.GetItemString(getRow(),"texto_destino")
destino  = This.GetItemString(This.getRow(),"puerto_destino")
origen   = This.GetItemString(This.getRow(),"puerto_origen")
IF Isnull(var_texto_origen) or Trim(var_texto_origen) = "" Then
	var_texto_origen = Trim(f_nombre_venlugares(codigo_empresa,origen)) 
		This.SetItem(This.GetRow(),"texto_origen",var_texto_origen)
END IF
IF Isnull(var_texto_destino) or Trim(var_texto_destino) = "" Then
	IF Trim(origen) <> "" and Trim(destino)<> "" Then
	var_texto_destino = Trim(f_nombre_venlugares(codigo_empresa,origen)) +& 
	+  	" - " + Trim(f_nombre_venlugares(codigo_empresa,destino)) 
	This.SetItem(This.GetRow(),"texto_destino",var_texto_destino)
 END IF
END IF


end event

event dw_pagina2::valores_numericos;call super::valores_numericos;f_valores_numericos(This,"puerto_origen")
f_valores_numericos(This,"puerto_destino")
end event

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer y = 160
integer width = 2816
integer height = 1100
string text = "Documentos~r~n   Bancos"
dw_dmto1 dw_dmto1
pb_1 pb_1
st_2 st_2
st_3 st_3
pb_2 pb_2
end type

on pagina_3.create
this.dw_dmto1=create dw_dmto1
this.pb_1=create pb_1
this.st_2=create st_2
this.st_3=create st_3
this.pb_2=create pb_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dmto1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.pb_2
end on

on pagina_3.destroy
call super::destroy
destroy(this.dw_dmto1)
destroy(this.pb_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.pb_2)
end on

event pagina_3::dragdrop;call super::dragdrop;dw_listado.SetTransObject(SQLCA)
dw_listado.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
OpenWithParm(w_impresoras_v2,dw_listado2)
end event

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 9
integer y = 0
integer width = 2514
integer height = 340
string dataobject = "dw_cartascredito3"
end type

event dw_pagina3::clicked;call super::clicked;datawindow var_datawindow
str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "wi_mant_distribuifores"

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_banco_negociador'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"banco_negociador")
   OpenWithParm(wi_mant_carbancos,lstr_param)  

END CHOOSE



end event

event dw_pagina3::itemfocuschanged;call super::itemfocuschanged;String li_codprov
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

event dw_pagina3::key;IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()

 CHOOSE CASE bus_campo
	CASE "banco_negociador"
      bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS "
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF


end event

event dw_pagina3::rbuttondown; bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 CHOOSE CASE bus_campo
	CASE "banco_negociador"
      bus_datawindow = "dw_ayuda_carbancos"
		bus_titulo = "VENTANA SELECCION DE BANCOS "
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
integer y = 160
integer width = 2816
integer height = 1100
string text = "Documentos~r~n   Clientes"
dw_dmto2 dw_dmto2
end type

on pagina_4.create
this.dw_dmto2=create dw_dmto2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_dmto2
end on

on pagina_4.destroy
call super::destroy
destroy(this.dw_dmto2)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
boolean visible = false
integer width = 1605
integer height = 880
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer y = 160
integer width = 2816
integer height = 1100
string text = "Facturación"
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
integer x = 23
integer y = 0
integer width = 2647
integer height = 1136
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
lstr_param.s_argumentos[1]  = "wi_mant_transportistas"

CHOOSE CASE f_objeto_datawindow(This)

CASE 'pb_paisbanco'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"paisbanco")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE "pb_zona"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_tipo_cliente"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_cliente")
   OpenWithParm(wi_mant_ventipocli,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
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
CASE "pb_tipoiva"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipoiva")
   OpenWithParm(wi_mant_contaiva,lstr_param)
CASE "pb_transportista"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_cod_entrega"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_entrega")
 OpenWithParm(wi_mant_vencondentrega,lstr_param)
CASE "pb_tarifa"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tarifa")
 OpenWithParm(wi_mant_ventarifas,lstr_param)
CASE "pb_domiciliacion"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
 OpenWithParm(wi_mant_vendomiciliacion,lstr_param)
CASE "pb_envio"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
 OpenWithParm(wi_mant_venenvio,lstr_param)
CASE "pb_forma_envio"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_envio")
 OpenWithParm(wi_mant_venformaenvio,lstr_param)
CASE "pb_tipoportes"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_portes")
 OpenWithParm(wi_mant_ventipoportes,lstr_param)
CASE "pb_serie"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
CASE "pb_correspondencia"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
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

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer y = 160
integer width = 2816
integer height = 1100
string text = "Estadísticas"
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
lstr_param.s_argumentos[1]  = "wi_mant_transportistas"

CHOOSE CASE f_objeto_datawindow(This)


CASE 'pb_paisbanco'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"paisbanco")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE "pb_zona"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_tipo_cliente"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_cliente")
   OpenWithParm(wi_mant_ventipocli,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
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
CASE "pb_tipoiva"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipoiva")
   OpenWithParm(wi_mant_contaiva,lstr_param)
CASE "pb_transportista"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_cod_entrega"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_entrega")
 OpenWithParm(wi_mant_vencondentrega,lstr_param)
CASE "pb_tarifa"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tarifa")
 OpenWithParm(wi_mant_ventarifas,lstr_param)
CASE "pb_domiciliacion"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
 OpenWithParm(wi_mant_vendomiciliacion,lstr_param)
CASE "pb_envio"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
 OpenWithParm(wi_mant_venenvio,lstr_param)
CASE "pb_forma_envio"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_envio")
 OpenWithParm(wi_mant_venformaenvio,lstr_param)
CASE "pb_tipoportes"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_portes")
 OpenWithParm(wi_mant_ventipoportes,lstr_param)
CASE "pb_serie"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
CASE "pb_correspondencia"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
 CASE "pb_banco_cobro"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"banco_de_cobro")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
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
integer y = 160
integer width = 2816
integer height = 1100
string text = "Varios"
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
integer width = 1911
integer height = 604
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
lstr_param.s_argumentos[1]  = "wi_mant_transportistas"

CHOOSE CASE f_objeto_datawindow(This)


CASE 'pb_paisbanco'
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"paisbanco")
   OpenWithParm(wi_mant_paises,lstr_param)  
CASE "pb_zona"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"zona")
   OpenWithParm(wi_mant_venzonas,lstr_param)  
CASE "pb_tipo_cliente"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_cliente")
   OpenWithParm(wi_mant_ventipocli,lstr_param)  
CASE "pb_grupo"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"grupo")
   OpenWithParm(wi_mant_vengrupos,lstr_param)  
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
CASE "pb_tipoiva"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipoiva")
   OpenWithParm(wi_mant_contaiva,lstr_param)
CASE "pb_transportista"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"transportista")
   OpenWithParm(wi_mant_ventransportistas,lstr_param)
CASE "pb_cod_entrega"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"cod_entrega")
 OpenWithParm(wi_mant_vencondentrega,lstr_param)
CASE "pb_tarifa"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tarifa")
 OpenWithParm(wi_mant_ventarifas,lstr_param)
CASE "pb_domiciliacion"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"domiciliacion")
 OpenWithParm(wi_mant_vendomiciliacion,lstr_param)
CASE "pb_envio"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"envio")
 OpenWithParm(wi_mant_venenvio,lstr_param)
CASE "pb_forma_envio"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"forma_envio")
 OpenWithParm(wi_mant_venformaenvio,lstr_param)
CASE "pb_tipoportes"
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"tipo_portes")
 OpenWithParm(wi_mant_ventipoportes,lstr_param)
CASE "pb_serie"
   lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"serie")
   OpenWithParm(wi_mant_venseries,lstr_param)  
CASE "pb_correspondencia"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"correspondencia")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
 CASE "pb_banco_cobro"
 lstr_param.i_nargumentos    = 3
 lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"codigo")
 lstr_param.s_argumentos[3]=GetItemString(This.GetRow(),"banco_de_cobro")
 OpenWithParm(wi_mant_vencorrespondencia,lstr_param)
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
integer y = 160
integer width = 2816
integer height = 1100
string text = "Comentarios"
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
integer x = 87
integer width = 2473
integer height = 1148
string dataobject = "dw_venclientes11"
end type

type dw_lineas from u_datawindow_consultas within pagina_2
integer x = 82
integer y = 716
integer width = 2702
integer height = 328
integer taborder = 2
string dataobject = "dw_cartascredito5"
boolean vscrollbar = true
end type

event clicked;call super::clicked;apartados.pagina_2.dw_pagina2.TriggerEvent(Clicked!)
IF cb_insertar.enabled = FALSE Then return
IF f_objeto_datawindow(This) = "insertar"  or f_objeto_datawindow(This) = "modificar"Then
	
 IF Trim(apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_origen"))="" Then
	 f_mensaje("Campo obligatorigo","Introduxca el puerto origen")
	 apartados.pagina_2.dw_pagina2.SetFocus()
	 apartados.pagina_2.dw_pagina2.Setcolumn("puerto_origen")
    Return	
 END IF
  IF Trim(apartados.pagina_2.dw_pagina2.GetItemString(1,"puerto_destino"))="" Then
	 f_mensaje("Campo obligatorigo","Introduxca el puerto destino")
	 apartados.pagina_2.dw_pagina2.SetFocus()
	 apartados.pagina_2.dw_pagina2.Setcolumn("puerto_destino")
    Return	
 END IF

IF f_objeto_datawindow(This) = "insertar"   Then  f_insertar_linea()
IF f_objeto_datawindow(This) = "modificar"  Then  f_modificar_linea()
END IF
IF f_objeto_datawindow(This) = "borrar" Then
	f_borrar_linea()
END IF
IF Row <> 0 Then 
apartados.pagina_2.dw_pagina2.SetItem(1,"puerto_origen",This.GetItemString(row,"puerto_origen"))
apartados.pagina_2.dw_pagina2.SetItem(1,"puerto_destino",This.GetItemString(row,"puerto_destino"))
apartados.pagina_2.dw_pagina2.SetItem(1,"texto_destino",This.GetItemString(row,"texto_destino"))
apartados.pagina_2.dw_pagina2.SetItem(1,"texto_origen",This.GetItemString(row,"texto_origen"))
apartados.pagina_2.dw_pagina2.SetItem(1,"observ_embar",This.GetItemString(row,"observaciones"))
apartados.pagina_2.dw_pagina2.SetItem(1,"bienes",This.GetItemString(row,"bienes"))
END IF
end event

event key;call super::key;IF Key = KeyF2! Then f_insertar_linea()
IF Key = KeyF3! Then f_borrar_linea()
end event

event rowfocuschanged;call super::rowfocuschanged;IF GetRow() =0 Then return
IF currentrow = 0 Then Return

apartados.pagina_2.dw_pagina2.SetItem(1,"puerto_origen",This.GetItemString(currentrow,"puerto_origen"))
apartados.pagina_2.dw_pagina2.SetItem(1,"puerto_destino",This.GetItemString(currentrow,"puerto_destino"))
apartados.pagina_2.dw_pagina2.SetItem(1,"texto_destino",This.GetItemString(currentrow,"texto_destino"))
apartados.pagina_2.dw_pagina2.SetItem(1,"texto_origen",This.GetItemString(currentrow,"texto_origen"))
apartados.pagina_2.dw_pagina2.SetItem(1,"observ_embar",This.GetItemString(currentrow,"observaciones"))
apartados.pagina_2.dw_pagina2.SetItem(1,"bienes",This.GetItemString(currentrow,"bienes"))
end event

type dw_dmto1 from u_datawindow_consultas within pagina_3
integer x = 73
integer y = 340
integer width = 2501
integer height = 472
integer taborder = 2
string dataobject = "dw_cartascredito4"
end type

event clicked;call super::clicked;apartados.pagina_3.dw_pagina3.TriggerEvent(Clicked!)
IF cb_insertar.enabled = FALSE Then return
IF f_objeto_datawindow(This) = "insertar" Then
	f_insertar_dmto1()
	
END IF
IF f_objeto_datawindow(This) = "borrar" Then
	f_borrar_dmto1()
END IF
end event

event ue_valores;call super::ue_valores;ue_marca_linea =FALSE
This.SetRowFocusIndicator(Hand!)
end event

event key;call super::key;IF Key = KeyF2! Then f_insertar_dmto1()
IF Key = KeyF3! Then f_borrar_dmto1()
end event

type pb_1 from upb_imprimir within pagina_3
integer x = 2697
integer taborder = 2
end type

event clicked;call super::clicked;dw_listado.SetTransObject(SQLCA)
dw_listado.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
OpenWithParm(w_impresoras_v2,dw_listado)
end event

type st_2 from statictext within pagina_3
integer x = 2437
integer y = 16
integer width = 256
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "List. Dmtos."
boolean focusrectangle = false
end type

type st_3 from statictext within pagina_3
integer x = 2441
integer y = 116
integer width = 247
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "List. Fra."
boolean focusrectangle = false
end type

type pb_2 from upb_imprimir within pagina_3
integer x = 2697
integer y = 96
integer taborder = 2
end type

event clicked;call super::clicked;dw_listado2.SetTransObject(SQLCA)
dw_listado2.Retrieve(codigo_empresa,var_anyo,sle_valor.text)
OpenWithParm(w_impresoras_v2,dw_listado2)
end event

type dw_dmto2 from u_datawindow_consultas within pagina_4
integer x = 119
integer y = 188
integer width = 2501
integer height = 472
integer taborder = 2
string dataobject = "dw_cartascredito4"
end type

event clicked;call super::clicked;apartados.pagina_4.dw_pagina4.TriggerEvent(Clicked!)
IF cb_insertar.enabled = FALSE Then return
IF f_objeto_datawindow(This) = "insertar" Then
	f_insertar_dmto2()
	
END IF
IF f_objeto_datawindow(This) = "borrar" Then
	f_borrar_dmto2()
END IF
end event

event ue_valores;call super::ue_valores;ue_marca_linea = FALSE
This.SetRowFocusIndicator(Hand!)
end event

event key;call super::key;IF Key = KeyF2! Then f_insertar_dmto2()
IF Key = KeyF3! Then f_borrar_dmto2()
end event

type gb_1 from groupbox within wi_mant_vencartascredito
integer x = 1486
integer y = 92
integer width = 1143
integer height = 124
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_proceso from datawindow within wi_mant_vencartascredito
boolean visible = false
integer width = 279
integer height = 104
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_proceso_vendocumentos"
boolean livescroll = true
end type

type dw_listado from datawindow within wi_mant_vencartascredito
boolean visible = false
integer x = 2245
integer width = 562
integer height = 116
integer taborder = 20
boolean bringtotop = true
string dataobject = "report_vencartacreditos1"
boolean livescroll = true
end type

type dw_listado2 from datawindow within wi_mant_vencartascredito
boolean visible = false
integer x = 1646
integer width = 562
integer height = 116
integer taborder = 10
boolean bringtotop = true
string dataobject = "report_vencartacreditos3"
boolean livescroll = true
end type

