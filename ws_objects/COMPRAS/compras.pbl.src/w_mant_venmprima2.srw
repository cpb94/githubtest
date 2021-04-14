$PBExportHeader$w_mant_venmprima2.srw
forward
global type w_mant_venmprima2 from wc_mantenimientos_tab
end type
type dw_primas from u_datawindow within pagina_2
end type
type cb_anyadir_pro from commandbutton within pagina_3
end type
type cb_borrar_pro from commandbutton within pagina_3
end type
type dw_2 from datawindow within pagina_4
end type
type st_descripcion_mp from statictext within w_mant_venmprima2
end type
type cb_1 from commandbutton within w_mant_venmprima2
end type
type pb_calculadora from u_calculadora within w_mant_venmprima2
end type
type st_texto from statictext within w_mant_venmprima2
end type
type cb_2 from commandbutton within w_mant_venmprima2
end type
type cb_pasar_a_ventas from commandbutton within w_mant_venmprima2
end type
end forward

global type w_mant_venmprima2 from wc_mantenimientos_tab
integer x = 9
integer y = 248
integer width = 4251
integer height = 2040
string icon = "Application!"
st_descripcion_mp st_descripcion_mp
cb_1 cb_1
pb_calculadora pb_calculadora
st_texto st_texto
cb_2 cb_2
cb_pasar_a_ventas cb_pasar_a_ventas
end type
global w_mant_venmprima2 w_mant_venmprima2

type variables
u_pipe i_upipe
end variables

forward prototypes
public function boolean f_actualizar ()
public subroutine f_insertar ()
public subroutine f_borrar ()
end prototypes

public function boolean f_actualizar ();//Integer prima2,elemento,elementos,reg,reg1
//String  var_componente,var_porcentaje,var_componente1,var_componente2,cta
////apartados.pagina_2.dw_pagina2.Accepttext()
////elemento = apartados.pagina_2.dw_primas.GetRow()
////elementos = apartados.pagina_2.dw_primas.RowCount()
//
//cta =dw_pag1.getItemString(1,"cuenta")
//
//IF   Trim(cta) <> "" Then
//	IF Trim(f_nombre_contaplan_directos(ejercicio_activo,codigo_empresa,cta))= "" Then
//	 f_mensaje("Campo obligatorio","La Cuenta no existe")
//	 apartados.pagina_2.dw_primas.SetColumn("elemento")
//	 Return FALSE
//	END IF
//END IF
//
//
//IF IsNull(elementos) Then elementos = 0
//
//
//
//IF elementos <> 0 Then
// var_componente =f_valor_columna(apartados.pagina_2.dw_primas,apartados.pagina_2.dw_primas.GetRow(),"elemento")
// var_porcentaje =f_valor_columna(apartados.pagina_2.dw_primas,apartados.pagina_2.dw_primas.GetRow(),"porcentaje")
//  IF IsNull(var_componente) or Trim(var_componente)= "" Then
//	 f_mensaje("Campo obligatorio"," Introduzca el componente")
//	 apartados.pagina_2.dw_primas.SetColumn("elemento")
//	 return False
// END If
//  IF IsNull(var_porcentaje) or Trim(var_porcentaje)= "" Then
//	 f_mensaje("Campo obligatorio"," Introduzca el Porcentaje")
//	 apartados.pagina_2.dw_primas.SetColumn("porcentaje")
//	 return False
// END If
// // control duplicados
// For reg = 1 To elementos
//	var_componente1 = f_valor_columna(apartados.pagina_2.dw_primas,reg,"elemento")
//	For reg1 = 1 To elementos
//		IF reg1 <> reg Then
//      	 var_componente2 = f_valor_columna(apartados.pagina_2.dw_primas,reg1,"elemento")
//		IF	 var_componente1 = var_componente2 Then
//			f_mensaje ("Error en datos"," Componente Repetido")
//			apartados.pagina_2.dw_primas.SetFocus()
//			apartados.pagina_2.dw_primas.SetRow(reg1)
//			apartados.pagina_2.dw_primas.SetColumn("elemento")
//			Return False
//		END IF
//      END IF
//	Next
// Next
//END IF 
//
//apartados.pagina_2.dw_primas.Update()
//COMMIT;
Return True
end function

public subroutine f_insertar ();//Integer prim,prim2
//apartados.pagina_2.dw_primas.AcceptText()
////IF Not f_actualizar() Then Return
//cb_insertar.enabled = TRUE
//prim = apartados.pagina_2.dw_primas.GetRow()
//prim2 =apartados.pagina_2.dw_primas.RowCount()
//apartados.pagina_2.dw_primas.InsertRow(prim2+1)
//apartados.pagina_2.dw_primas.setitem(prim2 + 1,"empresa",codigo_empresa)
//apartados.pagina_2.dw_primas.setitem(prim2 + 1,"prima",sle_valor.text)
//apartados.pagina_2.dw_primas.ScrollToRow(prim2+1)
//apartados.pagina_2.dw_primas.SetFocus()
//apartados.pagina_2.dw_primas.SetRow(prim2+1)
//apartados.pagina_2.dw_primas.SetColumn("elemento")


end subroutine

public subroutine f_borrar ();//Integer elemento
//elemento = apartados.pagina_2.dw_primas.GetRow()
//apartados.pagina_2.dw_primas.DeleteRow(elemento)
end subroutine

