$PBExportHeader$w_mant_conta_bal_grup.srw
forward
global type w_mant_conta_bal_grup from wi_mvent_con_empresa
end type
type pb_calculadora from u_calculadora within w_mant_conta_bal_grup
end type
type tab_1 from tab within w_mant_conta_bal_grup
end type
type tabpage_1 from userobject within tab_1
end type
type uo_ejercicio_ctas_resultados from u_ejercicio within tabpage_1
end type
type dw_conta_bal_grup_ctas from u_datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
uo_ejercicio_ctas_resultados uo_ejercicio_ctas_resultados
dw_conta_bal_grup_ctas dw_conta_bal_grup_ctas
end type
type tabpage_2 from userobject within tab_1
end type
type dw_grupos_totaliza from u_datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_grupos_totaliza dw_grupos_totaliza
end type
type tab_1 from tab within w_mant_conta_bal_grup
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
type uo_balance from u_em_campo_2 within w_mant_conta_bal_grup
end type
type gb_22 from groupbox within w_mant_conta_bal_grup
end type
end forward

global type w_mant_conta_bal_grup from wi_mvent_con_empresa
integer width = 3643
integer height = 2520
pb_calculadora pb_calculadora
tab_1 tab_1
uo_balance uo_balance
gb_22 gb_22
end type
global w_mant_conta_bal_grup w_mant_conta_bal_grup

type variables

boolean ib_actualizar_orden_absoluto = false

string  is_filtro

DataStore ids_centros,ids_centros2

end variables

event ue_activa_claves;call super::ue_activa_claves;pb_calculadora.visible = TRUE
uo_balance.enabled = true

end event

event open;call super::open;istr_parametros.s_titulo_ventana  = "Mantenimiento de Grupos de Balances"

//	istr_parametros.s_listado         = "report_empleados"

This.title = istr_parametros.s_titulo_ventana

tab_1.tabpage_1.dw_conta_bal_grup_ctas.settransobject(sqlca)

tab_1.tabpage_2.dw_grupos_totaliza.settransobject(sqlca)

tab_1.tabpage_1.uo_ejercicio_ctas_resultados.em_ejercicio.text = "0"

// Si recibo el codigo lo visualizo

IF istr_parametros.i_nargumentos>1 THEN

	sle_valor.text=istr_parametros.s_argumentos[2]

	IF Trim(sle_valor.text)<>"" and Not IsNull(sle_valor.text) Then

		dw_1.Retrieve(codigo_empresa,sle_valor.Text)

		tab_1.tabpage_1.dw_conta_bal_grup_ctas.Retrieve(codigo_empresa,sle_valor.Text)

		tab_1.tabpage_2.dw_grupos_totaliza.Retrieve(codigo_empresa,sle_valor.Text)

	END IF

END IF

end event

event ue_desactiva_claves;call super::ue_desactiva_claves;pb_calculadora.visible = false
uo_balance.enabled = false

end event

event ue_inserta_fila;call super::ue_inserta_fila;string ls_balance

ls_balance = uo_balance.em_codigo.text

dw_1.object.empresa[dw_1.getrow()]               = codigo_empresa
dw_1.object.conta_bal_cab_codigo[dw_1.getrow()]  = ls_balance
dw_1.object.codigo[dw_1.getrow()]                = sle_valor.text
dw_1.object.descripcion[dw_1.getrow()]           = ""
dw_1.object.descripcion_abr[dw_1.getrow()]       = ""
dw_1.object.conta_bal_grup_codigo[dw_1.getrow()] = ""
dw_1.object.conta_bal_grup_codigo_calc_po[dw_1.getrow()] = ""

int li_orden

select max(orden)
into   :li_orden
from   conta_bal_grup
where  empresa = :codigo_empresa
and    conta_bal_cab_codigo  = :ls_balance
and    conta_bal_grup_codigo = '';

if isnull(li_orden) then li_orden = 0

li_orden ++

dw_1.object.orden[dw_1.getrow()] = li_orden

end event

event ue_recuperar;
// Valores Para Funcion de bloqueo

