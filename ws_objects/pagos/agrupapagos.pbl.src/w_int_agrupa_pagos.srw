$PBExportHeader$w_int_agrupa_pagos.srw
forward
global type w_int_agrupa_pagos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_int_agrupa_pagos
end type
type cb_consulta from u_boton within w_int_agrupa_pagos
end type
type pb_imprimir_preli from picturebutton within w_int_agrupa_pagos
end type
type dw_listado from datawindow within w_int_agrupa_pagos
end type
type uo_tipodoc from u_marca_lista within w_int_agrupa_pagos
end type
type uo_proveedor from u_em_campo_2 within w_int_agrupa_pagos
end type
type cb_2 from u_boton within w_int_agrupa_pagos
end type
type gb_cuenta from groupbox within w_int_agrupa_pagos
end type
type dw_no_agrupados from datawindow within w_int_agrupa_pagos
end type
type dw_agrupados from u_datawindow within w_int_agrupa_pagos
end type
type cb_agrupar from u_boton within w_int_agrupa_pagos
end type
type cb_desagrupar from u_boton within w_int_agrupa_pagos
end type
type gb_2 from groupbox within w_int_agrupa_pagos
end type
end forward

global type w_int_agrupa_pagos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 3634
integer height = 2116
pb_2 pb_2
cb_consulta cb_consulta
pb_imprimir_preli pb_imprimir_preli
dw_listado dw_listado
uo_tipodoc uo_tipodoc
uo_proveedor uo_proveedor
cb_2 cb_2
gb_cuenta gb_cuenta
dw_no_agrupados dw_no_agrupados
dw_agrupados dw_agrupados
cb_agrupar cb_agrupar
cb_desagrupar cb_desagrupar
gb_2 gb_2
end type
global w_int_agrupa_pagos w_int_agrupa_pagos

type variables
datetime vto_agrupado
string      moneda_agrupado
end variables

forward prototypes
public function string f_filtro ()
public subroutine f_cargar ()
public subroutine f_agrupar ()
public subroutine f_desagrupar ()
end prototypes

public function string f_filtro ();Integer numero,x2
String filtro,filtro1

filtro = ""
numero = uo_tipodoc.dw_marca.RowCount()
IF  numero =0 Then return ""
FOR x2 = 1 To numero
   	IF uo_tipodoc.dw_marca.GetItemString(x2,"marca") = "S" THEN
      	IF Trim(filtro) = "" Then
         	filtro1 = " tipodoc = '" + uo_tipodoc.dw_marca.GetItemString(x2,"codigo") + "'"
      	Else
         	filtro1 = " Or tipodoc = '" + uo_tipodoc.dw_marca.GetItemString(x2,"codigo") + "'"
      	End If
      	filtro = filtro  + filtro1
  		END IF
	NEXT

return filtro
end function

public subroutine f_cargar ();String proveedor

uo_tipodoc.visible   = FALSE

dw_no_agrupados.SetTransObject(sqlca)
dw_no_agrupados.SetFilter("")
dw_no_agrupados.Filter()
dw_no_agrupados.SetFilter(f_filtro())
dw_no_agrupados.Filter()

if trim(uo_proveedor.em_codigo.text) <> "" then
	proveedor = uo_proveedor.em_codigo.text
	dw_no_agrupados.Retrieve(codigo_empresa,proveedor,"0")
	dw_agrupados.Retrieve(codigo_empresa,proveedor,"0")
	cb_agrupar.enabled    = false
	cb_desagrupar.enabled = false
else
	messagebox("Atención","Debe seleccionar un Proveedor.")
End if


end subroutine

public subroutine f_agrupar ();long    indice,total,anyo_primero,orden_primero
dec     total_importe,total_divisas
boolean bien = true
str_carpagos carpagos
str_carpagosdetagrupado detagrupado