on w_mant_venmprima2.create
int iCurrent
call super::create
this.st_descripcion_mp=create st_descripcion_mp
this.cb_1=create cb_1
this.pb_calculadora=create pb_calculadora
this.st_texto=create st_texto
this.cb_2=create cb_2
this.cb_pasar_a_ventas=create cb_pasar_a_ventas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_descripcion_mp
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.pb_calculadora
this.Control[iCurrent+4]=this.st_texto
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_pasar_a_ventas
end on

on w_mant_venmprima2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_descripcion_mp)
destroy(this.cb_1)
destroy(this.pb_calculadora)
destroy(this.st_texto)
destroy(this.cb_2)
destroy(this.cb_pasar_a_ventas)
end on

event open;call super::open;istr_parametros.s_titulo_ventana = "Mantenimiento de Materias Primas"
istr_parametros.s_listado        = ""
This.title = istr_parametros.s_titulo_ventana
 
tipo_mantenimiento ="C"
apartados.pagina_1.dw_pagina1.SetTransObject(SQLCA)
//apartados.pagina_2.dw_pagina2.SetTransObject(SQLCA)
//apartados.pagina_2.dw_primas.SetTransObject(SQLCA)

// Si recibo el codigo lo visualizo
IF istr_parametros.i_nargumentos>1 THEN
	sle_valor.text = istr_parametros.s_argumentos[2]
	IF Trim(sle_valor.text) <> "" and Not IsNull(sle_valor.text) Then
		f_activar_campo(sle_valor)
		TriggerEvent("ue_recuperar")
	END IF
END IF
end event

event ue_inserta_fila;call super::ue_inserta_fila;apartados.pagina_1.dw_pagina1.setitem(1,"empresa",codigo_empresa)
apartados.pagina_1.dw_pagina1.setitem(1,"codigo",sle_valor.text)

long i

for i=1 to apartados.pagina_3.dw_pagina3.rowcount()
	apartados.pagina_3.dw_pagina3.setitem(1,"empresa",codigo_empresa)
	apartados.pagina_3.dw_pagina3.setitem(1,"mprima",sle_valor.text)
next
end event

event ue_recuperar;// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[2]   =  trim(sle_valor.text)+space(20-longitud)
seleccion[1]     =  criterio[1]+criterio[2]
tabla[1]         = "venmprima"

apartados.pagina_1.dw_pagina1.Retrieve(codigo_empresa,sle_valor.Text)
apartados.pagina_3.dw_pagina3.Retrieve(codigo_empresa,sle_valor.Text)
//apartados.pagina_2.dw_pagina2.Retrieve(codigo_empresa,sle_valor.Text)
//apartados.pagina_2.dw_primas.Retrieve(codigo_empresa,sle_valor.Text)
CALL Super::ue_recuperar
end event

event ue_valores;call super::ue_valores;pag1 = TRUE
pag3 = TRUE

pag_act1 = TRUE
pag_act3 = TRUE

prin_pag1 = TRUE
prin_pag3 = TRUE
end event

event ue_borra_fila;pag_act3=False

call super::ue_borra_fila

pag_act3=True

DELETE FROM comartpro  
WHERE ( comartpro.empresa = :codigo_empresa ) 
AND  	( comartpro.mprima  = :sle_valor.text )   ;

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.enabled = false
cb_pasar_a_ventas.enabled = false
end event

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.enabled = true
cb_pasar_a_ventas.enabled = true
end event

type cb_salir from wc_mantenimientos_tab`cb_salir within w_mant_venmprima2
integer x = 3808
integer y = 88
integer taborder = 0
end type

type cb_borrar from wc_mantenimientos_tab`cb_borrar within w_mant_venmprima2
integer x = 3401
integer y = 88
integer taborder = 0
end type

event cb_borrar::clicked;long cuantos

select count(mp) into :cuantos from proddetformula
where empresa = :codigo_empresa 
and mp = :sle_valor.text;

if cuantos <> 0 and not (IsNull(cuantos)) then
	messagebox("Atención","No  es  posible  borrar  un  articulo~nque esta incluido en la composición~nde una o más formulas")
else
	Call Super::clicked
end if
end event