titulo        =  This.title
longitud      =  len(trim(codigo_empresa))
criterio[1]   =  trim(codigo_empresa)+ space(20-longitud)
longitud      =  len(trim(uo_balance.em_codigo.text))
criterio[2]   =  trim(uo_balance.em_codigo.text)+space(20-longitud)
longitud      =  len(trim(sle_valor.text))
criterio[3]   =  trim(sle_valor.text)+space(20-longitud)
seleccion     =  criterio[1]+criterio[2]+criterio[3]
tabla         =  "conta_bal_grup"

dw_1.Retrieve(codigo_empresa,uo_balance.em_codigo.text,sle_valor.Text)
tab_1.tabpage_1.dw_conta_bal_grup_ctas.Retrieve(codigo_empresa,uo_balance.em_codigo.text,sle_valor.Text)
tab_1.tabpage_2.dw_grupos_totaliza.Retrieve(codigo_empresa,uo_balance.em_codigo.text,sle_valor.Text)

CALL Super::ue_recuperar

end event

on w_mant_conta_bal_grup.create
int iCurrent
call super::create
this.pb_calculadora=create pb_calculadora
this.tab_1=create tab_1
this.uo_balance=create uo_balance
this.gb_22=create gb_22
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_calculadora
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.uo_balance
this.Control[iCurrent+4]=this.gb_22
end on

on w_mant_conta_bal_grup.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_calculadora)
destroy(this.tab_1)
destroy(this.uo_balance)
destroy(this.gb_22)
end on

event ue_actualiza_dw;string ls_error

if tab_1.tabpage_1.dw_conta_bal_grup_ctas.update() = -1 then

	ls_error = sqlca.sqlerrtext

	rollback;

	messagebox("Atención","Se ha producido un error al actualizar las cuentas del grupo~n"+ls_error)

else

	if tab_1.tabpage_2.dw_grupos_totaliza.update() = -1 then

		ls_error = sqlca.sqlerrtext

		rollback;

		messagebox("Atención","Se ha producido un error al actualizar las cuentas de gastos~n"+ls_error)

	else

		call super::ue_actualiza_dw

	end if

end if

end event

event ue_borra_fila;

boolean no_valido = false

string ls_grupo,ls_codigo_cos_centro, mensaje_error

long l



ls_grupo = sle_valor.text



// Borrado de la fila en curso



dw_1.DeleteRow( dw_1.GetRow() )



tab_1.tabpage_1.dw_conta_bal_grup_ctas.setfilter("")

tab_1.tabpage_1.dw_conta_bal_grup_ctas.filter()

	

for l = 1 to tab_1.tabpage_1.dw_conta_bal_grup_ctas.rowcount()

	

	tab_1.tabpage_1.dw_conta_bal_grup_ctas.deleterow(l)

	

next



if tab_1.tabpage_1.dw_conta_bal_grup_ctas.update() = -1 then

	rollback;

	messagebox("Atención","Se ha producido un error al actualizar las cuentas")

else

	for l = 1 to tab_1.tabpage_2.dw_grupos_totaliza.rowcount()

		

		tab_1.tabpage_2.dw_grupos_totaliza.deleterow(l)

		

	next

	

	if tab_1.tabpage_2.dw_grupos_totaliza.update() = -1 then

		rollback;

		messagebox("Atención","Se ha producido un error al actualizar los grupos totalizados")

	else

		commit;

	end if

end if

		

if no_valido then

	messagebox("Atención",mensaje_error)		

//	return 2

//	dw_1.setrow(dw_1.GetRow())

//	dw_1.setcolumn("sle_valor")

else

	ib_actualizar_orden_absoluto = true

end if

end event

event closequery;call super::closequery;string ls_grupos[],ls_sel,ls_balance
long   ll_indice,ll_total
datastore ds_datos

if ib_actualizar_orden_absoluto or 1 = 1 then
	ls_sel = "select codigo from conta_bal_cab where empresa = '"+codigo_empresa+"'"
	
	ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)
	
	for ll_indice = 1 to ll_total
		ls_balance = ds_datos.object.codigo[ll_indice]
		f_asigna_orden_absoluto_conta_bal_grup(codigo_empresa,ls_balance,'',ls_grupos)
	next
	destroy ds_datos

end if



Return 0

end event