total = dw_no_agrupados.rowcount()
anyo_primero  = 0
orden_primero = 0
total_importe = 0
total_divisas = 0
for indice = 1 to total
	if dw_no_agrupados.object.agrupar[indice] = "S" then
		total_importe = total_importe + dw_no_agrupados.object.importe[indice]
		total_divisas = total_divisas + dw_no_agrupados.object.divisas[indice]
		if anyo_primero = 0 and orden_primero = 0 then
			anyo_primero  = dw_no_agrupados.object.anyo[indice]
			orden_primero = dw_no_agrupados.object.orden[indice]
			
			SELECT carpagos.fvto, 				carpagos.fpago, 		 	carpagos.moneda,
					 carpagos.banco, 				carpagos.proveedor,		carpagos.tipodoc,
					 carpagos.codpago, 			carpagos.situacion,	 	carpagos.cuenta,
					 carpagos.femi, 				carpagos.num_talon,	 	carpagos.asignar_banco,
					 carpagos.tipodoc_pago, 	carpagos.punteado, 		carpagos.concepto,
					 carpagos.observaciones
			INTO   :carpagos.fvto, 				:carpagos.fpago, 		 	:carpagos.moneda,
					 :carpagos.banco, 			:carpagos.proveedor,		:carpagos.tipodoc,
					 :carpagos.codpago, 			:carpagos.situacion,	 	:carpagos.cuenta,
					 :carpagos.femi, 				:carpagos.num_talon,	 	:carpagos.asignar_banco,
					 :carpagos.tipodoc_pago, 	:carpagos.punteado,		:carpagos.concepto,
					 :carpagos.observaciones
			FROM 	 carpagos
			WHERE  empresa = :codigo_empresa
			AND    anyo    = :anyo_primero
			AND	 orden   = :orden_primero;
			
			if sqlca.sqlcode <> 0 then
				bien = false
			end if		
						
		end if
	end if
next

carpagos.anyo = year(today())

Select  Max(carpagos.orden)
Into 	  :carpagos.orden
From	  carpagos
Where   carpagos.empresa = :codigo_empresa
And     carpagos.anyo    = :carpagos.anyo ;

if isnull(carpagos.orden) then carpagos.orden = 0
carpagos.orden ++

carpagos.empresa  = codigo_empresa
carpagos.anyofra  = year(today())
carpagos.fra      = "AGRUPADO"
carpagos.recibo   = 1
carpagos.ffra     = datetime(today())
carpagos.importe  = total_importe
carpagos.divisas  = total_divisas
if total_divisas <> 0 then
	carpagos.cambio = total_divisas / total_importe
else
	carpagos.cambio = 1
end if	
carpagos.punteado = "N"
carpagos.agrupado = "S"
//Grabamos el efecto agrupado
IF Not f_insert_carpagos(carpagos) Then 
	bien  = false
end if
//Pasamos todos los efectos de carpagos a carpagosdetagrupado
detagrupado.empresa        = codigo_empresa
detagrupado.anyo_agrupado  = carpagos.anyo
detagrupado.orden_agrupado = carpagos.orden

for indice = 1 to total
	if dw_no_agrupados.object.agrupar[indice] = "S" then
		
		detagrupado.anyo    = dw_no_agrupados.object.anyo[indice]
		detagrupado.orden   = dw_no_agrupados.object.orden[indice]
		SELECT anyofra, 								fra, 								recibo,
		       ffra, 									fvto, 							fpago, 
				 importe, 								divisas, 						moneda, 
				 banco, 									proveedor, 						tipodoc, 
				 codpago, 								situacion, 						cuenta, 
				 femi, 									num_talon, 						asignar_banco, 
				 tipodoc_pago, 						cambio, 							punteado,
				 concepto,								observaciones
		INTO   :detagrupado.anyofra, 				:detagrupado.fra, 			:detagrupado.recibo,
				 :detagrupado.ffra, 					:detagrupado.fvto, 			:detagrupado.fpago,
				 :detagrupado.importe, 				:detagrupado.divisas, 		:detagrupado.moneda,
				 :detagrupado.banco, 				:detagrupado.proveedor, 	:detagrupado.tipodoc,
				 :detagrupado.codpago, 				:detagrupado.situacion, 	:detagrupado.cuenta,
				 :detagrupado.femi, 					:detagrupado.num_talon, 	:detagrupado.asignar_banco, 
				 :detagrupado.tipodoc_pago, 		:detagrupado.cambio, 		:detagrupado.punteado, 
				 :detagrupado.concepto,				:detagrupado.observaciones
		FROM 	 carpagos
		WHERE  empresa = :codigo_empresa
		AND    anyo    = :detagrupado.anyo
		AND	 orden   = :detagrupado.orden;
		
		if sqlca.sqlcode <> 0 then
			bien = false
		else
			if not(f_insert_carpagosdetagrupado(detagrupado)) then
				bien = false
			else
				delete carpagos
				where  empresa = :codigo_empresa
				and    anyo    = :detagrupado.anyo
				and	 orden   = :detagrupado.orden;
		
				if sqlca.sqlcode <> 0 then
					bien = false
				end if				
			end if
		end if		
	end if