type cb_insertar from wc_mantenimientos_tab`cb_insertar within w_mant_venmprima2
integer x = 2994
integer y = 88
integer taborder = 0
end type

event cb_insertar::clicked;boolean si=false, continuar
string proveedor, des_proveedor, tipo_materia
string articulo, sel
datastore regs
long m
dec{6} coste_caja


continuar = false
if apartados.pagina_3.dw_pagina3.rowcount() > 0 then
	proveedor = apartados.pagina_3.dw_pagina3.getitemstring(apartados.pagina_3.dw_pagina3.getrow(),"proveedor")
	des_proveedor = apartados.pagina_3.dw_pagina3.getitemstring(apartados.pagina_3.dw_pagina3.getrow(),"n_proveedor")
	continuar = true
end if
If cb_insertar.enabled = TRUE then
	si = true
	if apartados.pagina_3.dw_pagina3.rowcount()=0 then
		messagebox("Introducción de Materias Primas","Introduzca un Proveedor")
		return
	else
		long i,bien
		bien=0
		for i=1 to apartados.pagina_3.dw_pagina3.rowcount()
			if apartados.pagina_3.dw_pagina3.getitemstring(i,"n_proveedor")="" then
				messagebox("Introducción de Materias Primas","Proveedor Inexistente")
				bien=1
				exit
			end if
		next
		if bien=1 then return
	end if
end if
 
Call Super::clicked

if apartados.pagina_1.dw_pagina1.rowcount() > 0 then
	tipo_materia = apartados.pagina_1.dw_pagina1.getitemstring(apartados.pagina_1.dw_pagina1.getrow(),"tipo_materia")
end if


sel = " select almartcajas.articulo "+&
		" from almartcajas "+&
		" inner join almcajas on almcajas.empresa = almartcajas.empresa and almcajas.codigo = almartcajas.caja "+&
		" where almcajas.codigo_compras = '"+ sle_valor.text +"' "
		
f_cargar_cursor_nuevo (sel, regs)

for m = 1 to regs.rowcount()
	articulo = regs.object.almartcajas_articulo[m]
	coste_caja =  f_calculo_coste_packing (codigo_empresa, articulo)
	update art_ver_operaciones
	set coste_packing = :coste_caja
	where empresa = :codigo_empresa
	and articulo = :articulo 
	and version = '1';

next	

destroy regs

if continuar and ( tipo_materia = '16' or tipo_materia = '17' ) then
//	if  MessageBox("Atención", "Desea recalcular costes para el proveedor "+des_proveedor,  Question!, YesNO!, 2) = 1 then
//		if si then 
			st_texto.visible = true
			f_recalculo_costes_formulas (codigo_empresa, trim(sle_valor.text))
			st_texto.visible = false
			
//		end if
//	end if		
end if
end event

type wc_control_tabulador from wc_mantenimientos_tab`wc_control_tabulador within w_mant_venmprima2
integer x = 5
integer y = 0
integer width = 46
integer height = 40
integer taborder = 20
end type

type st_empresa from wc_mantenimientos_tab`st_empresa within w_mant_venmprima2
end type

type sle_valor from wc_mantenimientos_tab`sle_valor within w_mant_venmprima2
integer x = 293
integer y = 112
integer width = 302
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow =  "dw_ayuda_venmprima"
ue_titulo     =  "AYUDA SELECCION DE MATERIAS PRIMAS"
ue_filtro     =  ""
isle_campo    = This
valor_empresa = TRUE
end event

event sle_valor::modificado;call super::modificado;if not trim(sle_valor.text) = "" and not IsNull(sle_valor.text) then
	st_descripcion_mp.text = f_descripcion_venmprima(codigo_empresa, sle_valor.text)
else
	st_descripcion_mp.text = ""
end if
end event

type st_1 from wc_mantenimientos_tab`st_1 within w_mant_venmprima2
integer x = 18
integer y = 120
end type

type apartados from wc_mantenimientos_tab`apartados within w_mant_venmprima2
integer x = 9
integer y = 212
integer width = 4206
integer height = 1616
end type

on apartados.create
call super::create
this.Control[]={this.pagina_1,&
this.pagina_2,&
this.pagina_3,&
this.pagina_4,&
this.pagina_5,&
this.pagina_6,&
this.pagina_7,&
this.pagina_8}
end on

on apartados.destroy
call super::destroy
end on

type pagina_1 from wc_mantenimientos_tab`pagina_1 within apartados
integer width = 4169
integer height = 1488
string text = "Datos Generales"
end type

type dw_pagina1 from wc_mantenimientos_tab`dw_pagina1 within pagina_1
integer x = 0
integer y = 12
integer width = 3497
integer height = 1476
string dataobject = "dw_venmprima"
end type

event dw_pagina1::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_venmprima2"

CHOOSE CASE f_objeto_datawindow(This)
	CASE "pb_envase"
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"envase")
		OpenWithParm(w_mant_venenvases,lstr_param) 
	CASE "pb_familia"
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"tipo_materia")
		lstr_param.s_argumentos[3] = GetItemString(This.GetRow(),"familia")
		OpenWithParm(w_mant_venfamilias,lstr_param) 
	CASE "pb_cuenta"
		lstr_param.s_argumentos[2] = String(f_ejercicio_activo(codigo_empresa))
		lstr_param.s_argumentos[3] = GetItemString(This.GetRow(),"cuenta")
		OpenWithParm(wi_mant_contaplan,lstr_param) 
	CASE "pb_proveedor"
			lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"envase")
		OpenWithParm(w_mant_comproveedores,lstr_param)  
	CASE "pb_materia"
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"tipo_materia")
		OpenWithParm(w_mant_venmateria,lstr_param)  
	CASE "pb_unidad"
		lstr_param.s_argumentos[2] = GetItemString(This.GetRow(),"tipo_unidad")
		OpenWithParm(w_mant_comunimedida,lstr_param)  
	CASE "pb_pendiente"
		lstr_param.s_argumentos[2] = sle_valor.text
		OpenWithParm(w_con_pedidos_mprima,lstr_param)  
	CASE "pb_seccion"
		lstr_param.s_argumentos[2] = this.object.seccion[row]
		OpenWithParm(w_mant_contaseccion,lstr_param)  		
END CHOOSE


end event

event dw_pagina1::key; bus_filtro=""
 bus_titulo=""
 bus_datawindow = ""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "envase"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_venenvases"
		bus_titulo = "VENTANA SELECCION DE ENVASES"
	CASE "familia"
		bus_filtro ="tipo_materia = '" +GetItemString(1,"tipo_materia")+"'"
 		bus_datawindow = "dw_ayuda_venfamilias"
		bus_titulo = "VENTANA SELECCION DE FAMILIAS"
	CASE "cuenta"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"
 	CASE "tipo_materia"
 		bus_datawindow = "dw_ayuda_venmateria"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"
		
	CASE "tipo_unidad"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"

 	CASE "proveedor"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
		
	CASE "almacen_entra"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_comalmacenes"
		bus_titulo = "VENTANA SELECCION DE ALMACENES"
	CASE "seccion"
		bus_datawindow =  "dw_ayuda_contaseccion"
		bus_titulo     =  "AYUDA SELECCIÓN DE SECCIONES"
		bus_filtro     =  ""
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::key
 