type dw_1 from wi_mvent_con_empresa`dw_1 within w_mant_conta_bal_grup
integer x = 14
integer y = 228
integer width = 3113
integer height = 672
string dataobject = "dw_mant_conta_bal_grup"
end type

event dw_1::rbuttondown;bus_datawindow = ""

bus_filtro     = ""

valor_empresa  = TRUE	

bus_titulo     = ""

bus_campo      = This.GetColumnName()

CHOOSE CASE bus_campo

	CASE "conta_bal_grup_codigo"

 		bus_datawindow = "dw_ayuda_conta_bal_grup"

		bus_titulo = "AYUDA SELECCION DE GRUPOS DE CTA DE RESULT"

		bus_filtro = "codigo <> '"+this.object.codigo[row]+"'"

	CASE "conta_bal_grup_calcular_por"

 		bus_datawindow = "dw_ayuda_conta_bal_grup"

		bus_titulo = "AYUDA SELECCION DE GRUPOS DE CTA DE RESULT"

		bus_filtro = ""		

END CHOOSE



call super::rbuttondown

end event

event dw_1::key;bus_datawindow = ""
bus_filtro     = ""
valor_empresa  = TRUE	
bus_titulo     = ""
bus_campo      = This.GetColumnName()

CHOOSE CASE bus_campo

	CASE "conta_bal_grup_codigo"
 		bus_datawindow = "dw_ayuda_conta_bal_grup"
		bus_titulo = "AYUDA SELECCION DE GRUPOS DE CTA DE RESULT"
		bus_filtro = "codigo <> '"+this.object.codigo[this.getrow()]+"' and conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"'"

	CASE "conta_bal_grup_calcular_por"
 		bus_datawindow = "dw_ayuda_conta_bal_grup"
		bus_titulo = "AYUDA SELECCION DE GRUPOS DE CTA DE RESULT"
		bus_filtro = "conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"'"		

END CHOOSE



call super::key

end event

event dw_1::clicked;call super::clicked;long  ll_color_escogido,custom[],ll_color

if isvalid(dwo) then
	if dwo.name = "cb_color_texto" then
		ll_color_escogido = 255
		if ChooseColor(ll_color_escogido, custom [ ] ) = 1 then
			this.object.color_texto[row] = ll_color_escogido
		end if
	end if
	
	if dwo.name = "cb_color_fondo" then
		ll_color_escogido = 255
		if ChooseColor(ll_color_escogido, custom [ ] ) = 1 then
			this.object.color_fondo[row] = ll_color_escogido
		end if
	end if
end if
end event

event dw_1::itemchanged;call super::itemchanged;int li_orden
string ls_conta_bal_grup_codigo,ls_balance



if dwo.name = "conta_bal_grup_codigo" then
	//asignamos el orden dentro del grupo
	ls_balance               = uo_balance.em_codigo.text
	ls_conta_bal_grup_codigo = data

	select max(orden)
	into   :li_orden
	from   conta_bal_grup
	where  empresa = :codigo_empresa
	and    conta_bal_cab_codigo  = :ls_balance
	and    conta_bal_grup_codigo = :ls_conta_bal_grup_codigo;

	if isnull(li_orden) then li_orden = 0
	li_orden ++

	this.object.orden[row] = li_orden

end if

end event

type st_1 from wi_mvent_con_empresa`st_1 within w_mant_conta_bal_grup
integer x = 2560
integer y = 132
integer width = 187
string text = "Grupo:"
end type

type cb_insertar from wi_mvent_con_empresa`cb_insertar within w_mant_conta_bal_grup
integer x = 3141
integer y = 228
end type

event cb_insertar::clicked;//String descrip
//
//descrip = dw_1.GetItemString(dw_1.GetRow(),"descripcion")
//
//if IsNull(descrip) or Trim(descrip) = "" then
//	f_mensaje("Guardar datos de la Aplicación","Ha de introducir la descripción de la aplicación")
//	dw_1.SetFocus()
//	return
//end if

tab_1.tabpage_1.dw_conta_bal_grup_ctas.accepttext()
tab_1.tabpage_2.dw_grupos_totaliza.accepttext()

Call super::clicked

end event

type cb_borrar from wi_mvent_con_empresa`cb_borrar within w_mant_conta_bal_grup
integer x = 3141
integer y = 336
end type