next

if bien then 
	commit;
else
	rollback;
	messagebox("Atención","Se ha producido un error al agrupar.")
end if

end subroutine

public subroutine f_desagrupar ();string  sel
long    anyo_agrupado,orden_agrupado,indice,total
boolean bien = true
datastore detalle

str_carpagos carpagos

anyo_agrupado  = dw_agrupados.object.anyo[dw_agrupados.GetSelectedRow(0)]
orden_agrupado = dw_agrupados.object.orden[dw_agrupados.GetSelectedRow(0)]

sel = "select anyo,orden "+&
		"from carpagosdetagrupado "+&
		"where empresa = '"+codigo_empresa+"' "+&
		"and   anyo_agrupado = "+string(anyo_agrupado,"####")+" "+&
		"and   orden_agrupado = "+string(orden_agrupado,"########")

detalle = f_cargar_cursor(sel)

total = detalle.rowcount()
carpagos.empresa  = codigo_empresa
carpagos.agrupado = "N"

for indice = 1 to total
	carpagos.anyo  = detalle.object.anyo[indice]	
	carpagos.orden = detalle.object.orden[indice]	
	
	select anyofra, 							fra, 								recibo, 
			 ffra, 								fvto, 							fpago, 
			 importe, 							divisas, 						moneda, 
			 banco, 								proveedor, 						tipodoc, 
			 codpago, 							situacion, 						cuenta, 
			 femi, 								num_talon, 						asignar_banco, 
			 tipodoc_pago, 					cambio, 							punteado, 
			 concepto,							observaciones
	into   :carpagos.anyofra, 				:carpagos.fra, 				:carpagos.recibo, 
			 :carpagos.ffra, 					:carpagos.fvto, 				:carpagos.fpago,
			 :carpagos.importe, 				:carpagos.divisas, 			:carpagos.moneda, 
			 :carpagos.banco, 				:carpagos.proveedor, 		:carpagos.tipodoc, 
			 :carpagos.codpago, 				:carpagos.situacion, 		:carpagos.cuenta,
			 :carpagos.femi, 					:carpagos.num_talon, 		:carpagos.asignar_banco,
			 :carpagos.tipodoc_pago, 		:carpagos.cambio, 			:carpagos.punteado, 
			 :carpagos.concepto,				:carpagos.observaciones 			
	from   carpagosdetagrupado			 
	where  empresa = :codigo_empresa
	and    anyo    = :carpagos.anyo
	and    orden   = :carpagos.orden;
	
	if sqlca.sqlcode <> 0 then
		bien = false
	else
		IF Not f_insert_carpagos(carpagos) Then 
			bien  = false
		else
			delete carpagosdetagrupado
			where  empresa = :codigo_empresa
			and    anyo    = :carpagos.anyo
			and    orden   = :carpagos.orden;		
			
			if sqlca.sqlcode <> 0 then
				bien = false
			end if					
		end if
	end if
next

delete carpagos
where  empresa = :codigo_empresa
and    anyo    = :anyo_agrupado
and    orden   = :orden_agrupado;		

if sqlca.sqlcode <> 0 then
	bien = false
end if		


if bien then 
	commit;
else
	rollback;
	messagebox("Atención","Se ha producido un error al desagrupar.")
end if

end subroutine

event open;call super::open;Integer x2,registros2 
String var_codigo2,var_texto2,marca2
DataStore dw_comodin

This.title = "GESTIÓN DE PAGOS AGRUPADOS POR PROVEEDOR"

dw_no_agrupados.SetTransObject(sqlca)
dw_agrupados.SetTransObject(sqlca)

dw_comodin = f_cargar_cursor("Select tipodoc,texto from cartipodoc where empresa = '"+codigo_empresa+"'")
registros2 = dw_comodin.RowCOunt()
If registros2 > 0 THEN
	FOR x2 = 1 To registros2
		var_codigo2 = dw_comodin.GetItemString(x2,"tipodoc")
		var_texto2  = dw_comodin.GetItemString(x2,"texto")
		marca2      = "S"
		uo_tipodoc.dw_marca.InsertRow(x2)
		uo_tipodoc.dw_marca.setitem(x2,"marca",marca2)
		uo_tipodoc.dw_marca.setitem(x2,"codigo",var_codigo2)
		uo_tipodoc.dw_marca.setitem(x2,"texto",var_texto2)
	NEXT