end event

event dw_pagina1::rbuttondown;bus_filtro=""
 bus_titulo=""
  bus_datawindow = ""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE
 CHOOSE CASE bus_campo
	CASE "familia"
		bus_filtro ="tipo_materia = '" +GetItemString(1,"tipo_materia")+"'"
 		bus_datawindow = "dw_ayuda_venfamilias"
		bus_titulo = "VENTANA SELECCION DE FAMILIAS"		
 	CASE "tipo_materia"
 		bus_datawindow = "dw_ayuda_venmateria"
		bus_titulo = "VENTANA SELECCION DE GRUPOS"		
	CASE "tipo_unidad"
		valor_empresa = FALSE
 		bus_datawindow = "dw_ayuda_comunimedida"
		bus_titulo = "VENTANA SELECCION DE UNIDADES"
 	CASE "proveedor"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"		
	CASE "envase"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_venenvases"
		bus_titulo = "VENTANA SELECCION DE ENVASES"		
	CASE "cuenta"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_contaplan_activo_directos"
		bus_titulo = "VENTANA SELECCION DE CUENTAS"		
	CASE "almacen_entra"
		bus_filtro =""
 		bus_datawindow = "dw_ayuda_comalmacenes"
		bus_titulo = "VENTANA SELECCION DE ALMACENES"
	CASE "seccion"
		bus_datawindow =  "dw_ayuda_contaseccion"
		bus_titulo     =  "AYUDA SELECCIÓN DE SECCIONES"
		bus_filtro     =  ""
   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown

end event

event dw_pagina1::valores_numericos;call super::valores_numericos;f_valores_numericos(this,"tipo_materia")
end event

event dw_pagina1::itemfocuschanged;call super::itemfocuschanged;if isnull(dwo) then return
if isnull(dwo.name) then return

IF dwo.Name = "descripcion" THEN
	IF Trim(This.GetItemString(row,"descripcion_vtas")) = "" OR IsNull(This.GetItemString(row,"descripcion_vtas")) THEN
			This.SetItem(row,"descripcion_vtas",left(This.GetItemString(row,"descripcion"), 30))
	END IF
END IF
end event

event dw_pagina1::itemchanged;if isnull(dwo) then return
if isnull(dwo.name) then return

IF dwo.Name = "descripcion" THEN
	IF Trim(This.GetItemString(row,"descripcion_vtas")) = "" OR IsNull(This.GetItemString(row,"descripcion_vtas")) THEN
			This.SetItem(row,"descripcion_vtas",left (data, 30))
	END IF
END IF
end event

type pagina_2 from wc_mantenimientos_tab`pagina_2 within apartados
integer width = 4169
integer height = 1488
string text = "Componentes"
dw_primas dw_primas
end type

on pagina_2.create
this.dw_primas=create dw_primas
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_primas
end on

on pagina_2.destroy
call super::destroy
destroy(this.dw_primas)
end on

type dw_pagina2 from wc_mantenimientos_tab`dw_pagina2 within pagina_2
integer x = 9
integer y = 28
integer width = 2587
integer height = 212
string dataobject = "dw_con_venprimas1"
boolean border = true
borderstyle borderstyle = styleraised!
end type

type pagina_3 from wc_mantenimientos_tab`pagina_3 within apartados
integer width = 4169
integer height = 1488
string text = "Proveedores"
cb_anyadir_pro cb_anyadir_pro
cb_borrar_pro cb_borrar_pro
end type

on pagina_3.create
this.cb_anyadir_pro=create cb_anyadir_pro
this.cb_borrar_pro=create cb_borrar_pro
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_anyadir_pro
this.Control[iCurrent+2]=this.cb_borrar_pro
end on

on pagina_3.destroy
call super::destroy
destroy(this.cb_anyadir_pro)
destroy(this.cb_borrar_pro)
end on

type dw_pagina3 from wc_mantenimientos_tab`dw_pagina3 within pagina_3
integer x = 0
integer y = 128
integer width = 4142
integer height = 1356
string dataobject = "dw_comartpro"
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event dw_pagina3::rbuttondown;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE

CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE

CALL Super::rbuttondown

end event

event dw_pagina3::key;bus_filtro=""
bus_titulo=""
bus_datawindow = ""
bus_campo = This.GetColumnName()
valor_empresa = TRUE
CHOOSE CASE bus_campo
	CASE "proveedor"
		bus_filtro =""
		bus_datawindow = "dw_ayuda_proveedores"
		bus_titulo = "VENTANA SELECCION DE PROVEEDORES"
	CASE ELSE
		SetNull(bus_campo)
END CHOOSE
CALL Super::key
end event

event dw_pagina3::clicked;call super::clicked;str_parametros lstr_param

lstr_param.i_nargumentos    = 2
lstr_param.s_argumentos[1]  = "w_mant_venmprima2"

CHOOSE CASE f_objeto_datawindow(This)
	CASE "pb_proveedor"
		lstr_param.s_argumentos[2]=GetItemString(This.GetRow(),"proveedor")
		OpenWithParm(w_mant_comproveedores,lstr_param)  
END CHOOSE


end event