type sle_valor from wi_mvent_con_empresa`sle_valor within w_mant_conta_bal_grup
integer x = 2752
integer y = 128
end type

event sle_valor::getfocus;call super::getfocus;ue_datawindow  = "dw_ayuda_conta_bal_grup"
ue_titulo      = "AYUDA SELECCION DE GRUPOS DE BALANCE"
ue_filtro      = "conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"'"

end event

type cb_salir from wi_mvent_con_empresa`cb_salir within w_mant_conta_bal_grup
integer x = 3141
integer y = 444
end type

type control_tabulador from wi_mvent_con_empresa`control_tabulador within w_mant_conta_bal_grup
end type

type p_logotencer from wi_mvent_con_empresa`p_logotencer within w_mant_conta_bal_grup
end type

type st_empresa from wi_mvent_con_empresa`st_empresa within w_mant_conta_bal_grup
integer width = 2437
end type

type pb_calculadora from u_calculadora within w_mant_conta_bal_grup
integer x = 3013
integer y = 120
integer taborder = 0
end type

event clicked;call super::clicked;long ll_codigo
string ls_balance

ls_balance = uo_balance.em_codigo.text

if not(cb_insertar.enabled) and ls_balance <> "" then

  Select max(convert(int,conta_bal_grup.codigo))
  Into   :ll_codigo
  From   conta_bal_grup
  Where  conta_bal_grup.empresa = :codigo_empresa
  and    conta_bal_grup.conta_bal_cab_codigo = :ls_balance;

  if isnull(ll_codigo) then ll_codigo = 0

  ll_codigo ++

  sle_valor.text = string(ll_codigo)

  dw_1.triggerEvent("clicked")

end if



  

end event

type tab_1 from tab within w_mant_conta_bal_grup
event create ( )
event destroy ( )
integer x = 14
integer y = 900
integer width = 3611
integer height = 1508
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 12632256
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3575
integer height = 1392
long backcolor = 12632256
string text = "Cuentas Centros"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
uo_ejercicio_ctas_resultados uo_ejercicio_ctas_resultados
dw_conta_bal_grup_ctas dw_conta_bal_grup_ctas
end type

on tabpage_1.create
this.uo_ejercicio_ctas_resultados=create uo_ejercicio_ctas_resultados
this.dw_conta_bal_grup_ctas=create dw_conta_bal_grup_ctas
this.Control[]={this.uo_ejercicio_ctas_resultados,&
this.dw_conta_bal_grup_ctas}
end on

on tabpage_1.destroy
destroy(this.uo_ejercicio_ctas_resultados)
destroy(this.dw_conta_bal_grup_ctas)
end on

type uo_ejercicio_ctas_resultados from u_ejercicio within tabpage_1
event destroy ( )
boolean visible = false
integer y = 8
integer taborder = 50
end type

on uo_ejercicio_ctas_resultados.destroy
call u_ejercicio::destroy
end on

event destructor;call super::destructor;//modified tab_1.tabpage_1.dw_conta_bal_grup_ctas.event retrieveend(tab_1.tabpage_1.dw_conta_bal_grup_ctas.rowcount())
end event

type dw_conta_bal_grup_ctas from u_datawindow within tabpage_1
integer x = 5
integer y = 104
integer width = 1678
integer height = 1284
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Cuentas Centro"
string dataobject = "dw_mant_conta_bal_grup1"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long donde,indice,total,ll_ejercicio,ll_orden
string ls_conta_bal_cab_codigo,ls_datos[],ls_orden_max

choose case f_objeto_datawindow(this)
	case "insertar"
		if cb_insertar.enabled then	
			if dw_1.getrow() = 1 then
				if dw_1.object.gpo_de_ultimo_nivel[dw_1.getrow()] = 'S' then
					ls_conta_bal_cab_codigo = uo_balance.em_codigo.text
				else
					ls_conta_bal_cab_codigo = ""
				end if			

				if ls_conta_bal_cab_codigo <> "" then 

					ll_ejercicio = dec(tab_1.tabpage_1.uo_ejercicio_ctas_resultados.em_ejercicio.text)
					ls_orden_max = this.describe("evaluate('max( if(conta_bal_cab_codigo = ~""+ls_conta_bal_cab_codigo+"~" and ejercicio = "+string(ll_ejercicio,"###0")+", orden , 0 ) for all )',1)")
					ll_orden     = dec(ls_orden_max) +1

					total    = this.rowcount()

					donde = this.insertrow(total +1)

					this.object.empresa[donde]               = codigo_empresa			
					this.object.conta_bal_grup_codigo[donde] = sle_valor.text
					this.object.conta_bal_cab_codigo[donde]  = ls_conta_bal_cab_codigo
					this.object.ejercicio[donde]             = ll_ejercicio
					this.object.contaplan_cuenta[donde]      = ""
					this.object.orden[donde]                 = ll_orden
					this.setrow(donde)
					this.scrolltorow(donde)
					this.setcolumn("contaplan_cuenta")

				end if

			else
				messagebox("Atención","Solo se pueden añadir cuentas en grupos de ultimo nivel.")
			end if

		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if

	case "borrar"						
		if cb_insertar.enabled then		
			this.deleterow(this.getrow())
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)
			end if			
		end if
	case else
		if not(cb_insertar.enabled) then
			dw_1.triggerevent(clicked!)
		end if

end choose



end event

event rbuttondown;bus_filtro=""

bus_titulo=""

bus_datawindow = ""

bus_campo = This.GetColumnName()

valor_empresa = TRUE

CHOOSE CASE bus_campo

	CASE "contaplan_cuenta"

		bus_filtro     = "ejercicio = "+string(f_ejercicio_activo(codigo_empresa),"###0")//string(dec(tab_1.tabpage_1.uo_ejercicio_ctas_resultados.em_ejercicio.text),"###0")

		bus_datawindow = "dw_ayuda_contaplan"

		bus_titulo     = "VENTANA SELECCION DE CUENTAS CONTABLES"

	CASE ELSE

		SetNull(bus_campo)

END CHOOSE

CALL Super::rbuttondown

end event

event retrieveend;
String ls_datos[],ls_filtro

ls_filtro = "ejercicio = "+string(dec(tab_1.tabpage_1.uo_ejercicio_ctas_resultados.em_ejercicio.text),"###0")	

this.setfilter(ls_filtro)

this.filter()

end event

event key;IF  KeyDown(KeyEscape!) Then Parent.TriggerEvent("ue_esc")

IF  KeyDown(KeyF5!)Then Parent.TriggerEvent("ue_f5")

IF  KeyDown(KeyF2!)Then Parent.TriggerEvent("ue_f2")

IF  KeyDown(KeyF3!)Then Parent.TriggerEvent("ue_f3")



bus_filtro=""

bus_titulo=""

bus_datawindow = ""

bus_campo = This.GetColumnName()

valor_empresa = TRUE

CHOOSE CASE bus_campo

	CASE "contaplan_cuenta"

		bus_filtro     = "ejercicio = "+string(f_ejercicio_activo(codigo_empresa),"###0")//string(dec(tab_1.tabpage_1.uo_ejercicio_ctas_resultados.em_ejercicio.text),"###0")

		bus_datawindow = "dw_ayuda_contaplan"

		bus_titulo     = "VENTANA SELECCION DE CUENTAS CONTABLES"

	CASE ELSE

		SetNull(bus_campo)

END CHOOSE

CALL Super::key

end event

event itemchanged;call super::itemchanged;long     indice,ll_ejercicio,ll_indice,ll_total
dec      ld_porcentaje_ya_asignado,ld_porcentaje_a_asignar,ld_porc_asignado_grupo_actual
string   columna,mensaje_error,ls_cuenta_inserto,concepto,ls_cuenta,ls_sel,ls_conta_bal_grup_codigo,ls_filtro
string   ls_porc_asignado_grupo_actual
boolean  no_valido = false 
string   ls_balance

datastore ds_datos

columna = dwo.name

choose case columna
	case "contaplan_cuenta"
		ls_cuenta_inserto = data	
		if trim(ls_cuenta_inserto) <> "" then
			ls_conta_bal_grup_codigo = this.object.conta_bal_grup_codigo[row]
			ls_balance        = this.object.conta_bal_cab_codigo[row]
			ll_ejercicio                 = this.object.ejercicio[row]

			if trim(f_nombre_contaplan(ll_ejercicio,codigo_empresa,ls_cuenta_inserto)) = "" then
				no_valido     = true
				mensaje_error = "Cuenta inexistente"				
			end if	

			/// COMPROBACION QUE LA CUENTA

			/// NO TENGA EN OTROS CENTROS DE COSTE EL 100% YA IMPUTADO

			ld_porcentaje_ya_asignado = 0

			//			and    conta_bal_cab_codigo <> :ls_balance

			ls_filtro = this.Object.DataWindow.Table.filter
			this.setredraw(false)
			this.setfilter("")
			this.filter()

			ls_porc_asignado_grupo_actual = this.describe("evaluate('sum( if(contaplan_cuenta = ~""+ls_cuenta_inserto+"~" and ejercicio = "+string(ll_ejercicio,"###0")+", porcentaje , 0 ) for all )',1)")
			ld_porc_asignado_grupo_actual = dec(ls_porc_asignado_grupo_actual)				

			this.setfilter(ls_filtro)
			this.filter()	
			this.setredraw(true)

			select sum(porcentaje)
			into   :ld_porcentaje_ya_asignado
			from   conta_bal_grup_ctas
			where  empresa             = :codigo_empresa
			and    ejercicio           = :ll_ejercicio
			and    conta_bal_grup_codigo <> :ls_conta_bal_grup_codigo
			and    contaplan_cuenta    = :ls_cuenta_inserto;			

			if isnull(ld_porcentaje_ya_asignado) then ld_porcentaje_ya_asignado = 0	

			ld_porcentaje_ya_asignado += ld_porc_asignado_grupo_actual	

			if ld_porcentaje_ya_asignado >= 100 then
				ld_porcentaje_a_asignar = 0
				no_valido     = true
				mensaje_error = "La cuenta ya esta asignada en su totalidad a otros centros y grupos"		
				//		    "and    conta_bal_cab_codigo <> '"+ls_balance+"' "+&							

//				ls_sel = "select conta_bal_grup_codigo,conta_bal_cab_codigo,porcentaje "+&

//						    "from conta_bal_grup_ctas "+&

//						    "where  empresa             = '"+codigo_empresa+"' "+&

//						    "and    ejercicio           = "+string(ll_ejercicio,"###0")+" "+&

//							 "and    conta_bal_grup_codigo <> '"+ls_conta_bal_grup_codigo+"' "+&

//						    "and    contaplan_cuenta    = '"+ls_cuenta_inserto+"' "

//							  

//				ll_total = f_cargar_cursor_transaccion(sqlca,ds_datos,ls_sel)

//							 

//				for ll_indice = 1 to ll_total

//					mensaje_error += "~n"+f_cos_centros_descripcion(codigo_empresa,ds_datos.object.conta_bal_cab_codigo[ll_indice])+" "+string(ds_datos.object.porcentaje[ll_indice],"##0.00")+"%" 	

//				next

//							 							 

//				destroy ds_datos

			else
				ld_porcentaje_a_asignar = 100 - ld_porcentaje_ya_asignado
			end if				
		end if		

		if not(no_valido) and this.rowcount() > 1 then	
			for indice = 1 to this.rowcount()
				if indice <> row then
					concepto = this.object.contaplan_cuenta[indice]				
					if ls_cuenta_inserto = concepto then
						no_valido = true
						mensaje_error = "Cuenta ya introducida."
					end if
				end if
			next
		end if
		if not(no_valido) then
			this.object.porcentaje[row] = ld_porcentaje_a_asignar
		end if		
		
	case "porcentaje"
		ls_cuenta_inserto        = this.object.contaplan_cuenta[row]
		ls_conta_bal_grup_codigo = this.object.conta_bal_grup_codigo[row]
		ls_balance               = this.object.conta_bal_cab_codigo[row]
		ll_ejercicio             = this.object.ejercicio[row]
		
		/// NO TENGA EN OTROS CENTROS DE COSTE EL 100% YA IMPUTADO
		ld_porcentaje_ya_asignado = 0
		
		ls_filtro = this.Object.DataWindow.Table.filter
		this.setredraw(false)
		this.setfilter("")
		this.filter()	

		ls_porc_asignado_grupo_actual = this.describe("evaluate('sum( if(contaplan_cuenta = ~""+ls_cuenta_inserto+"~" and ejercicio = "+string(ll_ejercicio,"###0")+" and (conta_bal_grup_codigo <> ~""+ls_conta_bal_grup_codigo+"~" or conta_bal_cab_codigo <> ~""+ls_balance+"~"), porcentaje , 0 ) for all )',1)")
		ld_porc_asignado_grupo_actual = dec(ls_porc_asignado_grupo_actual)

		this.setfilter(ls_filtro)
		this.filter()	
		this.setredraw(true)
		
		select sum(porcentaje)
		into   :ld_porcentaje_ya_asignado
		from   conta_bal_grup_ctas
		where  empresa             = :codigo_empresa
		and    ejercicio           = :ll_ejercicio
		and    conta_bal_grup_codigo <> :ls_conta_bal_grup_codigo
		and    contaplan_cuenta    = :ls_cuenta_inserto;
		
		if isnull(ld_porcentaje_ya_asignado) then ld_porcentaje_ya_asignado = 0
	
		ld_porcentaje_ya_asignado += ld_porc_asignado_grupo_actual

		ld_porcentaje_a_asignar = 100 - ld_porcentaje_ya_asignado

		if dec(data) > ld_porcentaje_a_asignar then
			no_valido     = true
			mensaje_error = "El porcentaje maximo a asignar es "+string(ld_porcentaje_a_asignar,"##0.0")		
		end if

end choose

if no_valido then
	messagebox("Atención",mensaje_error)		
	return 2
	this.setrow(row)
	this.setcolumn(columna)
else
	return 0
end if

end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3575
integer height = 1392
long backcolor = 12632256
string text = "Grupos Totaliza"
long tabtextcolor = 33554432
long tabbackcolor = 12632256
long picturemaskcolor = 536870912
dw_grupos_totaliza dw_grupos_totaliza
end type

on tabpage_2.create
this.dw_grupos_totaliza=create dw_grupos_totaliza
this.Control[]={this.dw_grupos_totaliza}
end on

on tabpage_2.destroy
destroy(this.dw_grupos_totaliza)
end on

type dw_grupos_totaliza from u_datawindow within tabpage_2
integer x = 5
integer y = 4
integer width = 3566
integer height = 1384
integer taborder = 60
boolean bringtotop = true
string title = "Conceptos"
string dataobject = "dw_mant_conta_bal_grup2"
boolean vscrollbar = true
borderstyle borderstyle = styleraised!
end type

event clicked;call super::clicked;long donde,indice,total

str_parametros lstr_param

choose case f_objeto_datawindow(this)

	case "insertar"
		if cb_insertar.enabled then	
			if dw_1.getrow() = 1 then
				if dw_1.object.gpo_totalizador[dw_1.getrow()] = 'S' then			
					total    = this.rowcount()
		
					donde = this.insertrow(total +1)
					this.object.empresa[donde]                 = codigo_empresa	
					this.object.conta_bal_cab_codigo[donde]    = uo_balance.em_codigo.text
					this.object.conta_bal_grup_codigo[donde]   = sle_valor.text
					this.object.conta_bal_grup_codigo_t[donde] = ""
					this.setrow(donde)
					this.scrolltorow(donde)
					this.setcolumn("conta_bal_grup_codigo_t")
				else
					messagebox("Atención","Solo se pueden añadir en grupos totalizadores.")
				end if				
			end if
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)				
			end if
		end if

	case "borrar"

		if cb_insertar.enabled then		
			this.deleterow(this.getrow())
		else
			if not(cb_insertar.enabled) then
				dw_1.triggerevent(clicked!)
			end if			
		end if
	case else
		if not(cb_insertar.enabled) then
			dw_1.triggerevent(clicked!)
		end if
end choose



end event

event itemchanged;call super::itemchanged;dec      ld_porcentaje_ya_asignado,ld_porcentaje_a_asignar
long     indice,ll_indice,ll_total
string   columna,mensaje_error,ls_grupo_inserto,grupo,ls_Grupo,ls_sel
boolean  no_valido = false 
string   ls_conta_bal_grup_codigo

datastore ds_datos

columna = dwo.name

choose case columna
	case "conta_bal_grup_codigo_t_1","conta_bal_grup_codigo_t_2"
		ls_grupo_inserto = data	
		if data <> sle_valor.text then		
			if trim(ls_grupo_inserto) <> "" then  

				ls_conta_bal_grup_codigo = this.object.conta_bal_grup_codigo[row]

				if trim(f_conta_bal_grup_descripcion(codigo_empresa,uo_balance.em_codigo.text,ls_grupo_inserto)) = "" then
					no_valido     = true
					mensaje_error = "Grupo inexistente"				
				end if

			end if

			if not(no_valido) and this.rowcount() > 1 then	
				for indice = 1 to this.rowcount()
					if indice <> row then
						grupo = this.object.conta_bal_grup_codigo_t[indice]				
						if ls_grupo_inserto = grupo then
							no_valido = true
							mensaje_error = "Grupo ya introducido."
						end if
					end if
				next
			end if
		else
			no_valido = true
			mensaje_error = "El Grupo debe de ser distinto al actual."			
		end if	

		if not(no_valido) then
			this.object.conta_bal_grup_descripcion[row] = f_conta_bal_grup_descripcion(codigo_empresa,uo_balance.em_codigo.text,ls_grupo_inserto)
		end if

end choose

if no_valido then
	messagebox("Atención",mensaje_error)		
	return 2
	this.setrow(row)
	this.setcolumn(columna)
else
	return 0
end if

end event

event key;bus_datawindow = ""
bus_filtro     = ""
valor_empresa  = TRUE	
bus_titulo     = ""
bus_campo      = This.GetColumnName()

CHOOSE CASE bus_campo

	CASE "conta_bal_grup_codigo_t_1","conta_bal_grup_codigo_t_2"
 		bus_datawindow = "dw_ayuda_conta_bal_grup"
		bus_titulo = "AYUDA SELECCION DE GRUPOS DE CTA DE RESULT"
		bus_filtro = "codigo <> '"+sle_valor.text+"' and conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"'"

END CHOOSE



call super::key

end event

event rbuttondown;bus_datawindow = ""
bus_filtro     = ""
valor_empresa  = TRUE	
bus_titulo     = ""
bus_campo      = This.GetColumnName()

CHOOSE CASE bus_campo

	CASE "conta_bal_grup_codigo_t_1","conta_bal_grup_codigo_t_2"
 		bus_datawindow = "dw_ayuda_conta_bal_grup"
		bus_titulo = "AYUDA SELECCION DE GRUPOS DE CTA DE RESULT"
		bus_filtro = "codigo <> '"+sle_valor.text+"' and conta_bal_cab_codigo = '"+uo_balance.em_codigo.text+"'"

END CHOOSE

call super::rbuttondown

end event

type uo_balance from u_em_campo_2 within w_mant_conta_bal_grup
event destroy ( )
integer x = 27
integer y = 128
integer width = 2373
integer taborder = 60
boolean bringtotop = true
boolean border = true
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

on uo_balance.destroy
call u_em_campo_2::destroy
end on

event modificado;call super::modificado;uo_balance.em_campo.text=f_conta_bal_cab_descripcion(codigo_empresa,uo_balance.em_codigo.text)

IF Trim(uo_balance.em_campo.text)="" THEN 
 IF Trim(uo_balance.em_codigo.text)<>"" Then uo_balance.em_campo.SetFocus()
 uo_balance.em_campo.text=""
 uo_balance.em_codigo.text=""

END IF



end event

event getfocus;call super::getfocus;ue_titulo     = "Ayuda seleccion de balances"
ue_datawindow = "dw_ayuda_conta_bal_cab"
ue_filtro     = ""

end event

type gb_22 from groupbox within w_mant_conta_bal_grup
integer x = 14
integer y = 84
integer width = 2405
integer height = 144
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Balance"
end type