END IF
uo_tipodoc.st_titulo1.text = "Tipo Doc."
uo_tipodoc.st_titulo2.text = "Descripcion"

Destroy dw_comodin
setnull(vto_agrupado)
moneda_agrupado = ""
f_activar_campo(uo_proveedor.em_campo)


end event

on w_int_agrupa_pagos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.cb_consulta=create cb_consulta
this.pb_imprimir_preli=create pb_imprimir_preli
this.dw_listado=create dw_listado
this.uo_tipodoc=create uo_tipodoc
this.uo_proveedor=create uo_proveedor
this.cb_2=create cb_2
this.gb_cuenta=create gb_cuenta
this.dw_no_agrupados=create dw_no_agrupados
this.dw_agrupados=create dw_agrupados
this.cb_agrupar=create cb_agrupar
this.cb_desagrupar=create cb_desagrupar
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.cb_consulta
this.Control[iCurrent+3]=this.pb_imprimir_preli
this.Control[iCurrent+4]=this.dw_listado
this.Control[iCurrent+5]=this.uo_tipodoc
this.Control[iCurrent+6]=this.uo_proveedor
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.gb_cuenta
this.Control[iCurrent+9]=this.dw_no_agrupados
this.Control[iCurrent+10]=this.dw_agrupados
this.Control[iCurrent+11]=this.cb_agrupar
this.Control[iCurrent+12]=this.cb_desagrupar
this.Control[iCurrent+13]=this.gb_2
end on

on w_int_agrupa_pagos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.cb_consulta)
destroy(this.pb_imprimir_preli)
destroy(this.dw_listado)
destroy(this.uo_tipodoc)
destroy(this.uo_proveedor)
destroy(this.cb_2)
destroy(this.gb_cuenta)
destroy(this.dw_no_agrupados)
destroy(this.dw_agrupados)
destroy(this.cb_agrupar)
destroy(this.cb_desagrupar)
destroy(this.gb_2)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_int_agrupa_pagos
integer taborder = 0
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_int_agrupa_pagos
integer x = 55
end type