event dw_pagina3::ue_valores;call super::ue_valores;ue_marca_linea = True
end event

type pagina_4 from wc_mantenimientos_tab`pagina_4 within apartados
event create ( )
event destroy ( )
integer width = 4169
integer height = 1488
string text = "Traspaso"
dw_2 dw_2
end type

on pagina_4.create
this.dw_2=create dw_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on pagina_4.destroy
call super::destroy
destroy(this.dw_2)
end on

type dw_pagina4 from wc_mantenimientos_tab`dw_pagina4 within pagina_4
boolean visible = false
end type

type pagina_5 from wc_mantenimientos_tab`pagina_5 within apartados
integer width = 4169
integer height = 1488
end type

type dw_pagina5 from wc_mantenimientos_tab`dw_pagina5 within pagina_5
end type

type pagina_6 from wc_mantenimientos_tab`pagina_6 within apartados
integer width = 4169
integer height = 1488
end type

type dw_pagina6 from wc_mantenimientos_tab`dw_pagina6 within pagina_6
end type

type pagina_7 from wc_mantenimientos_tab`pagina_7 within apartados
integer width = 4169
integer height = 1488
end type

type dw_pagina7 from wc_mantenimientos_tab`dw_pagina7 within pagina_7
end type

type pagina_8 from wc_mantenimientos_tab`pagina_8 within apartados
integer width = 4169
integer height = 1488
end type

type dw_pagina8 from wc_mantenimientos_tab`dw_pagina8 within pagina_8
end type

type dw_primas from u_datawindow within pagina_2
integer x = 9
integer y = 240
integer width = 2587
integer height = 716
integer taborder = 2
string dataobject = "dw_vencompoprima"
end type

event clicked;call super::clicked;integer elementos
cb_insertar.enabled = TRUE
apartados.TriggerEvent("pulsar_datawindow")

CHOOSE CASE f_objeto_datawindow(This)
	CASE "borrar"
		f_borrar()
	CASE "insertar"
		f_insertar()
	CASE "actualizar"
		f_actualizar()
	END CHOOSE
end event

event key;IF Key = KeyF2! Then f_insertar()
IF Key = KeyF3! Then f_borrar()
IF Key = KeyF4! Then f_actualizar()
IF Key = KeyEnter! Then 
	IF apartados.pagina_2.dw_PRIMAS.GetColumnName() = "porcentaje"  Then
			f_insertar()
	END IF
END IF
IF KeyDown(KeyEnter!) OR KeyDown(KeyTab!) THEN
 bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE

 CHOOSE CASE bus_campo

  CASE "elemento"
 		bus_datawindow = "dw_ayuda_venelementos"
		bus_titulo = "VENTANA SELECCION DE ELEMENTOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::Key
END IF

end event

event rbuttondown;bus_filtro=""
 bus_titulo=""
 bus_campo = This.GetColumnName()
 valor_empresa = TRUE

 CHOOSE CASE bus_campo

  CASE "elemento"
 		bus_datawindow = "dw_ayuda_venelementos"
		bus_titulo = "VENTANA SELECCION DE ELEMENTOS"

   CASE ELSE
		SetNull(bus_campo)
 END CHOOSE
 CALL Super::rbuttondown
end event

type cb_anyadir_pro from commandbutton within pagina_3
integer x = 3479
integer y = 12
integer width = 320
integer height = 108
integer taborder = 2
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Añadir"
end type

event clicked;wc_index = 3
apartados.TriggerEvent("pulsar_datawindow")

long donde
donde=dw_pagina3.insertrow(0)
dw_pagina3.setitem(donde,"empresa",codigo_empresa)
dw_pagina3.setitem(donde,"mprima",sle_valor.text)
dw_pagina3.setfocus()
dw_pagina3.setrow(donde)
dw_pagina3.setcolumn("proveedor")

end event

type cb_borrar_pro from commandbutton within pagina_3
integer x = 3803
integer y = 12
integer width = 320
integer height = 108
integer taborder = 2
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Borrar"
end type

event clicked;wc_index = 3
apartados.TriggerEvent("pulsar_datawindow")

dw_pagina3.deleterow(dw_pagina3.getrow())
end event

type dw_2 from datawindow within pagina_4
boolean visible = false
integer x = 1769
integer y = 220
integer width = 494
integer height = 360
integer taborder = 20
boolean bringtotop = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_descripcion_mp from statictext within w_mant_venmprima2
integer x = 699
integer y = 112
integer width = 1307
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_mant_venmprima2
boolean visible = false
integer x = 2267
integer y = 20
integer width = 119
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "xx"
end type

event clicked;string sel,moneda
dec    cambio
long   indice,total
datastore monedas_compras

sel = "select distinct(moneda) moneda from comcabfac where empresa = '"+codigo_empresa+"'"

//monedas_compras = f_cargar_cursor(sel)
f_cargar_cursor_nuevo(sel, monedas_compras)

total = monedas_compras.rowcount()

for indice = 1 to total
	moneda = monedas_compras.object.moneda[indice]
	
	cambio = f_cambio_moneda(moneda)
	
	update comcabfac
	set    cambio  = :cambio
	where  empresa = :codigo_empresa
	and    moneda  = :moneda
	and   (cambio = 0 or cambio is null);
	
	if sqlca.sqlcode = 0 then
		commit;
	else
		rollback;
	end if
next

destroy monedas_compras
end event

type pb_calculadora from u_calculadora within w_mant_venmprima2
integer x = 590
integer y = 108
integer taborder = 11
string disabledname = "Compute!"
end type

event clicked;long registros

IF cb_insertar.enabled = TRUE THEN Return

Select max(convert(decimal,codigo))
Into   :registros
From   venmprima
where  empresa = :codigo_empresa
and    isnumeric(codigo) = 1;

if isnull(registros) then registros = 0

sle_valor.text = string(registros + 1)

Parent.TriggerEvent("ue_recuperar")

end event

type st_texto from statictext within w_mant_venmprima2
boolean visible = false
integer x = 539
integer y = 1528
integer width = 2533
integer height = 160
boolean bringtotop = true
integer textsize = -24
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 65535
long backcolor = 67108864
string text = "Calculando Costes ........"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_mant_venmprima2
integer x = 2949
integer y = 220
integer width = 681
integer height = 92
integer taborder = 12
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Sustituir MP en facturas"
end type

event clicked;if not trim(sle_valor.text) = "" and not IsNull(sle_valor.text) then
	openwithparm (w_mant_traspaso_mp_facturas,sle_valor.text)
else
	openwithparm (w_mant_traspaso_mp_facturas,"")
end if
end event

type cb_pasar_a_ventas from commandbutton within w_mant_venmprima2
integer x = 2546
integer y = 88
integer width = 448
integer height = 92
integer taborder = 11
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Pasar a ventas"
end type

event clicked;//Vamos a generar el producto en ventas para llevar el control de stock
string ls_codigo_compras,ls_codigo_ventas
long   ll_codigo_nuevo
int    li_existe_registro
boolean lb_correcto = true

str_articulos   lstr_articulos
str_almartcal   lstr_almartcal
str_almartcajas lstr_almartcajas
str_palarticulo lstr_palarticulo

str_art_escandallo lstr_art_escandallo
str_art_versiones lstr_art_versiones

str_venmprima lstr_venmprima

datastore ds_datos
long ll_indice,ll_total
string ls_sel