type st_empresa from w_int_con_empresa`st_empresa within w_int_agrupa_pagos
integer width = 2642
end type

type pb_2 from upb_salir within w_int_agrupa_pagos
integer x = 3502
integer width = 110
integer height = 100
integer taborder = 0
end type

type cb_consulta from u_boton within w_int_agrupa_pagos
integer x = 2290
integer y = 152
integer width = 274
integer height = 104
integer taborder = 40
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Consulta"
end type

event clicked;f_cargar()
f_activar_campo(uo_proveedor.em_campo)

end event

type pb_imprimir_preli from picturebutton within w_int_agrupa_pagos
integer x = 3177
integer y = 152
integer width = 123
integer height = 104
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string pointer = "\bmp\MANO.CUR"
string picturename = "print!"
end type

event clicked;f_cargar()
f_imprimir_datawindow(dw_listado)
f_activar_campo(uo_proveedor.em_campo)
end event

type dw_listado from datawindow within w_int_agrupa_pagos
boolean visible = false
integer y = 24
integer width = 379
integer height = 112
string dataobject = "report_con_pagos_proveedor"
boolean livescroll = true
end type

type uo_tipodoc from u_marca_lista within w_int_agrupa_pagos
boolean visible = false
integer x = 942
integer y = 264
integer width = 1349
integer height = 656
boolean border = false
end type

on uo_tipodoc.destroy
call u_marca_lista::destroy
end on

type uo_proveedor from u_em_campo_2 within w_int_agrupa_pagos
event destroy ( )
integer x = 357
integer y = 164
integer width = 1623
integer taborder = 10
boolean border = true
borderstyle borderstyle = stylelowered!
end type

on uo_proveedor.destroy
call u_em_campo_2::destroy
end on

event getfocus;call super::getfocus;ue_titulo = "Selección de Proveedores"
ue_datawindow ="dw_ayuda_proveedores"

end event

event modificado;uo_proveedor.em_campo.text = f_razon_genter(codigo_empresa,"P",uo_proveedor.em_codigo.text)
If Trim(uo_proveedor.em_campo.text)="" then
	uo_proveedor.em_campo.text=""
	uo_proveedor.em_codigo.text=""
	Return
end if 


end event

type cb_2 from u_boton within w_int_agrupa_pagos
event clicked pbm_bnclicked
integer x = 2016
integer y = 152
integer width = 274
integer height = 104
integer taborder = 0
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Arial"
string text = "&Tipo Doc."
end type

event clicked;uo_tipodoc.visible = not(uo_tipodoc.visible)

end event

type gb_cuenta from groupbox within w_int_agrupa_pagos
integer x = 338
integer y = 112
integer width = 1664
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 12632256
string text = "Proveedor"
end type

type dw_no_agrupados from datawindow within w_int_agrupa_pagos
integer x = 334
integer y = 272
integer width = 2985
integer height = 828
boolean titlebar = true
string title = "Pagos no Agrupados"
string dataobject = "dw_int_agrupa_pagos1"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param)
End If
end event

event itemchanged;datetime fvto
long     indice,total,marcados
string   moneda
if dwo.name = "agrupar" then
	if data = "S" then
		fvto   = this.object.fvto[row]
		moneda = this.object.moneda[row]
		
		if isnull(vto_agrupado) then
			vto_agrupado    = fvto
			moneda_agrupado = moneda
		else
			if vto_agrupado <> fvto then
				messagebox("Atención","Todos los pagos a agrupar deben vencer en la misma fecha.")				
				return 2
			else
				if moneda <> moneda_agrupado then 
					messagebox("Atención","Todos los pagos a agrupar deben tener la misma moneda.")				
					return 2
				else					
					cb_agrupar.enabled = true
				end if
			end if
		end if
	else
		marcados = 0
		total = this.rowcount()
		for indice = 1 to total
			if this.object.agrupar[indice] = "S" then
				marcados ++
			end if
		next
		if marcados <= 2 then
			setnull(vto_agrupado)
			moneda_agrupado = ""
			cb_agrupar.enabled = false
		end if
	end if
end if
end event

type dw_agrupados from u_datawindow within w_int_agrupa_pagos
integer x = 334
integer y = 1104
integer width = 2985
integer height = 740
integer taborder = 30
boolean bringtotop = true
boolean titlebar = true
string title = "Pagos Agrupados"
string dataobject = "dw_int_agrupa_pagos2"
borderstyle borderstyle = styleraised!
end type

event rbuttondown;call super::rbuttondown;long anyo,orden

if row > 0 then
	anyo  = this.object.anyo[row]
	orden = this.object.orden[row]
	f_muestra_detalle_pago_agrupado(anyo,orden,ypos + this.y + parent.y)
end if
end event

event clicked;call super::clicked;if row > 0 then
	this.selectrow(0,false)
	this.selectrow(row,true)
	cb_desagrupar.enabled = true
end if
end event

event doubleclicked;str_parametros lstr_param

IF Row <> 0 Then
  lstr_param.i_nargumentos=3
  lstr_param.s_argumentos[2]=String(This.GetItemNumber(Row,"anyo"))
  lstr_param.s_argumentos[3]=String(This.GetItemNumber(Row,"orden"))
  OpenWithParm(wi_mant_carpagos,lstr_param)
End If
end event

type cb_agrupar from u_boton within w_int_agrupa_pagos
integer x = 2565
integer y = 152
integer width = 274
integer height = 104
integer taborder = 20
boolean enabled = false
string text = "&Agrupar"
end type

event clicked;if messagebox("Confirmación","¿Desea agrupar los pagos marcados?",Question!,YesNo!,2) = 1 then
	f_agrupar()
	f_cargar()
	f_activar_campo(uo_proveedor.em_campo)
end if

end event

type cb_desagrupar from u_boton within w_int_agrupa_pagos
integer x = 2839
integer y = 152
integer width = 338
integer height = 104
integer taborder = 40
boolean enabled = false
string text = "&Desagrupar"
end type

event clicked;if messagebox("Confirmación","¿Desea desagrupar el pago seleccionado?",Question!,YesNo!,2) = 1 then
	f_desagrupar()
	f_cargar()
	f_activar_campo(uo_proveedor.em_campo)
end if

end event

type gb_2 from groupbox within w_int_agrupa_pagos
integer x = 2002
integer y = 112
integer width = 1312
integer height = 156
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