if  MessageBox("Confirmación", "¿Desea crear el artículo en ventas o actualizar los datos?",  Question!, YesNO!, 2) = 1 then
	
	if sle_valor.text = "" then
		ls_sel =   "select isnull(venmprima.codigo,'') as codigo "+&
					  "from   venmprima "+&
					  "where  venmprima.empresa = '"+codigo_empresa+"' "+&	
					  "and    venmprima.codigo in (select almcajas.codigo_compras "+&
					  "									 from   almcajas "+&
					  "									 where  almcajas.empresa = '"+codigo_empresa+"' "+&
					  "									 and    isnull(almcajas.codigo_compras,'') <> '') "+&
					  "order by convert(decimal(15,0),venmprima.codigo)"				  
	else	
		ls_sel =   "select isnull(venmprima.codigo,'') as codigo "+&
					  "from   venmprima "+&
					  "where  venmprima.empresa = '"+codigo_empresa+"' "+&
					  "and    venmprima.codigo = '"+sle_valor.text+"' "+&
					  "order by convert(decimal(15,0),venmprima.codigo)"	
	end if
				
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total
		f_mensaje_proceso("",ll_indice,ll_total)
		lb_correcto = true
		ls_codigo_compras = ds_datos.object.codigo[ll_indice]//sle_valor.text
		
		if f_cargar_str_venmprima(codigo_empresa,ls_codigo_compras,lstr_venmprima) then
			//Vamos a quitar los nulos
			f_inicializar_str_venmprima(lstr_venmprima)
			
			ls_codigo_ventas = ""
			
			select isnull(articulos.codigo,'')
			into   :ls_codigo_ventas
			from   articulos
			where  articulos.empresa        = :codigo_empresa 
			and    articulos.codigo_compras = :ls_codigo_compras;
			
			if trim(ls_codigo_ventas) <> "" then
				if not(f_cargar_str_articulos(codigo_empresa,ls_codigo_ventas,lstr_articulos)) then
					lb_correcto = false
				else
					f_inicializar_str_articulos(lstr_articulos)					
				end if
			else
				//Nuevo codigo de ventas
				ll_codigo_nuevo = f_colisiones2(codigo_empresa, "articulos", "codigo", "",false)
				
				if ll_codigo_nuevo = 0  then
					messagebox("ERROR", "No se puede asignar un código.")
					lb_correcto = false
				else
					lstr_articulos.empresa        = codigo_empresa
					lstr_articulos.codigo         = string(ll_codigo_nuevo,"#####0")
					lstr_articulos.codigo_compras = ls_codigo_compras
					lstr_articulos.cant_compras   = 1
					lstr_articulos.fecha_alta     = datetime(today())
				end if
			end if
			
			//Cargamos la estructura de articulos
			
			//lstr_articulos.empresa = 
			//lstr_articulos.codigo = 
			lstr_articulos.descripcion = lstr_venmprima.descripcion
			lstr_articulos.descripcion_arabe = lstr_venmprima.descripcion
			lstr_articulos.familia = "0"
			lstr_articulos.subfamilia = "0"
			lstr_articulos.formato = "0"
			lstr_articulos.formato_etiqueta = ""
			lstr_articulos.ancho = 0
			lstr_articulos.largo = 0
			lstr_articulos.ancho_std = 0
			lstr_articulos.largo_std = 0
			lstr_articulos.subformato = "0"
			lstr_articulos.modelo = "0"
			lstr_articulos.unidad = "0" //Unidades
			lstr_articulos.precio_coste = 0
			//lstr_articulos.fecha_alta = 
			setnull(lstr_articulos.fecha_anulado)
			setnull(lstr_articulos.fecha_fin)
			lstr_articulos.cuenta = ""
			lstr_articulos.proveedor = ""
			lstr_articulos.decorado = "N"
			lstr_articulos.sector = "N"
			lstr_articulos.conjunto = 0
			lstr_articulos.pesopieza = 0
			lstr_articulos.piezascaja = 0
			lstr_articulos.pesocaja = 0
			lstr_articulos.pesoenvase =0 
			lstr_articulos.metroscaja = 0
			lstr_articulos.metroslcaja = 0
			lstr_articulos.cuenta_contable = lstr_venmprima.cuenta
			lstr_articulos.tono = "N"
			lstr_articulos.calibre = "N"
			lstr_articulos.compras = "S"
			lstr_articulos.activo = "S"
			lstr_articulos.unidad_est = "0"
			lstr_articulos.prev_anular = "N"
			lstr_articulos.empleado = ""
			lstr_articulos.molde = ""
			lstr_articulos.marco = ""
			lstr_articulos.plato_sup = ""
			lstr_articulos.plato_inf = ""
			lstr_articulos.calibre_min = ""
			lstr_articulos.calibre_max = ""
			lstr_articulos.cliente = ""
			lstr_articulos.uso = "0"
			lstr_articulos.estilo = ""
			lstr_articulos.coleccion = "0"
			lstr_articulos.color = "0"
			lstr_articulos.imagen = ""
			lstr_articulos.referencia_laboratorio = ""
			lstr_articulos.version_laboratorio = 0
			setnull(lstr_articulos.fecha_primera_produccion)
			lstr_articulos.tipo_pasta = "0"
			lstr_articulos.codigo_pantallas = "0"
			lstr_articulos.espesor = 0
			lstr_articulos.ciclo = 0
			lstr_articulos.temp_inferior = 0
			lstr_articulos.temp_superior = 0
			lstr_articulos.ean13 = ""
			lstr_articulos.ventasitalia = ""
			lstr_articulos.usuario = ""
			lstr_articulos.temp_inferior1 = 0
			lstr_articulos.temp_superior1 = 0
			lstr_articulos.obs_ficha_hornos = ""
			lstr_articulos.tipo = "0"
			lstr_articulos.partidaest = ""
			lstr_articulos.control_stock = ""
			lstr_articulos.m2_sugeridos = 0
			lstr_articulos.stock_min = 0
			lstr_articulos.ubi_muestras = ""
			lstr_articulos.lote_minimo = 0
			lstr_articulos.stocksugerido = 0
			setnull(lstr_articulos.fechastocksugerido)
			//lstr_articulos.codigo_compras = ""
			//lstr_articulos.cant_compras = 1
			lstr_articulos.estandar = "N"
			lstr_articulos.bloqueado = "N"
			lstr_articulos.cod_cliente = ""
			lstr_articulos.canto_vivo = "N"
			lstr_articulos.marcado = ""
			lstr_articulos.etiqueta_ce = ""
			lstr_articulos.lote = 0
			lstr_articulos.observaciones = ""
			lstr_articulos.modelo_origen = "0"
			lstr_articulos.pieza_origen = "0"
			lstr_articulos.prueba_origen = "0"
			lstr_articulos.ean13_aux = ""
			lstr_articulos.bisel = 0
			lstr_articulos.relieve = "0"
			lstr_articulos.cliente_marca = ""
			lstr_articulos.tipo_operacion = "0"
			lstr_articulos.juegopantallas = ""
			lstr_articulos.coste_estimado = 0
			lstr_articulos.coste = "N"
			lstr_articulos.coste_fab = 0
			lstr_articulos.coste_mp = 0
			lstr_articulos.coste_fab_mermas = 0
			lstr_articulos.coste_mp_mermas = 0
			lstr_articulos.cod_cliente2 = ""
			lstr_articulos.promocion = "N"
			lstr_articulos.venta_conjuntos = "N"
			lstr_articulos.costilla = ""
			lstr_articulos.decimales_unidad = 0
			lstr_articulos.marcas_codigo = "0"
			lstr_articulos.submarcas_codigo = "0"
			lstr_articulos.T1 = ""
			lstr_articulos.T2 = ""
			lstr_articulos.T3 = ""
			lstr_articulos.T4 = ""
			lstr_articulos.T5 = ""
			lstr_articulos.T6 = ""
			lstr_articulos.T7 = ""
			lstr_articulos.T8 = ""
			lstr_articulos.T9 = ""
			lstr_articulos.T10 = ""
			lstr_articulos.ultimo_lote = 0
			lstr_articulos.contra_stock = "N"
			lstr_articulos.bloqueo_packing = "N"
			lstr_articulos.tono_cliente = "N"
			lstr_articulos.calibre_cliente = "N"
			lstr_articulos.ean13_sga = ""
			lstr_articulos.tipo_ubicacion = "2"
			
			if f_insert_str_articulos(lstr_articulos) then
				//Calidades por articulo
				lstr_almartcal.empresa  = lstr_articulos.empresa
				lstr_almartcal.articulo = lstr_articulos.codigo
				lstr_almartcal.calidad  = "0"
				
				li_existe_registro = 0
				
				select isnull(count(*),'')
				into   :li_existe_registro
				from   almartcal
				where  almartcal.empresa  = :lstr_almartcal.empresa 
				and    almartcal.articulo = :lstr_almartcal.articulo
				and    almartcal.calidad  = :lstr_almartcal.calidad;
				
				if li_existe_registro = 0 then
					lstr_almartcal.precio = 0
					lstr_almartcal.fecha_alta  = datetime(today())
					lstr_almartcal.stockmin    = 0
					lstr_almartcal.stockmax    = 0
					lstr_almartcal.puntopedido = 0 		
					
					if not(f_insert_str_almartcal(lstr_almartcal)) then
						lb_correcto = false
					end if
				end if 
				
				//Cajas por articulo
				lstr_almartcajas.empresa  = lstr_articulos.empresa
				lstr_almartcajas.articulo = lstr_articulos.codigo
				lstr_almartcajas.caja     = "0"
				
				li_existe_registro = 0
				
				select isnull(count(*),'')
				into   :li_existe_registro
				from   almartcajas
				where  almartcajas.empresa  = :lstr_almartcajas.empresa 
				and    almartcajas.articulo = :lstr_almartcajas.articulo
				and    almartcajas.caja     = :lstr_almartcajas.caja;
				
				if li_existe_registro = 0 then				
					lstr_almartcajas.piezascaja         = 1
					lstr_almartcajas.metroscaja         = 0
					lstr_almartcajas.metroslcaja        = 0
					lstr_almartcajas.pesocaja           = 0
					lstr_almartcajas.metros_reales_caja = 0
					lstr_almartcajas.peso_real_caja     = 0
					lstr_almartcajas.metros_reales      = 0
					lstr_almartcajas.descripcion        = ""
					lstr_almartcajas.codigo             = ""
					lstr_almartcajas.pordefecto	      = "S"	
					
					if not(f_insert_str_almartcajas(lstr_almartcajas)) then
						lb_correcto = false
					end if						
				end if
				//Palets por articulo
				
				lstr_palarticulo.empresa      = lstr_articulos.empresa
				lstr_palarticulo.articulo     = lstr_articulos.codigo
				lstr_palarticulo.codigo       = "2" 
				lstr_palarticulo.caja         = "0"
				
				li_existe_registro = 0
				
				select isnull(count(*),'')
				into   :li_existe_registro
				from   palarticulo
				where  palarticulo.empresa  = :lstr_palarticulo.empresa 
				and    palarticulo.articulo = :lstr_palarticulo.articulo
				and    palarticulo.codigo   = :lstr_palarticulo.codigo
				and    palarticulo.caja     = :lstr_palarticulo.caja;
				
				if li_existe_registro = 0 then										
					lstr_palarticulo.cajaspallet  = 5000
					lstr_palarticulo.planospallet = 1
					lstr_palarticulo.alturas      = 1
					lstr_palarticulo.pordefecto   = "S"	
					
					if not(f_insert_str_palarticulo(lstr_palarticulo)) then
						lb_correcto = false
					end if									
				end if		
				
				//Vamos a ver si tenemos cargadas las tablas art_versiones y art_escandallo
				lstr_art_versiones.empresa  = codigo_empresa 
				lstr_art_versiones.articulo = lstr_articulos.codigo
				lstr_art_versiones.version  = '1'				
				
				li_existe_registro = 0
				
				select isnull(count(*),'')
				into   :li_existe_registro
				from   art_versiones
				where  art_versiones.empresa  = :lstr_art_versiones.empresa 
				and    art_versiones.articulo = :lstr_art_versiones.articulo
				and    art_versiones.version  = :lstr_art_versiones.version;
				
				if li_existe_registro = 0 then									
					lstr_art_versiones.base            = '0'
					lstr_art_versiones.descripcion     = 'COMPRA'
					lstr_art_versiones.observaciones   = ''
					lstr_art_versiones.aprovechar_base = '' 
					lstr_art_versiones.tipo_version    = 'P'
					
					if not(f_insert_str_art_versiones(lstr_art_versiones)) then
						lb_correcto = false
					end if						
				end if
				
				lstr_art_escandallo.empresa      = codigo_empresa 
				lstr_art_escandallo.articulo     = lstr_articulos.codigo
				lstr_art_escandallo.version      = '1'				
				lstr_art_escandallo.articulo_ant = '0'
				
				li_existe_registro = 0
				
				select isnull(count(*),'')
				into   :li_existe_registro
				from   art_escandallo
				where  art_escandallo.empresa      = :lstr_art_escandallo.empresa 
				and    art_escandallo.articulo     = :lstr_art_escandallo.articulo
				and    art_escandallo.version      = :lstr_art_escandallo.version
				and    art_escandallo.articulo_ant = :lstr_art_escandallo.articulo_ant;
				
				if li_existe_registro = 0 then									
					lstr_art_escandallo.factor    = 1
					lstr_art_escandallo.aprovecha = ''
					
					if not(f_insert_str_art_escandallo(lstr_art_escandallo)) then
						lb_correcto = false
					end if						
				end if													
				
			else
				lb_correcto = false
			end if
						
			update venmprima
			set    venmprima.control_almacen = 'N'
			where  venmprima.empresa = :codigo_empresa
			and    venmprima.codigo  = :ls_codigo_compras;
			
			if sqlca.sqlcode <> 0 then
				lb_correcto = false
			end if
			
			if lb_correcto then
				commit;
				if ll_indice = ll_total then
					messagebox("¡Correcto!","Proceso finalizado.")
				end if
			else
				rollback;
				messagebox("¡Error!","No se ha podido grabar el articulo en ventas.")
			end if
		end if
	next
	
	destroy ds_datos
end if
end event

